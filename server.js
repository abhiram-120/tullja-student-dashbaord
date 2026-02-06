require("dotenv").config();

const express = require("express");
const cors = require("cors");
const path = require("path");
const db = require("./db");

const app = express();
const PORT = process.env.PORT || 4000;

app.use(cors());
app.use(express.json());

// Serve frontend files from the same project.
app.use(express.static(path.join(__dirname)));

const LEVEL_MEANING = {
  A1: "Can understand and use very basic everyday phrases.",
  A2: "Can communicate in simple routine tasks.",
  B1: "Can deal with most situations likely to arise while travelling.",
  B2: "Can interact with a degree of fluency and spontaneity.",
  C1: "Can use language flexibly in social, academic, and professional situations.",
  C2: "Can understand virtually everything heard or read with ease.",
};

// Simple helper for parsing integer query params.
function getIntParam(req, name) {
  const raw = req.query[name] ?? req.params[name];
  const parsed = parseInt(raw, 10);
  if (Number.isNaN(parsed)) {
    return null;
  }
  return parsed;
}

app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

// Get basic student profile for header.
app.get("/api/home/student", async (req, res) => {
  const studentId = getIntParam(req, "studentId");
  if (!studentId) {
    return res.status(400).json({ error: "studentId is required" });
  }

  try {
    const [rows] = await db.execute(
      "SELECT id, full_name FROM users WHERE id = ? LIMIT 1",
      [studentId]
    );

    const row = rows[0];
    if (!row) {
      return res.status(404).json({ error: "Student not found" });
    }

    const student = {
      id: row.id,
      name: row.full_name,
      tagline:
        "Progress builds step by step over time. Consistency matters more than speed.",
    };

    res.json(student);
  } catch (err) {
    console.error("Error in /api/home/student:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Next lesson card (1.0, 1.1, 1.2, 1.3).
app.get("/api/home/next-lesson", async (req, res) => {
  const studentId = getIntParam(req, "studentId");
  if (!studentId) {
    return res.status(400).json({ error: "studentId is required" });
  }

  try {
    const [rows] = await db.execute(
      `
      SELECT
        c.id AS class_id,
        DATE_FORMAT(c.meeting_start, '%W') AS day_name,
        DATE_FORMAT(c.meeting_start, '%Y-%m-%d') AS lesson_date,
        DATE_FORMAT(c.meeting_start, '%H:%i') AS lesson_time,
        c.meeting_start AS full_datetime,
        c.join_url,
        c.status,
        CASE
          WHEN c.meeting_start <= NOW() + INTERVAL 5 MINUTE
           AND c.meeting_start >= NOW()
          THEN 'enabled'
          ELSE 'disabled'
        END AS join_button_status,
        u.full_name AS teacher_name,
        u.avatar AS teacher_avatar,
        CASE
          WHEN c.status = 'pending'
           AND TIMESTAMPDIFF(HOUR, NOW(), c.meeting_start) >= 4
          THEN 1
          ELSE 0
        END AS can_cancel
      FROM classes c
      INNER JOIN users u ON c.teacher_id = u.id
      WHERE c.student_id = ?
        AND c.status = 'pending'
        AND c.meeting_start >= NOW()
      ORDER BY c.meeting_start ASC
      LIMIT 1;
    `,
      [studentId]
    );

    if (!rows.length) {
      // No upcoming lesson – frontend will show "Book lesson" state.
      return res.json(null);
    }

    res.json(rows[0]);
  } catch (err) {
    console.error("Error in /api/home/next-lesson:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Progress snapshot + classes usage (2.x, 3.x (structure), 1.4, 2.2, 2.4).
app.get("/api/home/progress", async (req, res) => {
  const studentId = getIntParam(req, "studentId");
  if (!studentId) {
    return res.status(400).json({ error: "studentId is required" });
  }

  try {
    // Current level with most recent assessment.
    const [levelRows] = await db.execute(
      `
      SELECT
        sp.student_id,
        sp.current_level,
        COALESCE(la.detected_level, sp.current_level) AS detected_level
      FROM student_progress sp
      LEFT JOIN (
        SELECT la2.student_id, la2.detected_level
        FROM level_assessments la2
        INNER JOIN (
          SELECT student_id, MAX(assessed_at) AS max_assessed
          FROM level_assessments
          GROUP BY student_id
        ) latest ON la2.student_id = latest.student_id
          AND la2.assessed_at = latest.max_assessed
      ) la ON sp.student_id = la.student_id
      WHERE sp.student_id = ?
      LIMIT 1;
    `,
      [studentId]
    );

    const levelRow = levelRows[0];
    const currentLevel =
      levelRow?.detected_level || levelRow?.current_level || null;

    const levelMeaning = currentLevel ? LEVEL_MEANING[currentLevel] : null;

    // Current learning goal (2.2).
    const [goalRows] = await db.execute(
      `
      SELECT
        u.id AS student_id,
        COALESCE(ug.goal_name, c.student_goal, 'Improve English fluency') AS goal_name
      FROM users u
      LEFT JOIN user_goals ug ON u.id = ug.user_id
      LEFT JOIN (
        SELECT student_id, student_goal
        FROM classes
        WHERE student_goal IS NOT NULL
        ORDER BY meeting_start DESC
        LIMIT 1
      ) c ON u.id = c.student_id
      WHERE u.id = ?
      LIMIT 1;
    `,
      [studentId]
    );

    const goalRow = goalRows[0];

    // Upcoming learning focus (2.4).
    const [focusRows] = await db.execute(
      `
      SELECT cs.areas_for_improvement
      FROM class_summaries cs
      INNER JOIN classes c ON cs.class_id = c.id
      WHERE c.student_id = ?
        AND cs.areas_for_improvement IS NOT NULL
      ORDER BY c.meeting_start DESC
      LIMIT 1;
    `,
      [studentId]
    );

    const upcomingRaw = focusRows[0]?.areas_for_improvement || null;
    const upcomingFocus = upcomingRaw
      ? [upcomingRaw]
      : ["Focus will appear after your next lesson summary."];

    // Classes usage (1.4).
    const [usageRows] = await db.execute(
      `
      SELECT
        left_lessons AS classes_remaining,
        weekly_lesson AS total_weekly_lessons,
        (weekly_lesson - left_lessons) AS classes_used
      FROM user_subscription_details
      WHERE user_id = ?
        AND status = 'active'
      ORDER BY created_at DESC
      LIMIT 1;
    `,
      [studentId]
    );

    const usageRow = usageRows[0] || null;

    res.json({
      snapshot: {
        current_level: currentLevel,
        level_meaning:
          levelMeaning ||
          "Your current level is still being assessed. New lessons will refine this snapshot.",
        goal_name: goalRow?.goal_name || "Improve English fluency.",
        upcoming_focus: upcomingFocus,
      },
      classesUsage: usageRow,
    });
  } catch (err) {
    console.error("Error in /api/home/progress:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Skill snapshot (3.0 – 3.3).
app.get("/api/home/skills", async (req, res) => {
  const studentId = getIntParam(req, "studentId");
  if (!studentId) {
    return res.status(400).json({ error: "studentId is required" });
  }

  try {
    // Grammar (3.0).
    const [grammarRows] = await db.execute(
      `
      SELECT
        ? AS student_id,
        la.grammar_score,
        lf.grammar_rate,
        ROUND(
          COALESCE(la.grammar_score, 0) * 0.6 +
          COALESCE(lf.grammar_rate * 20, 0) * 0.4
        ) AS grammar_progress
      FROM (
        SELECT student_id, grammar_score
        FROM level_assessments
        WHERE student_id = ?
        ORDER BY assessed_at DESC
        LIMIT 1
      ) la
      LEFT JOIN (
        SELECT student_id, AVG(grammar_rate) AS grammar_rate
        FROM lesson_feedbacks
        WHERE student_id = ?
          AND grammar_rate IS NOT NULL
        GROUP BY student_id
      ) lf ON la.student_id = lf.student_id;
    `,
      [studentId, studentId, studentId]
    );

    const grammarRow = grammarRows[0] || null;

    // Vocabulary (3.1).
    const [vocabRows] = await db.execute(
      `
      SELECT
        sp.student_id,
        la.vocabulary_score,
        sp.vocabulary_mastered,
        ROUND(
          COALESCE(la.vocabulary_score, 0) * 0.5 +
          LEAST(sp.vocabulary_mastered / 200.0 * 100, 100) * 0.5
        ) AS vocabulary_progress
      FROM student_progress sp
      LEFT JOIN (
        SELECT student_id, vocabulary_score
        FROM level_assessments
        WHERE student_id = ?
        ORDER BY assessed_at DESC
        LIMIT 1
      ) la ON sp.student_id = la.student_id
      WHERE sp.student_id = ?
      LIMIT 1;
    `,
      [studentId, studentId]
    );

    const vocabRow = vocabRows[0] || null;

    // Speaking (3.2).
    const [speakingRows] = await db.execute(
      `
      SELECT
        ? AS student_id,
        la.fluency_score,
        lf.speaking_rate,
        ROUND(
          COALESCE(la.fluency_score, 0) * 0.6 +
          COALESCE(lf.speaking_rate * 20, 0) * 0.4
        ) AS speaking_progress
      FROM (
        SELECT student_id, fluency_score
        FROM level_assessments
        WHERE student_id = ?
        ORDER BY assessed_at DESC
        LIMIT 1
      ) la
      LEFT JOIN (
        SELECT student_id, AVG(speaking_rate) AS speaking_rate
        FROM lesson_feedbacks
        WHERE student_id = ?
          AND speaking_rate IS NOT NULL
        GROUP BY student_id
      ) lf ON la.student_id = lf.student_id;
    `,
      [studentId, studentId, studentId]
    );

    const speakingRow = speakingRows[0] || null;

    // Pronunciation (3.3).
    const [pronRows] = await db.execute(
      `
      SELECT
        student_id,
        ROUND(AVG(pronunciation_rate), 1) AS avg_pronunciation,
        ROUND(AVG(pronunciation_rate) * 20) AS pronunciation_progress
      FROM lesson_feedbacks
      WHERE student_id = ?
        AND pronunciation_rate IS NOT NULL
      GROUP BY student_id;
    `,
      [studentId]
    );

    const pronRow = pronRows[0] || null;

    const skills = [
      {
        key: "grammar",
        name: "Grammar",
        progress: grammarRow?.grammar_progress ?? 0,
        foundationText:
          "Weighted from your latest assessment and grammar feedback from lessons.",
      },
      {
        key: "vocabulary",
        name: "Vocabulary",
        progress: vocabRow?.vocabulary_progress ?? 0,
        foundationText:
          "Combines assessment scores with words you've mastered in lessons and games.",
      },
      {
        key: "speaking",
        name: "Speaking",
        progress: speakingRow?.speaking_progress ?? 0,
        foundationText:
          "Built from fluency assessments and speaking feedback – more speaking, more growth.",
      },
      {
        key: "pronunciation",
        name: "Pronunciation",
        progress: pronRow?.pronunciation_progress ?? 0,
        foundationText:
          "Based on teacher ratings across your recent lessons, converted into a calm percentage.",
      },
    ];

    res.json(skills);
  } catch (err) {
    console.error("Error in /api/home/skills:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Practice & games (4.0 – 4.2).
app.get("/api/home/practice", async (req, res) => {
  const studentId = getIntParam(req, "studentId");
  if (!studentId) {
    return res.status(400).json({ error: "studentId is required" });
  }

  try {
    // Recent practice items, incomplete.
    const [practiceRows] = await db.execute(
      `
      SELECT
        g.id AS game_id,
        g.exercise_type,
        g.status,
        g.topic_name,
        g.class_id,
        c.meeting_start AS class_date,
        u.full_name AS teacher_name
      FROM games g
      INNER JOIN classes c ON g.class_id = c.id
      INNER JOIN users u ON c.teacher_id = u.id
      WHERE g.student_id = ?
        AND g.status IN ('pending', 'approved')
      ORDER BY g.created_at DESC
      LIMIT 5;
    `,
      [studentId]
    );

    // Estimated time per exercise type.
    const [timeRows] = await db.execute(
      `
      SELECT
        g.exercise_type,
        CEIL(COALESCE(AVG(aaq.average_time_seconds), 120) / 60) AS estimated_minutes
      FROM games g
      LEFT JOIN adaptive_assessment_questions aaq
        ON aaq.skill_focus = g.exercise_type
      WHERE g.student_id = ?
        AND g.status = 'pending'
      GROUP BY g.exercise_type;
    `,
      [studentId]
    );

    const minutesByType = new Map();
    timeRows.forEach((row) => {
      minutesByType.set(row.exercise_type, row.estimated_minutes);
    });

    const formatted = practiceRows.map((row) => {
      const dateLabel = row.class_date
        ? new Date(row.class_date).toLocaleDateString(undefined, {
            month: "short",
            day: "2-digit",
          })
        : "";

      const title =
        row.topic_name || row.exercise_type || "Practice exercise";

      const subtitleParts = [];
      if (dateLabel) subtitleParts.push(`From ${dateLabel} lesson`);
      if (row.teacher_name) subtitleParts.push(`with ${row.teacher_name}`);

      const status =
        row.status === "approved" || row.status === "ready"
          ? "approved"
          : "pending";

      return {
        id: row.game_id,
        title,
        subtitle: subtitleParts.join(" "),
        status,
        statusLabel:
          status === "pending" ? "Pending" : "Ready to practice",
        estimatedMinutes:
          minutesByType.get(row.exercise_type) ?? undefined,
      };
    });

    res.json(formatted);
  } catch (err) {
    console.error("Error in /api/home/practice:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Weekly highlights (5.0 – 5.2).
app.get("/api/home/weekly", async (req, res) => {
  const studentId = getIntParam(req, "studentId");
  if (!studentId) {
    return res.status(400).json({ error: "studentId is required" });
  }

  try {
    // New words learned this week (5.0).
    const [wordsRows] = await db.execute(
      `
      SELECT
        c.student_id,
        COALESCE(
          SUM(JSON_LENGTH(cs.vocabulary_learned)),
          sp.vocabulary_mastered
        ) AS words_count
      FROM classes c
      LEFT JOIN class_summaries cs ON c.id = cs.class_id
      LEFT JOIN student_progress sp ON c.student_id = sp.student_id
      WHERE c.student_id = ?
        AND c.status = 'ended'
        AND c.meeting_start >= DATE_SUB(NOW(), INTERVAL 7 DAY)
      GROUP BY c.student_id, sp.vocabulary_mastered;
    `,
      [studentId]
    );

    const wordsCount = wordsRows[0]?.words_count ?? 0;

    // Lessons completed this week (5.1).
    const [lessonsRows] = await db.execute(
      `
      SELECT
        COUNT(*) AS lessons_completed
      FROM classes
      WHERE student_id = ?
        AND status = 'ended'
        AND meeting_start >= DATE_SUB(NOW(), INTERVAL 7 DAY);
    `,
      [studentId]
    );

    const lessonsCompleted = lessonsRows[0]?.lessons_completed ?? 0;

    // Speaking percentage (latest engagement) (5.2).
    const [speakRows] = await db.execute(
      `
      SELECT
        c.student_id,
        cs.engagement_level,
        CASE cs.engagement_level
          WHEN 'very_high' THEN 95
          WHEN 'high' THEN 85
          WHEN 'medium' THEN 70
          WHEN 'low' THEN 50
          ELSE 60
        END AS speaking_percentage
      FROM classes c
      INNER JOIN class_summaries cs ON c.id = cs.class_id
      WHERE c.student_id = ?
        AND c.status = 'ended'
      ORDER BY c.meeting_start DESC
      LIMIT 1;
    `,
      [studentId]
    );

    const speakingPct = speakRows[0]?.speaking_percentage ?? 0;

    res.json({
      words: wordsCount,
      lessons: lessonsCompleted,
      speaking_percentage: speakingPct,
    });
  } catch (err) {
    console.error("Error in /api/home/weekly:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Lightweight student list for selector/search.
app.get("/api/students", async (req, res) => {
  try {
    const { q } = req.query;
    const limitRaw = req.query.limit;
    let limit = parseInt(limitRaw, 10);
    if (Number.isNaN(limit) || limit <= 0 || limit > 200) {
      limit = 50;
    }

    const params = [];
    let where = "role_name = 'student'";

    if (q && typeof q === "string" && q.trim().length) {
      const term = `%${q.trim()}%`;
      const maybeId = parseInt(q.trim(), 10);

      where += " AND (full_name LIKE ? OR email LIKE ? OR id = ?)";
      params.push(term, term, Number.isNaN(maybeId) ? 0 : maybeId);
    }

    const sql = `
      SELECT id, full_name, email
      FROM users
      WHERE ${where}
      ORDER BY full_name ASC
      LIMIT ?;
    `;

    params.push(limit);

    const [rows] = await db.execute(sql, params);

    const mapped = rows.map((row) => ({
      id: row.id,
      name: row.full_name || `Student #${row.id}`,
      email: row.email || null,
      label: row.full_name
        ? `${row.full_name} (#${row.id})`
        : `Student #${row.id}`,
    }));

    res.json(mapped);
  } catch (err) {
    console.error("Error in /api/students:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.listen(PORT, () => {
  console.log(`Server listening on http://localhost:${PORT}`);
});


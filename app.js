// Toggle this later when backend is ready.
const USE_MOCK_DATA = true;

document.addEventListener("DOMContentLoaded", () => {
  if (USE_MOCK_DATA) {
    hydrateWithMockData();
  } else {
    // Replace 1 with the authenticated student's id.
    loadFromApi({ studentId: 1 });
  }
});

function hydrateWithMockData() {
  const mock = getMockSnapshot();
  renderStudentHeader(mock.student);
  renderNextLesson(mock.nextLesson);
  renderClassesUsage(mock.classesUsage);
  renderProgressSnapshot(mock.progressSnapshot);
  renderSkills(mock.skills);
  renderPractice(mock.practice);
  renderWeeklyHighlights(mock.weeklyHighlights);
}

// Example shape for future backend integration.
async function loadFromApi({ studentId }) {
  try {
    const [
      nextLessonRes,
      progressRes,
      skillsRes,
      practiceRes,
      weeklyRes,
      studentRes,
    ] = await Promise.all([
      fetch(`/api/home/next-lesson?studentId=${studentId}`),
      fetch(`/api/home/progress?studentId=${studentId}`),
      fetch(`/api/home/skills?studentId=${studentId}`),
      fetch(`/api/home/practice?studentId=${studentId}`),
      fetch(`/api/home/weekly?studentId=${studentId}`),
      fetch(`/api/home/student?studentId=${studentId}`),
    ]);

    if (
      !nextLessonRes.ok ||
      !progressRes.ok ||
      !skillsRes.ok ||
      !practiceRes.ok ||
      !weeklyRes.ok ||
      !studentRes.ok
    ) {
      throw new Error("One or more API calls failed");
    }

    const [nextLesson, progress, skills, practice, weekly, student] =
      await Promise.all([
        nextLessonRes.json(),
        progressRes.json(),
        skillsRes.json(),
        practiceRes.json(),
        weeklyRes.json(),
        studentRes.json(),
      ]);

    renderStudentHeader(student);
    renderNextLesson(nextLesson);
    renderClassesUsage(progress.classesUsage);
    renderProgressSnapshot(progress.snapshot);
    renderSkills(skills);
    renderPractice(practice);
    renderWeeklyHighlights(weekly);
  } catch (err) {
    /* eslint-disable no-console */
    console.error("Failed to load data from API, falling back to mock:", err);
    hydrateWithMockData();
  }
}

function renderStudentHeader(student) {
  const nameEl = document.getElementById("student-name");
  const taglineEl = document.getElementById("student-tagline");
  if (nameEl) {
    nameEl.textContent = student.name;
  }
  if (taglineEl) {
    taglineEl.textContent =
      student.tagline ||
      "Progress builds step by step over time. Consistency matters more than speed.";
  }
}

function renderNextLesson(nextLesson) {
  const dayEl = document.getElementById("next-lesson-day");
  const dateEl = document.getElementById("next-lesson-date");
  const teacherNameEl = document.getElementById("teacher-name");
  const statusPillEl = document.getElementById("next-lesson-status-pill");
  const joinBtn = document.getElementById("join-lesson-btn");
  const cancelBtn = document.getElementById("cancel-lesson-btn");
  const helperTextEl = document.getElementById("lesson-helper-text");

  if (!nextLesson || !nextLesson.class_id) {
    // No upcoming lesson → "Book lesson" state handled mostly in backend UI spec.
    if (helperTextEl) {
      helperTextEl.textContent =
        "No upcoming lesson is scheduled. Book your next lesson to keep your momentum.";
    }
    if (joinBtn) {
      joinBtn.disabled = true;
      joinBtn.textContent = "No upcoming lesson";
    }
    if (cancelBtn) {
      cancelBtn.disabled = true;
    }
    if (statusPillEl) {
      statusPillEl.textContent = "No lesson";
    }
    return;
  }

  if (dayEl) dayEl.textContent = nextLesson.day_name || "—";
  if (dateEl) {
    const dateStr = [nextLesson.lesson_date, nextLesson.lesson_time]
      .filter(Boolean)
      .join(" · ");
    dateEl.textContent = dateStr || "—";
  }
  if (teacherNameEl) {
    teacherNameEl.textContent = nextLesson.teacher_name || "Teacher";
  }

  const isJoinEnabled = nextLesson.join_button_status === "enabled";
  if (joinBtn) {
    joinBtn.disabled = !isJoinEnabled;
    joinBtn.textContent = isJoinEnabled ? "Join lesson" : "Join lesson (soon)";
  }
  if (statusPillEl) {
    statusPillEl.textContent = nextLesson.status || "Pending";
  }
  if (helperTextEl) {
    helperTextEl.textContent = isJoinEnabled
      ? "You can now join your lesson."
      : "The join button becomes active a few minutes before your lesson starts.";
  }
}

function renderClassesUsage(usage) {
  const textEl = document.getElementById("classes-used-text");
  const barEl = document.getElementById("classes-usage-bar");
  if (!usage) return;

  const used = usage.classes_used ?? 0;
  const total = usage.total_weekly_lessons ?? 0;
  if (textEl) {
    textEl.textContent = total
      ? `Used ${used} of ${total}`
      : "No weekly limit set";
  }
  if (barEl) {
    const pct = total ? Math.min(100, Math.max(0, (used / total) * 100)) : 0;
    barEl.style.width = `${pct}%`;
  }
}

function renderProgressSnapshot(snapshot) {
  if (!snapshot) return;

  const levelPill = document.getElementById("current-level-pill");
  const levelMeaning = document.getElementById("level-meaning");
  const goalEl = document.getElementById("learning-goal");
  const upcomingList = document.getElementById("upcoming-focus-list");

  if (levelPill && snapshot.current_level) {
    levelPill.textContent = snapshot.current_level;
  }
  if (levelMeaning && snapshot.level_meaning) {
    levelMeaning.textContent = snapshot.level_meaning;
  }
  if (goalEl && snapshot.goal_name) {
    goalEl.textContent = snapshot.goal_name;
  }

  if (upcomingList && snapshot.upcoming_focus && snapshot.upcoming_focus.length) {
    upcomingList.innerHTML = "";
    snapshot.upcoming_focus.forEach((item) => {
      const li = document.createElement("li");
      const dot = document.createElement("span");
      dot.className = "checkpoint-dot";
      const text = document.createElement("span");
      text.textContent = item;
      li.appendChild(dot);
      li.appendChild(text);
      upcomingList.appendChild(li);
    });
  }
}

function renderSkills(skills) {
  const grid = document.getElementById("skills-grid");
  if (!grid || !Array.isArray(skills)) return;

  grid.innerHTML = "";
  skills.forEach((skill) => {
    const card = document.createElement("div");
    card.className = "card skill-card";

    const header = document.createElement("div");
    header.className = "skill-header";

    const title = document.createElement("div");
    title.className = "skill-title";
    title.textContent = skill.name;

    const pct = document.createElement("div");
    pct.className = "skill-percentage";
    pct.textContent = `${skill.progress}%`;

    header.appendChild(title);
    header.appendChild(pct);

    const bar = document.createElement("div");
    bar.className = "progress-bar";

    const fill = document.createElement("div");
    fill.className = "progress-fill";
    fill.style.width = `${Math.min(100, Math.max(0, skill.progress))}%`;
    bar.appendChild(fill);

    const foundation = document.createElement("p");
    foundation.className = "skill-foundation";
    foundation.textContent =
      skill.foundationText ||
      "Built from assessments and lesson feedback. Shows progress within this level.";

    card.appendChild(header);
    card.appendChild(bar);
    card.appendChild(foundation);

    grid.appendChild(card);
  });
}

function renderPractice(practice) {
  const list = document.getElementById("practice-list");
  const empty = document.getElementById("practice-empty");
  if (!list || !empty) return;

  list.innerHTML = "";

  if (!practice || !practice.length) {
    empty.hidden = false;
    return;
  }

  empty.hidden = true;
  practice.forEach((item) => {
    const li = document.createElement("li");
    li.className = "list-item";

    const main = document.createElement("div");
    main.className = "list-main";

    const title = document.createElement("div");
    title.className = "list-title";
    title.textContent = item.title;

    const subtitle = document.createElement("div");
    subtitle.className = "list-subtitle";
    subtitle.textContent = item.subtitle;

    main.appendChild(title);
    main.appendChild(subtitle);

    const meta = document.createElement("div");
    meta.className = "list-meta";

    const status = document.createElement("span");
    status.className = `badge ${
      item.status === "pending" ? "badge-pending" : "badge-soft"
    }`;
    status.textContent = item.statusLabel || item.status;

    const duration = document.createElement("span");
    duration.className = "list-subtitle";
    duration.textContent = item.estimatedMinutes
      ? `${item.estimatedMinutes} min`
      : "";

    meta.appendChild(status);
    meta.appendChild(duration);

    li.appendChild(main);
    li.appendChild(meta);

    list.appendChild(li);
  });
}

function renderWeeklyHighlights(weekly) {
  if (!weekly) return;
  const wordsEl = document.getElementById("weekly-words");
  const lessonsEl = document.getElementById("weekly-lessons");
  const speakingEl = document.getElementById("speaking-percentage");

  if (wordsEl) wordsEl.textContent = weekly.words ?? 0;
  if (lessonsEl) lessonsEl.textContent = weekly.lessons ?? 0;
  if (speakingEl) {
    const pct = weekly.speaking_percentage ?? 0;
    speakingEl.textContent = `${pct}%`;
  }
}

// Simple mock snapshot close to what the SQL would return.
function getMockSnapshot() {
  return {
    student: {
      name: "Alex",
      tagline: "Consistency over time is what moves levels.",
    },
    nextLesson: {
      class_id: 123,
      day_name: "Thursday",
      lesson_date: "2026-02-05",
      lesson_time: "18:30",
      status: "pending",
      join_button_status: "disabled",
      teacher_name: "Ms. Johnson",
      join_url: "#",
    },
    classesUsage: {
      classes_used: 2,
      total_weekly_lessons: 5,
    },
    progressSnapshot: {
      current_level: "A2",
      level_meaning: "Can communicate in simple routine tasks.",
      goal_name: "Improve business English communication.",
      upcoming_focus: [
        "Focus on pronunciation and fluency in professional contexts.",
        "Practice past and future tense in everyday situations.",
      ],
    },
    skills: [
      {
        name: "Grammar",
        progress: 78,
        foundationText:
          "Weighted from your latest assessment and grammar feedback from lessons.",
      },
      {
        name: "Vocabulary",
        progress: 82,
        foundationText:
          "Combines assessment scores with words you've mastered in lessons and games.",
      },
      {
        name: "Speaking",
        progress: 85,
        foundationText:
          "Built from fluency assessments and speaking feedback – more speaking, more growth.",
      },
      {
        name: "Pronunciation",
        progress: 76,
        foundationText:
          "Based on teacher ratings across your recent lessons, converted into a calm percentage.",
      },
    ],
    practice: [
      {
        id: 1,
        title: "Vocabulary quiz – Work emails",
        subtitle: "From Jan 28 lesson with Ms. Johnson",
        status: "pending",
        statusLabel: "Pending",
        estimatedMinutes: 8,
      },
      {
        id: 2,
        title: "Grammar practice – Past simple",
        subtitle: "From Jan 25 lesson",
        status: "approved",
        statusLabel: "Ready to practice",
        estimatedMinutes: 6,
      },
    ],
    weeklyHighlights: {
      words: 24,
      lessons: 3,
      speaking_percentage: 85,
    },
  };
}


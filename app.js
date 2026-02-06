let currentStudentId = null;

document.addEventListener("DOMContentLoaded", () => {
  setupStudentSelector();
});

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
    console.error("Failed to load data from API:", err);
    showGlobalError(
      "Unable to load data for this student. Please check the connection or try another student."
    );
  }
}

function showGlobalError(message) {
  // Reuse the system message area for now.
  const systemMessage = document.getElementById("system-message");
  if (systemMessage) {
    systemMessage.textContent = message;
  } else {
    // Fallback to alert if needed.
    // eslint-disable-next-line no-alert
    alert(message);
  }
}

async function setupStudentSelector() {
  const selectEl = document.getElementById("student-select");
  const searchInput = document.getElementById("student-search-input");
  const searchBtn = document.getElementById("student-search-btn");

  if (!selectEl) {
    return;
  }

  // Initial load of students list.
  await loadStudents();

  selectEl.addEventListener("change", () => {
    const value = selectEl.value;
    if (!value) return;
    const id = parseInt(value, 10);
    if (Number.isNaN(id)) return;
    currentStudentId = id;
    loadFromApi({ studentId: currentStudentId });
  });

  if (searchBtn && searchInput) {
    const performSearch = async () => {
      const term = searchInput.value.trim();
      await loadStudents(term);
      if (selectEl.value) {
        const id = parseInt(selectEl.value, 10);
        if (!Number.isNaN(id)) {
          currentStudentId = id;
          loadFromApi({ studentId: currentStudentId });
        }
      }
    };

    searchBtn.addEventListener("click", (e) => {
      e.preventDefault();
      performSearch();
    });

    searchInput.addEventListener("keydown", (e) => {
      if (e.key === "Enter") {
        e.preventDefault();
        performSearch();
      }
    });
  }
}

async function loadStudents(query) {
  const selectEl = document.getElementById("student-select");
  if (!selectEl) return;

  try {
    const url = new URL("/api/students", window.location.origin);
    if (query && query.trim().length) {
      url.searchParams.set("q", query.trim());
    }
    const res = await fetch(url.toString());
    if (!res.ok) {
      throw new Error("Failed to load students");
    }
    const students = await res.json();

    selectEl.innerHTML = "";

    if (!students.length) {
      const opt = document.createElement("option");
      opt.value = "";
      opt.textContent = "No students found";
      selectEl.appendChild(opt);
      return;
    }

    students.forEach((s, index) => {
      const opt = document.createElement("option");
      opt.value = s.id;
      opt.textContent = s.label;
      selectEl.appendChild(opt);

      if (index === 0 && currentStudentId == null) {
        currentStudentId = s.id;
      }
    });

    // If we don't yet have a student loaded, load the first one.
    if (currentStudentId != null) {
      selectEl.value = String(currentStudentId);
      await loadFromApi({ studentId: currentStudentId });
    }
  } catch (err) {
    console.error("Failed to load students:", err);
    selectEl.innerHTML = "";
    const opt = document.createElement("option");
    opt.value = "";
    opt.textContent = "Unable to load students";
    selectEl.appendChild(opt);
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


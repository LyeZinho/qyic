**Qyic** is a learning and memorization application that combines the power of the **Spaced Repetition System (SRS)** algorithm with the interactivity and engagement of **gamified quizzes**.

---

## 📌 About the Project

Traditional flashcard applications revolutionized long-term knowledge retention, but passive review sessions can often become monotonous over time. **Qyic** solves this pain point by transforming content review into a dynamic game with multiple quiz formats—all while preserving the scientific efficiency of spaced repetition under the hood.

### ✨ Key Features

- 🎮 **Dynamic Quiz Modes:** Multiple choice, fill-in-the-blank, matching pairs, and true/false.
- ⚡ **Offline-First:** Study anywhere, even without an internet connection.
- 🧠 **Modern SRS Algorithm:** Optimized FSRS algorithm implementation for intelligent review scheduling.
- 🏆 **Gamification Elements:** XP system, levels, streaks, and achievements.
- 🔄 **Cross-Platform Sync:** Track and seamlessly synchronize your progress across mobile devices and the web.

---

## 🛠️ Tech Stack

Engineering choices focused on **native performance**, **low resource consumption**, and a **smooth user experience**:

| Layer | Technology | Description / Motivation |
| :--- | :--- | :--- |
| **Mobile** | **Flutter** + **SQLite** | Up to 120 FPS performance without JS bridges, featuring full offline support via local database. |
| **Web Frontend** | **SvelteKit** + **TypeScript** | Super lightweight imperative JS compilation, no Virtual DOM, and instant page loads. |
| **Backend API** | **Rust** + **PostgreSQL** | Memory safety, extreme concurrency, and ultra-low CPU/RAM overhead on the server. |
| **DevOps** | **Docker** + **Docker Compose** | Consistent containerization for both development and production environments. |

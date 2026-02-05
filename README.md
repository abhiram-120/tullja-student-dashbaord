# Student Homepage Frontend

This folder contains a standalone frontend for the student homepage dashboard. It is designed to pair with a Node.js + MySQL backend that exposes APIs based on the SQL queries in the provided documentation.

## Files

- `index.html` – main layout for the student homepage.
- `styles.css` – modern, calm UI styles (no red/error-heavy analytics).
- `app.js` – renders the UI using either mock data or, later, real API responses.

## Running

For quick testing, you can open `index.html` directly in a browser. The page will render using mock data defined in `app.js`.

When you are ready to connect to a backend:

1. Point the browser at the same origin as your Node.js server (or adjust the `fetch` URLs in `app.js` to include the backend origin).
2. Change `USE_MOCK_DATA` in `app.js` to `false`.
3. Implement the following endpoints in your backend (or adapt `loadFromApi` to match whatever endpoints you have):
   - `GET /api/home/next-lesson?studentId=:id`
   - `GET /api/home/progress?studentId=:id`
   - `GET /api/home/skills?studentId=:id`
   - `GET /api/home/practice?studentId=:id`
   - `GET /api/home/weekly?studentId=:id`
   - `GET /api/home/student?studentId=:id`

The expected response shapes are reflected in how `app.js` reads the JSON fields (e.g. `current_level`, `goal_name`, `upcoming_focus`, `classes_used`, `total_weekly_lessons`, etc.), closely mirroring the SQL documentation.


# Student Homepage Implementation Plan

## Project Overview

This document outlines the implementation plan for the Student Homepage feature based on the requirements and SQL query documentation provided in the two PDF files.

## Key Objectives

- Create a confidence-building, student-centric homepage
- Display personalized learning progress and upcoming lessons
- Provide practice recommendations and weekly highlights
- Include teacher analytics for tracking student engagement

## Implementation Timeline

### Phase 1: Database & Backend Setup (Weeks 1-2)
- [ ] Set up database connections and ORM configuration
- [ ] Create API endpoints for each homepage section
- [ ] Implement SQL queries from `bi tables ver1 (3).pdf`
- [ ] Add error handling and data validation
- [ ] Set up caching for frequently accessed data

### Phase 2: Frontend Development (Weeks 3-4)
- [ ] Create homepage layout and responsive design
- [ ] Implement Next Lesson section with join button logic
- [ ] Build Learning Progress Snapshot with CEFR level display
- [ ] Develop Skill Snapshot with percentage progress bars
- [ ] Create Practice & Games section with recent exercises
- [ ] Add Weekly Highlights with achievement metrics

### Phase 4: Testing & Optimization (Weeks 7-8)
- [ ] Test all API endpoints and frontend components
- [ ] Optimize database queries for performance
- [ ] Add integration tests for critical workflows
- [ ] Conduct user acceptance testing
- [ ] Deploy to production environment

## Technical Architecture

### Database Schema
Key tables:
- `classes`: Lesson details (meeting start, status, join URL)
- `users`: Teacher and student information
- `user_subscription_details`: Subscription and class allowance
- `student_progress`: Current level and vocabulary mastered
- `level_assessments`: Assessment scores (grammar, vocabulary, fluency)
- `lesson_feedbacks`: Teacher ratings and comments
- `class_summaries`: Post-lesson summaries and topics
- `games`: Practice exercises and status
- `student_class_queries`: Student focus requests

### API Design
Endpoints:
- `/api/student/next-lesson`: Get upcoming lesson details
- `/api/student/progress`: Get learning progress and skill snapshot
- `/api/student/practice`: Get recent practice exercises
- `/api/student/weekly-highlights`: Get weekly achievement metrics
- `/api/teacher/churn`: Get teacher churn analysis
- `/api/student/classes`: Get class history and learning summaries

### Frontend Architecture
Components:
- NextLessonCard: Displays upcoming lesson with join button
- LearningProgress: Shows CEFR level and progress checkpoints
- SkillSnapshot: Displays grammar, vocabulary, speaking, pronunciation progress
- PracticeList: Shows recent practice exercises
- WeeklyHighlights: Displays weekly achievement metrics
- ClassHistory: Shows past lessons and learning summaries

## Design Guidelines

### Visual Design
- Use calm colors (avoid red/warning colors)
- Clear visual distinction between completed and in-progress content
- Horizontal CEFR scale with muted/highlighted levels
- Skill cards with "Completed Foundations" and "Progress Within Current Level" layers

### Micro-copy
- Emotional reinforcement: "Progress builds step by step over time"
- System memory message: "This learning path is continuously personalized"
- Global skill clarification: Explain small percentage changes are normal
- Empty state message: "All practice completed"

### Constraints
- Avoid excessive numbers and charts
- No deep CEFR breakdowns in V1
- No separate parent accounts in V1

## Performance Optimization

### Database
- Use indexing on frequent query parameters (student_id, class_id, meeting_start)
- Limit query results with LIMIT clauses
- Cache frequently accessed data
- Use proper query optimization techniques

### Frontend
- Lazy load non-critical components
- Optimize images and assets
- Implement client-side caching
- Use CDN for static assets

## Data Quality & Error Handling

- Use COALESCE and NULL checks to handle missing data
- Provide default values for missing fields
- Hide features if required data is unavailable
- Log errors for debugging purposes

## Future Enhancements (V2)

- Interactive skill views with detailed breakdowns
- Parent insight dashboard
- Learning momentum (consistency streak) tracking
- Vocabulary strength (retention) metrics
- Goal confidence scores
- System brain growth counter
- Active speaking application ratio
- Mastery milestones (skills "gilded")
- Skill balance radar chart

## Risk Management

### High Priority Risks
- Database performance issues with large datasets
- API latency affecting user experience
- Data inconsistencies between tables

### Mitigation Strategies
- Implement query optimization and indexing
- Set up API monitoring and alerting
- Use transactional queries where necessary
- Implement data validation and sanitization

## Conclusion

This implementation plan provides a structured approach to building the Student Homepage feature. By following this plan, we will create a confidence-building, data-driven user experience that meets the requirements outlined in the specifications.

# Colab Fellowship Database: Tables and Relationships

This document describes what each table stores and how tables are related.

## Schema Flow (High Level)

- `projects` own many `teams` and many `sprints`.
- `teams` have many `team_members`.
- `students` participate across `team_members`, `tasks`, `task_reviews`, `peer_evaluations`, `attendance`, and `contribution_scores`.
- `sprints` contain many `tasks`, and also scope `peer_evaluations` and `contribution_scores`.
- `tasks` can have one `task_review`.

---

## `students`

Stores fellowship participant profile data.

**Key columns**

- `student_id` (PK)
- `first_name`, `last_name`, `email`
- `track`, `cohort`, `status`, `join_date`

**Relationships**

- Referenced by `team_members.student_id` (student’s team assignments)
- Referenced by `tasks.assigned_to` (task ownership)
- Referenced by `task_reviews.reviewer_id` (who reviewed task)
- Referenced by `peer_evaluations.evaluator_id` and `peer_evaluations.evaluated_student_id`
- Referenced by `attendance.student_id`
- Referenced by `contribution_scores.student_id`

---

## `roles`

Stores role definitions used within teams (e.g., lead/developer/designer).

**Key columns**

- `role_id` (PK)
- `role_name`, `role_description`

**Relationships**

- Referenced by `team_members.role_id`

---

## `projects`

Stores project-level information.

**Key columns**

- `project_id` (PK)
- `project_name`, `description`
- `start_date`, `end_date`, `status`

**Relationships**

- Parent of `teams` via `teams.project_id`
- Parent of `sprints` via `sprints.project_id`
- Indirectly linked to `team_members` through composite team reference (`team_id`, `project_id`)

---

## `teams`

Stores teams created under a specific project.

**Key columns**

- `team_id` (PK)
- `team_name`
- `project_id` (FK to `projects.project_id`)

**Relationships**

- Belongs to one `project`
- Parent of `team_members` via composite FK target (`team_id`, `project_id`)

---

## `team_members`

Junction/assignment table linking students to teams and roles.

**Key columns**

- `id` (PK)
- `team_id`, `project_id`, `student_id`, `role_id`
- `assigned_date`

**Relationships**

- (`team_id`, `project_id`) -> `teams(team_id, project_id)`
- `student_id` -> `students(student_id)`
- `role_id` -> `roles(role_id)`

**Notes**

- Enforces one student per team: unique (`team_id`, `student_id`)
- Enforces one student per project in this table: unique (`project_id`, `student_id`)

---

## `sprints`

Stores sprint cycles for each project.

**Key columns**

- `sprint_id` (PK)
- `project_id` (FK)
- `sprint_number`, `start_date`, `end_date`

**Relationships**

- Belongs to one `project` (`project_id` -> `projects.project_id`)
- Parent of `tasks` (`tasks.sprint_id`)
- Parent of `peer_evaluations` (`peer_evaluations.sprint_id`)
- Parent of `contribution_scores` (`contribution_scores.sprint_id`)

---

## `tasks`

Stores sprint tasks and their assignment/status metadata.

**Key columns**

- `task_id` (PK)
- `sprint_id` (FK)
- `assigned_to` (nullable FK)
- `title`, `description`, `complexity_level`, `status`, `deadline`, `completed_date`

**Relationships**

- Belongs to one `sprint` (`sprint_id` -> `sprints.sprint_id`)
- Optionally assigned to one `student` (`assigned_to` -> `students.student_id`)
- Parent of `task_reviews` (one-to-one enforced by unique `task_reviews.task_id`)

---

## `task_reviews`

Stores review results for tasks.

**Key columns**

- `review_id` (PK)
- `task_id` (unique FK)
- `reviewer_id` (FK)
- `quality_score`, `feedback`, `review_date`

**Relationships**

- One-to-one with `tasks` (`task_id` unique -> `tasks.task_id`)
- Belongs to one reviewer in `students` (`reviewer_id` -> `students.student_id`)

---

## `peer_evaluations`

Stores student-to-student peer scores per sprint.

**Key columns**

- `id` (PK)
- `evaluator_id` (FK)
- `evaluated_student_id` (FK)
- `sprint_id` (FK)
- `teamwork_score`, `communication_score`, `reliability_score`, `created_at`

**Relationships**

- `evaluator_id` -> `students.student_id`
- `evaluated_student_id` -> `students.student_id`
- `sprint_id` -> `sprints.sprint_id`

**Notes**

- Prevents self-evaluation (`evaluator_id <> evaluated_student_id`)
- One evaluator can evaluate a specific student only once per sprint (unique on `sprint_id`, `evaluator_id`, `evaluated_student_id`)

---

## `attendance`

Stores daily attendance per student.

**Key columns**

- `id` (PK)
- `student_id` (FK)
- `date`, `status`

**Relationships**

- Belongs to one `student` (`student_id` -> `students.student_id`)

**Notes**

- One attendance record per student per date (unique on `student_id`, `date`)

---

## `contribution_scores`

Stores rubric-based contribution scoring per student per sprint.

**Key columns**

- `id` (PK)
- `student_id` (FK)
- `sprint_id` (FK)
- `execution_score`, `quality_score`, `collaboration_score`, `professionalism_score`, `total_score`, `created_at`

**Relationships**

- Belongs to one `student` (`student_id` -> `students.student_id`)
- Belongs to one `sprint` (`sprint_id` -> `sprints.sprint_id`)

**Notes**

- One contribution score per student per sprint (unique on `student_id`, `sprint_id`)

---

## Enum Types Used

- `student_status`: `Active`, `Completed`
- `project_status`: `Planned`, `Active`, `Completed`, `On Hold`, `Cancelled`
- `task_status`: `Todo`, `In Progress`, `Review`, `Done`
- `attendance_status`: `Present`, `Absent`, `Late`

---

## Helpful Indexes (Performance)

- Student lookup: `idx_students_track`, `idx_students_cohort`
- Team membership lookup: `idx_team_members_student`, `idx_team_members_team`
- Sprint/task access: `idx_sprints_project`, `idx_tasks_sprint_status`, `idx_tasks_assigned_to`
- Evaluation/attendance/score access: `idx_peer_evaluations_target`, `idx_attendance_student_date`, `idx_contribution_scores_sprint`

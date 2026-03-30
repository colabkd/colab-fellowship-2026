CREATE TABLE tasks (
    task_id BIGSERIAL PRIMARY KEY,
    sprint_id BIGINT NOT NULL REFERENCES sprints(sprint_id) ON DELETE CASCADE,
    assigned_to BIGINT REFERENCES students(student_id) ON DELETE SET NULL,
    title VARCHAR(220) NOT NULL,
    description TEXT,
    complexity_level SMALLINT NOT NULL,
    status task_status NOT NULL DEFAULT 'Todo',
    deadline DATE,
    completed_date DATE,
    CHECK (complexity_level BETWEEN 1 AND 5)
);

CREATE TABLE contribution_scores (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    sprint_id BIGINT NOT NULL REFERENCES sprints(sprint_id) ON DELETE CASCADE,
    execution_score NUMERIC(5,2) NOT NULL,
    quality_score NUMERIC(5,2) NOT NULL,
    collaboration_score NUMERIC(5,2) NOT NULL,
    professionalism_score NUMERIC(5,2) NOT NULL,
    total_score NUMERIC(5,2) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (execution_score BETWEEN 0 AND 100),
    CHECK (quality_score BETWEEN 0 AND 100),
    CHECK (collaboration_score BETWEEN 0 AND 100),
    CHECK (professionalism_score BETWEEN 0 AND 100),
    CHECK (total_score BETWEEN 0 AND 100),
    UNIQUE (student_id, sprint_id)
);

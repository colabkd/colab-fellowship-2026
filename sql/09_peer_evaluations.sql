CREATE TABLE peer_evaluations (
    id BIGSERIAL PRIMARY KEY,
    evaluator_id BIGINT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    evaluated_student_id BIGINT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    teamwork_score NUMERIC(5,2) NOT NULL,
    communication_score NUMERIC(5,2) NOT NULL,
    reliability_score NUMERIC(5,2) NOT NULL,
    sprint_id BIGINT NOT NULL REFERENCES sprints(sprint_id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (evaluator_id <> evaluated_student_id),
    CHECK (teamwork_score BETWEEN 1 AND 100),
    CHECK (communication_score BETWEEN 1 AND 100),
    CHECK (reliability_score BETWEEN 1 AND 100),
    UNIQUE (sprint_id, evaluator_id, evaluated_student_id)
);

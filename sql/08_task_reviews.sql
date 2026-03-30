CREATE TABLE task_reviews (
    review_id BIGSERIAL PRIMARY KEY,
    task_id BIGINT NOT NULL UNIQUE REFERENCES tasks(task_id) ON DELETE CASCADE,
    reviewer_id BIGINT NOT NULL REFERENCES students(student_id) ON DELETE RESTRICT,
    quality_score NUMERIC(5,2) NOT NULL,
    feedback TEXT,
    review_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CHECK (quality_score BETWEEN 1 AND 100)
);

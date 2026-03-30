CREATE TABLE students (
    student_id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    track VARCHAR(100) NOT NULL,
    cohort VARCHAR(100) NOT NULL,
    status student_status NOT NULL DEFAULT 'Active',
    join_date DATE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

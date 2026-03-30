CREATE TABLE attendance (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    date DATE NOT NULL,
    status attendance_status NOT NULL,
    UNIQUE (student_id, date)
);

CREATE TABLE projects (
    project_id BIGSERIAL PRIMARY KEY,
    project_name VARCHAR(180) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE,
    status project_status NOT NULL DEFAULT 'Planned',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (end_date IS NULL OR end_date >= start_date),
    UNIQUE (project_name, start_date)
);

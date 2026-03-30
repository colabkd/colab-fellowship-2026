CREATE TABLE sprints (
    sprint_id BIGSERIAL PRIMARY KEY,
    project_id BIGINT NOT NULL REFERENCES projects(project_id) ON DELETE CASCADE,
    sprint_number INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CHECK (sprint_number > 0),
    CHECK (end_date >= start_date),
    UNIQUE (project_id, sprint_number)
);

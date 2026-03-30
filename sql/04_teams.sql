CREATE TABLE teams (
    team_id BIGSERIAL PRIMARY KEY,
    team_name VARCHAR(150) NOT NULL,
    project_id BIGINT NOT NULL REFERENCES projects(project_id) ON DELETE CASCADE,
    created_date DATE NOT NULL DEFAULT CURRENT_DATE,
    UNIQUE (project_id, team_name),
    UNIQUE (team_id, project_id)
);

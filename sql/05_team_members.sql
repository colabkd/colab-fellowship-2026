CREATE TABLE team_members (
    id BIGSERIAL PRIMARY KEY,
    team_id BIGINT NOT NULL,
    project_id BIGINT NOT NULL,
    student_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    assigned_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_team_members_team_project
        FOREIGN KEY (team_id, project_id)
        REFERENCES teams(team_id, project_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_team_members_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_team_members_role
        FOREIGN KEY (role_id)
        REFERENCES roles(role_id)
        ON DELETE RESTRICT,
    CONSTRAINT uq_team_members_team_student UNIQUE (team_id, student_id),
    CONSTRAINT uq_team_members_project_student UNIQUE (project_id, student_id)
);

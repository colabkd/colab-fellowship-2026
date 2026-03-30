CREATE TYPE student_status AS ENUM ('Active', 'Completed');
CREATE TYPE project_status AS ENUM ('Planned', 'Active', 'Completed', 'On Hold', 'Cancelled');
CREATE TYPE task_status AS ENUM ('Todo', 'In Progress', 'Review', 'Done');
CREATE TYPE attendance_status AS ENUM ('Present', 'Absent', 'Late');

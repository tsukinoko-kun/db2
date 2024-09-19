CREATE TABLE projects (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  completed_at timestamp
);

CREATE TABLE tasks (
  id SERIAL,
  name text NOT NULL,
  project_id integer REFERENCES projects,
  completed BOOLEAN NOT NULL DEFAULT FALSE
);
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require "irb"

# connect to database
@db = PG::Connection.new(
  host: "postgres",
  user: "postgres",
  password: "secret",
  dbname: "postgres"
)

# teardown old tables
@db.exec(File.read("./teardown.sql"))

# create new tables
@db.exec(File.read("./setup.sql"))

# access pattern P1
def create_project(name, completed_at = nil)
  result = @db.exec_params('INSERT INTO projects (name, completed_at) VALUES ($1, $2) RETURNING id, name, completed_at', [name, completed_at])
  result.tuple(0)
end

# access pattern P2
def delete_project(id)
  @db.exec_params('DELETE FROM projects WHERE id = $1', [id])
end

# access pattern P3
def find_all_projects
  result = @db.exec_params('SELECT * FROM projects')
  tuples = []
  result.each do |tuple|
    tuples << tuple
  end
  tuples
end

# access pattern P4
def find_project(id)
  result = @db.exec_params('SELECT * FROM projects WHERE id = $1', [id])
  result.tuple(0)
rescue IndexError
  nil
end

# access pattern T1
def create_task(project_id, name, completed = false)
  result = @db.exec_params('INSERT INTO tasks (name, project_id, completed) VALUES ($1, $2, $3) RETURNING id, name, project_id, completed', [name, project_id, completed])
  result.tuple(0)
end

# access pattern T2
def mark_task_completed(id, completed = true)
  result = @db.exec_params('UPDATE tasks SET completed = $2 WHERE id = $1 RETURNING id, name, project_id, completed', [id, completed])
  result.tuple(0)
end

# access pattern P3
def find_all_tasks_for_project(project_id)
  result = @db.exec_params('SELECT * FROM tasks WHERE project_id = $1', [project_id])
  tuples = []
  result.each do |tuple|
    tuples << tuple
  end
  tuples
end

# create sample entities
project = create_project("Finish Presentation")
task1 = create_task(project["id"], "Add page numbers")
task2 = create_task(project["id"], "Add summary slide", true)
task3 = create_task(project["id"], "Add intro slide", true)

# query them
pp project
pp find_all_tasks_for_project(project["id"])
pp mark_task_completed(task1["id"])
pp find_all_tasks_for_project(project["id"])

IRB.start
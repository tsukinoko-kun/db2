package tasktracker;

import javax.naming.ldap.PagedResultsResponseControl;
import javax.xml.transform.Result;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.*;
import java.util.*;

public class App {
  private Connection db;

  private void connectDatabase() throws SQLException {
    // connect database
    db = DriverManager.getConnection(
        "jdbc:postgresql://postgres/postgres",
        "postgres",
        "secret"
    );
    System.out.println("connected to database");
  }

  private void executeFile(String path) throws SQLException, IOException {
    Path p = FileSystems.getDefault().getPath(path);
    Statement st = db.createStatement();
    st.executeUpdate(Files.readString(p));
    System.out.println("executed " + path);
  }

  // access pattern P1
  private Map<String,Object> createProject(String name) throws SQLException {
    PreparedStatement st = db.prepareStatement("INSERT INTO projects (name) VALUES (?) RETURNING id, name, completed_at");
    st.setString(1, name);
    ResultSet rs = st.executeQuery();

    Map<String,Object> project = new HashMap<String, Object>();
    while (rs.next())
    {
      project.put("id", rs.getInt("id"));
      project.put("name", rs.getString("name"));
      project.put("completed_at", rs.getTimestamp("completed_at"));
    }

    rs.close();
    st.close();

    return project;
  }

  // access pattern P2
  private void deleteProject(int id) throws SQLException {
    PreparedStatement st = db.prepareStatement("DELETE FROM projects WHERE id = ?");
    st.setInt(1, id);
    st.executeUpdate();
  }

  // access pattern P3
  private ArrayList<Map<String,Object>> findAllProjects() throws SQLException {
    Statement st = db.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM projects");

    ArrayList<Map<String,Object>> list = new ArrayList<>();
    while (rs.next())
    {
      Map<String,Object> project = new HashMap<String, Object>();
      project.put("id", rs.getInt("id"));
      project.put("name", rs.getString("name"));
      project.put("completed_at", rs.getTimestamp("completed_at"));
      list.add(project);
    }
    rs.close();
    st.close();

    return list;
  }

  // access pattern P4
  private Map<String,Object> findProject(int id) throws SQLException {
    PreparedStatement st = db.prepareStatement("SELECT * FROM projects WHERE id = ?");
    st.setInt(1, id);
    ResultSet rs = st.executeQuery();

    Map<String,Object> project = new HashMap<String, Object>();
    while (rs.next())
    {
      project.put("id", rs.getInt("id"));
      project.put("name", rs.getString("name"));
      project.put("completed_at", rs.getTimestamp("completed_at"));
    }

    rs.close();
    st.close();

    return project;
  }

  // access pattern T1
  private Map<String,Object> createTask(int projectId, String name) throws SQLException {
    PreparedStatement st = db.prepareStatement("INSERT INTO tasks (name,project_id) VALUES (?,?) RETURNING id, name, project_id, completed");
    st.setString(1, name);
    st.setInt(2, projectId);
    ResultSet rs = st.executeQuery();

    Map<String,Object> task = new HashMap<String, Object>();
    while (rs.next())
    {
      task.put("id", rs.getInt("id"));
      task.put("name", rs.getString("name"));
      task.put("project_id", rs.getInt("project_id"));
      task.put("completed", rs.getBoolean("completed"));
    }
    rs.close();
    st.close();

    return task;
  }

  // access pattern T2
  private Map<String,Object> markTaskCompleted(int id) throws SQLException {
    PreparedStatement st = db.prepareStatement("UPDATE tasks SET completed = true WHERE id = ? RETURNING id, name, project_id, completed");
    st.setInt(1, id);
    ResultSet rs = st.executeQuery();

    Map<String,Object> task = new HashMap<String, Object>();
    while (rs.next())
    {
      task.put("id", rs.getInt("id"));
      task.put("name", rs.getString("name"));
      task.put("project_id", rs.getInt("project_id"));
      task.put("completed", rs.getBoolean("completed"));
    }
    rs.close();
    st.close();

    return task;
  }

  // access pattern T3
  private ArrayList<Map<String,Object>> findAllTasksForProject(int id) throws SQLException {
    PreparedStatement st = db.prepareStatement("SELECT * FROM tasks WHERE project_id = ?");
    st.setInt(1, id);
    ResultSet rs = st.executeQuery();

    ArrayList<Map<String,Object>> list = new ArrayList<>();
    while (rs.next())
    {
      Map<String,Object> task = new HashMap<String, Object>();
      task.put("id", rs.getInt("id"));
      task.put("name", rs.getString("name"));
      task.put("project_id", rs.getInt("project_id"));
      task.put("completed", rs.getBoolean("completed"));
      list.add(task);
    }
    rs.close();
    st.close();

    return list;
  }

  public App() {
    try {
      // connect
      this.connectDatabase();

      // teardown & setup
      this.executeFile("../teardown.sql");
      this.executeFile("../setup.sql");

      // create project 1
      Map<String,Object> project = this.createProject("Finish Thesis");
      System.out.println(project);

      // create project 2
      Map<String,Object> project2 = this.createProject("Setup Website");
      System.out.println(project2);

      // list all projects
      ArrayList<Map<String,Object>> projects = this.findAllProjects();
      System.out.println(projects);

      // find a project by id
      project = this.findProject((int)project.get("id"));
      System.out.println(project);

      // delete project 2
      this.deleteProject((int)project2.get("id"));

      // create tasks
      Map<String,Object> task1 = this.createTask((int)project.get("id"), "Write Introduction");
      System.out.println(task1);

      Map<String,Object> task2 = this.createTask((int)project.get("id"), "Write Abstract");
      System.out.println(task2);

      // mark task as completed
      task1 = this.markTaskCompleted((int)task1.get("id"));
      System.out.println(task1);

      // show all tasks for a project
      ArrayList<Map<String,Object>> tasks = this.findAllTasksForProject((int)project.get("id"));
      System.out.println(tasks);


    } catch (SQLException | IOException throwables) {
      throwables.printStackTrace();
    }
  }

  public static void main(String[] args) {
    App app = new App();
  }
}

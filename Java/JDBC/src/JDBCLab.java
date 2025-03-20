import java.sql.*;
import java.util.Scanner;

// TODO include the Maven library mysql-connector-java-8.0.X 
//      in the project libraries

public class JDBCLab {
    
    private static final String DBURL = "jdbc:mysql://localhost/course";
    private static final String DBUSERID = "root";
    private static final String DBPASSWORD = "RootPassword";

    public static void main(String[] args) {
        
        // prompt for student_id, name, department 
        // insert a row for the new student with tot_cred of 0
        // then list all students ID, name in the department
        
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter student id");
        String student_id = sc.nextLine();
        System.out.println("Enter name");
        String name = sc.nextLine();
        System.out.println("Enter department");
        String department = sc.nextLine();
        sc.close();
        
        // TODO create a connection to the course database
        try(
        Connection conn = DriverManager.getConnection(
                DBURL,
                DBUSERID,
                DBPASSWORD
        );) {
            conn.setAutoCommit(false); // turn off auto commmit
            Statement stmt = conn.createStatement();

            ResultSet check = stmt.executeQuery(
                    "select id, d.dept_name from student join department as d"
            );
            // print the id and name for students in the result set
            boolean hasDepartment = false;
            while (check.next()) {
//                System.out.println(check.getString("id") + " " + check.getString("name"));
                if(check.getString("id").equals(student_id)){
                    System.out.println("The ID is already in use");
                    return;
                }
                if(check.getString("d.dept_name").equals(department)){
                    hasDepartment = true;
                    break;
                }
            }
            if(!hasDepartment){
                System.out.println("Department doesn't exist");
                return;
            }
            // TODO prepare and execute insert statement
            //    "insert into student(id, name, dept_name, tot_cred) values (?, ?, ?, 0)"
            PreparedStatement insert = conn.prepareStatement(
                    "insert into student(id, name, dept_name, tot_cred) values (?, ?, ?, 0)"
            );
            insert.setString(1, student_id);
            insert.setString(2, name);
            insert.setString(3, department);
            // print the number of modified rows from the executeUpdate() method.  Should be 1.
            System.out.println("Number of Rows: " + insert.executeUpdate());

            // TODO prepare and execute select statement
            //       "select id, name  from student where dept_name = ?"
            PreparedStatement pStmt = conn.prepareStatement(
                    "select id, name  from student where dept_name = ?"
            );
            pStmt.setString(1, department);

            ResultSet rs = pStmt.executeQuery();
            // print the id and name for students in the result set
            while (rs.next()) {
                System.out.println(rs.getString("id") + " " + rs.getString("name"));
            }
            // TODO test your program for a new students, a student 00128 that already exists, and a department that does not exist
            //Test for this one is on line 
            // TODO commit or rollback the transaction
            conn.rollback();
            // TODO close the connection
            stmt.close();
        } catch (SQLException e) {
            System.out.println("SQLException : " + e);
        }
        // TODO if you have time, rather than getting an SQLException in case of 
        //      duplicate key or invalid foreign key, create more user friendly 
        //      messages by pre-checking that the student_id does not exist and that 
        //      the department does exist before doing the insert.



    }

}

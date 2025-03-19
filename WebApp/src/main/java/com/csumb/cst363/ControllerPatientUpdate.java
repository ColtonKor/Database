package com.csumb.cst363;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
/*
 * Controller class for patient interactions.
 *   update patient profile.
 */
@SuppressWarnings("unused")
@Controller
public class ControllerPatientUpdate {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	

	/*
	 *  Display patient profile for patient id.
	 */
	@GetMapping("/patient/edit/{id}")
	public String getUpdateForm(@PathVariable int id, Model model) {

        System.out.println("getUpdateForm " + id);  // debug
        PreparedStatement ps = null;
        ResultSet rs = null;
        // TODO
        Patient p = null;
        try (Connection connection = getConnection();) {
            // get a connection to the database
            // using patient id and patient last name from patient object
            // retrieve patient profile and doctor's last name
            String sql = "SELECT last_name, doctor_id FROM patient WHERE id = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (!rs.next()) {
                throw new SQLException("Patient not found with ID: " + id);
            }

            p = new Patient();
            p.setId(id);
            p.setPrimaryName(rs.getString("name"));
            p.setBirthdate(String.valueOf(rs.getDate("birthdate")));
            p.setId(rs.getInt("doctor_id"));

            // Fetch doctor's last name using the doctor_id
            sql = "SELECT last_name FROM doctor WHERE id = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, p.getId());
            rs = ps.executeQuery();

            if (rs.next()) {
                p.setLast_name(rs.getString("last_name"));
            }

            // update patient object with patient profile data

            model.addAttribute("patient", p);
            return "patient_edit";
        } catch (SQLException e) {
            // if there is error
            model.addAttribute("message", "<error>" + e.getMessage());
            model.addAttribute("patient", p);
            return "index";
        }
    }
	
	
	/*
	 * Process changes to patient profile.  
	 */
	@PostMapping("/patient/edit")
	public String updatePatient(Patient p, Model model) {
		
		System.out.println("updatePatient " + p);  // for debug 
		PreparedStatement ps = null;
		ResultSet rs = null;
		// TODO
		try (Connection connection = getConnection();) {
			// get a connection to the database
			// validate the doctor's last name and obtain the doctor id
			// update the patient's profile for street, city, state, zip and doctor id
			String doctor = "SELECT id FROM doctor WHERE last_name = ?";
			ps = connection.prepareStatement(doctor);
			ps.setString(1, p.getLast_name());
			rs = ps.executeQuery();

			if(!rs.next()){
				throw new SQLException("Doctor"+p.getLast_name()+" not found");
			}
			int doctorId = rs.getInt("id");

			String update = "UPDATE patient SET name = ?, birthdate = ?, doctor_id = ? WHERE id = ?";
			ps = connection.prepareStatement(update);
			ps.setString(1, p.getPrimaryName());
			ps.setDate(2, java.sql.Date.valueOf(p.getBirthdate()));
			ps.setInt(3, doctorId);
			ps.setInt(4, p.getId());
			int updateCount = ps.executeUpdate();

			if (updateCount == 0) {
				throw new SQLException("Update failed.");
			}

			model.addAttribute("message", "Update successful.");
			model.addAttribute("patient", p);
			return "patient_show";
		}catch(SQLException e) {
			// if there is error
			model.addAttribute("message",  "SQL Error."+e.getMessage());
			model.addAttribute("patient", p);
			return "patient_edit";
		}
	}

	/*
	 * return JDBC Connection using jdbcTemplate in Spring Server
	 */

	private Connection getConnection() throws SQLException {
		Connection conn = jdbcTemplate.getDataSource().getConnection();
		return conn;
	}

}

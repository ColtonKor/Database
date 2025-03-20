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

		System.out.println("getUpdateForm "+ id );  // debug

		// TODO
		try (Connection con = getConnection();) {
			PreparedStatement ps = con.prepareStatement("select patient.last_name, patient.first_name, " +
					"birthdate, patient.ssn, street,city, state, zip, " +
					"doctor.last_name from patient left join doctor on " +
					"doctor.id = patient.doctor_id where patient.id = ?");

			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			Patient p = new Patient();
			if(rs.next()) {
				p.setId(id);
				p.setLast_name(rs.getString(1));
				p.setFirst_name(rs.getString(2));
				p.setBirthdate(rs.getString(3));
				p.setSsn(rs.getString(4));
				p.setStreet(rs.getString(5));
				p.setCity(rs.getString(6));
				p.setState(rs.getString(7));
				p.setZipcode(rs.getString(8));
				p.setPrimaryName(rs.getString(9));

				// update patient object with patient profile data

				model.addAttribute("patient", p);
				return "patient_edit";
			}else{
				model.addAttribute("message", "patient does not exist");
				model.addAttribute("patient", id);
				return "patient_get";
			}
		}
		catch(SQLException e){
			model.addAttribute("message", "SQL error");
			model.addAttribute("patient", id);
			return "patient_edit";

		}
		// get a connection to the database
		// using patient id and patient last name from patient object
		// retrieve patient profile and doctor's last name



		// if there is error
		// model.addAttribute("message", <error message>);
		// model.addAttribute("patient", p);
		// return "index";
	}


	/*
	 * Process changes to patient profile.
	 */
	@PostMapping("/patient/edit")
	public String updatePatient(Patient p, Model model) {

		System.out.println("updatePatient " + p);  // for debug

		// TODO

		// get a connection to the database
		// validate the doctor's last name and obtain the doctor id
		// update the patient's profile for street, city, state, zip and doctor id
		try (Connection con = getConnection();) {



			PreparedStatement ps2 = con.prepareStatement("select id from doctor where last_name = ? ");
			ps2.setString(1, p.getPrimaryName());
			ResultSet rs = ps2.executeQuery();

			if(rs.next()){
				PreparedStatement ps = con.prepareStatement("update patient set street = ?, city = ?, state = ?, zip = ?, doctor_id = ? where id = ?");
				ps.setString(1, p.getStreet());
				ps.setString(2, p.getCity());
				ps.setString(3, p.getState());
				ps.setString(4, p.getZipcode());
				ps.setInt(5, rs.getInt(1));
				ps.setInt(6, p.getId());
				int rc = ps.executeUpdate();
				// rc is row count from executeUpdate
				if (rc == 1) {
					model.addAttribute("message", "Update successful.");
					model.addAttribute("patient", p);
					return "patient_show";
				} else {
					model.addAttribute("message", "Error. Update was not successful ");
					model.addAttribute("patient", p);
					return "patient_show";
				}}else {
				model.addAttribute("message", "Error. Update was not successful Physician does not exist");
				return "patient_edit";
			}

		}
		catch (SQLException e){
			model.addAttribute("message", "SQL error");
			model.addAttribute("patient", p);
			return "patient_edit";
		}

		// if there is error
		// model.addAttribute("message",  <error message>);
		// model.addAttribute("patient", p);
		// return "patient_edit";

	}

	/*
	 * return JDBC Connection using jdbcTemplate in Spring Server
	 */

	private Connection getConnection() throws SQLException {
		Connection conn = jdbcTemplate.getDataSource().getConnection();
		return conn;
	}

}
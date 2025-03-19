package com.csumb.cst363;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@SuppressWarnings("unused")
@Controller    
public class ControllerPrescriptionCreate {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/*
	 * Doctor requests blank form for new prescription.
	 * Do not modify this method.
	 */
	@GetMapping("/prescription/new")
	public String getPrescriptionForm(Model model) {
		model.addAttribute("prescription", new Prescription());
		return "prescription_create";
	}
	

	/*
	 * Doctor creates a prescription.
	 */
	@PostMapping("/prescription")
	public String createPrescription(Prescription p, Model model) {

		System.out.println("createPrescription " + p);
		PreparedStatement ps = null;
		ResultSet rs = null;
		// TODO
		try (Connection connection = getConnection();) {
			/*-
			 * Process the new prescription form.
			 * 1. Obtain connection to database.
			 * 2. Validate that doctor id and name exists

			 * 3. Validate that patient id and name exists
			 * 4. Validate that Drug name exists and obtain drug id.
			 * 5. Insert new prescription
			 * 6. Get generated value for rxid
			 * 7. Update prescription object and return
			 */
			String sql = "SELECT id FROM doctor WHERE id = ? AND first_name = ? AND last_name = ?";
			ps = connection.prepareStatement(sql);
			ps.setInt(1, p.getDoctor_id());
			ps.setString(2, p.getDoctorFirstName());
			ps.setString(3, p.getDoctorLastName());
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new SQLException("Doctor not found");
			}

			sql = "SELECT id FROM patient WHERE id = ? AND first_name = ? AND last_name = ?";
			ps = connection.prepareStatement(sql);
			ps.setInt(1, p.getPatient_id());
			ps.setString(2, p.getPatientFirstName());
			ps.setString(3, p.getPatientLastName());
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new SQLException("Patient not found");
			}

			sql = "SELECT id FROM drug WHERE name = ?";
			ps = connection.prepareStatement(sql);
			ps.setString(1, p.getDrugName());
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new SQLException("Drug not found");
			}
			int drugId = rs.getInt("id");

			sql = "INSERT INTO prescription (doctor_id, patient_id, drug_id, date_prescribed, quantity, refills) VALUES (?, ?, ?, ?, ?, ?)";
			ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, p.getDoctor_id());
			ps.setInt(2, p.getPatient_id());
			ps.setInt(3, drugId);
			ps.setDate(4, java.sql.Date.valueOf(LocalDate.now()));
			ps.setInt(5, p.getQuantity());
			ps.setInt(6, p.getRefills());
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();

			if(rs.next())
			{
				p.setRxid((rs.getString(1)));
			}

			model.addAttribute("message", "Prescription created.");
			model.addAttribute("prescription", p);
			return "prescription_show";
		}catch(SQLException e){
			// if there is error
			 model.addAttribute("message",  "SQL Error."+e.getMessage());
			 model.addAttribute("prescription", p);
			 return "prescription_create";
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

package com.csumb.cst363;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@SuppressWarnings("unused")
@Controller   
public class ControllerPrescriptionFill {

	@Autowired
	private JdbcTemplate jdbcTemplate;


	/* 
	 * Patient requests form to search for prescription.
	 * Do not modify this method.
	 */
	@GetMapping("/prescription/fill")
	public String getfillForm(Model model) {
		model.addAttribute("prescription", new Prescription());
		return "prescription_fill";
	}


	/*
	 * Pharmacy fills prescription.
	 */
	@PostMapping("/prescription/fill")
	public String processFillForm(Prescription p, Model model) {

		System.out.println("processFillForm " + p);

		// TODO
		try(Connection connection = getConnection();) {
			// obtain connection to database.

			// valid pharamcy name and address in the prescription object and obtain the
			// pharmacy id.
			String pharmacySql = "SELECT id FROM pharmacy WHERE name = ? AND address = ?";
			PreparedStatement ps = connection.prepareStatement(pharmacySql);
			ps.setString(1, p.getPharmacyName());
			ps.setString(2, p.getPharmacyAddress());
			ResultSet rsPharmacy = ps.executeQuery();

			if (!rsPharmacy.next()) {
				throw new SQLException("Pharmacy not found.");
			}
			int id = rsPharmacy.getInt("id");
			// get prescription information for the rxid value and patient last name from
			// prescription object.
			String pres ="SELECT * FROM prescription WHERE rxid = ? AND patient_last_name = ?";
			PreparedStatement ps1 = connection.prepareStatement(pres);
			ps1.setString(1, p.getRxid());
			ps1.setString(2, p.getPatientLastName());
			ResultSet rsPresciption = ps1.executeQuery();

			if (!rsPresciption.next()) {
				throw new SQLException("Prescription not found.");
			}
			// copy prescription information into the prescription object for display.
			p.setDrugName(rsPresciption.getString("drug_name"));
			p.setQuantity(rsPresciption.getInt("quantity"));
			p.setRefills(rsPresciption.getInt("refills"));
			// get cost of drug and copy into prescription for display.
			p.setCost(String.valueOf(rsPresciption.getDouble("cost")));
			// update prescription table row with pharmacy id, fill date.
			String updateSQL = "UPDATE prescription SET pharmacy_id = ?, fill_date = CURRENT_DATE WHERE rxid = ?";
			PreparedStatement ps2 = connection.prepareStatement(updateSQL);
			ps2.setInt(1, id);
			ps2.setString(2, p.getRxid());
			int updateCount = ps2.executeUpdate();

			if (updateCount == 0) {
				throw new SQLException("Failed to update the prescription");
			}
			model.addAttribute("message", "Prescription filled.");
			model.addAttribute("prescription", p);
			return "prescription_show";
			// if there is error
			// model.addAttribute("message", <error message>);
			// model.addAttribute("prescription", p);
			// return "prescription_fill";
		}catch(SQLException e) {
			model.addAttribute("message", "SQL Error."+e.getMessage());
			model.addAttribute("prescription", p);
			return "prescription_fill";
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
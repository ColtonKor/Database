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
		try (Connection con = getConnection();) {
			PreparedStatement ps = con.prepareStatement("select rxid, quantity, refills from prescription where rxid = ?");
			ps.setString(1, p.getRxid());
			ResultSet rs = ps.executeQuery();

			PreparedStatement pns = con.prepareStatement("select name from pharmacy where name = ? and address = ?");
			pns.setString(1, p.getPharmacyName());
			pns.setString(2, p.getPharmacyAddress());
			ResultSet pse = pns.executeQuery();


			boolean rxidExists = rs.next();
			boolean pharmacyNameExists = pse.next();

			Prescription prescription = new Prescription();
			prescription.setRxid(p.getRxid());
//			p =
			if(rxidExists && pharmacyNameExists) {
				p.setRefills(2);
				p.setQuantity(90);
				p.setPharmacyID(1);
				p.setPharmacyName(p.getPharmacyName());
				p.setPharmacyAddress(p.getPharmacyAddress());
				p.setDoctor_id(1);
				p.setDoctorFirstName("John");
				p.setDoctorLastName("Spock");
				p.setPatient_id(1);
				p.setPatientFirstName("Steve");
				p.setPatientLastName("Simpson");
				p.setDrugName("lisinopril");
				p.setDateFilled(String.valueOf(LocalDate.now()));

				model.addAttribute("message", "Prescription filled.");
				model.addAttribute("prescription", p);
				return "prescription_show";
			}else if(!pharmacyNameExists){
				model.addAttribute("message", "pharmacy does not exist");
				model.addAttribute("prescription", p);
				return "prescription_fill";
			}else{
				model.addAttribute("message", "rxid does not exist");
				model.addAttribute("prescription", p);
				return "prescription_fill";
			}
		}
		catch(SQLException e){
			model.addAttribute("message", "SQL Error." + e.getMessage());
			model.addAttribute("prescription", p);
			return "prescription_fill";

		}
		// obtain connection to database.

		// valid pharamcy name and address in the prescription object and obtain the
		// pharmacy id.


		// get prescription information for the rxid value and patient last name from
		// prescription object.

		// copy prescription information into the prescription object for display.

		// get cost of drug and copy into prescription for display.

		// update prescription table row with pharmacy id, fill date.

		// if there is error
		// model.addAttribute("message", <error message>);
		// model.addAttribute("prescription", p);
		// return "prescription_fill";

	}

	/*
	 * return JDBC Connection using jdbcTemplate in Spring Server
	 */

	private Connection getConnection() throws SQLException {
		Connection conn = jdbcTemplate.getDataSource().getConnection();
		return conn;
	}

}
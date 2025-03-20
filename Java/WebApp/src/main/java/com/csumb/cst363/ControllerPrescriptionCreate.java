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

		// TODO
		try (Connection con = getConnection();) {
			PreparedStatement ds = con.prepareStatement("select id from doctor where last_name = ? && first_name = ? && id = ?");
			ds.setString(1, p.getDoctorLastName());
			ds.setString(2, p.getDoctorFirstName());
			ds.setInt(3, p.getDoctor_id());

			PreparedStatement ps = con.prepareStatement("select id from patient where last_name = ? && first_name = ? && id = ?");
			ps.setString(1, p.getPatientLastName());
			ps.setString(2, p.getPatientFirstName());
			ps.setInt(3, p.getPatient_id());

			PreparedStatement drug = con.prepareStatement("select drugID from drug where name = ? ");
			drug.setString(1, p.getDrugName());

			ResultSet rs = ds.executeQuery();
			ResultSet rps = ps.executeQuery();
			ResultSet rds = drug.executeQuery();

			boolean doctorExists = rs.next();
			boolean patientExists = rps.next();
			boolean drugExists = rds.next();


			if (doctorExists && patientExists && drugExists) {
				ps = con.prepareStatement("insert into prescription(doctor_id, patient_id, drug_id, quantity, refills, create_date) values(?, ?, ?, ?, ?, ?)",
						Statement.RETURN_GENERATED_KEYS);

				ps.setInt(1, p.getDoctor_id());
				ps.setInt(2, p.getPatient_id());
				ps.setInt(3, rds.getInt("drugID"));
				ps.setInt(4, p.getQuantity());
				ps.setInt(5, p.getRefills());
				ps.setString(6, p.getDateCreated());


				ps.executeUpdate();
				rs = ps.getGeneratedKeys();
				if (rs.next()) {
					p.setRxid(rs.getString(1));
					p.setDateFilled(String.valueOf(LocalDate.now()));
				}

				// display message and patient information
				model.addAttribute("message", "Prescription created.");
				model.addAttribute("prescription", p);
				return "prescription_show";

			} else if (!doctorExists){
				model.addAttribute("message", "Doctor not found, Creation Failed");
				return "prescription_create";
			}  else if (!patientExists){
				model.addAttribute("message", "Patient not found, Creation Failed");
				return "prescription_create";
			}else {
				model.addAttribute("message", "Drug not found, Creation Failed");
				return "prescription_create";
			}
		} catch (SQLException e) {
			model.addAttribute("message", "SQL Error." + e.getMessage());
			model.addAttribute("prescription", p);
			return "prescription_create";
		}

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

		// if there is error
		// model.addAttribute("message",  <error message>);
		// model.addAttribute("prescription", p);
		// return "prescription_create";

	}
	
	/*
	 * return JDBC Connection using jdbcTemplate in Spring Server
	 */

	private Connection getConnection() throws SQLException {
		Connection conn = jdbcTemplate.getDataSource().getConnection();
		return conn;
	}
	
}

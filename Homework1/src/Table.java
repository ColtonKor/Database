
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Represents a table contains rows of Instructor
 *
 */
public class Table implements Iterable<Instructor> {
	
	private ArrayList<Instructor> instructors = new ArrayList<>();
	
	/**
	 * Add an instructor object to the table.
	 * If the ID of the instructor already exists in the table, then 
	 * do not add and return false.  Otherwise add the instructor object
	 * and return true.
	 * @param add object to be added to table
	 * @return whether or not the instructor object was successfully added
	 */
	public boolean insert(Instructor add) {
		// TO DO complete this method
//		throw new  UnsupportedOperationException();
		for (int i = 0; i < instructors.size(); i++) {
			if(add == instructors.get(i)){
				return false;
			}
		}
		instructors.add(add);
		return true;
	}
	
	/**
	 * Remove the instructor object with ID value
	 * from the table.  Return false if no such object
	 * exists, other return true.
	 * @param ID the ID of the instructor to lok up
	 */
	public boolean delete(int ID) {
		// TO DO complete this method
//		throw new UnsupportedOperationException();
		for (int i = 0; i < instructors.size(); i++) {
			if(ID == instructors.get(i).getID()){
				instructors.remove(i);
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Return the Instructor object with the value ID,
	 * Return null if no such object exists in the table
	 * @param ID the ID of the instructor to lok up
	 */
	public Instructor lookup(int ID) {
		// TO DO complete this method
//		throw new UnsupportedOperationException();
		for (int i = 0; i < instructors.size(); i++) {
			if(ID == instructors.get(i).getID()){
				return instructors.get(i);
			}
		}
		return null;
	}
	
	/**
	 * Return a Table of Instructor objects filtered by the 
	 * predicate  attrName = value 
	 * @param attrName can be ID, name, dept_name or salary
	 * @param value value of data type int or String
	 * @return a table containing the objects associated with the query (0, 1, or many)
	 */
	public Table eval(String attrName, Object value) {
		// TO DO complete this method
//		throw new UnsupportedOperationException();
		Table result = new Table();
		for (int i = 0; i < instructors.size(); i++) {
			if(attrName.equals("ID")){
				if(value.equals(instructors.get(i).getID())){
					result.insert(instructors.get(i));
				}
			} else if(attrName.equals("name")){
				if(value.equals(instructors.get(i).getName())){
					result.insert(instructors.get(i));
				}
			} else if(attrName.equals("dept_name")){
				if(value.equals(instructors.get(i).getDept_name())){
					result.insert(instructors.get(i));
				}
			} else if(attrName.equals("salary")){
				if(value.equals(instructors.get(i).getSalary())){
					result.insert(instructors.get(i));
				}
			}
		}
		return result;
	}
	
	public Iterator<Instructor> iterator() {
		return instructors.iterator();
	}
	
	public String toString() {
		if (instructors.isEmpty()) {
			return "Empty Table";
		} else {
			StringBuilder sb = new StringBuilder();
			for (Instructor t : this) {
				sb.append(t.toString());
				sb.append("\n");
			}
			return sb.toString();
		}
	}

}

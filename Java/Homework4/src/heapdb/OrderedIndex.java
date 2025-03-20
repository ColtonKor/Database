package heapdb;

import java.util.ArrayList;

public class OrderedIndex implements Index {
	
	private String name;
	
	/*
	 * Each index value is represented by an IndexEntry
	 * containing the key value and the list of row numbers.
	 */
	private class IndexEntry {
		int key;
		ArrayList<Integer> rows = new ArrayList<>();
	}
	
	private ArrayList<IndexEntry> entries = new ArrayList<>();
	
	public OrderedIndex() {
		name="";
	}
	
	public OrderedIndex(String indexName) {
		this.name = indexName;
	}
	
	@Override
	public boolean insert(int key, int row_no) {
	
		// TODO 
		
		// add a new IndexEntry or 
		// add the row_no to an existing entry
		int index = searchGE(key);

		if (index < entries.size() && entries.get(index).key == key) {
			entries.get(index).rows.add(row_no);
		} else {
			IndexEntry newEntry = new IndexEntry();
			newEntry.key = key;
			newEntry.rows.add(row_no);
			entries.add(index, newEntry);
		}
		return true;
		
//		throw new UnsupportedOperationException();

	}

	@Override
	public int lookupOne(int key) {
		// TODO
		// return the row number of the key.
		// -1 if the key does not exist

		// if there are multiple row numbers, return the first one.
		int index = searchEQ(key);
		if(index == -1){
			return index;
		} else {
			return entries.get(index).rows.get(0);
		}
//		throw new UnsupportedOperationException();
	}
	
	@Override
	public ArrayList<Integer> lookupMany(int key){
		// TODO 
		// return the list of row number for the key.
		// if the key does not exist, return an empty list.
		int index = searchEQ(key);
		if(index == -1) {
			return new ArrayList<>();
		} else {
			return new ArrayList<>(entries.get(index).rows);
		}
//		throw new UnsupportedOperationException();
	}
	
	@Override
	public boolean delete(int key, int row_no) {
		
		// TODO 
		// delete row_number from the list of row numbers for the key
		// if the key is not found, return false
		// if the list of row_number is empty, delete the index entry

		int index = searchEQ(key);
		if(index == -1){
			return false;
		}
		IndexEntry entry = entries.get(index);
		if (entry.rows.remove(Integer.valueOf(row_no))) {
			if (entry.rows.isEmpty()) {
				entries.remove(index);
			}
			return true;
		}

		return false;
//		throw new UnsupportedOperationException();
	}
	
	/*
	 * return -1 if the key not found in entries
	 * return index of entries equal to key
	 */
	private int searchEQ(int key) {
		// TODO 
		// perform binary search for key value
//		throw new UnsupportedOperationException();

		int low = 0;
		int high = entries.size() - 1;

		while (low <= high) {
			int mid = (low + high) / 2;
			IndexEntry entry = entries.get(mid);
			if (entry.key == key) {
				return mid;
			} else if (entry.key < key) {
				low = mid + 1;
			} else {
				high = mid - 1;
			}
		}
		return -1;
	}
	
	/*
	 * return index of entry equal to key 
	 * or where to add the new entry
	 */
	private int searchGE(int key) {
		// TODO 
		// perform binary search 
//		throw new UnsupportedOperationException();

		int low = 0;
		int high = entries.size() - 1;

		while (low <= high) {
			int mid = (low + high) / 2;
			IndexEntry entry = entries.get(mid);
			if (entry.key == key) {
				return mid;
			} else if (entry.key < key) {
				low = mid + 1;
			} else {
				high = mid - 1;
			}
		}
		return low;
	}
	
	
	public void diagnosticPrint() {
		System.out.println(name);
		for (IndexEntry entry : entries) {
			System.out.printf("%d, %s\n", entry.key, entry.rows.toString());
		}
	}

}

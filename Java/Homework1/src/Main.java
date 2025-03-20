public class Main {
    public static void main(String[] args) {
        Table table = new Table();

        table.insert(new Instructor(12121, "Kim", "Elec. Engr.", 65000));
        table.insert(new Instructor(19803, "Wisneski", "Comp. Sci.", 46000));
        table.insert(new Instructor(24734, "Bruns", "Comp. Sci.", 70000));
        table.insert(new Instructor(55552, "Scott", "Math", 80000));
        table.insert(new Instructor(12321, "Tao", "Comp. Sci.", 95000));

        System.out.println(table);

        System.out.println("Delete 12121: " + table.delete(12121));

        System.out.println("\n" + table);

        System.out.println("Delete 12121: " + table.delete(12121));

        System.out.println("\nlookup 19803: " + table.lookup(19803));

        System.out.println("lookup 12121: " + table.lookup(12121));

        System.out.println("\neval dept_name='Comp. Sci.'\n" + table.eval("dept_name", "Comp. Sci."));

        System.out.println("\neval ID=19803\n" + table.eval("ID", 19803));

        System.out.println("\neval ID=19802\n" + table.eval("ID", 19802));

    }
}

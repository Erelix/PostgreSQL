import java.sql.*;
import java.util.Scanner;

public class Main {
    private static final String URL = "jdbc:postgresql://pgsql3.mif/studentu";
    private static final String USER = "adkl9920";
    private static final String PASSWORD = "CH3COONa";

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int mainChoice = -1;

        while (mainChoice != 0) {
            displayMainMenu();
            System.out.print("Operacijos nr: ");
            if (scanner.hasNextInt()) {
                mainChoice = scanner.nextInt();
                scanner.nextLine();

                switch (mainChoice) {
                    case 1:
                        handleViewOperations(scanner);
                        break;
                    case 2:
                        handleAddOperations(scanner);
                        break;
                    case 3:
                        handleUpdateOperations(scanner);
                        break;
                    case 4:
                        handleDeleteOperations(scanner);
                        break;
                    case 0:
                        System.out.println("Teatras kuria žmogų, žmogus kuria teatrą.");
                        break;
                    default:
                        System.out.println("Netinkamas pasirinkimas. Prašome pasirnkti teisinga operacijos nr.");
                }
            } else {
                System.out.println("Bloga įvestis, prašome įvesti skaičių.");
                scanner.nextLine();
            }
        }

        scanner.close();
    }

    private static void displayMainMenu() {
        System.out.println("\n===== LNOBT DB Pagrindinis Menu =====");
        System.out.println("1. Pažiūrėjimo Operacijos");
        System.out.println("2. Pridėjimo Operacijos");
        System.out.println("3. Redagavimo Operacijos");
        System.out.println("4. Šalinimo Operacijos");
        System.out.println("0. Išeiti");
        System.out.println("==============================");
    }

    private static void handleViewOperations(Scanner scanner) {
        int choice = -1;
        while (choice != 0) {
            displayViewMenu();
            System.out.print("Operacijos nr: ");
            if (scanner.hasNextInt()) {
                choice = scanner.nextInt();
                scanner.nextLine();

                switch (choice) {
                    case 1:
                        viewBaletoArtistas();
                        break;
                    case 2:
                        viewOperosArtistas();
                        break;
                    case 3:
                        viewSpektaklis();
                        break;
                    case 4:
                        viewRepertuaras();
                        break;
                    case 5:
                        viewDalyvauja();
                        break;
                    case 6:
                        viewPasirodymas();
                        break;
                    case 7:
                        viewBaluSkaiciuokle();
                        break;
                    case 8:
                        viewSpektakliuTarifuVidurkiai();
                        break;
                    case 9:
                        viewTopArtistai();
                        break;
                    case 10:
                        viewBaletoArtistas();
                        viewOperosArtistas();
                        searchSpektaklisByArtistas(scanner);
                        break;
                    case 0:
                        break;
                    default:
                        System.out.println("Netinkamas pasirinkimas. Prašome pasirnkti teisinga operacijos nr.");
                }
            } else {
                System.out.println("Bloga įvestis, prašome įvesti skaičių.");
                scanner.nextLine();
            }
        }
    }

    private static void displayViewMenu() {
        System.out.println("\n----- Pažiūrėjimo Operacijos -----");
        System.out.println("1. Baleto Artistų sąrašas");
        System.out.println("2. Operos Artistų sąrašas");
        System.out.println("3. Spektaklių sąrašas");
        System.out.println("4. Repertuarai");
        System.out.println("5. Dalyvaujama");
        System.out.println("6. Pasirodymai");
        System.out.println("7. Balų Skaiciuoklė");
        System.out.println("8. Spektaklių Tarifų Vidurkiai");
        System.out.println("9. Metų solistai");
        System.out.println("10. Ieškoti Spektaklių pagal Artistą");
        System.out.println("0. Atgal į Pagrindinį Meniu");
        System.out.println("----------------------------");
    }

    private static void handleAddOperations(Scanner scanner) {
        int choice = -1;
        while (choice != 0) {
            displayAddMenu();
            System.out.print("Operacijos nr: ");
            if (scanner.hasNextInt()) {
                choice = scanner.nextInt();
                scanner.nextLine();

                switch (choice) {
                    case 1:
                        viewOperosArtistas();
                        addOperosArtistas(scanner);
                        viewOperosArtistas();
                        break;
                    case 2:
                        viewBaletoArtistas();
                        addBaletoArtistas(scanner);
                        viewBaletoArtistas();
                        break;
                    case 3:
                        viewSpektaklis();
                        addSpektaklis(scanner);
                        viewSpektaklis();
                        break;
                    case 4:
                        viewBaletoArtistas();
                        viewOperosArtistas();
                        viewSpektaklis();
                        addDalyvauja(scanner);
                        viewDalyvauja();
                        break;
                    case 5:
                        viewSpektaklis();
                        viewRepertuaras();
                        addPasirodymas(scanner);
                        viewPasirodymas();
                        break;
                    case 6:
                        viewRepertuaras();
                        addRepertuaras(scanner);
                        viewRepertuaras();
                        break;
                    case 0:
                        break;
                    default:
                        System.out.println("Netinkamas pasirinkimas. Prašome pasirnkti teisinga operacijos nr.");
                }
            } else {
                System.out.println("Bloga įvestis, prašome įvesti skaičių.");
                scanner.nextLine();
            }
        }
    }

    private static void displayAddMenu() {
        System.out.println("\n----- Pridėjimo Operacijos -----");
        System.out.println("1. Operos Artisto užregistravimas");
        System.out.println("2. Baleto Artisto užregistravimas");
        System.out.println("3. Spektaklio užregistravimas");
        System.out.println("4. Dalyvaujamos sąstatos pridėjimas");
        System.out.println("5. Pasirodymo priskyrimas");
        System.out.println("6. Repertuaro sukūrimas");
        System.out.println("0. Atgal į Pagrindinį Meniu");
        System.out.println("--------------------------");
    }

    private static void handleUpdateOperations(Scanner scanner) {
        int choice = -1;
        while (choice != 0) {
            displayUpdateMenu();
            System.out.print("Operacijos nr: ");
            if (scanner.hasNextInt()) {
                choice = scanner.nextInt();
                scanner.nextLine();

                switch (choice) {
                    case 1:
                        viewBaletoArtistas();
                        viewOperosArtistas();
                        viewSpektaklis();
                        updateDalyvauja(scanner);
                        viewDalyvauja();
                        break;
                    case 2:
                        viewSpektaklis();
                        viewRepertuaras();
                        updatePasirodymas(scanner);
                        viewPasirodymas();
                        break;
                    case 3:
                        viewRepertuaras();
                        updateRepertuaras(scanner);
                        viewRepertuaras();
                        break;
                    case 0:
                        break;
                    default:
                        System.out.println("Netinkamas pasirinkimas. Prašome pasirnkti teisinga operacijos nr.");
                }
            } else {
                System.out.println("Bloga įvestis, prašome įvesti skaičių.");
                scanner.nextLine();
            }
        }
    }

    private static void displayUpdateMenu() {
        System.out.println("\n----- Redagavimo Operacijos -----");
        System.out.println("1. Redaguoti Sąstatus");
        System.out.println("2. Redaguoti Pasirodymus");
        System.out.println("3. Redaguoti Repertuarus");
        System.out.println("0. Atgal į Pagrindinį Meniu");
        System.out.println("------------------------------");
    }

    private static void handleDeleteOperations(Scanner scanner) {
        int choice = -1;
        while (choice != 0) {
            displayDeleteMenu();
            System.out.print("Operacijos nr: ");
            if (scanner.hasNextInt()) {
                choice = scanner.nextInt();
                scanner.nextLine();

                switch (choice) {
                    case 1:
                        viewDalyvauja();
                        deleteDalyvauja(scanner);
                        viewDalyvauja();
                        break;
                    case 2:
                        viewPasirodymas();
                        deletePasirodymas(scanner);
                        viewPasirodymas();
                        break;
                    case 0:
                        break;
                    default:
                        System.out.println("Netinkamas pasirinkimas. Prašome pasirnkti teisinga operacijos nr.");
                }
            } else {
                System.out.println("Bloga įvestis, prašome įvesti skaičių.");
                scanner.nextLine(); // Consume invalid input
            }
        }
    }

    private static void displayDeleteMenu() {
        System.out.println("\n----- Šalinimo Operacijos -----");
        System.out.println("1. Šalinti Sąstatą");
        System.out.println("2. Šalinti Pasirodymas");
        System.out.println("0. Atgal į Pagrindinį Meniu");
        System.out.println("------------------------------");
    }

    // view ============================================================================

    private static void viewBaletoArtistas() {
        String query = "SELECT * FROM Baleto_artistas ORDER BY Id";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            System.out.println("\n--- Baleto Artistas ---");
            System.out.printf("%-5s %-12s %-20s %-5s %-10s %-10s %-5s %-20s\n",
                    "ID", "Vardas", "Pavarde", "Lytis", "Gimimas", "Isidarbino", "Ugis", "Rangas");
            while (rs.next()) {
                System.out.printf("%-5d %-12s %-20s %-5s %-10s %-10s %-5d %-20s\n",
                        rs.getInt("Id"),
                        rs.getString("Vardas"),
                        rs.getString("Pavarde"),
                        rs.getString("Lytis"),
                        rs.getDate("Gimimas"),
                        rs.getDate("Isidarbino"),
                        rs.getInt("Ugis"),
                        rs.getString("Rangas"));
            }
        } catch (SQLException e) {
            System.err.println("Error traukiant Baleto_artistas data.");
            e.printStackTrace();
        }
    }

    private static void viewOperosArtistas() {
        String query = "SELECT * FROM Operos_artistas ORDER BY Id";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            System.out.println("\n--- Operos Artistas ---");
            System.out.printf("%-5s %-12s %-20s %-5s %-10s %-10s %-13s %-7s\n",
                    "ID", "Vardas", "Pavarde", "Lytis", "Gimimas", "Isidarbino", "Balsas", "Rangas");
            while (rs.next()) {
                System.out.printf("%-5d %-12s %-20s %-5s %-10s %-10s %-13s %-7s\n",
                        rs.getInt("Id"),
                        rs.getString("Vardas"),
                        rs.getString("Pavarde"),
                        rs.getString("Lytis"),
                        rs.getDate("Gimimas"),
                        rs.getDate("Isidarbino"),
                        rs.getString("Balsas"),
                        rs.getString("Rangas"));
            }
        } catch (SQLException e) {
            System.err.println("Error traukiant Operos_artistas data.");
            e.printStackTrace();
        }
    }

    private static void viewSpektaklis() {
        String query = "SELECT * FROM Spektaklis ORDER BY Id";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            System.out.println("\n--- Spektaklis ---");
            System.out.printf("%-5s %-32s %-10s %-5s %-32s\n",
                    "ID", "Pavadinimas", "Veiksmu_sk", "Tipas", "Stilius");
            while (rs.next()) {
                System.out.printf("%-5d %-32s %-10d %-5s %-32s\n",
                        rs.getInt("Id"),
                        rs.getString("Pavadinimas"),
                        rs.getInt("Veiksmu_sk"),
                        rs.getString("Tipas"),
                        rs.getString("Stilius"));
            }
        } catch (SQLException e) {
            System.err.println("Error traukiant Spektaklis data.");
            e.printStackTrace();
        }
    }

    private static void viewRepertuaras() {
        String query = "SELECT * FROM Repertuaras ORDER BY Sezonas";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            System.out.println("\n--- Repertuaras ---");
            System.out.printf("%-7s %-12s %-12s\n",
                    "Sezonas", "Pradzia_sez", "Pabaiga_sez");
            while (rs.next()) {
                System.out.printf("%-7d %-12d %-12d\n",
                        rs.getInt("Sezonas"),
                        rs.getInt("Pradzia_sez"),
                        rs.getInt("Pabaiga_sez"));
            }
        } catch (SQLException e) {
            System.err.println("Error traukiant Repertuaras data.");
            e.printStackTrace();
        }
    }

    private static void viewDalyvauja() {
        String query = "SELECT * FROM Dalyvauja ORDER BY Id";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            System.out.println("\n--- Dalyvauja ---");
            System.out.printf("%-5s %-18s %-18s %-12s %-20s %-20s %-5s\n",
                    "ID", "Operos_artisto_id", "Baleto_artisto_id", "Spektaklio_id", "Uzimtumas", "Vaidmuo", "Balai");
            while (rs.next()) {
                System.out.printf("%-5d %-18s %-18s %-12d %-20s %-20s %-5.1f\n",
                        rs.getInt("Id"),
                        rs.getObject("Operos_artisto_id"),
                        rs.getObject("Baleto_artisto_id"),
                        rs.getInt("Spektaklio_id"),
                        rs.getString("Uzimtumas"),
                        rs.getString("Vaidmuo"),
                        rs.getDouble("Balai"));
            }
        } catch (SQLException e) {
            System.err.println("Error traukiant Dalyvauja data.");
            e.printStackTrace();
        }
    }

    private static void viewPasirodymas() {
        String query = "SELECT * FROM Pasirodymas ORDER BY Pasirodymo_data";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            System.out.println("\n--- Pasirodymas ---");
            System.out.printf("%-20s %-15s %-20s %-7s %-14s\n",
                    "Pasirodymo_data", "Spektaklio_id", "Repertuaras", "Tarifas", "Ziurovai");
            while (rs.next()) {
                System.out.printf("%-20s %-15d %-20d %-7d %-14s\n",
                        rs.getTimestamp("Pasirodymo_data"),
                        rs.getInt("Spektaklio_id"),
                        rs.getInt("Repertuaras"),
                        rs.getInt("Tarifas"),
                        rs.getString("Ziurovai"));
            }
        } catch (SQLException e) {
            System.err.println("Error traukiant Pasirodymas data.");
            e.printStackTrace();
        }
    }

    private static void viewBaluSkaiciuokle() {
        String query = "SELECT * FROM Balu_skaiciuokle ORDER BY suma DESC";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            System.out.println("\n--- Balu Skaiciuokle ---");
            System.out.printf("%-12s %-20s %-10s %-15s\n",
                    "Vardas", "Pavarde", "suma", "artisto_tipas");
            while (rs.next()) {
                System.out.printf("%-12s %-20s %-10.1f %-15s\n",
                        rs.getString("Vardas"),
                        rs.getString("Pavarde"),
                        rs.getDouble("suma"),
                        rs.getString("artisto_tipas"));
            }
        } catch (SQLException e) {
            System.err.println("Error traukiant Balu_skaiciuokle data.");
            e.printStackTrace();
        }
    }

    private static void viewSpektakliuTarifuVidurkiai() {
        String query = "SELECT * FROM Spektakliu_tarifu_vidurkiai ORDER BY Vidutinis_Tarifas DESC";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            System.out.println("\n--- Spektakliu Tarifų Vidurkiai ---");
            System.out.printf("%-30s %-18s %-20s %-25s\n",
                    "Pavadinimas", "Pasirodymu_Skaicius", "Vidutinis_Tarifas", "Vidutiniskai_Gaunama_Is_Tarifu");
            while (rs.next()) {
                System.out.printf("%-30s %-18d %-20.2f %-25.2f\n",
                        rs.getString("Pavadinimas"),
                        rs.getInt("Pasirodymu_Skaicius"),
                        rs.getDouble("Vidutinis_Tarifas"),
                        rs.getDouble("vidutiniskai_gaunama_is_tarifu"));
            }
        } catch (SQLException e) {
            System.err.println("Error traukiant Spektakliu_tarifu_vidurkiai data.");
            e.printStackTrace();
        }
    }

    private static void viewTopArtistai() {
        String query = "SELECT * FROM top_Artistai ORDER BY vieta ASC";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            System.out.println("\n--- Top Artistai ---");
            System.out.printf("%-6s %-12s %-20s %-15s %-10s\n",
                    "Vieta", "Vardas", "Pavarde", "Artisto_Tipas", "Viso_Balu");
            while (rs.next()) {
                System.out.printf("%-6d %-12s %-20s %-15s %-10.1f\n",
                        rs.getInt("vieta"),
                        rs.getString("Vardas"),
                        rs.getString("Pavarde"),
                        rs.getString("Artisto_Tipas"),
                        rs.getDouble("Viso_Balu"));
            }
        } catch (SQLException e) {
            System.err.println("Error traukiant top_Artistai data.");
            e.printStackTrace();
        }
    }


    // Add ================================================================

    private static void addOperosArtistas(Scanner scanner) {
        System.out.println("\n--- Registruoti naują Operos Artistą ---");
        System.out.print("Vardas: ");
        String vardas = scanner.nextLine();

        System.out.print("Pavarde: ");
        String pavarde = scanner.nextLine();

        System.out.print("Lytis (Vyr/Mot): ");
        String lytis = scanner.nextLine();

        System.out.print("Gimimas (YYYY-MM-DD): ");
        String gimimasStr = scanner.nextLine();

        System.out.print("Isidarbino (YYYY-MM-DD): ");
        String isidarbinoStr = scanner.nextLine();

        System.out.print("Balsas (Soprano, Alto, Mezzo-soprano, Contralto, Countertenor, Tenor, Bass, Baritone): ");
        String balsas = scanner.nextLine();

        System.out.print("Rangas (Solista/Coro): ");
        String rangas = scanner.nextLine();

        String insertSQL = "INSERT INTO Operos_artistas (Vardas, Pavarde, Lytis, Gimimas, Isidarbino, Balsas, Rangas) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {

            pstmt.setString(1, vardas);
            pstmt.setString(2, pavarde);
            pstmt.setString(3, lytis);
            pstmt.setDate(4, Date.valueOf(gimimasStr));
            pstmt.setDate(5, Date.valueOf(isidarbinoStr));
            pstmt.setString(6, balsas);
            pstmt.setString(7, rangas);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Naujas Operos Artistas užregistruotas.");
            } else {
                System.out.println("Nepavyko užregistruoti Operos Artisto.");
            }
        } catch (SQLException e) {
            System.err.println("Error registruojant naują Operos Artistą.");
            e.printStackTrace();
        }
    }

    private static void addBaletoArtistas(Scanner scanner) {
        System.out.println("\n--- Registruoti naują Baleto Artistą ---");
        System.out.print("Vardas: ");
        String vardas = scanner.nextLine();

        System.out.print("Pavarde: ");
        String pavarde = scanner.nextLine();

        System.out.print("Lytis (Vyr/Mot): ");
        String lytis = scanner.nextLine();

        System.out.print("Gimimas (YYYY-MM-DD): ");
        String gimimasStr = scanner.nextLine();

        System.out.print("Isidarbino (YYYY-MM-DD): ");
        String isidarbinoStr = scanner.nextLine();

        System.out.print("Ugis (cm): ");
        int ugis = scanner.nextInt();
        scanner.nextLine();

        System.out.print("Rangas (Prima ballerina/Premier danseur/Sujet/Coryphee/Corps de ballet): ");
        String rangas = scanner.nextLine();

        String insertSQL = "INSERT INTO Baleto_artistas (Vardas, Pavarde, Lytis, Gimimas, Isidarbino, Ugis, Rangas) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {

            pstmt.setString(1, vardas);
            pstmt.setString(2, pavarde);
            pstmt.setString(3, lytis);
            pstmt.setDate(4, Date.valueOf(gimimasStr));
            pstmt.setDate(5, Date.valueOf(isidarbinoStr));
            pstmt.setInt(6, ugis);
            pstmt.setString(7, rangas);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Naujas Baleto Artistas užregistrotas.");
            } else {
                System.out.println("Nepavyko užregistroti naujo Baleto Artisto.");
            }
        } catch (SQLException e) {
            System.err.println("Error registruojant naują Baleto Artistą.");
            e.printStackTrace();
        }
    }

    private static void addSpektaklis(Scanner scanner) {
        System.out.println("\n--- Pridėti naują Spektaklį ---");
        System.out.print("Pavadinimas: ");
        String pavadinimas = scanner.nextLine();

        System.out.print("Veiksmu_sk (Veiksmų skaičius): ");
        int veiksmuSk = scanner.nextInt();
        scanner.nextLine();

        System.out.print("Tipas (O/B/OB): ");
        String tipas = scanner.nextLine();

        System.out.print("Stilius: ");
        String stilius = scanner.nextLine();

        String insertSQL = "INSERT INTO Spektaklis (Pavadinimas, Veiksmu_sk, Tipas, Stilius) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {

            pstmt.setString(1, pavadinimas);
            pstmt.setInt(2, veiksmuSk);
            pstmt.setString(3, tipas);
            pstmt.setString(4, stilius);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Sėkmingai pridėtas naujas spektaklis.");
            } else {
                System.out.println("Nepavyko pridėti naujo spektaklio.");
            }
        } catch (SQLException e) {
            System.err.println("Error pridedant naują spektaklį");
            e.printStackTrace();
        }
    }

    private static void addDalyvauja(Scanner scanner) {
        System.out.println("\n--- Naujo Sąstato pridėjimas ---");
        System.out.print("Operos_artisto_id (spaustkite \"enter\", kad praleistųmėte): ");
        String operosIdStr = scanner.nextLine();
        Integer operosId = operosIdStr.isEmpty() ? null : Integer.parseInt(operosIdStr);

        System.out.print("Baleto_artisto_id (spaustkite \"enter\", kad praleistųmėte): ");
        String baletoIdStr = scanner.nextLine();
        Integer baletoId = baletoIdStr.isEmpty() ? null : Integer.parseInt(baletoIdStr);

        System.out.print("Spektaklio_id: ");
        int spektaklioId = scanner.nextInt();
        scanner.nextLine();

        System.out.print("Uzimtumas (pvz., 1,2): ");
        String uzimtumas = scanner.nextLine();

        System.out.print("Vaidmuo: ");
        String vaidmuo = scanner.nextLine();

        System.out.print("Balai: ");
        double balai = scanner.nextDouble();
        scanner.nextLine();

        String insertSQL = "INSERT INTO Dalyvauja (Operos_artisto_id, Baleto_artisto_id, Spektaklio_id, Uzimtumas, Vaidmuo, Balai) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {

            if (operosId != null) {
                pstmt.setInt(1, operosId);
            } else {
                pstmt.setNull(1, Types.SMALLINT);
            }

            if (baletoId != null) {
                pstmt.setInt(2, baletoId);
            } else {
                pstmt.setNull(2, Types.SMALLINT);
            }

            pstmt.setInt(3, spektaklioId);
            pstmt.setString(4, uzimtumas);
            pstmt.setString(5, vaidmuo);
            pstmt.setDouble(6, balai);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Sėkmingai pridėtas naujas Sąstatas.");
            } else {
                System.out.println("Nepavyko pridėti naujo Sąstato.");
            }
        } catch (SQLException e) {
            System.err.println("Error pirdedant naują Sąstatą.");
            e.printStackTrace();
        }
    }

    private static void addPasirodymas(Scanner scanner) {
        System.out.println("\n--- Pridėti naują Pasirodymą ---");
        System.out.print("Spektaklio_id: ");
        int spektaklioId = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Repertuaras (Sezonas): ");
        int repertuaras = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Pasirodymo_data (YYYY-MM-DD HH:MM:SS): ");
        String pasirodymoDataStr = scanner.nextLine();
        System.out.print("Tarifas: ");
        int tarifas = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Ziurovai (Vaikams/Suaugusiesiems/Visiems): ");
        String ziurovai = scanner.nextLine();

        Connection conn = null;
        PreparedStatement pstmtInsert = null;
        PreparedStatement pstmtUpdate = null;

        String insertSQL = "INSERT INTO Pasirodymas (Pasirodymo_data, Spektaklio_id, Repertuaras, Tarifas, Ziurovai) " +
                "VALUES (?, ?, ?, ?, ?)";

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            conn.setAutoCommit(false);

            pstmtInsert = conn.prepareStatement(insertSQL);
            pstmtInsert.setTimestamp(1, Timestamp.valueOf(pasirodymoDataStr));
            pstmtInsert.setInt(2, spektaklioId);
            pstmtInsert.setInt(3, repertuaras);
            pstmtInsert.setInt(4, tarifas);
            pstmtInsert.setString(5, ziurovai);
            int rowsInserted = pstmtInsert.executeUpdate();

            pstmtUpdate.setInt(1, spektaklioId);
            int rowsUpdated = pstmtUpdate.executeUpdate();

            conn.commit();
            System.out.println("Sėkmingai pridėtas naujas Pasirodymas ir atnaujintas Spektaklis.");

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                    System.err.println("Transakcija atšaukta dėl klaidos.");
                } catch (SQLException ex) {
                    System.err.println("Klaida atliekant rollback.");
                    ex.printStackTrace();
                }
            }
            System.err.println("Error pridedant naują Pasirodymą.");
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException e) {
                    System.err.println("Klaida atstatant auto-commit.");
                    e.printStackTrace();
                }
            }
            if (pstmtInsert != null) {
                try {
                    pstmtInsert.close();
                } catch (SQLException e) {
                    System.err.println("Klaida uždarant PreparedStatement (insert).");
                    e.printStackTrace();
                }
            }
            if (pstmtUpdate != null) {
                try {
                    pstmtUpdate.close();
                } catch (SQLException e) {
                    System.err.println("Klaida uždarant PreparedStatement (update).");
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Klaida uždarant Connection.");
                    e.printStackTrace();
                }
            }
        }
    }


    private static void addRepertuaras(Scanner scanner) {
        System.out.println("\n--- Pridėti naują Repertuarą---");
        System.out.print("Sezonas: ");
        int sezonas = scanner.nextInt();
        scanner.nextLine();

        System.out.print("Pradzia_sez: ");
        int pradziaSez = scanner.nextInt();
        scanner.nextLine();

        System.out.print("Pabaiga_sez: ");
        int pabaigaSez = scanner.nextInt();
        scanner.nextLine();

        String insertSQL = "INSERT INTO Repertuaras (Sezonas, Pradzia_sez, Pabaiga_sez) " +
                "VALUES (?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {

            pstmt.setInt(1, sezonas);
            pstmt.setInt(2, pradziaSez);
            pstmt.setInt(3, pabaigaSez);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Sėkmingai pridėtas naujas Repertuaras.");
            } else {
                System.out.println("Nepavyko pridėti naujo Repertuaro.");
            }
        } catch (SQLException e) {
            System.err.println("Error Pridedant naują Repertuarą.");
            e.printStackTrace();
        }
    }

    // Update ========================================================

    private static void updateDalyvauja(Scanner scanner) {
        System.out.println("\n--- Redaguoti Sąstatą ---");
        System.out.print("Įveskite redaguojamo sąstato ID: ");
        int id = scanner.nextInt();
        scanner.nextLine();

        System.out.print("Naujas Operos_artisto_id (spauskite \"enter\", kad praleistųmėte): ");
        String operosIdStr = scanner.nextLine();
        Integer operosId = operosIdStr.isEmpty() ? null : Integer.parseInt(operosIdStr);

        System.out.print("Naujas Baleto_artisto_id (spauskite \"enter\", kad praleistųmėte): ");
        String baletoIdStr = scanner.nextLine();
        Integer baletoId = baletoIdStr.isEmpty() ? null : Integer.parseInt(baletoIdStr);

        System.out.print("Naujas Spektaklio_id (spauskite \"enter\", kad praleistųmėte): ");
        String spektaklioIdStr = scanner.nextLine();
        Integer spektaklioId = spektaklioIdStr.isEmpty() ? null : Integer.parseInt(spektaklioIdStr);

        System.out.print("Naujas Uzimtumas (e.g., 1,2): ");
        String uzimtumas = scanner.nextLine();

        System.out.print("Naujas Vaidmuo: ");
        String vaidmuo = scanner.nextLine();

        System.out.print("Naujas Balai: ");
        String balaiStr = scanner.nextLine();
        Double balai = balaiStr.isEmpty() ? null : Double.parseDouble(balaiStr);

        StringBuilder sqlBuilder = new StringBuilder("UPDATE Dalyvauja SET ");
        boolean first = true;

        if (operosIdStr != null && !operosIdStr.isEmpty()) {
            sqlBuilder.append("Operos_artisto_id = ?");
            first = false;
        }

        if (baletoIdStr != null && !baletoIdStr.isEmpty()) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("Baleto_artisto_id = ?");
            first = false;
        }

        if (spektaklioIdStr != null && !spektaklioIdStr.isEmpty()) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("Spektaklio_id = ?");
            first = false;
        }

        if (!uzimtumas.isEmpty()) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("Uzimtumas = ?");
            first = false;
        }

        if (!vaidmuo.isEmpty()) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("Vaidmuo = ?");
            first = false;
        }

        if (balai != null) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("Balai = ?");
            first = false;
        }

        sqlBuilder.append(" WHERE Id = ?");

        String updateSQL = sqlBuilder.toString();

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(updateSQL)) {

            int paramIndex = 1;

            if (operosId != null) {
                pstmt.setInt(paramIndex++, operosId);
            }

            if (baletoId != null) {
                pstmt.setInt(paramIndex++, baletoId);
            }

            if (spektaklioId != null) {
                pstmt.setInt(paramIndex++, spektaklioId);
            }

            if (!uzimtumas.isEmpty()) {
                pstmt.setString(paramIndex++, uzimtumas);
            }

            if (!vaidmuo.isEmpty()) {
                pstmt.setString(paramIndex++, vaidmuo);
            }

            if (balai != null) {
                pstmt.setDouble(paramIndex++, balai);
            }

            pstmt.setInt(paramIndex, id);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Sąstatas sėkmingai paredaguotas.");
            } else {
                System.out.println("Nerastas Sąstatas su tokiu ID.");
            }
        } catch (SQLException e) {
            System.err.println("Error redaguojant Sąstatą.");
            e.printStackTrace();
        }
    }

    private static void updatePasirodymas(Scanner scanner) {
        System.out.println("\n--- Redaguoti Pasirodymą ---");
        System.out.print("Įveskite Pasirodymo_data (YYYY-MM-DD HH:MM:SS), kuris bus redaguojamas: ");
        String pasirodymoDataStr = scanner.nextLine();

        System.out.print("Naujas Spektaklio_id (spaustkite \"enter\", kad paliktumėte nepakeistą): ");
        String spektaklioIdStr = scanner.nextLine();
        Integer spektaklioId = spektaklioIdStr.isEmpty() ? null : Integer.parseInt(spektaklioIdStr);

        System.out.print("Naujas Repertuaras (Sezonas) (spaustkite \"enter\", kad paliktumėte nepakeistą): ");
        String repertuarasStr = scanner.nextLine();
        Integer repertuaras = repertuarasStr.isEmpty() ? null : Integer.parseInt(repertuarasStr);

        System.out.print("Naujas Tarifas (spaustkite \"enter\", kad paliktumėte nepakeistą): ");
        String tarifasStr = scanner.nextLine();
        Integer tarifas = tarifasStr.isEmpty() ? null : Integer.parseInt(tarifasStr);

        System.out.print("Naujas Ziurovai (Vaikams/Suaugusiesiems/Visiems) (spaustkite \"enter\", kad paliktumėte nepakeistą): ");
        String ziurovai = scanner.nextLine();

        StringBuilder sqlBuilder = new StringBuilder("UPDATE Pasirodymas SET ");
        boolean first = true;

        if (spektaklioIdStr != null && !spektaklioIdStr.isEmpty()) {
            sqlBuilder.append("Spektaklio_id = ?");
            first = false;
        }

        if (repertuarasStr != null && !repertuarasStr.isEmpty()) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("Repertuaras = ?");
            first = false;
        }

        if (tarifas != null) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("Tarifas = ?");
            first = false;
        }

        if (!ziurovai.isEmpty()) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("Ziurovai = ?");
            first = false;
        }

        sqlBuilder.append(" WHERE Pasirodymo_data = ?");

        String updateSQL = sqlBuilder.toString();

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(updateSQL)) {

            int paramIndex = 1;

            if (spektaklioId != null) {
                pstmt.setInt(paramIndex++, spektaklioId);
            }

            if (repertuaras != null) {
                pstmt.setInt(paramIndex++, repertuaras);
            }

            if (tarifas != null) {
                pstmt.setInt(paramIndex++, tarifas);
            }

            if (!ziurovai.isEmpty()) {
                pstmt.setString(paramIndex++, ziurovai);
            }

            pstmt.setTimestamp(paramIndex, Timestamp.valueOf(pasirodymoDataStr));

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Sėkmingai pakeistas Pasirodymas.");
            } else {
                System.out.println("Nebuvo rastas pasirodymas su tokia Pasirodymo_data.");
            }
        } catch (SQLException e) {
            System.err.println("Error redaguojant Pasirodymas.");
            e.printStackTrace();
        }
    }

    private static void updateRepertuaras(Scanner scanner) {
        System.out.println("\n--- Redaguoti Repertuarą ---");
        System.out.print("Įveskite readaguojamo Repertuaro sezoną: ");
        int sezonas = scanner.nextInt();
        scanner.nextLine();

        System.out.print("New Pradzia_sez (spaustkite \"enter\", kad paliktumėte nepakeistą): ");
        String pradziaSezStr = scanner.nextLine();
        Integer pradziaSez = pradziaSezStr.isEmpty() ? null : Integer.parseInt(pradziaSezStr);

        System.out.print("New Pabaiga_sez (spaustkite \"enter\", kad paliktumėte nepakeistą): ");
        String pabaigaSezStr = scanner.nextLine();
        Integer pabaigaSez = pabaigaSezStr.isEmpty() ? null : Integer.parseInt(pabaigaSezStr);

        StringBuilder sqlBuilder = new StringBuilder("UPDATE Repertuaras SET ");
        boolean first = true;

        if (pradziaSezStr != null && !pradziaSezStr.isEmpty()) {
            sqlBuilder.append("Pradzia_sez = ?");
            first = false;
        }

        if (pabaigaSezStr != null && !pabaigaSezStr.isEmpty()) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("Pabaiga_sez = ?");
            first = false;
        }

        sqlBuilder.append(" WHERE Sezonas = ?");

        String updateSQL = sqlBuilder.toString();

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(updateSQL)) {

            int paramIndex = 1;

            if (pradziaSez != null) {
                pstmt.setInt(paramIndex++, pradziaSez);
            }

            if (pabaigaSez != null) {
                pstmt.setInt(paramIndex++, pabaigaSez);
            }

            pstmt.setInt(paramIndex, sezonas);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Sėkmingai pakeistas Repertuaras.");
            } else {
                System.out.println("Nebuvo rastas Repertuaras su tokiu Sezonas.");
            }
        } catch (SQLException e) {
            System.err.println("Error redaguojant Repertuaras.");
            e.printStackTrace();
        }
    }


    // Delete ===================================================

    private static void deleteDalyvauja(Scanner scanner) {
        System.out.println("\n--- Šalinti Dalyvauja ---");
        System.out.print("Įveskite Dalyvauja ID, kurį norite šalinti: ");
        int id = -1;
        while (id <= 0) {
            try {
                id = scanner.nextInt();
                scanner.nextLine();
                if (id <= 0) {
                    System.out.print("ID turi būti teigiamas skaičius. Įveskite dar kartą: ");
                }
            } catch (Exception e) {
                System.out.print("Neteisinga įvestis. Įveskite teigiamą skaičių: ");
                scanner.nextLine();
            }
        }

        String deleteSQL = "DELETE FROM Dalyvauja WHERE Id = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(deleteSQL)) {

            pstmt.setInt(1, id);

            int rowsDeleted = pstmt.executeUpdate();
            if (rowsDeleted > 0) {
                System.out.println("Dalyvauja įrašas sėkmingai pašalintas.");
            } else {
                System.out.println("Nerastas Dalyvauja įrašas su tokiu ID.");
            }
        } catch (SQLException e) {
            System.err.println("Error šalinant Dalyvauja įrašą.");
            e.printStackTrace();
        }
    }

    private static void deletePasirodymas(Scanner scanner) {
        System.out.println("\n--- Šalinti Pasirodymą ---");
        System.out.print("Įveskite Pasirodymo_data (YYYY-MM-DD HH:MM:SS), kurį norite šalinti: ");
        String pasirodymoDataStr = scanner.nextLine();

        String deleteSQL = "DELETE FROM Pasirodymas WHERE Pasirodymo_data = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(deleteSQL)) {

            pstmt.setTimestamp(1, Timestamp.valueOf(pasirodymoDataStr));

            int rowsDeleted = pstmt.executeUpdate();
            if (rowsDeleted > 0) {
                System.out.println("Pasirodymas sėkmingai pašalintas.");
            } else {
                System.out.println("Nerastas Pasirodymas su tokiu Pasirodymo_data.");
            }
        } catch (SQLException e) {
            System.err.println("Error šalinant Pasirodymas įrašą.");
            e.printStackTrace();
        }
    }


    private static void searchSpektaklisByArtistas(Scanner scanner) {
        System.out.println("\n--- Ieškoti Spektaklių pagal Artistą ---");
        System.out.print("Įveskite Artisto Vardą: ");
        String vardas = scanner.nextLine().trim();
        System.out.print("Įveskite Artisto Pavardę: ");
        String pavarde = scanner.nextLine().trim();

        String query = "SELECT S.Pavadinimas, D.vaidmuo, P.Pasirodymo_data " +
                "FROM Spektaklis S " +
                "JOIN Dalyvauja D ON S.Id = D.Spektaklio_id " +
                "JOIN Pasirodymas P ON S.Id = P.Spektaklio_id " +
                "LEFT JOIN Operos_artistas O ON D.Operos_artisto_id = O.Id " +
                "LEFT JOIN Baleto_artistas BA ON D.Baleto_artisto_id = BA.Id " +
                "WHERE (O.Vardas = ? AND O.Pavarde = ?) OR (BA.Vardas = ? AND BA.Pavarde = ?) " +
                "ORDER BY P.Pasirodymo_data DESC";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, vardas);
            pstmt.setString(2, pavarde);
            pstmt.setString(3, vardas);
            pstmt.setString(4, pavarde);

            try (ResultSet rs = pstmt.executeQuery()) {
                System.out.println("\n--- Ieškoti Spektaklių ---");
                System.out.printf("%-32s %-32s %-20s\n", "Spektaklio Pavadinimas", "Vaidmuo", "Pasirodymo Data");
                boolean found = false;
                while (rs.next()) {
                    String pavadinimas = rs.getString("Pavadinimas");
                    String vaidmuo = rs.getString("Vaidmuo");
                    Timestamp data = rs.getTimestamp("Pasirodymo_data");
                    System.out.printf("%-32s %-32s %-20s\n", pavadinimas, vaidmuo, data.toString());
                    found = true;
                }
                if (!found) {
                    System.out.println("Nerasta spektaklių pagal nurodytą artistą.");
                }
            }

        } catch (SQLException e) {
            System.err.println("Klaida ieškant spektaklių pagal artistą.");
            e.printStackTrace();
        }
    }


}

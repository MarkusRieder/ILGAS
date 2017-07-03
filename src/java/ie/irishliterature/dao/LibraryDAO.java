package ie.irishliterature.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.Library;

/**
 *
 * @author markus
 */
public class LibraryDAO {

    private static Connection connection;
    private static final Database db = new Database();

    protected static void connect() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                connection = db.getConnection();
            } catch (InstantiationException | IllegalAccessException | ClassNotFoundException ex) {
                Logger.getLogger(LibraryDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    protected static void disconnect() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }

    //insertBook
    public static int insertBook(Library library) throws DBException {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("INSERT INTO library ( referenceNumber, Title, Publisher, publishingYear, Genre, "
                    + "translationTitle, translationPublisher, translationPublisherYear, Language, Cover, CoverName, physicalDescription, "
                    + "Duplicates, Copies, Notes, ISBN, ISSN, LASTUPDATED) "
                    + "VALUES( ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?, ?, ?)");

            ps1.setString(1, library.getReferenceNumber());
            ps1.setString(2, library.getTitle());
            ps1.setString(3, library.getPublisher());
            ps1.setString(4, library.getPublisheryear());
            ps1.setString(5, library.getGenre());
            ps1.setString(6, library.getTranslationTitle());
            ps1.setString(7, library.getTranslationPublisher());
            ps1.setString(8, library.getTranslationPublisherYear());
            ps1.setString(9, library.getLanguage());
            ps1.setString(10, library.getCover());
            ps1.setString(11, library.getCoverName());
            ps1.setString(12, library.getPhysicalDescription());
            ps1.setInt(13, library.getDuplicates());
            ps1.setString(14, library.getCopies());
            ps1.setString(15, library.getNotes());
            ps1.setString(16, library.getISBN());
            ps1.setString(17, library.getISSN());
            ps1.setTimestamp(18, library.getLASTUPDATED());

            ps1.executeUpdate();

            ps2 = conn.prepareStatement("SELECT LAST_INSERT_ID()");
            res = ps2.executeQuery();

            System.out.println(" LAST_INSERT_ID(): " + res);

            if (res != null) {
                while (res.next()) {
                    id = res.getInt(1);
                }
            }

            conn.commit();
            DBConn.close(conn, ps1, ps2, res);

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps1, ps2, res);
            e.printStackTrace();
            throw new DBException("4 Excepion while accessing database");
        }

       // add Arrays to Application_Author / Application_Translator System 

        // reset variables
//        conn = null;
//        ps1 = null;
//        ps2 = null;
//        res = null;
// 
//        try {
//
//            ps1 = conn.prepareStatement("INSERT INTO Application_Author (ReferenceNumber, idAuthor) VALUES( ?,  ?)");
//
//            ps1.setInt(1, library.getBookID());
//            ps1.setString(2, library.getReferenceNumber());
////            ps1.setString(3, library.getAuthor());
//
//            conn = DBConn.getConnection();
//            conn.setAutoCommit(false);
//
//            conn.commit();
//            DBConn.close(conn, ps1, ps2, res);
//
//        } catch (ClassNotFoundException | SQLException e) {
//            DBConn.close(conn, ps1, ps2, res);
//            e.printStackTrace();
//            throw new DBException("4 Excepion while accessing database");
//        }

        return id;
    }

    //listAllLibrary
    @SuppressWarnings("unchecked")
    public static ArrayList listAllLibrary() throws DBException {
        ArrayList listLibrary = new ArrayList();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT * FROM Books");
            rs = ps.executeQuery();

            while (rs.next()) {
                Library library = new Library();

                library.setBookID(rs.getInt("bookID"));
                library.setReferenceNumber(rs.getString("referenceNumber"));
//                library.setAuthor(rs.getString("Author"));
                library.setTitle(rs.getString("Title"));
                library.setPublisher(rs.getString("Publisher"));
                library.setPublisheryear(rs.getString("publishingYear"));
                library.setGenre(rs.getString("Genre"));
                library.setTranslationTitle(rs.getString("translationTitle"));
                library.setTranslationPublisher(rs.getString("translationPublisher"));
                library.setTranslationPublisherYear(rs.getString("translationPublisherYear"));
//                library.setTranslator(rs.getString("Translator"));
                library.setLanguage(rs.getString("Language"));
                library.setPhysicalDescription(rs.getString("physicalDescription"));
                library.setDuplicates(rs.getInt("Duplicates"));
                library.setCopies(rs.getString("Copies"));
                library.setNotes(rs.getString("Notes"));
                library.setISBN(rs.getString("ISBN"));
                library.setISSN(rs.getString("ISSN"));

                listLibrary.add(library);
            }

            conn.commit();
            DBConn.close(conn, ps, rs);

            disconnect();

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, rs);
            throw new DBException("4 Excepion while accessing database");
        }

        return listLibrary;
    }
    //updateLibrary

    public static boolean updateLibrary(Library library, int bookID) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        boolean id;
        int committed = 0;
        ResultSet res = null;
        int book = bookID;

        System.out.println("doing insertBook::  ");
        try {
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            String sql = "UPDATE library SET ( bookID , referenceNumber , Author , Title , Publisher , publishingYear , Genre , translationTitle , translationPublisher , translationPublisherYear , Translator , Language , physicalDescription , Duplicates , Copies , Notes , ISBN , ISSN ) VALUES ( ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?,  ?)";
            sql += " WHERE bookID = " + book;

            System.out.println("sql::  " + sql);
            System.out.println("bookID::  " + bookID);

            ps1 = conn.prepareStatement(sql);

            ps1.setInt(1, library.getBookID());
            ps1.setString(2, library.getReferenceNumber());
//            ps1.setString(3, library.getAuthor());
            ps1.setString(4, library.getTitle());
            ps1.setString(5, library.getPublisher());
            ps1.setString(6, library.getPublisheryear());
            ps1.setString(7, library.getGenre());
            ps1.setString(8, library.getTranslationTitle());
            ps1.setString(9, library.getTranslationPublisher());
            ps1.setString(10, library.getTranslationPublisherYear());
//            ps1.setString(11, library.getTranslator());
            ps1.setString(12, library.getLanguage());
            ps1.setString(13, library.getPhysicalDescription());
            ps1.setInt(14, library.getDuplicates());
            ps1.setString(15, library.getCopies());
            ps1.setString(16, library.getNotes());
            ps1.setString(17, library.getISBN());
            ps1.setString(18, library.getISSN());

            ps1.executeUpdate();

            conn.commit();

            id = committed > 0;

            DBConn.close(conn, ps1, res);

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps1, res);
            throw new DBException("4 Excepion while accessing database");
        }
        System.out.println("return id::  " + id);
        return id;
    }

    //deleteBook
    public static boolean deleteBook(Library library) throws SQLException {

        Connection conn;
        PreparedStatement ps;
        boolean id = false;

        try {

            conn = DBConn.getConnection();

            String sql = "DELETE FROM library where bookID = ?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, library.getBookID());

            id = ps.executeUpdate() > 0;
            ps.close();
            disconnect();

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LibraryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return id;
    }

    @SuppressWarnings("unchecked")
    public static ArrayList getAllBooks() throws ClassNotFoundException, DBException, SQLException {

        ArrayList listLibrary = new ArrayList();
        Connection conn;
        PreparedStatement ps = null;

        try {

            conn = DBConn.getConnection();
            final String searchQuery = "SELECT * FROM Books";

            PreparedStatement Stmt = conn.prepareStatement(searchQuery);
            ResultSet res = Stmt.executeQuery(searchQuery);

            System.out.println("res:  " + res);

            if (res != null) {
                while (res.next()) {
                    Library library = new Library();

                    library.setBookID(res.getInt("BookID"));
                    library.setReferenceNumber(res.getString("referenceNumber"));
//                    library.setAuthor(res.getString("Author"));
                    library.setTitle(res.getString("Title"));
//                library.setPublisher(res.getString("Publisher"));
                    library.setPublisheryear(res.getString("Publisheryear"));
                    library.setGenre(res.getString("Genre"));
                    library.setTranslationTitle(res.getString("translationTitle"));
//                library.setTranslationPublisher(res.getString("translationPublisher"));
                    library.setTranslationPublisherYear(res.getString("translationPublisherYear"));
//                    library.setTranslator(res.getString("Translator"));
                    library.setLanguage(res.getString("Language"));
                    library.setPhysicalDescription(res.getString("physicalDescription"));
                    library.setDuplicates(res.getInt("Duplicates"));
                    library.setCopies(res.getString("Copies"));
                    library.setNotes(res.getString("Notes"));
                    library.setISBN(res.getString("ISBN"));
                    library.setISSN(res.getString("ISSN"));

                    listLibrary.add(library);
                }
            } else {

            }

            DBConn.close(conn, ps, res);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LibraryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return listLibrary;
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sl.dao;

import com.sl.db.DBConn;
import com.sl.db.DBException;
import com.sl.model.Publisher;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

/**
 *
 * @author markus
 *
 * returns publisherList containing object (pojo) publisher
 *
 * using database field names
 *
 * AC = autocomplete
 *
 */
@SuppressWarnings("unchecked")
public class ACpublisherDAO_test {

    private static Connection connection;
    private static final Database db = new Database();

    protected static void connect() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                connection = db.getConnection();
            } catch (InstantiationException | IllegalAccessException | ClassNotFoundException ex) {
                Logger.getLogger(ACpublisherDAO_test.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    protected static void disconnect() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }

    //getpublisher by Name
    public ArrayList getpublisher(String s) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

        ArrayList publisherList = new ArrayList();

        connect();

        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM international_publishers WHERE Company  like ?");
            ps.setString(1, "%" + s + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Publisher publisher = new Publisher();

                publisher.setId(rs.getString("Company_Number"));
                publisher.setValue(rs.getString("Company"));
                publisher.setCompany(rs.getString("Company"));
                publisher.setAddress1(rs.getString("Address1"));
                publisher.setAddress2(rs.getString("Address2"));
                publisher.setAddress3(rs.getString("Address3"));
                publisher.setAddress4(rs.getString("Address4"));
                publisher.setPostCode(rs.getString("postCode"));
                publisher.setCity(rs.getString("City"));
                publisher.setCountry(rs.getString("Country"));
                publisher.setCountryCode(rs.getString("CountryCode"));
                publisher.setTelephone(rs.getString("Telephone"));
                publisher.setFax(rs.getString("Fax"));
                publisher.setWWW(rs.getString("WWW"));
                publisher.setDoNotMail(rs.getString("DoNotMail"));
                publisher.setBursaries(rs.getString("Bursaries"));
                publisher.setFounded(rs.getString("Founded"));
                publisher.setNumberOfTitles(rs.getString("NumberOfTitles"));
                publisher.setDateModified(rs.getString("DateModified"));
                publisher.setNotes(rs.getString("Notes"));
                publisher.setStatus(rs.getString("Status"));

                publisherList.add(publisher);

                ps.close();
                disconnect();
            }
        } catch (SQLException e) {
        }

        return publisherList;
    }

        //getpublisher by publisherID
    public static ArrayList getpublisherByID(int publisherID) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

        ArrayList publisherList = new ArrayList();

        connect();

        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM international_publishers WHERE Company_Number = ?");
            ps.setInt(1, publisherID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Publisher publisher = new Publisher();

                publisher.setId(rs.getString("Company_Number"));
                publisher.setValue(rs.getString("Company"));
                publisher.setCompany(rs.getString("Company"));
                publisher.setAddress1(rs.getString("Address1"));
                publisher.setAddress2(rs.getString("Address2"));
                publisher.setAddress3(rs.getString("Address3"));
                publisher.setAddress4(rs.getString("Address4"));
                publisher.setPostCode(rs.getString("postCode"));
                publisher.setCity(rs.getString("City"));
                publisher.setCountry(rs.getString("Country"));
                publisher.setCountryCode(rs.getString("CountryCode"));
                publisher.setTelephone(rs.getString("Telephone"));
                publisher.setFax(rs.getString("Fax"));
                publisher.setWWW(rs.getString("WWW"));
                publisher.setDoNotMail(rs.getString("DoNotMail"));
                publisher.setBursaries(rs.getString("Bursaries"));
                publisher.setFounded(rs.getString("Founded"));
                publisher.setNumberOfTitles(rs.getString("NumberOfTitles"));
                publisher.setDateModified(rs.getString("DateModified"));
                publisher.setNotes(rs.getString("Notes"));
                publisher.setStatus(rs.getString("Status"));

                publisherList.add(publisher);

                ps.close();
                disconnect();
            }
        } catch (SQLException e) {
        }

        return publisherList;
    }
    
    
    //isPublisherExists
    public static boolean isPublisherExists(String Company) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean verified = false;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT * FROM international_publishers "
                    + "WHERE Company = ?");
            System.out.println("isPublisherExists company: try:: " + ps);
            ps.setString(1, Company);
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    System.out.println("isPublisherExists res:   " + res.getString(1));
                    verified = true;
                }
            }

            DBConn.close(conn, ps, res);

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, res);
            throw new DBException("3 Excepion while accessing database");
        }
        System.out.println("isPublisherExists verified:  " + verified);
        return verified;
    }
    
     //isNewPublisher 
    public static boolean isNewPublisher(int Company_Number) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean newPublisher = false;
        ResultSet res = null;
       

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Company, Status FROM international_publishers "
                    + "WHERE Company_Number = ?");
            
            ps.setInt(1, Company_Number);
            
            System.out.println("isPublisherNew company: try:: " + ps);
            
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    System.out.println("isPublisherNew res:   " + res.getString(1));
                    
                    if("new".equals(res.getString(2))){
                    
                        newPublisher = true;
                        
                    }else{
                    
                        newPublisher = false;
                        
                    }
                    
                 System.out.println("isPublisherNew Status: try:: " + newPublisher);
                }
            }

            DBConn.close(conn, ps, res);

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, res);
            throw new DBException("3 Excepion while accessing database");
        }
        System.out.println("return newPublisher:  " + newPublisher);
        
        return newPublisher;
    }

    //insertPublisher
    public static int insertPublisher(Publisher pojo) throws DBException {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);
                                                        
            ps1 = conn.prepareStatement("insert into international_publishers (Company,Address1,Address2,Address3,Address4,postCode,City,Country,CountryCode,Telephone,Fax,WWW,DoNotMail,Bursaries,Founded,NumberOfTitles,DateModified,Notes,Status) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

            ps1.setString(1, pojo.getCompany());
            ps1.setString(2, pojo.getAddress1());
            ps1.setString(3, pojo.getAddress2());
            ps1.setString(4, pojo.getAddress3());
            ps1.setString(5, pojo.getAddress4());
            ps1.setString(6, pojo.getPostCode());
            ps1.setString(7, pojo.getCity());
            ps1.setString(8, pojo.getCountry());
            ps1.setString(9, pojo.getCountryCode());
            ps1.setString(10, pojo.getTelephone());
            ps1.setString(11, pojo.getFax());
            ps1.setString(12, pojo.getWWW());
            ps1.setString(13, pojo.getDoNotMail());
            ps1.setString(14, pojo.getBursaries());
            ps1.setString(15, pojo.getFounded());
            ps1.setString(16, pojo.getNumberOfTitles());
            ps1.setString(17, pojo.getDateModified());
            ps1.setString(18, pojo.getNotes());
            ps1.setString(19, pojo.getStatus());

            String uname = pojo.getCompany();
            System.out.println("getCompany dao insertPublisher: " + uname);

            String getAddress1 = pojo.getAddress1();
            System.out.println("getAddress1: " + getAddress1);

            String getStatus = pojo.getStatus();
            System.out.println("getStatus: " + getStatus);

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
        System.out.println(" insertPublisher id: " + id);

        return id;
    }

    // insert rudimentary Publisher via Registration Servlet
    public static int insertRudimentaryPublisher(Publisher pojo) throws DBException {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("insert into international_publishers (Company, Status) values (?,?)");

            ps1.setString(1, pojo.getCompany());
            ps1.setString(2, pojo.getStatus());     

            String company = pojo.getCompany();
            System.out.println("insertRudimentaryPublisher new Publisher name: " + company);

            String getStatus = pojo.getStatus();
            System.out.println("getStatus: " + getStatus);

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
        System.out.println("New Publisher id: " + id);

        return id;
    }

    public static int insertPublisherUserJoined(int userID, int Company_Number) throws DBException {

        Connection conn;
        PreparedStatement ps1;
        PreparedStatement ps2;
        int id = 0;
        ResultSet res;

        try {
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("insert into PublisherUserJoined (userID, Company_Number)  values (?,?)");

            ps1.setInt(1, userID);
            ps1.setInt(2, Company_Number);

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

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(ACpublisherDAO_test.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return id;
    }

    //listAllPublisher
    public static List<Publisher> listAllPublisher() throws DBException {
        List<Publisher> listPublisher = new ArrayList<>();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT * FROM international_publishers");
            rs = ps.executeQuery();

            while (rs.next()) {
                Publisher publisher = new Publisher();

                publisher.setId(rs.getString("Company_Number"));
                publisher.setValue(rs.getString("Company"));
                publisher.setCompany(rs.getString("Company"));
                publisher.setAddress1(rs.getString("Address1"));
                publisher.setAddress2(rs.getString("Address2"));
                publisher.setAddress3(rs.getString("Address3"));
                publisher.setAddress4(rs.getString("Address4"));
                publisher.setPostCode(rs.getString("postCode"));
                publisher.setCity(rs.getString("City"));
                publisher.setCountry(rs.getString("Country"));
                publisher.setCountryCode(rs.getString("CountryCode"));
                publisher.setTelephone(rs.getString("Telephone"));
                publisher.setFax(rs.getString("Fax"));
                publisher.setWWW(rs.getString("WWW"));
                publisher.setDoNotMail(rs.getString("DoNotMail"));
                publisher.setBursaries(rs.getString("Bursaries"));
                publisher.setFounded(rs.getString("Founded"));
                publisher.setNumberOfTitles(rs.getString("NumberOfTitles"));
                publisher.setDateModified(rs.getString("DateModified"));
                publisher.setNotes(rs.getString("Notes"));
                publisher.setStatus(rs.getString("Status"));

                listPublisher.add(publisher);
            }

            conn.commit();
            DBConn.close(conn, ps, rs);

            disconnect();

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, rs);
            throw new DBException("4 Excepion while accessing database");
        }

        return listPublisher;
    }

    //deletePublisher
    public static boolean deletePublisher(Publisher publisher) throws SQLException {

        Connection conn;
        PreparedStatement ps;
        ResultSet rs = null;
        boolean id = false;

        try {

            conn = DBConn.getConnection();

            String sql = "DELETE FROM publisher where Company_Number = ?";

            ps = conn.prepareStatement(sql);
            ps.setString(1, publisher.getCompany_Number());

            id = ps.executeUpdate() > 0;
            ps.close();
            disconnect();

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ACpublisherDAO_test.class.getName()).log(Level.SEVERE, null, ex);
        }

        return id;
    }

    //updatePublisher
    public static boolean updatePublisher(Publisher publisher, int Company_Number) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        boolean id;
        int committed;
        ResultSet res = null;
        int CompanyNumber = Company_Number;

        System.out.println("doing updatePublisher::  ");
        try {
            conn = DBConn.getConnection();
            //conn.setAutoCommit(false);

            String sql = "UPDATE international_publishers SET (Company,Company_Number,Address1,Address2,Address3,Address4,postCode,City,Country,CountryCode,Telephone,Fax,WWW,DoNotMail,Bursaries,Founded,NumberOfTitles,DateModified,Notes ) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            sql += " WHERE Company_Number = " + CompanyNumber;

            System.out.println("sql::  " + sql);
            System.out.println("UserID::  " + Company_Number);

            ps1 = conn.prepareStatement(sql);

            ps1.setString(1, publisher.getCompany());
            ps1.setString(2, publisher.getAddress1());
            ps1.setString(3, publisher.getAddress2());
            ps1.setString(4, publisher.getAddress3());
            ps1.setString(5, publisher.getAddress4());
            ps1.setString(6, publisher.getPostCode());
            ps1.setString(7, publisher.getCity());
            ps1.setString(8, publisher.getCountry());
            ps1.setString(9, publisher.getCountryCode());
            ps1.setString(10, publisher.getTelephone());
            ps1.setString(11, publisher.getFax());
            ps1.setString(12, publisher.getWWW());
            ps1.setString(13, publisher.getDoNotMail());
            ps1.setString(14, publisher.getBursaries());
            ps1.setString(15, publisher.getFounded());
            ps1.setString(16, publisher.getNumberOfTitles());
            ps1.setString(17, publisher.getDateModified());
            ps1.setString(18, publisher.getNotes());
            ps1.setString(19, publisher.getStatus());

            committed = ps1.executeUpdate();

            conn.commit();

            if (committed > 0) {
                id = true;
            } else {
                id = false;
            }

            DBConn.close(conn, ps1, res);

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps1, res);
            throw new DBException("4 Excepion while accessing database");
        }
        System.out.println("return id::  " + id);
        return id;
    }
}

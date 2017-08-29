/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.dao;

import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static java.nio.charset.StandardCharsets.*;

/**
 *
 * @author markus
 */
public class CSVReader1 {

    static String Translator;
    static int TranslatorID;

    public static void main(String[] args) throws DBException, SQLException {

        String csvFile1 = "/home/markus/NetBeansProjects/testupload.csv";
        String csvFile2 = "/home/markus/NetBeansProjects/Untitled 2.csv";
        String csvFile3 = "/home/markus/NetBeansProjects/Author1.csv";
        String csvFileBooks = "/home/markus/NetBeansProjects/books.csv";

        String line = "";
        String cvsSplitBy = ",";
        int counter = 1;
        int z = 1;

        try (BufferedReader br = new BufferedReader(new FileReader(csvFileBooks))) {
            counter = 1;
            while ((line = br.readLine()) != null && line.contains(",")) {

                // use comma as separator
                String[] country = line.split(cvsSplitBy);

                for (int i = 0; i < country.length; i++) {
                    System.out.println("country [" + i + "]  ::" + country[i]);
                    System.out.println("--------------------------------------------\n");
                }

//                "BookID","Referencenumber","Author","Title","Publisheryear"
                String BookID = country[0];
                String Referencenumber = country[1];
                String Author = country[2];
                String First = country[3];
                String Title = country[4];
                String Publisheryear = country[5];
                String year = country[6];

                String year1 = country[7];
                String year2 = country[8];
                String year3 = country[9];
                String year4 = country[10];

//                remove quotes
                String BookID2 = BookID.substring(1, BookID.length() - 1);
                String RefNo2 = Referencenumber.substring(1, Referencenumber.length() - 1);
                String Author2 = Author.substring(1, Author.length() - 1);
                
                String Title2 = Title.substring(1, Title.length() - 1);
                String Publisheryear2 = Publisheryear.substring(1, Publisheryear.length() - 1);

//                byte[] ptext = Translator2.getBytes(ISO_8859_1);
//                String value = new String(ptext, UTF_8);
//                Translator2 = Translator2.replaceAll("  ", " ");
//                Title2 = Title2.replaceAll(",", "-");
//                System.out.println("BookID :: " + BookID);
//                System.out.println("Referencenumber :: " + Referencenumber);
//                System.out.println("First :: " + First);
//                System.out.println("Last :: " + Author);
//                System.out.println("Title :: " + Title);
//                System.out.println("Publisher :: " + Publisheryear);
//                System.out.println("Year :: " + year);
//                System.out.println("Year1 :: " + year1);
//                System.out.println("Year2 :: " + year2);
//                System.out.println("Year3 :: " + year3);
//                System.out.println("Year4 :: " + year4);
                System.out.println("--------------------------------------------\n");

//                TranslatorID = findTranslator(Translator2);
                if (0 != TranslatorID) {
//                    insertRow(RefNo2, Author2, Title2, Translator2, TranslatorID);
                } else {
//                    System.out.println(" No: " + z + " counter: " + counter + " :: [RefNo= " + country[0] + " , Author=" + country[1] + " , Title=" + Title2 + " , Translator=" + country[3] + ", TranslatorID=" + TranslatorID + "]");

                    z++;
                }
                //   public static String insertRow(String RefNo, String Author, String Title, String Translator, String TranslatorID) throws DBException 
                counter++;
            }

        } catch (IOException e) {
        }

    }

}

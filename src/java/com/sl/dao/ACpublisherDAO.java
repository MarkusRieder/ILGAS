/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sl.dao;

import com.sl.model.ACpublisher;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author markus
 * 
 * AC = autocomplete 
 * 
 */
@SuppressWarnings("unchecked")
public class ACpublisherDAO {
    public ArrayList getpublisher(String s) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
  
  ArrayList publisherList = new ArrayList();
  Database db = new Database();
  Connection connection = db.getConnection();
  
  try{
   PreparedStatement ps = connection.prepareStatement("SELECT Company, Company_Number FROM international_publishers WHERE Company  like ?");
   ps.setString(1, "%" +s+"%");
   ResultSet rs = ps.executeQuery();
   
   while(rs.next()){
    ACpublisher publisher = new ACpublisher();
    publisher.setId(rs.getString("Company_Number"));
    publisher.setValue(rs.getString("Company"));
    publisherList.add(publisher);
   }
  }catch(SQLException e){
  }
  return publisherList;
 }
    
}

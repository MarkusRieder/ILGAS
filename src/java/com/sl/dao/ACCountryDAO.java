/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sl.dao;

import com.sl.model.ACcountry;
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
public class ACCountryDAO {
    public ArrayList getCountry(String s) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException{
  
  ArrayList publisherList = new ArrayList();
  Database db = new Database();
  Connection connection = db.getConnection();
  
  try{
   PreparedStatement ps = connection.prepareStatement("SELECT nicename, iso  from country WHERE nicename  like ?");
   ps.setString(1, "%" +s+"%");
   ResultSet rs = ps.executeQuery();
   
   while(rs.next()){
    ACcountry country = new ACcountry();
    country.setId(rs.getString("iso"));
    country.setValue(rs.getString("nicename"));
    publisherList.add(country);
   }
  }catch(SQLException e){
  }
  return publisherList;
 }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author markus
 *
 *
 * AC = autocomplete
 *
 * modified setDateModified to format date
 *
 */
public class Publisher {

    private String id;
    private String value;
    private String Company;
    private String Company_Number;
    private String Address1;
    private String Address2;
    private String Address3;
    private String Address4;
    private String postCode;
    private String City;
    private String Country;
    private String CountryCode;
    private String Telephone;
    private String Fax;
    private String WWW;
    private String DoNotMail;
    private String Bursaries;
    private String Founded;
    private String NumberOfTitles;
    private String DateModified;
    private String Notes;
    private String Status;


    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @return the value same as Company but used for autocomplete
     */
    public String getValue() {
        return value;
    }

    /**
     * @param value the value to set same as Company but used for autocomplete
     */
    public void setValue(String value) {
        this.value = value;
    }

    /**
     * @return the Company
     */
    public String getCompany() {
        return Company;
    }

    /**
     * @param Company the Company to set
     */
    public void setCompany(String Company) {
        this.Company = Company;
    }

    /**
     * @return the Company_Number
     */
    public String getCompany_Number() {
        return Company_Number;
    }

    /**
     * @param Company_Number the Company_Number to set
     */
    public void setCompany_Number(String Company_Number) {
        this.Company_Number = Company_Number;
    }

    /**
     * @return the Address1
     */
    public String getAddress1() {
        return Address1;
    }

    /**
     * @param Address1 the Address1 to set
     */
    public void setAddress1(String Address1) {
        this.Address1 = Address1;
    }

    /**
     * @return the Address2
     */
    public String getAddress2() {
        return Address2;
    }

    /**
     * @param Address2 the Address2 to set
     */
    public void setAddress2(String Address2) {
        this.Address2 = Address2;
    }

    /**
     * @return the Address3
     */
    public String getAddress3() {
        return Address3;
    }

    /**
     * @param Address3 the Address3 to set
     */
    public void setAddress3(String Address3) {
        this.Address3 = Address3;
    }

    /**
     * @return the Address4
     */
    public String getAddress4() {
        return Address4;
    }

    /**
     * @param Address4 the Address4 to set
     */
    public void setAddress4(String Address4) {
        this.Address4 = Address4;
    }

    /**
     * @return the postCode
     */
    public String getPostCode() {
        return postCode;
    }

    /**
     * @param postCode the postCode to set
     */
    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    /**
     * @return the City
     */
    public String getCity() {
        return City;
    }

    /**
     * @param City the City to set
     */
    public void setCity(String City) {
        this.City = City;
    }

    /**
     * @return the Country
     */
    public String getCountry() {
        return Country;
    }

    /**
     * @param Country the Country to set
     */
    public void setCountry(String Country) {
        this.Country = Country;
    }

    /**
     * @return the CountryCode
     */
    public String getCountryCode() {
        return CountryCode;
    }

    /**
     * @param CountryCode the CountryCode to set
     */
    public void setCountryCode(String CountryCode) {
        this.CountryCode = CountryCode;
    }

    /**
     * @return the Telephone
     */
    public String getTelephone() {
        return Telephone;
    }

    /**
     * @param Telephone the Telephone to set
     */
    public void setTelephone(String Telephone) {
        this.Telephone = Telephone;
    }

    /**
     * @return the Fax
     */
    public String getFax() {
        return Fax;
    }

    /**
     * @param Fax the Fax to set
     */
    public void setFax(String Fax) {
        this.Fax = Fax;
    }

    /**
     * @return the WWW
     */
    public String getWWW() {
        return WWW;
    }

    /**
     * @param WWW the WWW to set
     */
    public void setWWW(String WWW) {
        this.WWW = WWW;
    }

    /**
     * @return the DoNotMail
     */
    public String getDoNotMail() {
        return DoNotMail;
    }

    /**
     * @param DoNotMail the DoNotMail to set
     */
    public void setDoNotMail(String DoNotMail) {
        this.DoNotMail = DoNotMail;
    }

    /**
     * @return the Bursaries
     */
    public String getBursaries() {
        return Bursaries;
    }

    /**
     * @param Bursaries the Bursaries to set
     */
    public void setBursaries(String Bursaries) {
        this.Bursaries = Bursaries;
    }

    /**
     * @return the Founded
     */
    public String getFounded() {
        return Founded;
    }

    /**
     * @param Founded the Founded to set
     */
    public void setFounded(String Founded) {
        this.Founded = Founded;
    }

    /**
     * @return the NumberOfTitles
     */
    public String getNumberOfTitles() {
        return NumberOfTitles;
    }

    /**
     * @param NumberOfTitles the NumberOfTitles to set
     */
    public void setNumberOfTitles(String NumberOfTitles) {
        this.NumberOfTitles = NumberOfTitles;
    }

    /**
     * @return the DateModified
     */
    public String getDateModified() {
        return DateModified;
    }

    /**
     * @param DateModified the DateModified to set
     */
    public void setDateModified(String DateModified) {
        
         this.DateModified = DateModified;

//        try {
//            SimpleDateFormat sourceFormat = new SimpleDateFormat("yy.MM.dd");
//            SimpleDateFormat targetFormat = new SimpleDateFormat("dd/MM/yyyy");
//
//            String dateStr = DateModified;
//
//            Date date = sourceFormat.parse(dateStr);
//            String formattedDate = targetFormat.format(date);
//
//            System.out.println(formattedDate);
//
//            this.DateModified = formattedDate;
//        } catch (ParseException ex) {
//            Logger.getLogger(Publisher.class.getName()).log(Level.SEVERE, null, ex);
//        }
    }

    /**
     * @return the Notes
     */
    public String getNotes() {
        return Notes;
    }

    /**
     * @param Notes the Notes to set
     */
    public void setNotes(String Notes) {
        this.Notes = Notes;
    }

    /**
     * @return the Status
     */
    public String getStatus() {
        return Status;
    }

    /**
     * @param Status the Status to set
     */
    public void setStatus(String Status) {
        this.Status = Status;
    }
}

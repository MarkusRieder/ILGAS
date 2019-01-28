/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.model;

/**
 *
 * @author markus
 */
public class Languages_Library {

    private int idLanguages_Library;
    private int idLanguages;
    private String lang;
    private int bookID;
    private String ReferenceNumber;

    /**
     * @return the idLanguages_Library
     */
    public int getIdLanguages_Library() {
        return idLanguages_Library;
    }

    /**
     * @param idLanguages_Library the idLanguages_Library to set
     */
    public void setIdLanguages_Library(int idLanguages_Library) {
        this.idLanguages_Library = idLanguages_Library;
    }

    /**
     * @return the idLanguages
     */
    public int getIdLanguages() {
        return idLanguages;
    }

    /**
     * @param idLanguages the idLanguages to set
     */
    public void setIdLanguages(int idLanguages) {
        this.idLanguages = idLanguages;
    }

    /**
     * @return the lang
     */
    public String getLang() {
        return lang;
    }

    /**
     * @param lang the lang to set
     */
    public void setLang(String lang) {
        this.lang = lang;
    }

    /**
     * @return the bookID
     */
    public int getBookID() {
        return bookID;
    }

    /**
     * @param bookID the bookID to set
     */
    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    /**
     * @return the ReferenceNumber
     */
    public String getReferenceNumber() {
        return ReferenceNumber;
    }

    /**
     * @param ReferenceNumber the ReferenceNumber to set
     */
    public void setReferenceNumber(String ReferenceNumber) {
        this.ReferenceNumber = ReferenceNumber;
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.model;

import java.util.ArrayList;


/**
 *
 * @author markus
 */

public class TranslatorTracker {

    private String translatorID;

    private String translatorName;

    private String ReferenceNumber;

    private ArrayList<String> titles;

    private ArrayList<String> authorName;

    private ArrayList<String> yuppydoo;

    /**
     * @return the translatorID
     */
    public String getTranslatorID() {
        return translatorID;
    }

    /**
     * @param translatorID the translatorID to set
     */
    public void setTranslatorID(String translatorID) {
        this.translatorID = translatorID;
    }

    /**
     * @return the translatorName
     */
    public String getTranslatorName() {
        return translatorName;
    }

    /**
     * @param translatorName the translatorName to set
     */
    public void setTranslatorName(String translatorName) {
        this.translatorName = translatorName;
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

    /**
     * @return the titles
     */
    public ArrayList<String> getTitles() {
        return titles;
    }

    /**
     * @param titles the titles to set
     */
    public void setTitles(ArrayList<String> titles) {
        this.titles = titles;
    }

    /**
     * @return the authorName
     */
    public ArrayList<String> getAuthorName() {
        return authorName;
    }

    /**
     * @param authorName the authorName to set
     */
    public void setAuthorName(ArrayList<String> authorName) {
        this.authorName = authorName;
    }
    
    
  @Override public String toString() {
    return "ToStringExample(" + this.getTranslatorID() + ", " + this.getTranslatorName() + ", " + this.getTitles() + ", " + this.getReferenceNumber() + ", " + this.getAuthorName() + ")";
  }
}

package com.sl.model;

import java.util.Date;

public class GrantApplication {

    private int ApplicationNumber;

    private String company;

    private String publisherID;
    
//    Rights Agreement

    private String agreement;//path + filename

    private String contract; //path + filename
    
//    Publication Details

    private Date proposedDateOfPublication;

    private Date proposedDateOfPrintRun;

    private int plannedPageExtent;
    
//     a copy of the Translator's CV

    private String translatorCV;//path + filename

    private int numberOfPages;

    private double feePerPage;

    private double translatorFee;

    private String Notes;
    
    private String Status;
    
//    Original Work & Sample Translation

    private boolean copiesSent;

    private Date dateCopiesWereSent;

    private String copiesTranslationSample ; //path + filename
    
//    General

    private boolean TC_ACCEPTED;

    private boolean APPROVED;


    /**
     * @return the APPROVED
     */
    public boolean isAPPROVED() {
        return APPROVED;
    }

    /**
     * @param APPROVED the APPROVED to set
     */
    public void setAPPROVED(boolean APPROVED) {
        this.APPROVED = APPROVED;
    }

    /**
     * @return the TC_ACCEPTED
     */
    public boolean isTC_ACCEPTED() {
        return TC_ACCEPTED;
    }

    /**
     * @param TC_ACCEPTED the TC_ACCEPTED to set
     */
    public void setTC_ACCEPTED(boolean TC_ACCEPTED) {
        this.TC_ACCEPTED = TC_ACCEPTED;
    }

    /**
     * @return the ApplicationNumber
     */
    public int getApplicationNumber() {
        return ApplicationNumber;
    }

    /**
     * @param ApplicationNumber the ApplicationNumber to set
     */
    public void setApplicationNumber(int ApplicationNumber) {
        this.ApplicationNumber = ApplicationNumber;
    }

    /**
     * @return the company
     */
    public String getCompany() {
        return company;
    }

    /**
     * @param company the company to set
     */
    public void setCompany(String company) {
        this.company = company;
    }

    /**
     * @return the publisherID
     */
    public String getPublisherID() {
        return publisherID;
    }

    /**
     * @param publisherID the publisherID to set
     */
    public void setPublisherID(String publisherID) {
        this.publisherID = publisherID;
    }

    /**
     * @return the agreement
     */
    public String getAgreement() {
        return agreement;
    }

    /**
     * @param agreement the agreement to set
     */
    public void setAgreement(String agreement) {
        this.agreement = agreement;
    }

    /**
     * @return the contract
     */
    public String getContract() {
        return contract;
    }

    /**
     * @param contract the contract to set
     */
    public void setContract(String contract) {
        this.contract = contract;
    }

    /**
     * @return the proposedDateOfPublication
     */
    public Date getProposedDateOfPublication() {
        return proposedDateOfPublication;
    }

    /**
     * @param proposedDateOfPublication the proposedDateOfPublication to set
     */
    public void setProposedDateOfPublication(Date proposedDateOfPublication) {
        this.proposedDateOfPublication = proposedDateOfPublication;
    }

    /**
     * @return the proposedDateOfPrintRun
     */
    public Date getProposedDateOfPrintRun() {
        return proposedDateOfPrintRun;
    }

    /**
     * @param proposedDateOfPrintRun the proposedDateOfPrintRun to set
     */
    public void setProposedDateOfPrintRun(Date proposedDateOfPrintRun) {
        this.proposedDateOfPrintRun = proposedDateOfPrintRun;
    }

    /**
     * @return the plannedPageExtent
     */
    public int getPlannedPageExtent() {
        return plannedPageExtent;
    }

    /**
     * @param plannedPageExtent the plannedPageExtent to set
     */
    public void setPlannedPageExtent(int plannedPageExtent) {
        this.plannedPageExtent = plannedPageExtent;
    }

    /**
     * @return the translatorCV
     */
    public String getTranslatorCV() {
        return translatorCV;
    }

    /**
     * @param translatorCV the translatorCV to set
     */
    public void setTranslatorCV(String translatorCV) {
        this.translatorCV = translatorCV;
    }

    /**
     * @return the numberOfPages
     */
    public int getNumberOfPages() {
        return numberOfPages;
    }

    /**
     * @param numberOfPages the numberOfPages to set
     */
    public void setNumberOfPages(int numberOfPages) {
        this.numberOfPages = numberOfPages;
    }

    /**
     * @return the feePerPage
     */
    public double getFeePerPage() {
        return feePerPage;
    }

    /**
     * @param feePerPage the feePerPage to set
     */
    public void setFeePerPage(double feePerPage) {
        this.feePerPage = feePerPage;
    }

    /**
     * @return the translatorFee
     */
    public double getTranslatorFee() {
        return translatorFee;
    }

    /**
     * @param translatorFee the translatorFee to set
     */
    public void setTranslatorFee(double translatorFee) {
        this.translatorFee = translatorFee;
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
     * @return the copiesSent
     */
    public boolean isCopiesSent() {
        return copiesSent;
    }

    /**
     * @param copiesSent the copiesSent to set
     */
    public void setCopiesSent(boolean copiesSent) {
        this.copiesSent = copiesSent;
    }

    /**
     * @return the dateCopiesWereSent
     */
    public Date getDateCopiesWereSent() {
        return dateCopiesWereSent;
    }

    /**
     * @param dateCopiesWereSent the dateCopiesWereSent to set
     */
    public void setDateCopiesWereSent(Date dateCopiesWereSent) {
        this.dateCopiesWereSent = dateCopiesWereSent;
    }

    /**
     * @return the copiesTranslationSample
     */
    public String getCopiesTranslationSample() {
        return copiesTranslationSample;
    }

    /**
     * @param copiesTranslationSample the copiesTranslationSample to set
     */
    public void setCopiesTranslationSample(String copiesTranslationSample) {
        this.copiesTranslationSample = copiesTranslationSample;
    }
    
    
    

    @Override
    public String toString() {
        return "ClassPojo [ApplicationNumber = " + getApplicationNumber() + ", company = " + getCompany() + ", publisherID = " + getPublisherID() + ", agreement = " + getAgreement() + ", contract = " + getContract() + ", proposedDateOfPublication = " + getProposedDateOfPublication() + ", proposedDateOfPrintRun = " + getProposedDateOfPrintRun() + ", plannedPageExtent = " + getPlannedPageExtent() + ", translatorCV = " + getTranslatorCV() + ", numberOfPages = " + getNumberOfPages() + ", feePerPage = " + getFeePerPage() + ", translatorFee = " + getTranslatorFee() + ", Notes = " + getNotes() + ", copiesSent = " + isCopiesSent() + ", dateCopiesWereSent = " + getDateCopiesWereSent() + ", copiesTranslationSample = " + getCopiesTranslationSample() + ", TC_ACCEPTED = " + isTC_ACCEPTED() + ", APPROVED = " + isAPPROVED() + "]";
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

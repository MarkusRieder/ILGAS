package ie.irishliterature.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class GrantApplication {

    private int ApplicationNumber;

    private String ApplicationYear;

    private String ReferenceNumber;

    private String company;

    private int publisherID;

    private String userID;

//    Rights Agreement
    private String agreement;//path + filename

    private String agreementDocName; //filename

    private String contract; //path + filename

    private String contractDocName;  //filename

//    Publication Details
    private Date proposedDateOfPublication;

    private int proposedPrintRun;

    private int plannedPageExtent;

//     a copy of the Translator's CV
    private String translatorCV;//path + filename

    private String translatorCVDocName; //filename

    private int numberOfPages;

    private BigDecimal feePerPage;

    private BigDecimal translatorFee;

    private String Notes;

    private String Status;

//    Original Work & Sample Translation
    private int copiesSent;

    private Date dateCopiesWereSent;

    private String copiesTranslationSample;  //filename

    private String copiesTranslationSampleDocName; //filename

//    General
    private int TC_ACCEPTED;

    private int APPROVED;

    private String cover;//path + filename

    private String coverName; //filename

    private ArrayList<String> TranslatorName;
    
    private ArrayList<String> TranslatorTrack;
    
    private  ArrayList<ArrayList<String>> translatorTitles;

    private String AuthorName;

    private ArrayList<String> Author;

    private int idTranslator;

    private List<String> Titles;

    private java.sql.Timestamp LASTUPDATED;
    
                                                   
private String foreignPublisher;
private String foreignCountry ;
private String targetLanguage;
//4. Translator’s name
//5. Translator’s track record
//6. Translation Sample (as is!)
private String Original; // (Like the attachment one for translation sample)
//8. T&Cs Accepted (great!)
//9. Application Approved (also great!)

//1. Expert Reader
//2. Sample Sent Out
//3. Sample Returned
//4. Reader’s Report
//5. Reader’s Report Summary (this goes into the document for the board – staff can add this)
//
//1. Board Meeting
//2. Amount Requested 
//3. Fee Calculation (see below)
//4. Proposed Publication Date
//5. Planned Page Extent
//6. Planned Print Run
//7. Award (checkbox)
//8. Amount Approved 
//9. Publisher Informed of Outcome 
//10. Board Comments/Instructions

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
     * @return the ApplicationYear
     */
    public String getApplicationYear() {
        return ApplicationYear;
    }

    /**
     * @param ApplicationYear the ApplicationYear to set
     */
    public void setApplicationYear(String ApplicationYear) {
        this.ApplicationYear = ApplicationYear;
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
    public int getPublisherID() {
        return publisherID;
    }

    /**
     * @param publisherID the publisherID to set
     */
    public void setPublisherID(int publisherID) {
        this.publisherID = publisherID;
    }

    /**
     * @return the userID
     */
    public String getUserID() {
        return userID;
    }

    /**
     * @param userID the userID to set
     */
    public void setUserID(String userID) {
        this.userID = userID;
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
     * @return the agreementDocName
     */
    public String getAgreementDocName() {
        return agreementDocName;
    }

    /**
     * @param agreementDocName the agreementDocName to set
     */
    public void setAgreementDocName(String agreementDocName) {
        this.agreementDocName = agreementDocName;
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
     * @return the contractDocName
     */
    public String getContractDocName() {
        return contractDocName;
    }

    /**
     * @param contractDocName the contractDocName to set
     */
    public void setContractDocName(String contractDocName) {
        this.contractDocName = contractDocName;
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
     * @return the proposedPrintRun
     */
    public int getProposedPrintRun() {
        return proposedPrintRun;
    }

    /**
     * @param proposedPrintRun the proposedPrintRun to set
     */
    public void setProposedPrintRun(int proposedPrintRun) {
        this.proposedPrintRun = proposedPrintRun;
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
     * @return the translatorCVDocName
     */
    public String getTranslatorCVDocName() {
        return translatorCVDocName;
    }

    /**
     * @param translatorCVDocName the translatorCVDocName to set
     */
    public void setTranslatorCVDocName(String translatorCVDocName) {
        this.translatorCVDocName = translatorCVDocName;
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
    public BigDecimal getFeePerPage() {
        return feePerPage;
    }

    /**
     * @param feePerPage the feePerPage to set
     */
    public void setFeePerPage(BigDecimal feePerPage) {
        this.feePerPage = feePerPage;
    }

    /**
     * @return the translatorFee
     */
    public BigDecimal getTranslatorFee() {
        return translatorFee;
    }

    /**
     * @param translatorFee the translatorFee to set
     */
    public void setTranslatorFee(BigDecimal translatorFee) {
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

    /**
     * @return the copiesSent
     */
    public int getCopiesSent() {
        return copiesSent;
    }

    /**
     * @param copiesSent the copiesSent to set
     */
    public void setCopiesSent(int copiesSent) {
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

    /**
     * @return the copiesTranslationSampleDocName
     */
    public String getCopiesTranslationSampleDocName() {
        return copiesTranslationSampleDocName;
    }

    /**
     * @param copiesTranslationSampleDocName the copiesTranslationSampleDocName to set
     */
    public void setCopiesTranslationSampleDocName(String copiesTranslationSampleDocName) {
        this.copiesTranslationSampleDocName = copiesTranslationSampleDocName;
    }

    /**
     * @return the TC_ACCEPTED
     */
    public int getTC_ACCEPTED() {
        return TC_ACCEPTED;
    }

    /**
     * @param TC_ACCEPTED the TC_ACCEPTED to set
     */
    public void setTC_ACCEPTED(int TC_ACCEPTED) {
        this.TC_ACCEPTED = TC_ACCEPTED;
    }

    /**
     * @return the APPROVED
     */
    public int getAPPROVED() {
        return APPROVED;
    }

    /**
     * @param APPROVED the APPROVED to set
     */
    public void setAPPROVED(int APPROVED) {
        this.APPROVED = APPROVED;
    }

    /**
     * @return the cover
     */
    public String getCover() {
        return cover;
    }

    /**
     * @param cover the cover to set
     */
    public void setCover(String cover) {
        this.cover = cover;
    }

    /**
     * @return the coverName
     */
    public String getCoverName() {
        return coverName;
    }

    /**
     * @param coverName the coverName to set
     */
    public void setCoverName(String coverName) {
        this.coverName = coverName;
    }

    /**
     * @return the TranslatorName
     */
    public ArrayList<String> getTranslatorName() {
        return TranslatorName;
    }

    /**
     * @param TranslatorName the TranslatorName to set
     */
    public void setTranslatorName(ArrayList<String> TranslatorName) {
        this.TranslatorName = TranslatorName;
    }

    /**
     * @return the TranslatorTrack
     */
    public ArrayList<String> getTranslatorTrack() {
        return TranslatorTrack;
    }

    /**
     * @param TranslatorTrack the TranslatorTrack to set
     */
    public void setTranslatorTrack(ArrayList<String> TranslatorTrack) {
        this.TranslatorTrack = TranslatorTrack;
    }

    /**
     * @return the translatorTitles
     */
    public ArrayList<ArrayList<String>> getTranslatorTitles() {
        return translatorTitles;
    }

    /**
     * @param translatorTitles the translatorTitles to set
     */
    public void setTranslatorTitles(ArrayList<ArrayList<String>> translatorTitles) {
        this.translatorTitles = translatorTitles;
    }

    /**
     * @return the AuthorName
     */
    public String getAuthorName() {
        return AuthorName;
    }

    /**
     * @param AuthorName the AuthorName to set
     */
    public void setAuthorName(String AuthorName) {
        this.AuthorName = AuthorName;
    }

    /**
     * @return the Author
     */
    public ArrayList<String> getAuthor() {
        return Author;
    }

    /**
     * @param Author the Author to set
     */
    public void setAuthor(ArrayList<String> Author) {
        this.Author = Author;
    }

    /**
     * @return the idTranslator
     */
    public int getIdTranslator() {
        return idTranslator;
    }

    /**
     * @param idTranslator the idTranslator to set
     */
    public void setIdTranslator(int idTranslator) {
        this.idTranslator = idTranslator;
    }

    /**
     * @return the Titles
     */
    public List<String> getTitles() {
        return Titles;
    }

    /**
     * @param Titles the Titles to set
     */
    public void setTitles(List<String> Titles) {
        this.Titles = Titles;
    }

    /**
     * @return the LASTUPDATED
     */
    public java.sql.Timestamp getLASTUPDATED() {
        return LASTUPDATED;
    }

    /**
     * @param LASTUPDATED the LASTUPDATED to set
     */
    public void setLASTUPDATED(java.sql.Timestamp LASTUPDATED) {
        this.LASTUPDATED = LASTUPDATED;
    }


}

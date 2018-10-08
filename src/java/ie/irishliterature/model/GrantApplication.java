package ie.irishliterature.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class GrantApplication {

    /**
     * @return the bilingual_edition
     */
    public int getBilingual_edition() {
        return bilingual_edition;
    }

    /**
     * @param bilingual_edition the bilingual_edition to set
     */
    public void setBilingual_edition(int bilingual_edition) {
        this.bilingual_edition = bilingual_edition;
    }

    private int ApplicationNumber;

    private String ApplicationYear;

    private String ReferenceNumber;

    private String company;

    private int publisherID;

    private String userID;

    private String bookTitle;

//    Rights Agreement
    private String agreement;//path + filename

    private String agreementDocName; //filename

    private String contract; //path + filename

    private String contractDocName;  //filename

//    Publication Details
    private Date proposedDateOfPublication;

//    private Date originalDateOfPublication;
    
    private String publicationYear;


    private int originalPageExtent;

    private String originalLanguage;

    private String countryOfPublication;

    private Date boardMeeting;

    private BigDecimal amountRequested;

    private BigDecimal amountApproved;

    private Date publisherInformedOfMeeting;

    private String boardComments_Instructions;

    private Date contractSentToPublisher;

    private Date acknowledgementApproved;

    private Date datePublishedBooksReceived;

    private Date datePaymentMadeToPublisher;

    private String paymentReferenceNumber;

    private String addendumRightsAgreement;

    private String addendumRightsAgreementName;

    private String proofOfPaymentToTranslator;

    private String proofOfPaymentToTranslatorName;

    private String bankDetailsForm;

    private String bankDetailsFormName;

    private String SignedLIContract;  //file path

    private String SignedLIContractName; //filename

    private String paymentStatus;
    
    private ArrayList<String> previousGrantAid;
    
    private int award;
    
    private int bilingual_edition;

    private int salesFigures;

    private int proposedPrintRun;

    private int plannedPageExtent;

    private String translatorCV;//path + filename

    private String translatorCVDocName; //filename

    private String original;//path + filename

    private String originalName; //filename

    private int numberOfPages;

    private String breakDownTranslatorFee;

    private BigDecimal translatorFee;

    private String bookNotes;
    
    private String translatorNotes;

    private String Status;

//    Original Work & Sample Translation
    private int copiesSent;

    private Date dateCopiesWereSent;

    private String copiesTranslationSample;  //filename

    private String copiesTranslationSampleDocName; //filename

//    General
    private int TC_ACCEPTED;
    
    private int gdprACCEPTED;

    private int APPROVED;

    private String cover;//path + filename

    private String coverName; //filename

    private String genre;

    private ArrayList<String> TranslatorName;

    private ArrayList<ArrayList<String>> TranslatorTrack;

    private ArrayList<ArrayList<String>> translatorTitles;
    
    private String translationTitle;

    private String AuthorName;

    private ArrayList<String> Author;

    private int idTranslator;

    private List<String> Titles;

    private String foreignPublisher;

    private String foreignCountry;

    private String targetLanguage;
    
    private String Languages;
    
    private String Series;

    private String expertReaderName;

    private String sampleSentOut;

    private String sampleReturned;

    private String readerReport;

    private String readerReportSummary; // (this goes into the document for the board – staff can add this)

    private List<String[]> expertReaderList;

    private List<String> unassignedExpertReaderList;
    
    private List<List<String>> transList;    

    private java.sql.Timestamp LASTUPDATED;

    private java.sql.Timestamp Created;
    

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
     * @return the bookTitle
     */
    public String getBookTitle() {
        return bookTitle;
    }

    /**
     * @param bookTitle the bookTitle to set
     */
    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
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
     * @return the originalPageExtent
     */
    public int getOriginalPageExtent() {
        return originalPageExtent;
    }

    /**
     * @param originalPageExtent the originalPageExtent to set
     */
    public void setOriginalPageExtent(int originalPageExtent) {
        this.originalPageExtent = originalPageExtent;
    }

    /**
     * @return the originalLanguage
     */
    public String getOriginalLanguage() {
        return originalLanguage;
    }

    /**
     * @param originalLanguage the originalLanguage to set
     */
    public void setOriginalLanguage(String originalLanguage) {
        this.originalLanguage = originalLanguage;
    }

    /**
     * @return the countryOfPublication
     */
    public String getCountryOfPublication() {
        return countryOfPublication;
    }

    /**
     * @param countryOfPublication the countryOfPublication to set
     */
    public void setCountryOfPublication(String countryOfPublication) {
        this.countryOfPublication = countryOfPublication;
    }

    /**
     * @return the boardMeeting
     */
    public Date getBoardMeeting() {
        return boardMeeting;
    }

    /**
     * @param boardMeeting the boardMeeting to set
     */
    public void setBoardMeeting(Date boardMeeting) {
        this.boardMeeting = boardMeeting;
    }

    /**
     * @return the amountRequested
     */
    public BigDecimal getAmountRequested() {
        return amountRequested;
    }

    /**
     * @param amountRequested the amountRequested to set
     */
    public void setAmountRequested(BigDecimal amountRequested) {
        this.amountRequested = amountRequested;
    }

    /**
     * @return the amountApproved
     */
    public BigDecimal getAmountApproved() {
        return amountApproved;
    }

    /**
     * @param amountApproved the amountApproved to set
     */
    public void setAmountApproved(BigDecimal amountApproved) {
        this.amountApproved = amountApproved;
    }

    /**
     * @return the publisherInformedOfMeeting
     */
    public Date getPublisherInformedOfMeeting() {
        return publisherInformedOfMeeting;
    }

    /**
     * @param publisherInformedOfMeeting the publisherInformedOfMeeting to set
     */
    public void setPublisherInformedOfMeeting(Date publisherInformedOfMeeting) {
        this.publisherInformedOfMeeting = publisherInformedOfMeeting;
    }

    /**
     * @return the boardComments_Instructions
     */
    public String getBoardComments_Instructions() {
        return boardComments_Instructions;
    }

    /**
     * @param boardComments_Instructions the boardComments_Instructions to set
     */
    public void setBoardComments_Instructions(String boardComments_Instructions) {
        this.boardComments_Instructions = boardComments_Instructions;
    }

    /**
     * @return the contractSentToPublisher
     */
    public Date getContractSentToPublisher() {
        return contractSentToPublisher;
    }

    /**
     * @param contractSentToPublisher the contractSentToPublisher to set
     */
    public void setContractSentToPublisher(Date contractSentToPublisher) {
        this.contractSentToPublisher = contractSentToPublisher;
    }

    /**
     * @return the acknowledgementApproved
     */
    public Date getAcknowledgementApproved() {
        return acknowledgementApproved;
    }

    /**
     * @param acknowledgementApproved the acknowledgementApproved to set
     */
    public void setAcknowledgementApproved(Date acknowledgementApproved) {
        this.acknowledgementApproved = acknowledgementApproved;
    }

    /**
     * @return the datePublishedBooksReceived
     */
    public Date getDatePublishedBooksReceived() {
        return datePublishedBooksReceived;
    }

    /**
     * @param datePublishedBooksReceived the datePublishedBooksReceived to set
     */
    public void setDatePublishedBooksReceived(Date datePublishedBooksReceived) {
        this.datePublishedBooksReceived = datePublishedBooksReceived;
    }

    /**
     * @return the datePaymentMadeToPublisher
     */
    public Date getDatePaymentMadeToPublisher() {
        return datePaymentMadeToPublisher;
    }

    /**
     * @param datePaymentMadeToPublisher the datePaymentMadeToPublisher to set
     */
    public void setDatePaymentMadeToPublisher(Date datePaymentMadeToPublisher) {
        this.datePaymentMadeToPublisher = datePaymentMadeToPublisher;
    }

    /**
     * @return the paymentReferenceNumber
     */
    public String getPaymentReferenceNumber() {
        return paymentReferenceNumber;
    }

    /**
     * @param paymentReferenceNumber the paymentReferenceNumber to set
     */
    public void setPaymentReferenceNumber(String paymentReferenceNumber) {
        this.paymentReferenceNumber = paymentReferenceNumber;
    }

    /**
     * @return the addendumRightsAgreement
     */
    public String getAddendumRightsAgreement() {
        return addendumRightsAgreement;
    }

    /**
     * @param addendumRightsAgreement the addendumRightsAgreement to set
     */
    public void setAddendumRightsAgreement(String addendumRightsAgreement) {
        this.addendumRightsAgreement = addendumRightsAgreement;
    }

    /**
     * @return the addendumRightsAgreementName
     */
    public String getAddendumRightsAgreementName() {
        return addendumRightsAgreementName;
    }

    /**
     * @param addendumRightsAgreementName the addendumRightsAgreementName to set
     */
    public void setAddendumRightsAgreementName(String addendumRightsAgreementName) {
        this.addendumRightsAgreementName = addendumRightsAgreementName;
    }

    /**
     * @return the proofOfPaymentToTranslator
     */
    public String getProofOfPaymentToTranslator() {
        return proofOfPaymentToTranslator;
    }

    /**
     * @param proofOfPaymentToTranslator the proofOfPaymentToTranslator to set
     */
    public void setProofOfPaymentToTranslator(String proofOfPaymentToTranslator) {
        this.proofOfPaymentToTranslator = proofOfPaymentToTranslator;
    }

    /**
     * @return the proofOfPaymentToTranslatorName
     */
    public String getProofOfPaymentToTranslatorName() {
        return proofOfPaymentToTranslatorName;
    }

    /**
     * @param proofOfPaymentToTranslatorName the proofOfPaymentToTranslatorName
     * to set
     */
    public void setProofOfPaymentToTranslatorName(String proofOfPaymentToTranslatorName) {
        this.proofOfPaymentToTranslatorName = proofOfPaymentToTranslatorName;
    }

    /**
     * @return the bankDetailsForm
     */
    public String getBankDetailsForm() {
        return bankDetailsForm;
    }

    /**
     * @param bankDetailsForm the bankDetailsForm to set
     */
    public void setBankDetailsForm(String bankDetailsForm) {
        this.bankDetailsForm = bankDetailsForm;
    }

    /**
     * @return the bankDetailsFormName
     */
    public String getBankDetailsFormName() {
        return bankDetailsFormName;
    }

    /**
     * @param bankDetailsFormName the bankDetailsFormName to set
     */
    public void setBankDetailsFormName(String bankDetailsFormName) {
        this.bankDetailsFormName = bankDetailsFormName;
    }

    /**
     * @return the SignedLIContract
     */
    public String getSignedLIContract() {
        return SignedLIContract;
    }

    /**
     * @param SignedLIContract the SignedLIContract to set
     */
    public void setSignedLIContract(String SignedLIContract) {
        this.SignedLIContract = SignedLIContract;
    }

    /**
     * @return the SignedLIContractName
     */
    public String getSignedLIContractName() {
        return SignedLIContractName;
    }

    /**
     * @param SignedLIContractName the SignedLIContractName to set
     */
    public void setSignedLIContractName(String SignedLIContractName) {
        this.SignedLIContractName = SignedLIContractName;
    }

    /**
     * @return the paymentStatus
     */
    public String getPaymentStatus() {
        return paymentStatus;
    }

    /**
     * @param paymentStatus the paymentStatus to set
     */
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    /**
     * @return the previousGrantAid
     */
    public ArrayList<String> getPreviousGrantAid() {
        return previousGrantAid;
    }

    /**
     * @param previousGrantAid the previousGrantAid to set
     */
    public void setPreviousGrantAid(ArrayList<String> previousGrantAid) {
        this.previousGrantAid = previousGrantAid;
    }

    /**
     * @return the award
     */
    public int getAward() {
        return award;
    }

    /**
     * @param award the award to set
     */
    public void setAward(int award) {
        this.award = award;
    }

    /**
     * @return the salesFigures
     */
    public int getSalesFigures() {
        return salesFigures;
    }

    /**
     * @param salesFigures the salesFigures to set
     */
    public void setSalesFigures(int salesFigures) {
        this.salesFigures = salesFigures;
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
     * @return the breakDownTranslatorFee
     */
    public String getBreakDownTranslatorFee() {
        return breakDownTranslatorFee;
    }

    /**
     * @param breakDownTranslatorFee the breakDownTranslatorFee to set
     */
    public void setBreakDownTranslatorFee(String breakDownTranslatorFee) {
        this.breakDownTranslatorFee = breakDownTranslatorFee;
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
     * @param copiesTranslationSampleDocName the copiesTranslationSampleDocName
     * to set
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
     * @return the genre
     */
    public String getGenre() {
        return genre;
    }

    /**
     * @param genre the genre to set
     */
    public void setGenre(String genre) {
        this.genre = genre;
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
    public ArrayList<ArrayList<String>> getTranslatorTrack() {
        return TranslatorTrack;
    }

    /**
     * @param TranslatorTrack the TranslatorTrack to set
     */
    public void setTranslatorTrack(ArrayList<ArrayList<String>> TranslatorTrack) {
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
     * @return the foreignPublisher
     */
    public String getForeignPublisher() {
        return foreignPublisher;
    }

    /**
     * @param foreignPublisher the foreignPublisher to set
     */
    public void setForeignPublisher(String foreignPublisher) {
        this.foreignPublisher = foreignPublisher;
    }

    /**
     * @return the foreignCountry
     */
    public String getForeignCountry() {
        return foreignCountry;
    }

    /**
     * @param foreignCountry the foreignCountry to set
     */
    public void setForeignCountry(String foreignCountry) {
        this.foreignCountry = foreignCountry;
    }

    /**
     * @return the targetLanguage
     */
    public String getTargetLanguage() {
        return targetLanguage;
    }

    /**
     * @param targetLanguage the targetLanguage to set
     */
    public void setTargetLanguage(String targetLanguage) {
        this.targetLanguage = targetLanguage;
    }

    /**
     * @return the expertReaderName
     */
    public String getExpertReaderName() {
        return expertReaderName;
    }

    /**
     * @param expertReaderName the expertReaderName to set
     */
    public void setExpertReaderName(String expertReaderName) {
        this.expertReaderName = expertReaderName;
    }

    /**
     * @return the sampleSentOut
     */
    public String getSampleSentOut() {
        return sampleSentOut;
    }

    /**
     * @param sampleSentOut the sampleSentOut to set
     */
    public void setSampleSentOut(String sampleSentOut) {
        this.sampleSentOut = sampleSentOut;
    }

    /**
     * @return the sampleReturned
     */
    public String getSampleReturned() {
        return sampleReturned;
    }

    /**
     * @param sampleReturned the sampleReturned to set
     */
    public void setSampleReturned(String sampleReturned) {
        this.sampleReturned = sampleReturned;
    }

    /**
     * @return the readerReport
     */
    public String getReaderReport() {
        return readerReport;
    }

    /**
     * @param readerReport the readerReport to set
     */
    public void setReaderReport(String readerReport) {
        this.readerReport = readerReport;
    }

    /**
     * @return the readerReportSummary
     */
    public String getReaderReportSummary() {
        return readerReportSummary;
    }

    /**
     * @param readerReportSummary the readerReportSummary to set
     */
    public void setReaderReportSummary(String readerReportSummary) {
        this.readerReportSummary = readerReportSummary;
    }

    /**
     * @return the expertReaderList
     */
    public List<String[]> getExpertReaderList() {
        return expertReaderList;
    }

    /**
     * @param expertReaderList the expertReaderList to set
     */
    public void setExpertReaderList(List<String[]> expertReaderList) {
        this.expertReaderList = expertReaderList;
    }

    /**
     * @return the unassignedExpertReaderList
     */
    public List<String> getUnassignedExpertReaderList() {
        return unassignedExpertReaderList;
    }

    /**
     * @param unassignedExpertReaderList the unassignedExpertReaderList to set
     */
    public void setUnassignedExpertReaderList(List<String> unassignedExpertReaderList) {
        this.unassignedExpertReaderList = unassignedExpertReaderList;
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

    /**
     * @return the original
     */
    public String getOriginal() {
        return original;
    }

    /**
     * @param original the original to set
     */
    public void setOriginal(String original) {
        this.original = original;
    }

    /**
     * @return the originalName
     */
    public String getOriginalName() {
        return originalName;
    }

    /**
     * @param originalName the originalName to set
     */
    public void setOriginalName(String originalName) {
        this.originalName = originalName;
    }

    /**
     * @return the publicationYear
     */
    public String getPublicationYear() {
        return publicationYear;
    }

    /**
     * @param publicationYear the publicationYear to set
     */
    public void setPublicationYear(String publicationYear) {
        this.publicationYear = publicationYear;
    }

    /**
     * @return the Languages
     */
    public String getLanguages() {
        return Languages;
    }

    /**
     * @param Languages the Languages to set
     */
    public void setLanguages(String Languages) {
        this.Languages = Languages;
    }

    /**
     * @return the Series
     */
    public String getSeries() {
        return Series;
    }

    /**
     * @param Series the Series to set
     */
    public void setSeries(String Series) {
        this.Series = Series;
    }

    /**
     * @return the Created
     */
    public java.sql.Timestamp getCreated() {
        return Created;
    }

    /**
     * @param Created the Created to set
     */
    public void setCreated(java.sql.Timestamp Created) {
        this.Created = Created;
    }

    /**
     * @return the translationTitle
     */
    public String getTranslationTitle() {
        return translationTitle;
    }

    /**
     * @param translationTitle the translationTitle to set
     */
    public void setTranslationTitle(String translationTitle) {
        this.translationTitle = translationTitle;
    }

    /**
     * @return the gdprACCEPTED
     */
    public int getGdprACCEPTED() {
        return gdprACCEPTED;
    }

    /**
     * @param gdprACCEPTED the gdprACCEPTED to set
     */
    public void setGdprACCEPTED(int gdprACCEPTED) {
        this.gdprACCEPTED = gdprACCEPTED;
    }

    /**
     * @return the bookNotes
     */
    public String getBookNotes() {
        return bookNotes;
    }

    /**
     * @param bookNotes the bookNotes to set
     */
    public void setBookNotes(String bookNotes) {
        this.bookNotes = bookNotes;
    }

    /**
     * @return the translatorNotes
     */
    public String getTranslatorNotes() {
        return translatorNotes;
    }

    /**
     * @param translatorNotes the translatorNotes to set
     */
    public void setTranslatorNotes(String translatorNotes) {
        this.translatorNotes = translatorNotes;
    }

    /**
     * @return the transList
     */
    public List<List<String>>getTransList() {
        return transList;
    }

    /**
     * @param transList the transList to set
     */
    public void setTransList(List<List<String>> transList) {
        this.transList = transList;
    }

}

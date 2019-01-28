/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.db;

/**
 *
 * @author markus
 */
public class EntryDb {

    private String ReferenceNumber;
    private String company;
    private String bookTitle;
    private String Status;
    private String Author;

    public EntryDb(String ReferenceNumber, String company, String bookTitle, String Status, String Author) {
        super();
        this.ReferenceNumber = ReferenceNumber;
        this.company = company;
        this.bookTitle = bookTitle;
        this.Status = Status;
        this.Author = Author;
    }

    public String getReferenceNumber() {
        return ReferenceNumber;
    }

    public void setReferenceNumber(String ReferenceNumber) {
        this.ReferenceNumber = ReferenceNumber;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public String getAuthor() {
        return Author;
    }

    public void setAuthor(String Author) {
        this.Author = Author;
    }
}

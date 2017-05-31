/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sl.test;

/**
 *
 * @author markus
 */
import java.util.List;
import ie.irishliterature.model.Library;

public class DataTableDevice {

    int iTotalRecords;

    int iTotalDisplayRecords;
    

    String sEcho;

    String sColumns;

    List<Library> aaData;

    public int getiTotalRecords() {
        return iTotalRecords;
    }

    public void setiTotalRecords(int iTotalRecords) {
        this.iTotalRecords = iTotalRecords;
    }

    public int getiTotalDisplayRecords() {
        return iTotalDisplayRecords;
    }

    public void setiTotalDisplayRecords(int iTotalDisplayRecords) {
        this.iTotalDisplayRecords = iTotalDisplayRecords;
    }

    public String getsEcho() {
        return sEcho;
    }

    public void setsEcho(String sEcho) {
        this.sEcho = sEcho;
    }

    public String getsColumns() {
        return sColumns;
    }

    public void setsColumns(String sColumns) {
        this.sColumns = sColumns;
    }

    public List<Library> getAaData() {
        return aaData;
    }

    public void setAaData(List<Library> aaData) {
        this.aaData = aaData;
    }

}

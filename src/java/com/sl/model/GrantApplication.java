package com.sl.model;

public class GrantApplication {

    private boolean APPROVED;

    private boolean TC_ACCEPTED;

    private String USERNAME;

    private String EMAIL;

    private String FIRST_NAME;

    private String LAST_NAME;

    private String EMAIL_VERIFICATION_HASH;

    private int EMAIL_VERIFICATION_ATTEMPTS;

    private String PASSWORD;

    private String FUNCTION;

    private String ROLE;

    private String CREATED_TIME;

    private String STATUS;

    public String getUSERNAME() {
        return USERNAME;
    }

    public void setUSERNAME(String USERNAME) {
        this.USERNAME = USERNAME;
    }

    public String getEMAIL() {
        return EMAIL;
    }

    public void setEMAIL(String EMAIL) {
        this.EMAIL = EMAIL;
    }

    public String getFIRST_NAME() {
        return FIRST_NAME;
    }

    public void setFIRST_NAME(String FIRST_NAME) {
        this.FIRST_NAME = FIRST_NAME;
    }

    public String getLAST_NAME() {
        return LAST_NAME;
    }

    public void setLAST_NAME(String LAST_NAME) {
        this.LAST_NAME = LAST_NAME;
    }

    public String getEMAIL_VERIFICATION_HASH() {
        return EMAIL_VERIFICATION_HASH;
    }

    public void setEMAIL_VERIFICATION_HASH(String EMAIL_VERIFICATION_HASH) {
        this.EMAIL_VERIFICATION_HASH = EMAIL_VERIFICATION_HASH;
    }

    public int getEMAIL_VERIFICATION_ATTEMPTS() {
        return EMAIL_VERIFICATION_ATTEMPTS;
    }

    public void setEMAIL_VERIFICATION_ATTEMPTS(int EMAIL_VERIFICATION_ATTEMPTS) {
        this.EMAIL_VERIFICATION_ATTEMPTS = EMAIL_VERIFICATION_ATTEMPTS;
    }

    public String getPASSWORD() {
        return PASSWORD;
    }

    public void setPASSWORD(String PASSWORD) {
        this.PASSWORD = PASSWORD;
    }

    public String getFUNCTION() {
        return FUNCTION;
    }

    public void setFUNCTION(String FUNCTION) {
        this.FUNCTION = FUNCTION;
    }

    public String getROLE() {
        return ROLE;
    }

    public void setROLE(String ROLE) {
        this.ROLE = ROLE;
    }

    public String getSTATUS() {
        return STATUS;
    }

    public void setSTATUS(String STATUS) {
        this.STATUS = STATUS;
    }

    public String getCREATED_TIME() {
        return CREATED_TIME;
    }

    public void setCREATED_TIME(String CREATED_TIME) {
        this.CREATED_TIME = CREATED_TIME;
    }

    @Override
    public String toString() {
        return "ClassPojo [USERNAME = " + getUSERNAME() + ", EMAIL = " + getEMAIL() + ", FIRST_NAME = " + getFIRST_NAME() + ", LAST_NAME = " + getLAST_NAME() + ", EMAIL_VERIFICATION_HASH = " + getEMAIL_VERIFICATION_HASH() + ", EMAIL_VERIFICATION_ATTEMPTS = " + getEMAIL_VERIFICATION_ATTEMPTS() + ", PASSWORD = " + getPASSWORD() + ", STATUS = " + getSTATUS() + ", CREATED_TIME = " + getCREATED_TIME() + "]";
    }

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
}

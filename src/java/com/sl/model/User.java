package com.sl.model;

public class User {

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
        return "ClassPojo [USERNAME = " + USERNAME + ", EMAIL = " + EMAIL + ", FIRST_NAME = " + FIRST_NAME + ", LAST_NAME = " + LAST_NAME + ", EMAIL_VERIFICATION_HASH = " + EMAIL_VERIFICATION_HASH + ", EMAIL_VERIFICATION_ATTEMPTS = " + EMAIL_VERIFICATION_ATTEMPTS + ", PASSWORD = " + PASSWORD + ", STATUS = " + STATUS + ", CREATED_TIME = " + CREATED_TIME + "]";
    }

}

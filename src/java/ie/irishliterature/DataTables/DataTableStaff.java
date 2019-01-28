/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.DataTables;
/**
 *
 * @author markus
 */
public class DataTableStaff {
    
    	/// <summary>
    /// Request sequence number sent by DataTable, same value must be returned in response
    /// </summary>       
    private String sEcho;

    /// <summary>
    /// Text used for filtering
    /// </summary>
    private String sSearch;

    /// <summary>
    /// Number of records that should be shown in table
    /// </summary>
    private int iDisplayLength;

    /// <summary>
    /// First record that should be shown(used for paging)
    /// </summary>
    private int iDisplayStart;

    /// <summary>
    /// Number of columns in table
    /// </summary>
    private int iColumns;	

    /// <summary>
    /// Number of columns that are used in sorting
    /// </summary>
    private int iSortingCols;
    
    /// <summary>
    /// Index of the column that is used for sorting
    /// </summary>
    private int iSortColumnIndex;
    
    /// <summary>
    /// Sorting direction "asc" or "desc"
    /// </summary>
    private String sSortDirection;

    /// <summary>
    /// Comma separated list of column names
    /// </summary>
    private String sColumns;

    /**
     * @return the sEcho
     */
    public String getsEcho() {
        return sEcho;
    }

    /**
     * @param sEcho the sEcho to set
     */
    public void setsEcho(String sEcho) {
        this.sEcho = sEcho;
    }

    /**
     * @return the sSearch
     */
    public String getsSearch() {
        return sSearch;
    }

    /**
     * @param sSearch the sSearch to set
     */
    public void setsSearch(String sSearch) {
        this.sSearch = sSearch;
    }

    /**
     * @return the iDisplayLength
     */
    public int getiDisplayLength() {
        return iDisplayLength;
    }

    /**
     * @param iDisplayLength the iDisplayLength to set
     */
    public void setiDisplayLength(int iDisplayLength) {
        this.iDisplayLength = iDisplayLength;
    }

    /**
     * @return the iDisplayStart
     */
    public int getiDisplayStart() {
        return iDisplayStart;
    }

    /**
     * @param iDisplayStart the iDisplayStart to set
     */
    public void setiDisplayStart(int iDisplayStart) {
        this.iDisplayStart = iDisplayStart;
    }

    /**
     * @return the iColumns
     */
    public int getiColumns() {
        return iColumns;
    }

    /**
     * @param iColumns the iColumns to set
     */
    public void setiColumns(int iColumns) {
        this.iColumns = iColumns;
    }

    /**
     * @return the iSortingCols
     */
    public int getiSortingCols() {
        return iSortingCols;
    }

    /**
     * @param iSortingCols the iSortingCols to set
     */
    public void setiSortingCols(int iSortingCols) {
        this.iSortingCols = iSortingCols;
    }

    /**
     * @return the iSortColumnIndex
     */
    public int getiSortColumnIndex() {
        return iSortColumnIndex;
    }

    /**
     * @param iSortColumnIndex the iSortColumnIndex to set
     */
    public void setiSortColumnIndex(int iSortColumnIndex) {
        this.iSortColumnIndex = iSortColumnIndex;
    }

    /**
     * @return the sSortDirection
     */
    public String getsSortDirection() {
        return sSortDirection;
    }

    /**
     * @param sSortDirection the sSortDirection to set
     */
    public void setsSortDirection(String sSortDirection) {
        this.sSortDirection = sSortDirection;
    }

    /**
     * @return the sColumns
     */
    public String getsColumns() {
        return sColumns;
    }

    /**
     * @param sColumns the sColumns to set
     */
    public void setsColumns(String sColumns) {
        this.sColumns = sColumns;
    }
    
}

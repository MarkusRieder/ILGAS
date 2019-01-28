/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.util;

import ie.irishliterature.DataTables.DataTableStaff;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author markus
 */
public class DataTablesParamUtility {
	
	public static DataTableStaff getParam(HttpServletRequest request)
	{
		if(request.getParameter("sEcho")!=null && !"".equals(request.getParameter("sEcho")))
		{
			DataTableStaff param = new DataTableStaff();
			param.setsEcho(request.getParameter("sEcho"));
			param.setsSearch(request.getParameter("sSearch"));
			param.setsColumns(request.getParameter("sColumns"));
			param.setiDisplayStart(Integer.parseInt( request.getParameter("iDisplayStart") ));
			param.setiDisplayLength(Integer.parseInt( request.getParameter("iDisplayLength") ));
			param.setiColumns(Integer.parseInt( request.getParameter("iColumns") ));
			param.setiSortingCols(Integer.parseInt( request.getParameter("iSortingCols") ));
			param.setiSortColumnIndex(Integer.parseInt(request.getParameter("iSortCol_0")));
			param.setsSortDirection(request.getParameter("sSortDir_0"));
			return param;
		}else {
                    return null;
                }
	}
}

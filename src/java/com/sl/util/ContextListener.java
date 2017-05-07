package com.sl.util;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
 
@WebListener("application context listener")
public class ContextListener implements ServletContextListener {
 
    /**
     * Initialize log4j when the application is being started
     * @param event
     */
    @Override
    public void contextInitialized(ServletContextEvent event) {
        // initialize log4j here
        ServletContext context = event.getServletContext();
//        String log4jConfigFile = context.getInitParameter("log4j-config-location");
//        String fullPath = context.getRealPath("") + File.separator + log4jConfigFile + "/WEB-INF/";
//         
//        PropertyConfigurator.configure(fullPath);
//        
//         System.out.println("context:  " + context);
//         System.out.println("log4jConfigFile:  " + log4jConfigFile);
//         System.out.println("log:  " + fullPath);
//          System.out.println("context.getRealPath  " + context.getRealPath(""));
    }
     
    @Override
    public void contextDestroyed(ServletContextEvent event) {
        // do nothing
    }  
}

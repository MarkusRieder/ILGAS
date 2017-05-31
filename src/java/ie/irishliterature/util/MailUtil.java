package ie.irishliterature.util;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailUtil {

    public static void sendEmailRegistrationLink(String uname, String email, String hash) throws AddressException, MessagingException {
        Properties props = new Properties();

        props.put("mail.smtp.host", "lh30.dnsireland.com");
        props.put("mail.smtp.port", "26");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Setup.MAIL_USERNAME, Setup.MAIL_PASSWORD);
            }
        });

        try {

            String link = Setup.MAIL_REGISTRATION_SITE_LINK + "?scope=activation&userId=" + uname + "&hash=" + hash;

            StringBuilder bodyText = new StringBuilder();
//            bodyText.append("<div>")
//                    .append("  Dear User " + uname + "<br/><br/>")
//                    .append("  Thank you for registration. Your mail (" + email + ") is under verification<br/>")
//                    .append("  Please click <a href=\"" + link + "\">here</a> or open below link in browser<br/>")
//                    .append("  <a href=\"" + link + "\">" + link + "</a>")
//                    .append("  <br/><br/>")
//                    .append("  Thanks,<br/>")
//                    .append("  Irish Literature")
//                    .append("</div>");
            bodyText.append("<div>")
                    .append("  Dear Irish Literature User,<br/><br/>")
                    .append("  ")
                    .append("  This email is sent to validate the email address that you have")
                    .append("  provided for your Irish Literature login.")
                    .append("   <br/><br/>")
                    .append("  To ensure the security of the account information associated with your")
                    .append("  Irish Literature login, please take a moment to click through the link below")
                    .append("  and verify that we have the correct email address. If you do not")
                    .append("  confirm your email address, your Irish Literature login will eventually be")
                    .append("  disabled.")
                    .append("   <br/><br/>")
                    .append("  To confirm your email address, please visit the following URL:")
                    .append("   <br/><br/>")
                    .append("  <a href=\"" + link + "\">" + link + "</a>")
                    .append("   <br/><br/>")
                    .append("  Thank you for being part of Irish Literature.")
                    .append("   <br/><br/>")
                    .append("  Account Information:<br/><br/>")
                    .append("    Your login:         " + uname + "<br/>")
                    .append("    Your email address: " + email)
                    .append("</div>");

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Setup.MAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(email));
            message.setSubject("Irish Literature - Email Registration");
            message.setContent(bodyText.toString(), "text/html; charset=utf-8");
            message.setSentDate(new Date());
            Transport.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public static void sendResetPasswordLink(String id, String email, String hash) throws AddressException, MessagingException {

        Properties props = new Properties();
        props.put("mail.smtp.host", "lh30.dnsireland.com");
        props.put("mail.smtp.port", "26");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Setup.MAIL_USERNAME, Setup.MAIL_PASSWORD);
            }
        });

        try {

            String link = Setup.MAIL_REGISTRATION_SITE_LINK + "?scope=resetPassword&userId=" + id + "&hash=" + hash;

            StringBuilder bodyText = new StringBuilder();
            bodyText.append("<div>")
                    .append("  Dear User<br/><br/>")
                    .append("  We got your reset password request, Find below link to reset password <br/>")
                    .append("  Please click <a href=\"" + link + "\">here</a> or open below link in browser<br/>")
                    .append("  <a href=\"" + link + "\">" + link + "</a>")
                    .append("  <br/><br/>")
                    .append("  Thanks,<br/>")
                    .append("  Irish Literature")
                    .append("</div>");
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Setup.MAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(email));
            message.setSubject("Irish Literature - Reset Password");
            message.setContent(bodyText.toString(), "text/html; charset=utf-8");
            message.setSentDate(new Date());
            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}

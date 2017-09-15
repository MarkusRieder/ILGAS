package ie.irishliterature.util;

import java.util.Date;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

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
                    .append("  <a href=\"")
                    .append(link)
                    .append("\">")
                    .append(link)
                    .append("</a>")
                    .append("   <br/><br/>")
                    .append("  Thank you for being part of Irish Literature.")
                    .append("   <br/><br/>")
                    .append("  Account Information:<br/><br/>")
                    .append("    Your login:         ")
                    .append(uname)
                    .append("<br/>")
                    .append("    Your email address: ")
                    .append(email)
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
                    .append("  Please click <a href=\"")
                    .append(link)
                    .append("\">here</a> or open below link in browser<br/>")
                    .append("  <a href=\"")
                    .append(link)
                    .append("\">")
                    .append(link)
                    .append("</a>")
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

    public static void sendEmailWithAttachmentExpertReader(String expertReaderName, String expertReaderEmail, String[] attachFiles, String expectedReturnDate) throws AddressException, MessagingException {

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

            StringBuilder bodyText = new StringBuilder();
            bodyText.append("<div>").append("  Dear ")
                    .append(expertReaderName)
                    .append(",<br/><br/>")
                    .append("<br/><br/>")
                    .append("Many thanks for agreeing to take on this task. Please find attached a sample translation of the above mentioned title in German together with a copy of the original work. Please supply a report of no more than two pages on the sample translation enclosed, addressing the points below.")
                    .append("<br/><br/>")
                    .append("Your report will be taken into account by the Board of Literature Ireland (formerly Ireland Literature Exchange) when assessing this application. The report may also be made available, anonymously, to the publisher and/or translator of the work. For this reason, we would recommend that an objective tone be maintained throughout. <strong>Please do not sign your name to the report</strong>. Use the project reference number only.")
                    .append("<br/><br/>")
                    .append("<ol>")
                    .append("<li>       Is the literary quality of the translation of an acceptable standard? Is the quality maintained consistently throughout the enclosed extract?</li>")
                    .append("<li>       Is the translation readable, i.e. does it flow?")
                    .append("<li>       Does the style of the translation reflect that of the original?</li>")
                    .append("<li>       Is the translation complete, correct and accurate?")
                    .append("<li>       Does the original pose specific difficulties, e.g. specialised terminology, culture-specific vocabulary, dialect? Does the translator resolve these difficulties adequately? Does the translator demonstrate complete creative command of his/her own language?</li>")
                    .append("<li>       If applicable, please comment on register, rhyme, rhythm, alliteration, word order and other poetic devices, or is the translation a free interpretation?</li>")
                    .append("<li>       Would you recommend publication of the translation? If yes, please specify whether you would recommend publication a) as it stands or b) with revisions.</li>")
                    .append("</ol>")
                    .append("<strong>Please supply concrete textual examples</strong> both in the language of the original and in that of the translation to illustrate your assessment, bearing in mind that the board and staff of Literature Ireland may not be familiar with the language of the translation in question. In other words, we would ask you to furnish explanations in English for what in your opinion are grounds for praise or criticism. Also, if you can see an improved solution, we would ask you to provide concrete suggestions.<br />")
                    .append("The fee for the report will be EUR €125. We would be grateful if you could return your report to me as a <strong>Word document</strong> (or equivalent but not PDF) by <strong>")
                    .append(expectedReturnDate)
                    .append("</strong>. Please let me know if you would like to receive a gratis copy of the finished translation on publication.<br />")
                    .append("<br/><br/>")
                    .append("We ask that submit an invoice, citing the project reference number, at the same time as your report, along with a completed bank details form. A copy of this form can be requested via email to <a href='mailto:florence@irelandliterature.com'>florence@irelandliterature.com</a>.<br /><br />")
                    .append("<br/><br/>")
                    .append("If you have any queries, please do not hesitate to contact me.")
                    .append("<br/><br/>")
                    .append("Thank you for your time and expertise.")
                    .append("<br/><br/>")
                    .append("Kind regards, <br />")
                    .append("Rita McCann<br />")
                    .append("<br/><br/>")
                    .append("<br/><br/>")
                    .append("--<br />")
                    .append("Deputy Director<br />")
                    .append("Literature Ireland<br />")
                    .append("<br/><br/>")
                    .append("Trinity Centre for Literary Translation, 36 Fenian Street, Trinity College Dublin, Dublin 2<br />")
                    .append("Ireland <br />")
                    .append("Tel: +353 1 896 4179")
                    .append("</div>");

            //   System.out.println(bodyText);
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Setup.MAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(expertReaderEmail));
            message.setSubject("Irish Literature - New book for review");

            // creates message part
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(bodyText.toString(), "text/html");

            // creates multi-part
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);

            // adds attachments
            if (attachFiles != null && attachFiles.length > 0) {
                for (String filePath : attachFiles) {

                    messageBodyPart = new MimeBodyPart();
                    DataSource source = new FileDataSource(filePath);
                    messageBodyPart.setDataHandler(new DataHandler(source));
                    messageBodyPart.setFileName(filePath);

                    multipart.addBodyPart(messageBodyPart);

                }
            }

            // sets the multi-part as e-mail's content
            message.setContent(multipart, "text/html; charset=utf-8");

            //   message.setContent(bodyText.toString(), "text/html; charset=utf-8");
            message.setSentDate(new Date());

            // sends the e-mail
            Transport.send(message);

        } catch (MessagingException e) {

            throw new RuntimeException(e);
        }
    }
}

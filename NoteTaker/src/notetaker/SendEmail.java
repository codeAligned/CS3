package notetaker;

import java.io.IOException;
import java.util.Properties;
 
import java.util.Date;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
 
@SuppressWarnings("serial")
public class SendEmail extends HttpServlet {
 
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        
        Date date = new Date();
        
        // read parameters
        String note = req.getParameter("content");
        String recipient = req.getParameter("mailTo");
        Properties props = new Properties();
        Session session = Session.getDefaultInstance(props, null);
 
        // compose the message to send
        String msgBody = "Your Note: \n" + note + "\n \n Sent at: \n" + date;
 
        // get address/name to send from
        String address = user.toString();
        String nick = user.getNickname();
        
        // if email recipient is empty, just send back to self to avoid error
        if (recipient == "") {
        	recipient = address;
        }
        
        
        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(address, nick));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
                    recipient));
            msg.setSubject("Note from Lakers NoteTaker");
            msg.setText(msgBody);
            Transport.send(msg);
 
        } catch (Exception e) {
            resp.setContentType("text/plain");
            resp.getWriter().println("Something went wrong. Please try again.");
            throw new RuntimeException(e);
        }
 
        // if successful give confirmation that a note has been emailed.
        resp.setContentType("text/plain");
        resp.getWriter().println(
                "An email has been sent out to " + recipient + ". \n" + "\n"
        + "\n" + "(Hit Back to go back to your notes.) \n");
    }
}
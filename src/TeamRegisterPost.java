import java.net.URLEncoder;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.OutputStream;

/**
 * This public class registers the team to the class metadata system.
 */
public class TeamRegisterPost {
     /**
     * This is where the file runs through.
     * @param  args      part of main
     * @throws Exception just in case
     */
    public static void main(final String[] args) throws Exception {

        // Encode data.
        String content = "name=" + URLEncoder.encode("lakers")
                + "&gerritProject="
                + URLEncoder.encode("lakers") + "&gerritGroup="
                + URLEncoder.encode("lakers") + "&buildTarget="
                + URLEncoder.encode("build.xml") + "&homePage="
                + URLEncoder.encode("http://goo.gl/gSO04")
                + "&javadocUrl=" + URLEncoder.encode("N/A")
                + "&testDashboardUrl="
                + URLEncoder.encode("N/A")
                + "&testDashboardXml="
                + URLEncoder.encode("N/A") + "&buildStatusUrl="
                + URLEncoder.encode("N/A") + "&buildStatusXml="
                + URLEncoder.encode("N/A") + "&apiJavadocUrl="
                + URLEncoder.encode("N/A") + "&apiDocUrl="
                + URLEncoder.encode("http://goo.gl/DXw8s") + "&designDocUrl="
                + URLEncoder.encode("http://goo.gl/ZYnFC")
                + "&introDocUrl="
                + URLEncoder.encode("http://goo.gl/UEvWs")
                + "&frontendUrl="
                + URLEncoder.encode("http://goo.gl/gSO04")
                + "&demoPresentationUrl="
                + URLEncoder.encode("http://goo.gl/gSO04")
                + "&appUrl="
                + URLEncoder.encode("http://goo.gl/gSO04")
                + "&gerritAccountId="
                + URLEncoder.encode("1000155")
                + "&gerritAccountKey="
                + URLEncoder.encode("E99F2D");

        // Establish the connection to the server.
        HttpURLConnection connection = (HttpURLConnection) (new URL(
                "http://cs3.cms.caltech.edu/cms/team")
                .openConnection());
        connection.setDoOutput(true);
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Length", ""
                + content.getBytes().length);

        // Get the output.
        OutputStream output = connection.getOutputStream();
        output.write(content.getBytes());
        output.close();

        // Print the response.
        System.out.println("The response code is: "
                + connection.getResponseCode());
    }
}

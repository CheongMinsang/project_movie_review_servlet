package controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EncryptServlet")
public class EncryptServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = request.getParameter("password");
        String encryptedPassword = encryptSHA256(password);
        response.getWriter().write(encryptedPassword);
    }

    private String encryptSHA256(String value) {
        String encryptData = "";
        try {
            MessageDigest sha = MessageDigest.getInstance("SHA-256");
            sha.update(value.getBytes());

            byte[] digest = sha.digest();
            for (int i = 0; i < digest.length; i++) {
                encryptData += Integer.toHexString(digest[i] & 0xFF).toUpperCase();
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return encryptData;
    }
}

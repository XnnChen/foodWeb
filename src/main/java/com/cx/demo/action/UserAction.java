package com.cx.demo.action;

import com.cx.demo.model.User;
import com.cx.demo.util.DB;
import org.jasypt.util.password.StrongPasswordEncryptor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/user")
public class UserAction extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action.equals("signUp")) {
            signUp(req, resp);
        }
        if (action.equals("checkEmail")) {
            checkEmail(req, resp);
        }
        if (action.equals("logIn")) {
            logIn(req, resp);
        }
        if (action.equals("signOut")) {
            signOut(req, resp);
        }
    }

    private void signUp(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email").trim();
        if (queryUserByEmail(email) != null) {
            req.setAttribute("message", "Email is already existed.");
            req.getRequestDispatcher("signUp.jsp").forward(req, resp);
            return;
        }

        Connection connection = DB.getConnection();
        PreparedStatement preparedStatement = null;
        String firstName = req.getParameter("firstname").trim();
        String lastName = req.getParameter("lastname").trim();
        String password = req.getParameter("password");
        StrongPasswordEncryptor strongPasswordEncryptor = new StrongPasswordEncryptor();
        String encryptedPassword = strongPasswordEncryptor.encryptPassword(password);
        String sql = "insert into foodweb_db.user value(null, ?, ?, ?, ?)";
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,email);
            preparedStatement.setString(2,firstName);
            preparedStatement.setString(3,lastName);
            preparedStatement.setString(4,encryptedPassword);
            preparedStatement.executeUpdate();
            resp.sendRedirect("home.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void checkEmail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email").trim();
        if(queryUserByEmail(email) != null){
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("application/json; charset=UTR-8");
            String data = "{\"isEmailExisted\" : true}";
            resp.getWriter().write(data);
        }
    }

    private User queryUserByEmail(String email){
        try {
            Connection connection = DB.getConnection();
            String sql = "select * from foodweb_db.user where email = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,email);
            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                return new User(
                        resultSet.getInt("id"),
                        resultSet.getString("email"),
                        resultSet.getString("firstname"),
                        resultSet.getString("lastname"),
                        resultSet.getString("password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private void logIn(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email").trim();
        String password = req.getParameter("password");
        User user = queryUserByEmail(email);

        if(user != null){
            StrongPasswordEncryptor strongPasswordEncryptor = new StrongPasswordEncryptor();
            if(strongPasswordEncryptor.checkPassword(password,user.getPassword())){
                req.getSession().setAttribute("user",user);
                resp.sendRedirect("index.jsp");
                return;
            }
        }
        req.setAttribute("message", "Invalid Email or password.");
        req.getRequestDispatcher("home.jsp").forward(req,resp);
    }

    private void signOut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().invalidate();
        resp.sendRedirect("home.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}

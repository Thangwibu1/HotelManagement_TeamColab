package controller;

import dao.GuestDAO;
import dao.StaffDAO;
import model.Guest;
import model.Staff;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private StaffDAO staffDAO;
    private GuestDAO guestDAO;

    @Override
    public void init() throws ServletException {
        staffDAO = new StaffDAO();
        guestDAO = new GuestDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Staff staff = staffDAO.getStaffByUsernameAndPassword(username, password);
        Guest guest = guestDAO.getGuestByUsernameAndPassword(username, password);
        request.getSession().setAttribute("isLogin", false);

        if (staff != null) {
            request.getSession().setAttribute("isLogin", true);
            request.getSession().setAttribute("userStaff", staff);
            response.sendRedirect("home");
            return; // Dừng thực thi
        }
        System.out.println(guest);
        if (guest != null) {
            request.getSession().setAttribute("isLogin", true);
            request.getSession().setAttribute("userGuest", guest);
            response.sendRedirect("home");
            return; // Dừng thực thi
        }

// Nếu cả hai đều null
        request.setAttribute("error", "Invalid username or password");
        request.getRequestDispatcher("loginPage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
}

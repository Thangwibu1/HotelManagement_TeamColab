package controller;

import dao.RoomDAO;
import dao.RoomTypeDAO;
import model.Room;
import model.RoomType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {
    private RoomDAO roomDAO;
    private RoomTypeDAO roomTypeDAO;

    @Override
    public void init() throws ServletException {
        roomDAO = new RoomDAO();
        roomTypeDAO = new RoomTypeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ArrayList<Room> rooms = roomDAO.getAllRoom();
        ArrayList<RoomType> roomTypes = roomTypeDAO.getAllRoomType();
        req.setAttribute("rooms", rooms);
        req.setAttribute("roomTypes", roomTypes);
        req.getRequestDispatcher("home.jsp").forward(req, resp);
        // test thui

    }
}

package dao;

import model.Staff;
import utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class StaffDAO {
    public ArrayList<Staff> getAllStaff() {
        ArrayList<Staff> result = new ArrayList<>();
        String sql = "SELECT TOP (1000) [StaffID] ,[FullName] ,[Role] ,[Username] ,[PasswordHash] ,[Phone] ,[Email] FROM [HotelManagement].[dbo].[STAFF]";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs != null) {
                    Staff staff = new Staff();
                    staff.setStaffId(rs.getInt("StaffID"));
                    staff.setFullName(rs.getString("FullName"));
                    staff.setRole(rs.getString("Role"));
                    staff.setUsername(rs.getString("Username"));
                    staff.setPasswordHash(rs.getString("PasswordHash"));
                    staff.setPhone(rs.getString("Phone"));
                    staff.setEmail(rs.getString("Email"));
                    result.add(staff);

            }
        } catch (Exception e) {

        }
        return result;
    }

    public Staff getStaffByUsernameAndPassword(String username, String password) {
        Staff staff = new Staff();

        String sql = "SELECT TOP (1000) [StaffID] ,[FullName] ,[Role] ,[Username] ,[PasswordHash] ,[Phone] ,[Email] FROM [HotelManagement].[dbo].[STAFF] where Username = ? and PasswordHash = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    staff.setStaffId(rs.getInt("StaffID"));
                    staff.setFullName(rs.getString("FullName"));
                    staff.setRole(rs.getString("Role"));
                    staff.setUsername(rs.getString("Username"));
                    staff.setPasswordHash(rs.getString("PasswordHash"));
                }
            }

        } catch (Exception e) {

        }

        return staff;
    }
}

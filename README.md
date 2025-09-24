Sửa lại bên trong RoomTypeDao hàm này

```java
public ArrayList<RoomType> getAllRoomType() {
        ArrayList<RoomType> result = new ArrayList<RoomType>();

        String sql = "  SELECT [RoomTypeID] ,[TypeName], [Capacity] ,[PricePerNight] FROM [HotelManagement].[dbo].[ROOM_TYPE]";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("RoomTypeID");
                String typeName = rs.getString("TypeName");
                int capacity = rs.getInt("Capacity");
                BigDecimal pricePerNight = rs.getBigDecimal("PricePerNight");
                RoomType roomType = new RoomType(id, typeName, capacity, pricePerNight);

                result.add(roomType);
            }
        } catch (SQLException e) {
            System.err.println("Database error in getAllRoomType: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("General error in getAllRoomType: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Close resources in reverse order
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }

        return result;
    }
```

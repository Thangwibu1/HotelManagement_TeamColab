<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Room" %>
<%@ page import="model.RoomType" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luxury Hotel</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
</head>
<body>

<%-- Lấy danh sách rooms và roomTypes từ request attributes --%>
<%
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
    List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
%>

<header class="header">
    <div class="container">
        <div class="logo">
            <a href="#">Luxury Hotel</a>
        </div>
        <nav class="main-nav">
            <form action="login" method="GET" style="display: inline;">
                <button type="submit" class="btn btn-secondary">Đăng nhập</button>
            </form>
            <form action="register" method="GET" style="display: inline;">
                <button type="submit" class="btn btn-primary">Đăng ký</button>
            </form>
        </nav>
    </div>
</header>

<section class="hero">
    <div class="hero-content">
        <h1>Chào mừng đến với Luxury Hotel</h1>
        <p>Trải nghiệm đẳng cấp - Dịch vụ hoàn hảo</p>
    </div>
    <div class="booking-form-container">
        <form class="booking-form">
            <div class="form-group">
                <label for="check-in">Ngày nhận phòng</label>
                <input type="date" id="check-in" name="check-in">
            </div>
            <div class="form-group">
                <label for="check-out">Ngày trả phòng</label>
                <input type="date" id="check-out" name="check-out">
            </div>
            <div class="form-group">
                <label for="guests">Số người</label>
                <input type="number" id="guests" name="guests" value="2" min="1">
            </div>
            <div class="form-group">
                <label for="room-type">Loại phòng</label>
                <select id="room-type" name="room-type">
                    <option value="">Chọn loại phòng</option>
                    <%
                        if (roomTypes != null) {
                            for (RoomType rt : roomTypes) {
                    %>
                    <option value="<%= rt.getRoomTypeId() %>"><%= rt.getTypeName() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn btn-search">Tìm kiếm phòng</button>
        </form>
    </div>
</section>

<main class="main-content">
    <div class="container">
        <section class="room-listings">
            <h2>Phòng khách sạn</h2>
            <p>Khám phá các loại phòng đa dạng với kiến trúc hiện đại</p>

            <div class="room-grid">
                <%
                    if (rooms != null && !rooms.isEmpty()) {
                        for (Room room : rooms) {
                            // Tìm RoomType tương ứng với roomTypeId của room này
                            RoomType currentRoomType = null;
                            if (roomTypes != null) {
                                for (RoomType rt : roomTypes) {
                                    if (rt.getRoomTypeId() == room.getRoomTypeId()) {
                                        currentRoomType = rt;
                                        break; // Tìm thấy rồi thì thoát loop
                                    }
                                }
                            }
                            
                            // Lấy thông tin từ RoomType hoặc dùng default
                            String typeName = currentRoomType != null ? currentRoomType.getTypeName() : "Standard";
                            String price = currentRoomType != null ? String.format("%.0f", currentRoomType.getPricePerNight()) : "1,500,000";
                            int capacity = currentRoomType != null ? currentRoomType.getCapacity() : 2;
                %>
                <div class="room-card">
                    <div class="room-image">
                        <img src="images/room-<%= room.getRoomId() %>.jpg" alt="Phòng <%= room.getRoomNumber() %>">
                        <span class="room-badge <%= typeName.toLowerCase() %>"><%= typeName %></span>
                    </div>
                    <div class="room-details">
                        <h3>Phòng <%= room.getRoomNumber() %></h3>
                        <p class="room-description">
                            <%= room.getDescription() != null ? room.getDescription() : "Phòng thoải mái với đầy đủ tiện nghi hiện đại." %>
                        </p>
                        <div class="room-amenities">
                            <span><i class="fa-solid fa-user-group"></i> Tối đa <%= capacity %> người</span>
                            <span><i class="fa-solid fa-bed"></i> Giường <%= typeName %></span>
                            <%
                                // Thêm tiện ích dựa trên giá phòng
                                if (currentRoomType != null && currentRoomType.getPricePerNight().doubleValue() > 2000000) {
                            %>
                            <span><i class="fa-solid fa-mug-saucer"></i> Breakfast</span>
                            <span><i class="fa-solid fa-car"></i> Parking</span>
                            <%
                                }
                            %>
                        </div>
                        <div class="room-price"><%= price %> VNĐ <span>/đêm</span></div>
                        <button class="btn btn-book">Đặt phòng ngay</button>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <p>Hiện không có phòng nào để hiển thị.</p>
                <%
                    }
                %>
            </div>
        </section>
    </div>
</main>

<footer class="footer">
    <div class="container footer-grid">
        <div class="footer-col">
            <h3>Luxury Hotel</h3>
            <p>Chất lượng sang trọng hàng đầu với dịch vụ chất lượng cao và các tiện ích tốt.</p>
        </div>
        <div class="footer-col">
            <h3>Liên hệ</h3>
            <p><i class="fa-solid fa-location-dot"></i> 123 Đường ABC, Quận 1, TP.HCM</p>
            <p><i class="fa-solid fa-phone"></i> (028) 1234-5678</p>
            <p><i class="fa-solid fa-envelope"></i> info@luxuryhotel.com</p>
        </div>
        <div class="footer-col">
            <h3>Dịch vụ</h3>
            <ul>
                <li><a href="#">Nhà hàng & Bar</a></li>
                <li><a href="#">Spa & Trị liệu</a></li>
                <li><a href="#">Bể bơi Rooftop</a></li>
                <li><a href="#">Phòng gym hiện đại</a></li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2024 Luxury Hotel. Bảo lưu mọi quyền.</p>
    </div>
</footer>

</body>
</html>
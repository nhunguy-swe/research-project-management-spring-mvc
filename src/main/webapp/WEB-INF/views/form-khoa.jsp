<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="container mt-4" style="max-width: 600px;">
    <div class="card shadow border-0">
        <div class="card-header bg-dark text-white text-center py-3">
            <h4 class="mb-0 fw-bold"><i class="bi bi-building-plus-fill me-2"></i>Thêm Khoa Mới</h4>
        </div>
        <div class="card-body p-4 bg-white">

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/khoa/them" method="post">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Mã Khoa (Viết tắt)</label>
                    <input type="text" name="maKhoa" class="form-control" placeholder="Ví dụ: CNTT, KHMT, ĐTVT..." required>
                    <div class="form-text">Mã khoa là khóa chính và không được trùng lặp.</div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên đầy đủ của Khoa</label>
                    <input type="text" name="tenKhoa" class="form-control" placeholder="Ví dụ: Công nghệ thông tin..." required>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Vị trí văn phòng Khoa</label>
                    <input type="text" name="vanPhongKhoa" class="form-control" placeholder="Ví dụ: Phòng 401 - Nhà C..." required>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg fw-bold">
                        <i class="bi bi-check-circle-fill me-2"></i>Lưu Thông Tin Khoa
                    </button>
                    <a href="${pageContext.request.contextPath}/khoa/tra-cuu" class="btn btn-outline-secondary">
                        <i class="bi bi-list-ul me-1"></i> Xem danh sách và Tra cứu Khoa
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>

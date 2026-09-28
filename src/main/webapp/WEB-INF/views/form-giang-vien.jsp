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
            <h4 class="mb-0 fw-bold"><i class="bi bi-person-plus-fill me-2"></i>Thêm Giảng Viên Mới</h4>
        </div>
        <div class="card-body p-4 bg-white">

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/giang-vien/them" method="post">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Họ và tên Giảng viên</label>
                    <input type="text" name="hoTen" class="form-control" placeholder="Nhập đầy đủ họ tên..." required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Học vị</label>
                    <select name="hocVi" class="form-select" required>
                        <option value="Thạc sĩ">Thạc sĩ</option>
                        <option value="Tiến sĩ" selected>Tiến sĩ</option>
                        <option value="PGS">Phó Giáo sư (PGS)</option>
                        <option value="GS">Giáo sư (GS)</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Địa chỉ Email</label>
                    <input type="email" name="email" class="form-control" placeholder="username@university.edu.vn" required>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Thuộc Khoa quản lý</label>
                    <select name="maKhoa" class="form-select" required>
                        <option value="">-- Chọn Khoa chủ quản --</option>
                        <c:forEach items="${listKhoa}" var="k">
                            <option value="${k.maKhoa}">${k.tenKhoa}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-success btn-lg fw-bold">
                        <i class="bi bi-check-circle-fill me-2"></i>Lưu Thông Tin
                    </button>
                    <a href="${pageContext.request.contextPath}/giang-vien/tra-cuu" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-right-short me-1"></i>Chuyển đến trang Tra cứu
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>

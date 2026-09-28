<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Đề Tài Nghiên Cứu</title>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="container">
    <div class="p-5 mb-5 bg-white rounded-3 shadow-sm border">
        <div class="container-fluid py-3 text-center text-md-start">
            <h1 class="display-5 fw-bold text-dark">Chào mừng bạn đến với Cổng nghiên cứu khoa học</h1>
            <p class="col-md-9 fs-5 text-muted mt-3">
                Hệ thống hỗ trợ sinh viên đăng ký đề tài nghiên cứu khoa học dưới sự hướng dẫn chuyên môn của các Giảng viên, Phó giáo sư, Tiến sĩ trực thuộc các Khoa trong toàn trường.
            </p>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/dang-ky" class="btn btn-success btn-lg px-4 me-md-2 mb-2">
                    <i class="bi bi-plus-circle me-2"></i>Đăng ký đề tài mới
                </a>
                <a href="${pageContext.request.contextPath}/tra-cuu" class="btn btn-outline-dark btn-lg px-4 mb-2">
                    <i class="bi bi-search me-2"></i>Tra cứu đề tài
                </a>
            </div>
        </div>
    </div>

    <div class="row g-4 justify-content-center">
        <div class="col-md-4">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body p-4 text-center">
                    <div class="bg-success-subtle text-success rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 70px; height: 70px;">
                        <i class="bi bi-file-earmark-medical fs-2"></i>
                    </div>
                    <h3 class="card-title fw-bold">Phân hệ Đề Tài</h3>
                    <p class="card-text text-muted my-3">
                        Khai báo thông tin tên đề tài, kinh phí phê duyệt chẵn triệu, lĩnh vực nghiên cứu và quản lý danh sách đề tài theo mô hình đa bảng.
                    </p>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/dang-ky" class="btn btn-outline-success btn-sm">Form Đăng Ký</a>
                        <a href="${pageContext.request.contextPath}/tra-cuu" class="btn btn-outline-dark btn-sm">Tra Cứu Đề Tài</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body p-4 text-center">
                    <div class="bg-primary-subtle text-primary rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 70px; height: 70px;">
                        <i class="bi bi-people-fill fs-2"></i>
                    </div>
                    <h3 class="card-title fw-bold">Giảng Viên</h3>
                    <p class="card-text text-muted my-3">
                        Quản lý đội ngũ cán bộ hướng dẫn khoa học, học vị (Thạc sĩ, Tiến sĩ, PGS, GS) kết nối đồng bộ trực thuộc đơn vị Khoa công tác.
                    </p>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/giang-vien/them" class="btn btn-outline-primary btn-sm">Thêm Giảng Viên</a>
                        <a href="${pageContext.request.contextPath}/giang-vien/tra-cuu" class="btn btn-outline-dark btn-sm">Tra Cứu Nhân Sự</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body p-4 text-center">
                    <div class="bg-info-subtle text-info-emphasis rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 70px; height: 70px;">
                        <i class="bi bi-building-fill fs-2"></i>
                    </div>
                    <h3 class="card-title fw-bold">Phân Hệ Khoa</h3>
                    <p class="card-text text-muted my-3">
                        Thiết lập các đơn vị quản lý chuyên môn trực thuộc nhà trường (CNTT, Kinh tế, Kế toán...), văn phòng làm việc và mã định danh.
                    </p>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/khoa/them" class="btn btn-outline-info btn-sm">Thêm Khoa Mới</a>
                        <a href="${pageContext.request.contextPath}/khoa/tra-cuu" class="btn btn-outline-dark btn-sm">Danh Sách Khoa</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>
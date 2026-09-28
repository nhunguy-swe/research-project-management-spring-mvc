<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Tra cứu Đề tài</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="header.jsp" />
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Hệ Thống Tra Cứu Đề Tài Khoa Học</h2>
        <a href="dang-ky" class="btn btn-primary">← Về trang Đăng Ký</a>
    </div>

    <div class="card mb-4 shadow-sm">
        <div class="card-body">
            <form action="tra-cuu" method="get" class="row g-3">
                <div class="col-md-9">
                    <input type="text" name="keyword" class="form-control" value="${keyword}"
                           placeholder="Nhập tên Khoa hoặc tên Giảng viên để tra cứu...">
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-dark w-100">Tìm kiếm</button>
                </div>
            </form>
        </div>
    </div>

    <div class="table-responsive bg-white rounded shadow-sm p-3">
        <table class="table table-hover table-striped align-middle">
            <thead class="table-dark">
            <tr>
                <th>Mã ĐT</th>
                <th>Tên Đề Tài</th>
                <th>Lĩnh Vực</th>
                <th>GV Hướng Dẫn</th>
                <th>Học Vị</th>
                <th>Khoa Quản Lý</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty listDeTai}">
                    <c:forEach items="${listDeTai}" var="dt">
                        <tr>
                            <td><strong>${dt.maDeTai}</strong></td>
                            <td>${dt.tenDeTai}</td>
                            <td><span class="badge bg-secondary">${dt.linhVuc}</span></td>
                            <td>${dt.giangVien.hoTen}</td>
                            <td>${dt.giangVien.hocVi}</td>
                            <td><span class="text-primary fw-semibold">${dt.giangVien.khoa.tenKhoa}</span></td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6" class="text-center text-muted py-4">Không tìm thấy đề tài nào phù hợp với từ khóa.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Đăng ký Đề tài</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="header.jsp" />
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Đăng Ký Đề Tài Nghiên Cứu Khoa Học</h2>
        <a href="tra-cuu" class="btn btn-outline-primary">Qua trang Tra Cứu →</a>
    </div>

    <div class="card shadow-sm">
        <div class="card-body p-4">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form action="dang-ky" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold">Tên đề tài</label>
                    <input type="text" name="tenDeTai" class="form-control" value="${param.tenDeTai}">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Lĩnh vực</label>
                    <input type="text" name="linhVuc" class="form-control" value="${param.linhVuc}">
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Kinh phí phê duyệt (VNĐ)</label>
                        <input type="number" name="kinhPhi" class="form-control" placeholder="Ví dụ: 15000000" value="${param.kinhPhi}">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Ngày đăng ký</label>
                        <input type="date" name="ngayDangKy" class="form-control" value="${param.ngayDangKy}">
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Giảng viên hướng dẫn chủ trì</label>
                    <select name="maGiangVien" class="form-select">
                        <c:forEach items="${giangViens}" var="gv">
                            <option value="${gv.maGiangVien}" ${param.maGiangVien == gv.maGiangVien ? 'selected' : ''}>
                                    ${gv.hoTen} (${gv.hocVi}) - Khoa: ${gv.khoa.tenKhoa}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <button type="submit" class="btn btn-success px-4 btn-lg">Gửi Đăng Ký</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
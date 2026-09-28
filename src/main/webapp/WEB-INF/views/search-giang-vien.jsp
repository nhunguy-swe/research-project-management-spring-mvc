<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container mt-4">
  <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
    <div>
      <h2 class="fw-bold text-dark mb-1"><i class="bi bi-search text-primary me-2"></i>Tra Cứu Giảng Viên</h2>
      <p class="text-muted mb-0">Tìm kiếm cán bộ giảng dạy dựa trên hệ thống cơ sở dữ liệu tích hợp.</p>
    </div>
    <div>
      <a href="${pageContext.request.contextPath}/giang-vien/them" class="btn btn-success fw-semibold">
        <i class="bi bi-plus-lg me-2"></i>Thêm Giảng Viên Mới
      </a>
    </div>
  </div>

  <div class="card mb-4 shadow-sm border-0">
    <div class="card-body p-3 bg-white rounded-3">
      <form action="${pageContext.request.contextPath}/giang-vien/tra-cuu" method="get" class="row g-2">
        <div class="col-md-10">
          <div class="input-group">
            <span class="input-group-text bg-light text-muted"><i class="bi bi-filter"></i></span>
            <input type="text" name="keyword" class="form-control form-control-lg" value="${keyword}"
                   placeholder="Nhập tên Giảng viên hoặc nhập tên Khoa công tác cần tìm...">
          </div>
        </div>
        <div class="col-md-2">
          <button type="submit" class="btn btn-primary btn-lg w-100 fw-semibold">Tìm kiếm</button>
        </div>
      </form>
    </div>
  </div>

  <div class="card shadow-sm border-0">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover table-striped align-middle mb-0">
          <thead class="table-dark text-uppercase fs-7">
          <tr>
            <th class="ps-4 py-3" style="width: 15%;">Mã Nhân Viên</th>
            <th style="width: 25%;">Họ và Tên Giảng Viên</th>
            <th style="width: 15%;">Học Vị</th>
            <th style="width: 20%;">Hộp Thư Email</th>
            <th class="pe-4" style="width: 25%;">Khoa Trực Thuộc</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${not empty listGiangVien}">
              <c:forEach items="${listGiangVien}" var="gv">
                <tr>
                  <td class="ps-4 text-muted">#${gv.maGiangVien}</td>
                  <td class="fw-bold text-dark">${gv.hoTen}</td>
                  <td><span class="badge bg-secondary-subtle text-secondary border border-secondary px-2.5 py-1.5">${gv.hocVi}</span></td>
                  <td class="text-muted">${gv.email}</td>
                  <td class="pe-4 fw-medium text-primary">${gv.khoa.tenKhoa}</td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="5" class="text-center text-muted py-5">
                  <i class="bi bi-folder-x d-block fs-1 mb-2 text-black-50"></i>
                  Không tìm thấy bất kỳ dữ liệu giảng viên nào khớp với từ khóa "<strong>${keyword}</strong>".
                </td>
              </tr>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>

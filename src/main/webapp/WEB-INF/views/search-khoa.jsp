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
      <h2 class="fw-bold text-dark mb-1"><i class="bi bi-search text-success me-2"></i>Danh Sách & Tra Cứu Khoa</h2>
      <p class="text-muted mb-0">Tìm kiếm các đơn vị đào tạo, khoa chuyên môn trong toàn trường.</p>
    </div>
    <div>
      <a href="${pageContext.request.contextPath}/khoa/them" class="btn btn-primary fw-semibold">
        <i class="bi bi-plus-lg me-2"></i>Thêm Khoa Mới
      </a>
    </div>
  </div>

  <div class="card mb-4 shadow-sm border-0">
    <div class="card-body p-3 bg-white rounded-3">
      <form action="${pageContext.request.contextPath}/khoa/tra-cuu" method="get" class="row g-2">
        <div class="col-md-10">
          <div class="input-group">
            <span class="input-group-text bg-light text-muted"><i class="bi bi-funnel-fill"></i></span>
            <input type="text" name="keyword" class="form-control form-control-lg" value="${keyword}"
                   placeholder="Nhập Mã khoa hoặc Tên khoa cần tìm kiếm...">
          </div>
        </div>
        <div class="col-md-2">
          <button type="submit" class="btn btn-success btn-lg w-100 fw-semibold">Tìm kiếm</button>
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
            <th class="ps-4 py-3" style="width: 20%;">Mã Khoa</th>
            <th style="width: 50%;">Tên Khoa Đào Tạo</th>
            <th class="pe-4" style="width: 30%;">Vị Trí Văn Phòng</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${not empty listKhoa}">
              <c:forEach items="${listKhoa}" var="k">
                <tr>
                  <td class="ps-4">
                    <span class="badge bg-dark px-3 py-2 fs-6">${k.maKhoa}</span>
                  </td>
                  <td class="fw-bold text-secondary fs-5">${k.tenKhoa}</td>
                  <td class="pe-4 text-muted">
                    <i class="bi bi-geo-alt-fill text-danger me-1"></i>${k.vanPhongKhoa}
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="3" class="text-center text-muted py-5">
                  <i class="bi bi-building-x d-block fs-1 mb-2 text-black-50"></i>
                  Không tìm thấy thông tin khoa nào ứng với từ khóa "<strong>${keyword}</strong>".
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

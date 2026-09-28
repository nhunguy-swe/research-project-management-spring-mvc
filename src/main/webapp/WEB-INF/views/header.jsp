<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        main {
            flex: 1;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">
            <i class="bi bi-mortarboard-fill me-2"></i>RESEARCH PORTAL
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/"><i class="bi bi-house-door-fill me-1"></i> Trang chủ</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dang-ky"><i class="bi bg-pencil-square me-1"></i> Đăng ký đề tài</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/tra-cuu"><i class="bi bi-search me-1"></i> Tra cứu đề tài</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/giang-vien/them"><i class="bi bi-person-plus-fill me-1"></i> Thêm giảng viên</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/giang-vien/tra-cuu"><i class="bi bi-people-fill me-1"></i> Tra cứu GV</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-info fw-semibold" href="${pageContext.request.contextPath}/khoa/them"><i class="bi bi-building-add me-1"></i> Thêm Khoa</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-info fw-semibold" href="${pageContext.request.contextPath}/khoa/tra-cuu"><i class="bi bi-building-fill me-1"></i> Tra cứu Khoa</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<main class="py-5 bg-light"/>
# HỆ THỐNG QUẢN LÝ ĐĂNG KÝ ĐỀ TÀI NGHIÊN CỨU (RESEARCH PROJECT MANAGEMENT)

## Mô tả bài toán

Trường đại học cần xây dựng một website quản lý việc đăng ký đề tài nghiên cứu khoa học của sinh viên dưới sự hướng dẫn của giảng viên.

### Quan hệ dữ liệu

* Một **Khoa** có nhiều **Giảng viên**.
* Một **Giảng viên** thuộc một **Khoa**.
* Một **Giảng viên** có thể hướng dẫn nhiều **Đề tài**.
* Một **Đề tài** chỉ có một **Giảng viên hướng dẫn**.

---

# Công nghệ sử dụng

* Java 17+
* Spring MVC (Không sử dụng Spring Boot)
* Hibernate ORM
* MySQL
* JSP/JSTL
* Apache Tomcat 10
* Maven
* Bootstrap 5
* Font Awesome

---

# Thiết kế cơ sở dữ liệu

## Bảng KHOA

| Tên cột      | Kiểu dữ liệu | Ràng buộc |
| ------------ | ------------ | --------- |
| maKhoa       | VARCHAR(20)  | PK        |
| tenKhoa      | VARCHAR(100) | NOT NULL  |
| vanPhongKhoa | VARCHAR(255) | NOT NULL  |

---

## Bảng GIANG_VIEN

| Tên cột     | Kiểu dữ liệu | Ràng buộc          |
| ----------- | ------------ | ------------------ |
| maGiangVien | INT          | PK, AUTO_INCREMENT |
| hoTen       | VARCHAR(100) | NOT NULL           |
| hocVi       | VARCHAR(50)  | NOT NULL           |
| email       | VARCHAR(100) | NOT NULL           |
| maKhoa      | VARCHAR(20)  | FK                 |

### Khóa ngoại

```sql
ALTER TABLE GIANG_VIEN
ADD CONSTRAINT FK_GIANGVIEN_KHOA
FOREIGN KEY(maKhoa)
REFERENCES KHOA(maKhoa);
```

---

## Bảng DE_TAI

| Tên cột         | Kiểu dữ liệu | Ràng buộc          |
| --------------- | ------------ | ------------------ |
| maDeTai         | INT          | PK, AUTO_INCREMENT |
| tenDeTai        | VARCHAR(255) | NOT NULL           |
| linhVuc         | VARCHAR(100) | NOT NULL           |
| kinhPhiPheDuyet | BIGINT       | NOT NULL           |
| ngayDangKy      | DATE         | NOT NULL           |
| maGiangVien     | INT          | FK                 |

### Khóa ngoại

```sql
ALTER TABLE DE_TAI
ADD CONSTRAINT FK_DETAI_GIANGVIEN
FOREIGN KEY(maGiangVien)
REFERENCES GIANG_VIEN(maGiangVien);
```

---

# Mapping Hibernate

## Khoa Entity

```java
@OneToMany(mappedBy = "khoa")
private List<GiangVien> giangVienList;
```

---

## GiangVien Entity

```java
@ManyToOne
@JoinColumn(name = "maKhoa")
private Khoa khoa;

@OneToMany(mappedBy = "giangVien")
private List<DeTai> deTaiList;
```

---

## DeTai Entity

```java
@ManyToOne
@JoinColumn(name = "maGiangVien")
private GiangVien giangVien;
```

---

# Chức năng 1: Đăng ký đề tài nghiên cứu

## Form nhập liệu

Thông tin cần nhập:

* Tên đề tài
* Lĩnh vực
* Kinh phí phê duyệt
* Ngày đăng ký
* Giảng viên hướng dẫn

---

## ComboBox Giảng viên

Dữ liệu được load từ bảng:

```text
GIANG_VIEN
```

Ví dụ:

```jsp
<form:select path="maGiangVien">
    <form:options
        items="${giangVienList}"
        itemValue="maGiangVien"
        itemLabel="hoTen"/>
</form:select>
```

---

# Validation

## Kiểm tra bắt buộc nhập

```java
@NotBlank
private String tenDeTai;

@NotBlank
private String linhVuc;

@NotNull
private Long kinhPhiPheDuyet;

@NotNull
private LocalDate ngayDangKy;
```

---

## Kiểm tra kinh phí

Điều kiện:

* Là số nguyên dương.
* Chia hết cho 1.000.000.

Ví dụ:

```java
kinhPhiPheDuyet > 0
&& kinhPhiPheDuyet % 1000000 == 0
```

### Hợp lệ

```text
1000000
5000000
10000000
15000000
20000000
```

### Không hợp lệ

```text
1500000
2500000
17500000
```

---

## Kiểm tra học vị giảng viên

Quy định:

* Tiến sĩ → Được hướng dẫn
* PGS → Được hướng dẫn
* Thạc sĩ → Không được hướng dẫn đề tài cấp trường

Ví dụ:

```java
if (giangVien.getHocVi().equals("Thạc sĩ")) {
    errors.rejectValue(
        "maGiangVien",
        "error.hocVi",
        "Giảng viên có học vị Thạc sĩ không đủ điều kiện hướng dẫn đề tài cấp trường"
    );
}
```

---

# Chức năng 2: Tra cứu đề tài

## Form tìm kiếm

Cho phép tìm theo:

* Tên khoa
* Tên giảng viên

Ví dụ:

```text
Công nghệ thông tin
```

hoặc

```text
Nguyễn Văn A
```

---

## Kết quả hiển thị

| Mã đề tài | Tên đề tài | Lĩnh vực | Giảng viên | Học vị | Khoa |
| --------- | ---------- | -------- | ---------- | ------ | ---- |

---

# Truy vấn JOIN 3 bảng

## SQL

```sql
SELECT dt.maDeTai,
       dt.tenDeTai,
       dt.linhVuc,
       gv.hoTen,
       gv.hocVi,
       k.tenKhoa
FROM DE_TAI dt
INNER JOIN GIANG_VIEN gv
    ON dt.maGiangVien = gv.maGiangVien
INNER JOIN KHOA k
    ON gv.maKhoa = k.maKhoa
WHERE k.tenKhoa LIKE '%?%'
   OR gv.hoTen LIKE '%?%';
```

---

## HQL

```java
SELECT dt
FROM DeTai dt
JOIN dt.giangVien gv
JOIN gv.khoa k
WHERE k.tenKhoa LIKE :keyword
   OR gv.hoTen LIKE :keyword
```

---

# Cấu trúc Project

```text
src/main/java
│
├── controller
│   ├── DeTaiController
│   └── SearchController
│
├── model
│   ├── Khoa.java
│   ├── GiangVien.java
│   └── DeTai.java
│
├── dao
│   ├── KhoaDAO.java
│   ├── GiangVienDAO.java
│   └── DeTaiDAO.java
│
├── service
│   └── DeTaiService.java
│
├── validator
│   └── DeTaiValidator.java
│
└── config
    ├── WebConfig.java
    ├── HibernateConfig.java
    └── AppInitializer.java
```

---

# Giao diện

## Dashboard

Hiển thị:

* Tổng số khoa
* Tổng số giảng viên
* Tổng số đề tài

## Quản lý đề tài

* Thêm mới đề tài
* Danh sách đề tài

## Tra cứu

* Theo khoa
* Theo giảng viên

Yêu cầu:

* Bootstrap 5
* Font Awesome
* Responsive Design

---

# Yêu cầu kỹ thuật

## Framework

* Spring MVC thuần

## ORM

* Hibernate Mapping

## Database

* MySQL

## Application Server

* Apache Tomcat 10

## Coding Convention

* Package:

    * controller
    * model
    * dao
    * service

* Class: PascalCase

* Variable: camelCase

* Mô hình:
  Controller → Service → DAO → Entity

---

# Kết luận

Hệ thống đáp ứng đầy đủ các yêu cầu:

* Quản lý Khoa
* Quản lý Giảng viên
* Quản lý Đề tài nghiên cứu
* ComboBox load dữ liệu từ CSDL
* Validation kinh phí phê duyệt
* Validation học vị giảng viên
* JOIN 3 bảng (DE_TAI → GIANG_VIEN → KHOA)
* Tìm kiếm theo Khoa hoặc Giảng viên
* Spring MVC thuần
* Hibernate ORM
* MySQL
* Apache Tomcat 10
* Bootstrap + Font Awesome
* Tuân thủ Java Coding Convention

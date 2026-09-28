# HỆ THỐNG QUẢN LÝ ĐĂNG KÝ ĐỀ TÀI NGHIÊN CỨU (Research Project Management)

<p>
  <img src="https://img.shields.io/badge/Java-17%2B-orange" alt="Java">
  <img src="https://img.shields.io/badge/Spring%20MVC-brightgreen" alt="Spring MVC">
  <img src="https://img.shields.io/badge/Hibernate-ORM-blue" alt="Hibernate">
  <img src="https://img.shields.io/badge/MySQL-Database-4479A1" alt="MySQL">
  <img src="https://img.shields.io/badge/Tomcat-10-yellow" alt="Tomcat 10">
</p>

## Mô tả bài toán

Trường đại học cần xây dựng một website quản lý việc đăng ký đề tài nghiên cứu khoa học của sinh viên dưới sự hướng dẫn của giảng viên.

### Quan hệ dữ liệu

- Một **Khoa** có nhiều **Giảng viên**.
- Một **Giảng viên** thuộc một **Khoa**.
- Một **Giảng viên** có thể hướng dẫn nhiều **Đề tài**.
- Một **Đề tài** chỉ có một **Giảng viên hướng dẫn**.

---

## Công nghệ sử dụng

- Java 17+
- Spring MVC (Không sử dụng Spring Boot)
- Hibernate ORM
- MySQL
- JSP/JSTL
- Apache Tomcat 10
- Maven
- Bootstrap 5
- Font Awesome

---

## Thiết kế cơ sở dữ liệu

### Bảng KHOA

| Tên cột      | Kiểu dữ liệu | Ràng buộc |
| ------------ | ------------ | --------- |
| maKhoa       | VARCHAR(20)  | PK        |
| tenKhoa      | VARCHAR(100) | NOT NULL  |
| vanPhongKhoa | VARCHAR(255) | NOT NULL  |

### Bảng GIANG_VIEN

| Tên cột     | Kiểu dữ liệu | Ràng buộc          |
| ----------- | ------------ | ------------------- |
| maGiangVien | INT          | PK, AUTO_INCREMENT  |
| hoTen       | VARCHAR(100) | NOT NULL             |
| hocVi       | VARCHAR(50)  | NOT NULL              |
| email       | VARCHAR(100) | NOT NULL               |
| maKhoa      | VARCHAR(20)  | FK                       |

```sql
ALTER TABLE GIANG_VIEN
ADD CONSTRAINT FK_GIANGVIEN_KHOA
FOREIGN KEY(maKhoa)
REFERENCES KHOA(maKhoa);
```

### Bảng DE_TAI

| Tên cột         | Kiểu dữ liệu | Ràng buộc          |
| --------------- | ------------ | ------------------- |
| maDeTai         | INT          | PK, AUTO_INCREMENT  |
| tenDeTai        | VARCHAR(255) | NOT NULL             |
| linhVuc         | VARCHAR(100) | NOT NULL              |
| kinhPhiPheDuyet | BIGINT       | NOT NULL               |
| ngayDangKy      | DATE         | NOT NULL                |
| maGiangVien     | INT          | FK                        |

```sql
ALTER TABLE DE_TAI
ADD CONSTRAINT FK_DETAI_GIANGVIEN
FOREIGN KEY(maGiangVien)
REFERENCES GIANG_VIEN(maGiangVien);
```

---

## Mapping Hibernate

**Khoa Entity**
```java
@OneToMany(mappedBy = "khoa")
private List<GiangVien> giangVienList;
```

**GiangVien Entity**
```java
@ManyToOne
@JoinColumn(name = "maKhoa")
private Khoa khoa;

@OneToMany(mappedBy = "giangVien")
private List<DeTai> deTaiList;
```

**DeTai Entity**
```java
@ManyToOne
@JoinColumn(name = "maGiangVien")
private GiangVien giangVien;
```

---

## Chức năng 1: Đăng ký đề tài nghiên cứu

**Form nhập liệu:** Tên đề tài, Lĩnh vực, Kinh phí phê duyệt, Ngày đăng ký, Giảng viên hướng dẫn.

**ComboBox Giảng viên** — dữ liệu load từ bảng `GIANG_VIEN`:

```jsp
<form:select path="maGiangVien">
    <form:options
        items="${giangVienList}"
        itemValue="maGiangVien"
        itemLabel="hoTen"/>
</form:select>
```

### Validation

**Bắt buộc nhập:**
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

**Kinh phí:** là số nguyên dương, chia hết cho 1.000.000.
```java
kinhPhiPheDuyet > 0
&& kinhPhiPheDuyet % 1000000 == 0
```
- Hợp lệ: `1000000`, `5000000`, `10000000`, `15000000`, `20000000`
- Không hợp lệ: `1500000`, `2500000`, `17500000`

**Học vị giảng viên:** Tiến sĩ/PGS → được hướng dẫn; Thạc sĩ → không được hướng dẫn đề tài cấp trường.
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

## Chức năng 2: Tra cứu đề tài

**Tìm theo:** Tên khoa, hoặc Tên giảng viên.

**Kết quả hiển thị:** Mã đề tài, Tên đề tài, Lĩnh vực, Giảng viên, Học vị, Khoa.

### Truy vấn JOIN 3 bảng

**SQL:**
```sql
SELECT dt.maDeTai, dt.tenDeTai, dt.linhVuc,
       gv.hoTen, gv.hocVi, k.tenKhoa
FROM DE_TAI dt
INNER JOIN GIANG_VIEN gv ON dt.maGiangVien = gv.maGiangVien
INNER JOIN KHOA k ON gv.maKhoa = k.maKhoa
WHERE k.tenKhoa LIKE '%?%'
   OR gv.hoTen LIKE '%?%';
```

**HQL:**
```
SELECT dt
FROM DeTai dt
JOIN dt.giangVien gv
JOIN gv.khoa k
WHERE k.tenKhoa LIKE :keyword
   OR gv.hoTen LIKE :keyword
```

---

## Cấu trúc Project

```
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

## Giao diện

**Dashboard:** Tổng số khoa, Tổng số giảng viên, Tổng số đề tài.

**Quản lý đề tài:** Thêm mới đề tài, Danh sách đề tài.

**Tra cứu:** Theo khoa, Theo giảng viên.

Yêu cầu: Bootstrap 5, Font Awesome, Responsive Design.

---

## Yêu cầu kỹ thuật

- **Framework:** Spring MVC thuần
- **ORM:** Hibernate Mapping
- **Database:** MySQL
- **Application Server:** Apache Tomcat 10
- **Coding Convention:** Package (`controller`, `model`, `dao`, `service`), Class PascalCase, Variable camelCase, mô hình `Controller → Service → DAO → Entity`

---

## Bắt đầu (Getting Started)

### Yêu cầu

- JDK 17+
- MySQL
- Apache Tomcat 10
- IDE: IntelliJ IDEA / Eclipse

### Cài đặt

```bash
git clone https://github.com/nhunguy-swe/research-project-management-spring-mvcgit
cd research-project-management-spring-mvc
```

### Cấu hình Database

1. Chạy script SQL trong thư mục `database/` để tạo các bảng `KHOA`, `GIANG_VIEN`, `DE_TAI` theo thiết kế ở trên.
2. Cập nhật thông tin kết nối trong `HibernateConfig.java` (hoặc file properties tương ứng).

> ⚠️ Không hard-code mật khẩu database trực tiếp trong code nếu push lên GitHub public — dùng biến môi trường hoặc file cấu hình đã thêm vào `.gitignore`.

### Chạy ứng dụng

1. Build project bằng Maven:
   ```bash
   mvn clean install
   ```
2. Deploy file `.war` lên **Apache Tomcat 10**.
3. Truy cập ứng dụng qua trình duyệt tại địa chỉ Tomcat cấu hình (ví dụ `http://localhost:8080/quan-ly-de-tai/`).

---

## Kết luận

Hệ thống đáp ứng đầy đủ các yêu cầu: Quản lý Khoa · Quản lý Giảng viên · Quản lý Đề tài nghiên cứu · ComboBox load dữ liệu từ CSDL · Validation kinh phí phê duyệt · Validation học vị giảng viên · JOIN 3 bảng (DE_TAI → GIANG_VIEN → KHOA) · Tìm kiếm theo Khoa hoặc Giảng viên · Spring MVC thuần · Hibernate ORM · MySQL · Apache Tomcat 10 · Bootstrap + Font Awesome · Tuân thủ Java Coding Convention

---

## Tác giả

- GitHub: [@nhunguy-swe](https://github.com/nhunguy-swe)

---

## Giấy phép

Dự án này được thực hiện cho mục đích học tập/đồ án cá nhân.

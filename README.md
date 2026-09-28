# RESEARCH PROJECT REGISTRATION MANAGEMENT SYSTEM

<p>
  <img src="https://img.shields.io/badge/Java-17%2B-orange" alt="Java">
  <img src="https://img.shields.io/badge/Spring%20MVC-brightgreen" alt="Spring MVC">
  <img src="https://img.shields.io/badge/Hibernate-ORM-blue" alt="Hibernate">
  <img src="https://img.shields.io/badge/MySQL-Database-4479A1" alt="MySQL">
  <img src="https://img.shields.io/badge/Tomcat-10-yellow" alt="Tomcat 10">
</p>

## Problem Statement

A university needs to build a website to manage students' scientific research project registrations under the supervision of lecturers.

### Data Relationships

- A **Faculty** has many **Lecturers**.
- A **Lecturer** belongs to one **Faculty**.
- A **Lecturer** can supervise many **Research Projects**.
- A **Research Project** has only one **Supervising Lecturer**.

---

## Tech Stack

- Java 17+
- Spring MVC (no Spring Boot)
- Hibernate ORM
- MySQL
- JSP/JSTL
- Apache Tomcat 10
- Maven
- Bootstrap 5
- Font Awesome

---

## Database Design

### FACULTY Table (KHOA)

| Column       | Data Type    | Constraint |
| ------------ | ------------ | ---------- |
| maKhoa       | VARCHAR(20)  | PK         |
| tenKhoa      | VARCHAR(100) | NOT NULL   |
| vanPhongKhoa | VARCHAR(255) | NOT NULL   |

### LECTURER Table (GIANG_VIEN)

| Column      | Data Type    | Constraint          |
| ----------- | ------------ | -------------------- |
| maGiangVien | INT          | PK, AUTO_INCREMENT   |
| hoTen       | VARCHAR(100) | NOT NULL              |
| hocVi       | VARCHAR(50)  | NOT NULL               |
| email       | VARCHAR(100) | NOT NULL                |
| maKhoa      | VARCHAR(20)  | FK                        |

```sql
ALTER TABLE GIANG_VIEN
ADD CONSTRAINT FK_GIANGVIEN_KHOA
FOREIGN KEY(maKhoa)
REFERENCES KHOA(maKhoa);
```

### RESEARCH PROJECT Table (DE_TAI)

| Column          | Data Type    | Constraint          |
| --------------- | ------------ | -------------------- |
| maDeTai         | INT          | PK, AUTO_INCREMENT   |
| tenDeTai        | VARCHAR(255) | NOT NULL              |
| linhVuc         | VARCHAR(100) | NOT NULL               |
| kinhPhiPheDuyet | BIGINT       | NOT NULL                |
| ngayDangKy      | DATE         | NOT NULL                 |
| maGiangVien     | INT          | FK                         |

```sql
ALTER TABLE DE_TAI
ADD CONSTRAINT FK_DETAI_GIANGVIEN
FOREIGN KEY(maGiangVien)
REFERENCES GIANG_VIEN(maGiangVien);
```

---

## Hibernate Mapping

**Khoa (Faculty) Entity**
```java
@OneToMany(mappedBy = "khoa")
private List<GiangVien> giangVienList;
```

**GiangVien (Lecturer) Entity**
```java
@ManyToOne
@JoinColumn(name = "maKhoa")
private Khoa khoa;

@OneToMany(mappedBy = "giangVien")
private List<DeTai> deTaiList;
```

**DeTai (Research Project) Entity**
```java
@ManyToOne
@JoinColumn(name = "maGiangVien")
private GiangVien giangVien;
```

---

## Feature 1: Register a Research Project

**Input form:** Project title, Field, Approved budget, Registration date, Supervising lecturer.

**Lecturer ComboBox** — data loaded from the `GIANG_VIEN` table:

```jsp
<form:select path="maGiangVien">
    <form:options
        items="${giangVienList}"
        itemValue="maGiangVien"
        itemLabel="hoTen"/>
</form:select>
```

### Validation

**Required fields:**
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

**Budget:** must be a positive integer, divisible by 1,000,000.
```java
kinhPhiPheDuyet > 0
&& kinhPhiPheDuyet % 1000000 == 0
```
- Valid: `1000000`, `5000000`, `10000000`, `15000000`, `20000000`
- Invalid: `1500000`, `2500000`, `17500000`

**Lecturer's degree:** PhD/Associate Professor → allowed to supervise; Master's degree → not allowed to supervise university-level projects.
```java
if (giangVien.getHocVi().equals("Thạc sĩ")) {
    errors.rejectValue(
        "maGiangVien",
        "error.hocVi",
        "A lecturer with a Master's degree is not qualified to supervise a university-level project"
    );
}
```

---

## Feature 2: Search Research Projects

**Search by:** Faculty name, or Lecturer name.

**Results displayed:** Project ID, Project title, Field, Lecturer, Degree, Faculty.

### 3-Table JOIN Query

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

## Project Structure

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

## UI

**Dashboard:** Total faculties, Total lecturers, Total research projects.

**Project Management:** Add a new project, list of projects.

**Search:** By faculty, by lecturer.

Requirements: Bootstrap 5, Font Awesome, Responsive Design.

---

## Technical Requirements

- **Framework:** Plain Spring MVC (no Spring Boot)
- **ORM:** Hibernate Mapping
- **Database:** MySQL
- **Application Server:** Apache Tomcat 10
- **Coding Convention:** Packages (`controller`, `model`, `dao`, `service`), Class in PascalCase, Variable in camelCase, following the pattern `Controller → Service → DAO → Entity`

---

## Getting Started

### Requirements

- JDK 17+
- MySQL
- Apache Tomcat 10
- IDE: IntelliJ IDEA / Eclipse

### Installation

```bash
git clone https://github.com/nhunguy-swe/research-project-management-spring-mvc.git
cd research-project-management-spring-mvc
```

### Database Setup

1. Run the SQL script in the `database/` folder to create the `KHOA`, `GIANG_VIEN`, and `DE_TAI` tables per the design above.
2. Update the connection info in `HibernateConfig.java` (or the corresponding properties file).

> ⚠️ Don't hard-code the database password directly in your code if pushing to a public GitHub repo — use environment variables or a config file added to `.gitignore` instead.

### Running the Application

1. Build the project with Maven:
   ```bash
   mvn clean install
   ```
2. Deploy the resulting `.war` file to **Apache Tomcat 10**.
3. Access the application in your browser at your Tomcat's configured address (e.g. `http://localhost:8080/quan-ly-de-tai/`).

---

## Conclusion

The system fully meets the requirements: Faculty management · Lecturer management · Research project management · ComboBox loaded from the database · Approved budget validation · Lecturer's degree validation · 3-table JOIN (DE_TAI → GIANG_VIEN → KHOA) · Search by Faculty or Lecturer · Plain Spring MVC · Hibernate ORM · MySQL · Apache Tomcat 10 · Bootstrap + Font Awesome · Follows Java coding convention

---

## Author

- GitHub: [@nhunguy-swe](https://github.com/nhunguy-swe)

---

## License

Created for learning/academic purposes.

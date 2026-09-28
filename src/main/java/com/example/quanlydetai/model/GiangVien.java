package com.example.quanlydetai.model;

import jakarta.persistence.*;

@Entity
@Table(name = "GIANG_VIEN")
public class GiangVien {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int maGiangVien;
    private String hoTen;
    private String hocVi;
    private String email;

    @ManyToOne
    @JoinColumn(name = "maKhoa")
    private Khoa khoa;

    // Getters, Setters
    public int getMaGiangVien() { return maGiangVien; }
    public void setMaGiangVien(int maGiangVien) { this.maGiangVien = maGiangVien; }
    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }
    public String getHocVi() { return hocVi; }
    public void setHocVi(String hocVi) { this.hocVi = hocVi; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public Khoa getKhoa() { return khoa; }
    public void setKhoa(Khoa khoa) { this.khoa = khoa; }
}

package com.example.quanlydetai.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "DE_TAI")
public class DeTai {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int maDeTai;
    private String tenDeTai;
    private String linhVuc;
    private long kinhPhiPheDuyet; // Dùng long để dễ kiểm tra số nguyên
    private LocalDate ngayDangKy;

    @ManyToOne
    @JoinColumn(name = "maGiangVien")
    private GiangVien giangVien;

    // Getters, Setters
    public int getMaDeTai() { return maDeTai; }
    public void setMaDeTai(int maDeTai) { this.maDeTai = maDeTai; }
    public String getTenDeTai() { return tenDeTai; }
    public void setTenDeTai(String tenDeTai) { this.tenDeTai = tenDeTai; }
    public String getLinhVuc() { return linhVuc; }
    public void setLinhVuc(String linhVuc) { this.linhVuc = linhVuc; }
    public long getKinhPhiPheDuyet() { return kinhPhiPheDuyet; }
    public void setKinhPhiPheDuyet(long kinhPhiPheDuyet) { this.kinhPhiPheDuyet = kinhPhiPheDuyet; }
    public LocalDate getNgayDangKy() { return ngayDangKy; }
    public void setNgayDangKy(LocalDate ngayDangKy) { this.ngayDangKy = ngayDangKy; }
    public GiangVien getGiangVien() { return giangVien; }
    public void setGiangVien(GiangVien giangVien) { this.giangVien = giangVien; }
}

package com.example.quanlydetai.model;

import jakarta.persistence.*;

@Entity
@Table(name = "KHOA")
public class Khoa {
    @Id
    @Column(name = "maKhoa")
    private String maKhoa;
    private String tenKhoa;
    private String vanPhongKhoa;

    // Getters, Setters, Constructors
    public String getMaKhoa() { return maKhoa; }
    public void setMaKhoa(String maKhoa) { this.maKhoa = maKhoa; }
    public String getTenKhoa() { return tenKhoa; }
    public void setTenKhoa(String tenKhoa) { this.tenKhoa = tenKhoa; }
    public String getVanPhongKhoa() { return vanPhongKhoa; }
    public void setVanPhongKhoa(String vanPhongKhoa) { this.vanPhongKhoa = vanPhongKhoa; }
}
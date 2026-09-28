package com.example.quanlydetai.dao;

import com.example.quanlydetai.model.GiangVien;
import com.example.quanlydetai.model.Khoa;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class GiangVienDAO {

    @Autowired
    private SessionFactory sessionFactory;

    // Lấy toàn bộ danh sách Khoa đổ vào ComboBox ở Form thêm mới
    public List<Khoa> getAllKhoa() {
        return sessionFactory.getCurrentSession().createQuery("from Khoa", Khoa.class).list();
    }

    // Tìm kiếm giảng viên JOIN sang bảng Khoa
    public List<GiangVien> searchGiangVien(String keyword) {
        String hql = "SELECT g FROM GiangVien g " +
                "JOIN FETCH g.khoa k " +
                "WHERE g.hoTen LIKE :kw OR k.tenKhoa LIKE :kw";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, GiangVien.class)
                .setParameter("kw", "%" + keyword + "%")
                .list();
    }

    // Lưu giảng viên mới
    public void saveGiangVien(GiangVien giangVien) {
        sessionFactory.getCurrentSession().persist(giangVien);
    }
}
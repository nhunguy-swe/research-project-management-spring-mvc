package com.example.quanlydetai.dao;

import com.example.quanlydetai.model.DeTai;
import com.example.quanlydetai.model.GiangVien;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class DeTaiDAO {
    @Autowired
    private SessionFactory sessionFactory;

    public List<GiangVien> getAllGiangVien() {
        return sessionFactory.getCurrentSession().createQuery("from GiangVien", GiangVien.class).list();
    }

    public GiangVien getGiangVienById(int id) {
        return sessionFactory.getCurrentSession().get(GiangVien.class, id);
    }

    public void saveDeTai(DeTai deTai) {
        sessionFactory.getCurrentSession().persist(deTai);
    }

    // Câu lệnh JOIN lấy toàn bộ thông tin đề tài, giảng viên, khoa theo tìm kiếm [Yêu cầu tra cứu]
    public List<DeTai> searchDeTai(String keyword) {
        String hql = "SELECT d FROM DeTai d " +
                "JOIN FETCH d.giangVien g " +
                "JOIN FETCH g.khoa k " +
                "WHERE g.hoTen LIKE :kw OR k.tenKhoa LIKE :kw";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, DeTai.class)
                .setParameter("kw", "%" + keyword + "%")
                .list();
    }
}
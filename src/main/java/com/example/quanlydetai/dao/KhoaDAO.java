package com.example.quanlydetai.dao;

import com.example.quanlydetai.model.Khoa;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class KhoaDAO {

    @Autowired
    private SessionFactory sessionFactory;

    // Kiểm tra trùng mã khoa trước khi lưu
    public Khoa getKhoaById(String maKhoa) {
        return sessionFactory.getCurrentSession().get(Khoa.class, maKhoa);
    }

    // Lưu thực thể khoa mới vào CSDL
    public void saveKhoa(Khoa khoa) {
        sessionFactory.getCurrentSession().persist(khoa);
    }

    // Tra cứu tìm kiếm Khoa
    public List<Khoa> searchKhoa(String keyword) {
        String hql = "FROM Khoa k WHERE k.maKhoa LIKE :kw OR k.tenKhoa LIKE :kw";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, Khoa.class)
                .setParameter("kw", "%" + keyword + "%")
                .list();
    }
}
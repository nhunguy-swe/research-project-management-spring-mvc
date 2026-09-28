package com.example.quanlydetai.service;

import com.example.quanlydetai.dao.DeTaiDAO;
import com.example.quanlydetai.model.DeTai;
import com.example.quanlydetai.model.GiangVien;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class DeTaiService {
    @Autowired
    private DeTaiDAO deTaiDAO;

    public List<GiangVien> getAllGiangVien() { return deTaiDAO.getAllGiangVien(); }
    public GiangVien getGiangVienById(int id) { return deTaiDAO.getGiangVienById(id); }
    public void saveDeTai(DeTai deTai) { deTaiDAO.saveDeTai(deTai); }
    public List<DeTai> searchDeTai(String keyword) { return deTaiDAO.searchDeTai(keyword); }
}
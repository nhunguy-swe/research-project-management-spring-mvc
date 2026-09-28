package com.example.quanlydetai.controller;

import com.example.quanlydetai.model.Khoa;
import com.example.quanlydetai.dao.KhoaDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/khoa")
@Transactional
public class KhoaController {

    @Autowired
    private KhoaDAO khoaDao;

    // --- DIỀU HƯỚNG GIAO DIỆN FORM NHẬP ---
    @GetMapping("/them")
    public String showForm() {
        return "form-khoa";
    }

    // Xử lý khi submit form thêm mới khoa
    @PostMapping("/them")
    public String executeThem(
            @RequestParam("maKhoa") String maKhoa,
            @RequestParam("tenKhoa") String tenKhoa,
            @RequestParam("vanPhongKhoa") String vanPhongKhoa,
            Model model) {

        // Validate dữ liệu trống
        if (maKhoa.isBlank() || tenKhoa.isBlank() || vanPhongKhoa.isBlank()) {
            model.addAttribute("error", "Vui lòng nhập đầy đủ toàn bộ thông tin của Khoa!");
            return "form-khoa";
        }

        // Đưa về chữ in hoa cho mã khoa
        String cleanMaKhoa = maKhoa.trim().toUpperCase();

        // Kiểm tra trùng khóa chính (maKhoa)
        if (khoaDao.getKhoaById(cleanMaKhoa) != null) {
            model.addAttribute("error", "Lỗi: Mã khoa '" + cleanMaKhoa + "' đã tồn tại trên hệ thống!");
            return "form-khoa";
        }

        try {
            Khoa k = new Khoa();
            k.setMaKhoa(cleanMaKhoa);
            k.setTenKhoa(tenKhoa.trim());
            k.setVanPhongKhoa(vanPhongKhoa.trim());

            khoaDao.saveKhoa(k);
            model.addAttribute("success", "Thêm đơn vị Khoa mới thành công!");
        } catch (Exception e) {
            model.addAttribute("error", "Không thể lưu dữ liệu: " + e.getMessage());
        }

        return "form-khoa";
    }

    // --- DIỀU HƯỚNG GIAO DIỆN TRA CỨU TÌM KIẾM ---
    @GetMapping("/tra-cuu")
    public String searchKhoa(
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
            Model model) {

        String cleanKeyword = keyword.trim();
        List<Khoa> result = khoaDao.searchKhoa(cleanKeyword);

        model.addAttribute("listKhoa", result);
        model.addAttribute("keyword", cleanKeyword);

        return "search-khoa";
    }
}
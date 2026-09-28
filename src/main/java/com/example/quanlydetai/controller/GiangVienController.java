package com.example.quanlydetai.controller;

import com.example.quanlydetai.model.GiangVien;
import com.example.quanlydetai.model.Khoa;
import com.example.quanlydetai.dao.GiangVienDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/giang-vien")
@Transactional
public class GiangVienController {

    @Autowired
    private GiangVienDAO giangVienDao;

    // --- CHỨC NĂNG 1: FORM NHẬP LIỆU GIẢNG VIÊN ---

    // Giao diện Form thêm mới giảng viên
    @GetMapping("/them")
    public String showFormThem(Model model) {
        List<Khoa> listKhoa = giangVienDao.getAllKhoa(); // Lấy danh sách khoa nạp vào ComboBox
        model.addAttribute("listKhoa", listKhoa);
        return "form-giang-vien"; // Trả về giang-vien-form.jsp
    }

    // Xử lý lưu thông tin dữ liệu từ Form gửi lên
    @PostMapping("/them")
    public String executeThem(
            @RequestParam("hoTen") String hoTen,
            @RequestParam("hocVi") String hocVi,
            @RequestParam("email") String email,
            @RequestParam("maKhoa") String maKhoa,
            Model model) {

        if (hoTen.isBlank() || email.isBlank() || maKhoa.isBlank()) {
            model.addAttribute("error", "Lỗi: Vui lòng không bỏ trống các trường thông tin cốt lõi!");
            model.addAttribute("listKhoa", giangVienDao.getAllKhoa());
            return "form-giang-vien";
        }

        try {
            GiangVien gv = new GiangVien();
            gv.setHoTen(hoTen.trim());
            gv.setHocVi(hocVi);
            gv.setEmail(email.trim());

            Khoa k = new Khoa();
            k.setMaKhoa(maKhoa);
            gv.setKhoa(k);

            giangVienDao.saveGiangVien(gv);
            model.addAttribute("success", "Thêm mới cán bộ giảng viên thành công!");
        } catch (Exception e) {
            model.addAttribute("error", "Không thể lưu dữ liệu: " + e.getMessage());
        }

        model.addAttribute("listKhoa", giangVienDao.getAllKhoa());
        return "form-giang-vien";
    }

    // --- CHỨC NĂNG 2: TRA CỨU TÌM KIẾM GIẢNG VIÊN + KHOA ---

    // Giao diện Tìm kiếm kết quả tích hợp đa bảng
    @GetMapping("/tra-cuu")
    public String showSearchPage(
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
            Model model) {

        String cleanKeyword = keyword.trim();
        List<GiangVien> listResult = giangVienDao.searchGiangVien(cleanKeyword);

        model.addAttribute("listGiangVien", listResult);
        model.addAttribute("keyword", cleanKeyword);

        return "search-giang-vien"; // Trả về giang-vien-search.jsp
    }
}
package com.example.quanlydetai.controller;

import com.example.quanlydetai.model.DeTai;
import com.example.quanlydetai.model.GiangVien;
import com.example.quanlydetai.service.DeTaiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/")
public class DeTaiController {

    @Autowired
    private DeTaiService deTaiService ;

    @GetMapping("/")
    public String index() {
        return "index";
    }

    // Hiển thị form đăng ký
    @GetMapping("/dang-ky")
    public String showForm(Model model) {
        model.addAttribute("giangViens", deTaiService.getAllGiangVien());
        return "form-dang-ky";
    }

    // Xử lý gửi Form & Nghiệm thu Validation
    @PostMapping("/dang-ky")
    public String handleRegistration(
            @RequestParam("tenDeTai") String tenDeTai,
            @RequestParam("linhVuc") String linhVuc,
            @RequestParam("kinhPhi") String kinhPhiStr,
            @RequestParam("ngayDangKy") String ngayDangKyStr,
            @RequestParam("maGiangVien") int maGiangVien,
            Model model) {

        List<GiangVien> giangViens = deTaiService.getAllGiangVien();
        model.addAttribute("giangViens", giangViens);

        // 1. Validation cơ bản: Không bỏ trống
        if (tenDeTai.isBlank() || linhVuc.isBlank() || kinhPhiStr.isBlank() || ngayDangKyStr.isBlank()) {
            model.addAttribute("error", "Vui lòng nhập đầy đủ tất cả các trường thông tin cốt lõi!");
            return "form-dang-ky";
        }

        long kinhPhi = Long.parseLong(kinhPhiStr);
        // 2. Validation: Kinh phí phải là số nguyên dương tròn triệu
        if (kinhPhi <= 0 || kinhPhi % 1000000 != 0) {
            model.addAttribute("error", "Kinh phí phê duyệt phải là số nguyên dương tròn triệu (Ví dụ: 15,000,000)!");
            return "form-dang-ky";
        }

        // 3. Validation học vị: Giảng viên cấp trường phải từ Tiến sĩ trở lên
        GiangVien gv = deTaiService.getGiangVienById(maGiangVien);
        if (gv != null && "Thạc sĩ".equals(gv.getHocVi())) {
            model.addAttribute("error", "Lỗi: Giảng viên có học vị Thạc sĩ không được phép chủ trì hướng dẫn đề tài cấp trường!");
            return "form-dang-ky";
        }

        // Nếu hợp lệ hết -> Lưu thông tin
        DeTai dt = new DeTai();
        dt.setTenDeTai(tenDeTai);
        dt.setLinhVuc(linhVuc);
        dt.setKinhPhiPheDuyet(kinhPhi);
        dt.setNgayDangKy(LocalDate.parse(ngayDangKyStr));
        dt.setGiangVien(gv);

        deTaiService.saveDeTai(dt);
        model.addAttribute("success", "Đăng ký đề tài khoa học thành công!");
        return "form-dang-ky";
    }

    // Tra cứu danh sách đề tài (Sử dụng JOIN)
    @GetMapping("/tra-cuu")
    public String search(@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword, Model model) {
        List<DeTai> list = deTaiService.searchDeTai(keyword);
        model.addAttribute("listDeTai", list);
        model.addAttribute("keyword", keyword);
        return "tra-cuu";
    }
}

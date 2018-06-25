using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TTCNWeb.Models;

namespace TTCNWeb.Controllers
{
    public class QuanLyKhachHangController : Controller
    {
        // GET: QuanLyKhachHang
        MyBookModel db = new MyBookModel();
        public ActionResult KhachHang(int? page1)
        {
            int pageNumber = (page1 ?? 1);
            int pageSize = 10;
            return View(db.KhachHangs.ToList().OrderBy(n => n.MaKH).ToPagedList(pageNumber, pageSize));
        }
        [HttpGet]
        public ActionResult ChinhSua(int MaKH)
        {
            //Lấy ra đối tượng theo mã 
            KhachHang KH = db.KhachHangs.SingleOrDefault(n => n.MaKH == MaKH);
            if (KH == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            //Đưa dữ liệu vào dropdownlist
            ViewBag.MaKH = new SelectList(db.KhachHangs.ToList().OrderBy(n => n.HoTen), "MaKH", "HoTen", KH.MaKH);
            return View(KH);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ChinhSua(Sach NXB, FormCollection f)
        {
            //Thêm vào cơ sở dữ liệu
            if (ModelState.IsValid)
            {
                //Thực hiện cập nhận trong model
                db.Entry(NXB).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
            }
            //Đưa dữ liệu vào dropdownlist
            ViewBag.MaNXB = new SelectList(db.NhaXuatBans.ToList().OrderBy(n => n.TenNXB), "MaNXB", "TenNXB", NXB.MaNXB);

            return RedirectToAction("NXB");

        }
        public ActionResult Xoa()
        {


            return View();
        }
        public ActionResult HienThi()
        {


            return View();
        }
        public ActionResult ThemMoi()
        {
            return View();
        }
    }
}
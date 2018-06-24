using BANSACHADMIN.Models.DATA;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList.Mvc;
using PagedList;
namespace BANSACHADMIN.Controllers
{
    public class QuanLyNXBController : Controller
    {
        // GET: QuanLyNXB
        SachOnline db = new SachOnline();
        public ActionResult NXB(int? page2)
        {
            int pageNumber = (page2 ?? 1);
            int pageSize = 10;
            return View(db.NhaXuatBans.ToList().OrderBy(n => n.MaNXB).ToPagedList(pageNumber, pageSize));
        }
        [HttpGet]
        public ActionResult ChinhSua(string MaNXB)
        {
            //Lấy ra đối tượng theo mã 
            NhaXuatBan NXB = db.NhaXuatBans.SingleOrDefault(n => n. MaNXB == MaNXB);
            if (NXB == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            //Đưa dữ liệu vào dropdownlist
            ViewBag.MaNXB = new SelectList(db.NhaXuatBans.ToList().OrderBy(n => n.TenNXB), "MaNXB", "TenNXB", NXB.MaNXB);
            return View(NXB);
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
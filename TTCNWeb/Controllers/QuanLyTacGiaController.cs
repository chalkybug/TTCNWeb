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
    public class QuanLyTacGiaController : Controller
    {
        // GET: QuanLyTacGia
        SachOnline db = new SachOnline();
        public ActionResult TacGia(int ? page5)
        {
            int pageNumber = (page5 ?? 1);
            int pageSize = 10;
            return View(db.TacGias.ToList().OrderBy(n => n.MaTacGia).ToPagedList(pageNumber, pageSize));
        }
        [HttpGet]
        public ActionResult ChinhSua(int MaTacGia)
        {
            //Lấy ra đối tượng theo mã 
           TacGia TG = db.TacGias.SingleOrDefault(n => n.MaTacGia == MaTacGia);
            if (TG == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            //Đưa dữ liệu vào dropdownlist
            ViewBag.MaTacGia = new SelectList(db.TacGias.ToList().OrderBy(n => n.TenTacGia), "MaTacGia", "TenTacGia", TG.MaTacGia);
            return View(TG);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ChinhSua(TacGia TG, FormCollection f)
        {
            //Thêm vào cơ sở dữ liệu
            if (ModelState.IsValid)
            {
                //Thực hiện cập nhận trong model
                db.Entry(TG).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
            }
            //Đưa dữ liệu vào dropdownlist
            ViewBag.MaTacGia = new SelectList(db.TacGias.ToList().OrderBy(n => n.TenTacGia), "MaTacGia", "TenNXB", TG.MaTacGia);

            return RedirectToAction("TG");

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
   
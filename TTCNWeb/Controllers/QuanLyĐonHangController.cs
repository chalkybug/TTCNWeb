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
    public class QuanLyĐonHangController : Controller
    {
        // GET: QuanLyĐonHang
        SachOnline db = new SachOnline();
        public ActionResult DonHang(int? page3)
        {
            int pageNumber = (page3 ?? 1);
            int pageSize = 10;
            return View(db.DonHangs.ToList().OrderBy(n => n.MaDonHang).ToPagedList(pageNumber, pageSize));
        }
        public ActionResult ChinhSua()
        {


            return View();

        }
        public ActionResult Xoa()
        {


            return View();
        }
        public ActionResult HienThi()
        {


            return View();
        }
    }
}
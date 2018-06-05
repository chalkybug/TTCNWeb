using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TTCNWeb.Models;

namespace TTCNWeb.Controllers
{
    public class ChiTietDonHangController : Controller
    {
        // GET: ChiTietDonHang
        MyBookModel db = new MyBookModel();
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(ChiTietDonHang chitietdonhang)
        {
            db.ChiTietDonHangs.Add(chitietdonhang);
            db.SaveChanges();

            return View();
        }
    }
}
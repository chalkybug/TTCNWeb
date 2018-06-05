using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TTCNWeb.Models;

namespace TTCNWeb.Controllers
{
    public class DonHangController : Controller
    {
        MyBookModel db = new MyBookModel();
        // GET: DonHang
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(DonHang donhang, string returnURL)
        {
            db.DonHangs.Add(donhang);
            db.SaveChanges();
            return Redirect(returnURL);
        }

    }
}
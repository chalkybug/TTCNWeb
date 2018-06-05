using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TTCNWeb.Models;

namespace TTCNWeb.Controllers
{
    public class KhachHangController : Controller
    {
        // GET: KhachHang
        MyBookModel db = new MyBookModel();
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(FormCollection form)
        {
            var listCustomer = db.KhachHangs.ToList();

            string username = form["username"].ToString();
            string pass = form["password"].ToString();

            foreach (var item in listCustomer)
            {
                if (item.TaiKhoan.Equals(username) && item.MatKhau.Equals(pass))
                {
                    Session["Customer"] = item;
                    ViewBag.Customer = item;
                    return RedirectToAction("Show", "Sach");

                }
            }
            return View("Index");

        }


        [HttpPost]
        public ActionResult Create(FormCollection form)
        {
            KhachHang khach = new KhachHang();
            TryUpdateModel(khach, form);
            ViewBag.msg = "Tao tai khoan thanh cong. Hay dang nhap !!";
            return View("Index");

        }



        }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TTCNWeb.Models;

namespace TTCNWeb.Controllers
{
    public class SachController : Controller
    {
        // GET: Product
        MyBookModel db = new MyBookModel();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Show()
        {

            List<Sach> list = db.Saches.ToList();
            return View(list);
        }


        public ActionResult Detail(int id)
        {

            Sach sach = db.Saches.Where(x => x.MaSach == id).FirstOrDefault();


            return View(sach);
        }

        public ActionResult test()
        {
           
            return View();
        }


    }
}
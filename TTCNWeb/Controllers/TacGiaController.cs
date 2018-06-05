using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TTCNWeb.Models;

namespace TTCNWeb.Controllers
{
    public class TacGiaController : Controller
    {
        // GET: TacGia
        MyBookModel db = new MyBookModel();
        public ActionResult Index()
        {
            return View();
        }



    }
}
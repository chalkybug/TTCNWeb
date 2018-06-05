using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TTCNWeb.Models;
using TTCNWeb.Models.Security;

namespace TTCNWeb.Controllers
{
    [CustomAuthentication(Roles = "EDIT")]
    public class PermissionController : Controller
    {
        // GET: Permission
        MyBookModel db = new MyBookModel();


        public ActionResult Index()
        {
            var list = db.Permissions.ToList();
            return View(list);
        }

    
        public ActionResult Edit(int id)
        {
            var item = db.Permissions.Where(x => x.id == id).FirstOrDefault();
            return View(item);
        }



    }
}
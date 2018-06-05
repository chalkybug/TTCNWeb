using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TTCNWeb.Models;
using TTCNWeb.Models.Constant;
using TTCNWeb.Models.Security;

namespace TTCNWeb.Controllers
{
    
    public class AdminController : Controller
    {
        // GET: Admin
        
        MyBookModel db = new MyBookModel();

        [CustomAuthentication(Roles = "VIEW")]
        public ActionResult Index()
        {
            return View();
        }

        [AllowAnonymous]
        public ActionResult Login()
        {
            if (MySession.isLogin(GroupName.ADMIN_GROUP))
            {
                return RedirectToAction("Notification");
            }
            return View();
        }



        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(FormCollection form)
        {

            if (ModelState.IsValid)
            {
                var listCustomer = db.KhachHangs.ToList();

                string username = form["username"].ToString();
                string pass = form["password"].ToString();

                foreach (var item in listCustomer)
                {
                    if (item.TaiKhoan.Equals(username)
                        && item.MatKhau.Equals(pass)
                        && (item.idUserGroup.Equals(GroupName.ADMIN_GROUP)
                        || item.idUserGroup.Equals(GroupName.MANAGER_GROUP)
                        || item.idUserGroup.Equals(GroupName.MEMBER_GROUP)))
                    {

                        MySession.setCustomer(item, GroupName.ADMIN_GROUP);
                        ViewBag.nameCustomer = item.HoTen;
                        return View("Index");

                    }
                }
                ModelState.AddModelError("Lỗi đăng nhập", "Bạn không có quyền truy cập");


            }
            return View("Login");

        }

        [AllowAnonymous]
        public ActionResult Notification()
        {
            return View();
        }


        public ActionResult Logout()
        {
            MySession.logout(GroupName.ADMIN_GROUP);
            return View("Login");
        }

        

    }
}
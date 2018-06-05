using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TTCNWeb.Models;

namespace TTCNWeb.Controllers
{
    public class CartController : Controller
    {
        // GET: Cart
        MyBookModel db = new MyBookModel();
        public ActionResult Index()
        {
            var cart = Session["CartSession"] as Cart;

            List<CartItem> list = new List<CartItem>();
            if (cart != null)
            {
                list = cart.listCartItem.ToList();
                ViewBag.TongTien = cart.ComputeTotalValue();
            }

            return View(list);
        }

        public ActionResult AddItem(int id, string returnURL)
        {

            var sach = db.Saches.Find(id);

            var cart = Session["CartSession"] as Cart;

            if (cart != null)
            {
                cart.AddItem(sach, 1);
                //Gán vào session
                Session["CartSession"] = cart;
            }
            else
            {
                //tạo mới đối tượng cart item
                cart = new Cart();
                cart.AddItem(sach, 1);
                //Gán vào session
                Session["CartSession"] = cart;
            }

            if (string.IsNullOrEmpty(returnURL))
            {
                return RedirectToAction("Index");
            }

            return Redirect(returnURL);

        }


        public ActionResult UpdateCart(int id, int value)
        {

            var sach = db.Saches.Find(id);

            var cart = (Cart)Session["CartSession"];

            if (cart != null)
            {
                int NewQuantity = cart.getQuantity(sach) + value;
                cart.UpdateItem(sach, NewQuantity);
                //Gán vào session
                Session["CartSession"] = cart;
            }
            else
            {
                //tạo mới đối tượng cart item
                cart = new Cart();
                cart.AddItem(sach, 1);
                //Gán vào session
                Session["CartSession"] = cart;
            }
            return RedirectToAction("Index");

        }


        public ActionResult RemoveLine(int id)
        {

            var sach = db.Saches.Find(id);

            var cart = (Cart)Session["CartSession"];

            if (cart != null)
            {
                cart.RemoveLine(sach);
                //Gán vào session
                Session["CartSession"] = cart;
            }
            return RedirectToAction("Index");
        }

        public ActionResult CheckOut()
        {
            var cart = Session["CartSession"] as Cart;
            ViewBag.Cart = cart;
            List<CartItem> list = new List<CartItem>();
            if (cart != null)
            {
                list = cart.listCartItem.ToList();
                ViewBag.TongTien = cart.ComputeTotalValue();
            }

            if (Session["Customer"] != null)
            {
                var Customer = Session["Customer"] as KhachHang;
                ViewBag.Customer = Customer;
            }
            else
            {
                // đăng ký mới
            }
            return View(list);
        }

    
        public ActionResult Order()
        {
            var Customer = Session["Customer"] as KhachHang;
            if (Customer!=null)
            {
                DonHang donhang = new DonHang();

                donhang.NgayDat = DateTime.Now;
                donhang.NgayGiao = DateTime.Now.AddDays(7);
                donhang.DaThanhToan = 0;
                donhang.TinhTrangGiaoHang = 0;
                donhang.MaKH = Customer.MaKH;

                db.DonHangs.Add(donhang);
                
                db.SaveChanges();

                // get donhang max
                int maDonHang = db.DonHangs.Max(x => x.MaDonHang);

                var cart = (Cart)Session["CartSession"];

                foreach (var item in cart.listCartItem)
                {
                    // add chi tiết hóa đơn
                    ChiTietDonHang chitiet = new ChiTietDonHang();

                    chitiet.MaDonHang = maDonHang;
                    chitiet.MaSach = item.Sach.MaSach;
                    chitiet.SoLuong = item.SoLuong;
                    chitiet.DonGia = item.Sach.GiaBan;
                   
                    db.ChiTietDonHangs.Add(chitiet);
                    db.SaveChanges();
                }
                // clear
                Session["CartSession"] = null;

            }


            return RedirectToAction("Show", "Sach");
        }



    }
}
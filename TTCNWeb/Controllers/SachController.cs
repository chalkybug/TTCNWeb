using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TTCNWeb.Models;
using PagedList;
using PagedList.Mvc;

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
        int pageSize = 12;
        public ActionResult Show(int? pageTemp)
        {

            int pageNumber = pageTemp ?? 1;

            var list = db.Saches.ToList().OrderBy(a => a.TenSach).ToPagedList(pageNumber, pageSize);
            return View(list);
        }


        public ActionResult Detail(int id)
        {

            Sach sach = db.Saches.Where(x => x.MaSach == id).FirstOrDefault();
            //var matacgia = db.ThamGias.
            //    Where(x => x.MaSach == sach.MaSach).
            //     Where(x => x.ViTri == "1").
            //    Select(x => x.MaTacGia).FirstOrDefault();

            //var tentacgia = db.TacGias.Where(x => x.MaTacGia == matacgia).FirstOrDefault();

            //ViewBag.tentacgia = tentacgia.TenTacGia;

            return View(sach);
        }

        public ActionResult Search(string author, string category, int? maxPrice, int? minPrice)
        {
            List<Sach> books = new List<Sach>();
            var listBooks = books.ToPagedList(1, 50);
            if (author == "")
            {
                try
                {

                    var machude = db.ChuDes.Where(x => x.TenChuDe.Contains(category)).Select(x => x.MaChuDe).FirstOrDefault();


                    var dsBook = db.Saches.Where(x => x.MaChuDe == machude).
                        Where(a => a.GiaBan <= maxPrice).
                         Where(a => a.GiaBan >= minPrice).
                         ToList();


                    foreach (var item in dsBook)
                    {
                        books.Add(item);
                    }
                }
                catch
                {


                }
                listBooks = books.ToPagedList(1, 50);
                return View("Show", listBooks);

            }/// end if

            if (category == "")
            {
                try
                {

                    var matacgia = db.TacGias.Where(x => x.TenTacGia.Contains(author)).Select(x => x.MaTacGia).FirstOrDefault();

                    var thamgia = db.ThamGias.Where(x => x.MaTacGia == matacgia).ToList();


                    foreach (var item in thamgia)
                    {

                        var book = db.Saches.Where(x => x.MaSach == item.MaSach).
                           Where(a => a.GiaBan <= maxPrice).
                        Where(a => a.GiaBan >= minPrice).
                        FirstOrDefault();

                        books.Add(book);

                    }

                }
                catch
                {

                }

                listBooks = books.ToPagedList(1, 50);
                return View("Show", listBooks);

            }// end if
            try
            {

                var machude = db.ChuDes.Where(x => x.TenChuDe.Contains(category)).Select(x => x.MaChuDe).FirstOrDefault();


                var matacgia = db.TacGias.Where(x => x.TenTacGia.Contains(author)).Select(x => x.MaTacGia).FirstOrDefault();


                var thamgia = db.ThamGias.Where(x => x.MaTacGia == matacgia).ToList();



                foreach (var item in thamgia)
                {
                    var book = db.Saches.Where(x => x.MaSach == item.MaSach).
                           Where(a => a.GiaBan <= maxPrice).
                        Where(a => a.GiaBan >= minPrice).
                        FirstOrDefault();

                    books.Add(book);

                }

            }
            catch
            {


            }
            listBooks = books.ToPagedList(1, 50);
            return View("Show", listBooks);

        }

        public ActionResult SearchQuery(string author, string category, int? maxPrice, int? minPrice)
        {
            List<Sach> books = new List<Sach>();
            var listBooks = books.ToPagedList(1, 50);

            if (author == "")
            {
                try
                {
                    var machude = (from x in db.ChuDes
                                   where x.TenChuDe.Contains(category)

                                   select x.MaChuDe).FirstOrDefault();

                    var dsBook = (from x in db.Saches

                                  where machude == x.MaChuDe.Value
                                  where x.GiaBan <= maxPrice
                                  where x.GiaBan >= minPrice
                                  select x).ToList();

                    foreach (var item in dsBook)
                    {
                        books.Add(item);
                    }
                }
                catch
                {


                }
                listBooks = books.ToPagedList(1, 50);
                return View("Show", listBooks);

            }
            if (category == "")
            {
                try
                {
                    var matacgia = (from x in db.TacGias
                                    where x.TenTacGia.Contains(author)
                                    select x).First<TacGia>().MaTacGia;

                    var thamgia = (from x in db.ThamGias
                                   where x.MaTacGia == matacgia
                                   select x).ToList();



                    foreach (var item in thamgia)
                    {
                        var book = (from x in db.Saches
                                    where x.GiaBan <= maxPrice
                                    where x.GiaBan >= minPrice
                                    where x.MaSach == item.MaSach
                                    select x).First<Sach>();

                        books.Add(book);

                    }

                }
                catch
                {

                }

                listBooks = books.ToPagedList(1, 50);
                return View("Show", listBooks);

            }

            try
            {
                var machude = (from x in db.ChuDes
                               where x.TenChuDe.Contains(category)
                               select x.MaChuDe).FirstOrDefault();

                var matacgia = (from x in db.TacGias
                                where x.TenTacGia.Contains(author)
                                select x).First<TacGia>().MaTacGia;

                var thamgia = (from x in db.ThamGias
                               where x.MaTacGia == matacgia
                               select x).ToList();



                foreach (var item in thamgia)
                {
                    var book = (from x in db.Saches
                                where x.GiaBan <= maxPrice
                                where x.GiaBan >= minPrice
                                where machude == x.MaChuDe.Value
                                where x.MaSach == item.MaSach
                                select x).First<Sach>();

                    books.Add(book);

                }

            }
            catch
            {


            }
            listBooks = books.ToPagedList(1, 50);
            return View("Show", listBooks);
        }

        [HttpPost]
        public ActionResult TimKiem(FormCollection f)
        {
            string tensach = f["tensach"].ToString();
            if (tensach!=null)
            {
                var books = db.Saches.Where(x => x.TenSach.Contains(tensach));

                var listBooks = books.OrderBy(x => x.TenSach).ToPagedList(1, 50);
                return View("Show", listBooks);
            }
            return View("Show");

        }

    }
}
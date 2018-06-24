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


            return View(sach);
        }

        public ActionResult Search(string author)
        {
            var _author = db.TacGias.Where(x => x.TenTacGia.Contains(author)).FirstOrDefault();

            var listThamgia = db.ThamGias.Where(x => x.MaTacGia == _author.MaTacGia).ToList();

            var books = new List<Sach>();
            foreach (var item in listThamgia)
            {
                Sach sach = db.Saches.Where(x => x.MaSach == item.MaSach).FirstOrDefault();
                books.Add(sach);
            }

            return View("Show", books);
        }

        public ActionResult SearchQuery(string author, string category, int? maxPrice, int? minPrice)
        {
            List<Sach> books = new List<Sach>();
            var listBooks = books.ToPagedList(1, 50);

            //if (!maxPrice.HasValue)
            //{
            //    maxPrice = 9999999;
            //}
            //if (!minPrice.HasValue)
            //{
            //    minPrice = 0;
            //}
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



    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TTCNWeb.Models
{
    public class CartItem
    {
        public Sach Sach { get; set; }
        public int SoLuong { set; get; }
    }
    public class Cart
    {
        private List<CartItem> lineCollection = new List<CartItem>();

        public void AddItem(Sach sp, int quantity)
        {
            CartItem line = lineCollection
                .Where(p => p.Sach.MaSach == sp.MaSach)
                .FirstOrDefault();

            if (line == null)
            {
                lineCollection.Add(new CartItem
                {
                    Sach = sp,
                    SoLuong = quantity
                });
            }
            else
            {
                line.SoLuong += quantity;
                if (line.SoLuong <= 0)
                {
                    lineCollection.RemoveAll(l => l.Sach.MaSach == sp.MaSach);
                }
            }
        }
        public void UpdateItem(Sach sp, int quantity)
        {
            CartItem line = lineCollection
                .Where(p => p.Sach.MaSach == sp.MaSach)
                .FirstOrDefault();

            if (line != null)
            {
                if (quantity > 0)
                {
                    line.SoLuong = quantity;
                }
                else
                {
                    lineCollection.RemoveAll(l => l.Sach.MaSach == sp.MaSach);
                }
            }
        }
        public void RemoveLine(Sach sp)
        {
            lineCollection.RemoveAll(l => l.Sach.MaSach == sp.MaSach);
        }

        public decimal? ComputeTotalValue()
        {
            return lineCollection.Sum(e => e.Sach.GiaBan * e.SoLuong);

        }
        public int? ComputeTotalProduct()
        {
            return lineCollection.Sum(e => e.SoLuong);

        }
        public void Clear()
        {
            lineCollection.Clear();
        }

        public int getQuantity(Sach sach)
        {
            var item = lineCollection.Find(x=>x.Sach.MaSach==sach.MaSach);
            
            return item.SoLuong;
        }

        public IEnumerable<CartItem> listCartItem
        {
            get { return lineCollection; }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TTCNWeb.Models;

namespace TTCNWeb
{
    public class MySession : System.Web.UI.Page
    {
       
        static public void setKey(string key, string value)
        {
            System.Web.HttpContext.Current.Session[key] = value;
        }

        static public object getKey(string key, object defaultValue=null)
        {
            if (System.Web.HttpContext.Current.Session[key] == null)
            {
                return defaultValue;
            }
            return System.Web.HttpContext.Current.Session[key];

        }


        static public int setCustomer(KhachHang customer,string Key)
        {
            System.Web.HttpContext.Current.Session[Key] = customer;
            //assign for later
            return 0;
        }


        static public int setCart(Cart cart, string Key)
        {
            System.Web.HttpContext.Current.Session[Key] = cart;
            //assign for later
            return 0;
        }


        static public int logout(string Key)
        {
            System.Web.HttpContext.Current.Session[Key] = null;
            return 0;
        }

        // check the login status
        static public bool isLogin(string Key)
        {
            if (System.Web.HttpContext.Current.Session[Key] == null)
            {
                return false;
            }
          
            return true;
        }

        // get Name
        static public string getNameCustomner(string Key)
        {
            if (System.Web.HttpContext.Current.Session[Key] == null)
                return "";
            KhachHang customer = (KhachHang)System.Web.HttpContext.Current.Session[Key];
            return customer.HoTen;
        }


    }
}
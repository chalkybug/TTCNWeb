using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TTCNWeb;
using TTCNWeb.Models.Constant;

namespace TTCNWeb.Models.Security
{
    public class CustomAuthenticationAttribute : FilterAttribute, IAuthorizationFilter
    {


        public string Roles { get; set; }

        public void OnAuthorization(AuthorizationContext filterContext)
        {

            //Kiểm tra session

            if (!MySession.isLogin(GroupName.ADMIN_GROUP))
            {
                //Chuyển sang form đăng nhập
                filterContext.Result = new RedirectResult("/Admin/Login");
                return;
            }
           
            // get permission user
            PermissionUser per = new PermissionUser();
            KhachHang admin = MySession.getKey(GroupName.ADMIN_GROUP) as KhachHang;
            
            List<string> listRoles = per.getPermission(admin.idUserGroup);

            if (!listRoles.Contains(Roles))
            {
                filterContext.Result = new RedirectResult("/Admin/Notification");
            }


        }
    }


}
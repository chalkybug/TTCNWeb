using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TTCNWeb.Models.Security
{
    public class PermissionUser
    {
        MyBookModel db = new MyBookModel();
        public List<string> getPermission(string idUserGroup)
        {
            var user = db.UserGroups.Where(x => x.id == idUserGroup).FirstOrDefault();
            var result = from s in db.Permissions
                         join x in db.Roles on s.idRole equals x.id
                         join y in db.UserGroups on s.idUser equals y.id
                         where y.id == user.id
                         select x.id;

            return result.ToList();
        }
    }
}
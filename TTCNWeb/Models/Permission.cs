namespace TTCNWeb.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Permission")]
    public partial class Permission
    {
        [Key]
        [Column(Order = 0)]
        public int id { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string idRole { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string idUser { get; set; }

        public virtual Role Role { get; set; }

        public virtual UserGroup UserGroup { get; set; }
    }
}

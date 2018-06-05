namespace TTCNWeb.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("KhachHang")]
    public partial class KhachHang
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public KhachHang()
        {
            DonHangs = new HashSet<DonHang>();
        }

        [Key]
        public int MaKH { get; set; }

        [Required(ErrorMessage ="Bạn phải điền tên")]
        [StringLength(100)]
        public string HoTen { get; set; }

        [Column(TypeName = "date")]
        public DateTime NgaySinh { get; set; }

        [Required]
        [StringLength(3)]
        public string GioiTinh { get; set; }

        [Required]
        [StringLength(50)]
        public string DienThoai { get; set; }

        [Required(ErrorMessage = "Bạn phải điền tài khoản")]
        [StringLength(50)]
        public string TaiKhoan { get; set; }

        [Required(ErrorMessage = "Bạn phải điền mật khẩu")]
        [StringLength(50)]
        public string MatKhau { get; set; }

        [Required]
        [StringLength(50)]
        public string Email { get; set; }

        [Required]
        public string DiaChi { get; set; }

        [StringLength(50)]
        public string idUserGroup { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DonHang> DonHangs { get; set; }

        public virtual UserGroup UserGroup { get; set; }
    }
}

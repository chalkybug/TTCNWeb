namespace TTCNWeb.Models
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class MyBookModel : DbContext
    {
        public MyBookModel()
            : base("name=MyBookModel")
        {
        }

        public virtual DbSet<ChiTietDonHang> ChiTietDonHangs { get; set; }
        public virtual DbSet<ChuDe> ChuDes { get; set; }
        public virtual DbSet<DonHang> DonHangs { get; set; }
        public virtual DbSet<KhachHang> KhachHangs { get; set; }
        public virtual DbSet<NhaXuatBan> NhaXuatBans { get; set; }
        public virtual DbSet<Permission> Permissions { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<Sach> Saches { get; set; }
        public virtual DbSet<TacGia> TacGias { get; set; }
        public virtual DbSet<ThamGia> ThamGias { get; set; }
        public virtual DbSet<UserGroup> UserGroups { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DonHang>()
                .HasMany(e => e.ChiTietDonHangs)
                .WithRequired(e => e.DonHang)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<KhachHang>()
                .Property(e => e.DienThoai)
                .IsUnicode(false);

            modelBuilder.Entity<KhachHang>()
                .Property(e => e.TaiKhoan)
                .IsUnicode(false);

            modelBuilder.Entity<KhachHang>()
                .Property(e => e.MatKhau)
                .IsUnicode(false);

            modelBuilder.Entity<KhachHang>()
                .Property(e => e.Email)
                .IsUnicode(false);

            modelBuilder.Entity<KhachHang>()
                .Property(e => e.idUserGroup)
                .IsUnicode(false);

            modelBuilder.Entity<NhaXuatBan>()
                .Property(e => e.MaNXB)
                .IsUnicode(false);

            modelBuilder.Entity<NhaXuatBan>()
                .Property(e => e.DienThoai)
                .IsUnicode(false);

            modelBuilder.Entity<Permission>()
                .Property(e => e.idRole)
                .IsUnicode(false);

            modelBuilder.Entity<Permission>()
                .Property(e => e.idUser)
                .IsUnicode(false);

            modelBuilder.Entity<Role>()
                .Property(e => e.id)
                .IsUnicode(false);

            modelBuilder.Entity<Role>()
                .HasMany(e => e.Permissions)
                .WithRequired(e => e.Role)
                .HasForeignKey(e => e.idRole)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Sach>()
                .Property(e => e.MaNXB)
                .IsUnicode(false);

            modelBuilder.Entity<Sach>()
                .HasMany(e => e.ChiTietDonHangs)
                .WithRequired(e => e.Sach)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Sach>()
                .HasMany(e => e.ThamGias)
                .WithRequired(e => e.Sach)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<TacGia>()
                .Property(e => e.DienThoai)
                .IsUnicode(false);

            modelBuilder.Entity<TacGia>()
                .HasMany(e => e.ThamGias)
                .WithRequired(e => e.TacGia)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<UserGroup>()
                .Property(e => e.id)
                .IsUnicode(false);

            modelBuilder.Entity<UserGroup>()
                .HasMany(e => e.KhachHangs)
                .WithOptional(e => e.UserGroup)
                .HasForeignKey(e => e.idUserGroup);

            modelBuilder.Entity<UserGroup>()
                .HasMany(e => e.Permissions)
                .WithRequired(e => e.UserGroup)
                .HasForeignKey(e => e.idUser)
                .WillCascadeOnDelete(false);
        }
    }
}

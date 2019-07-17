CREATE DATABASE QLBS
GO
USE QLBS
GO


-----tạo bảng nxb----
CREATE TABLE NhaXuatBan
(MaNXB VARCHAR(50)  PRIMARY KEY NOT NULL,
TenNXB NVARCHAR(50 ) NOT NULL,
DiaChi NVARCHAR(100) NOT NULL,
DienThoai VARCHAR(50) NOT NULL,
)
GO

------tạo bảng chủ đề ---------
CREATE TABLE ChuDe
(
MaChuDe INT PRIMARY KEY NOT NULL,
TenChuDe NVARCHAR(50) NOT NULL,
)
GO

---tạo bảng sách-----
CREATE TABLE Sach
(
MaSach INT IDENTITY PRIMARY KEY NOT NULL ,
TenSach NVARCHAR(100) NOT NULL,
GiaBan INT NOT NULL,
MoTa NVARCHAR( MAX ) NULL ,
NgayCapNhat DATETIME NULL,
AnhBia NVARCHAR( MAX) NULL,
SoLuongTon INT NULL ,
MaChuDe INT REFERENCES dbo.ChuDe(MaChuDe),
MaNXB VARCHAR(50) REFERENCES dbo.NhaXuatBan(MaNXB) ,
TinhTrang INT NULL,
)
GO
---tạo bảng tác giả---
CREATE TABLE TacGia
(
MaTacGia INT PRIMARY KEY NOT NULL,
TenTacGia NVARCHAR(50) NULL ,
DiaChi NVARCHAR(100) NULL,
TieuSu NVARCHAR( 50) NULL,
DienThoai VARCHAR(50) NULL,
)
GO
----tạo bảng tham gia -----
CREATE TABLE ThamGia
(MaSach INT REFERENCES dbo.Sach(MaSach),
MaTacGia INT REFERENCES dbo.TacGia(MaTacGia),
VaiTro NVARCHAR(50) NULL,
ViTri NVARCHAR(50) NULL ,
PRIMARY KEY(MaSach,MaTacGia),
)
GO

--- -- -- - create table for permission
CREATE TABLE Role(
	id VARCHAR(50) PRIMARY KEY,
	name NVARCHAR(50),
);
go
CREATE TABLE UserGroup(
	id VARCHAR(50) PRIMARY KEY,
	name NVARCHAR(50),
);
go
CREATE TABLE Permission(
	id INT IDENTITY ,
	idRole VARCHAR(50) REFERENCES dbo.Role(id),
	idUser VARCHAR(50) REFERENCES dbo.UserGroup(id),
	PRIMARY KEY(idRole,idUser,id)
	
);

go
--- tạo bảng khách hàng -----
CREATE TABLE KhachHang
(
MaKH INT IDENTITY PRIMARY KEY ,
HoTen NVARCHAR(100) NOT NULL,
NgaySinh DATE NOT NULL,
GioiTinh NVARCHAR(3) NOT NULL,
DienThoai VARCHAR(50) NOT NULL,
TaiKhoan VARCHAR(50) NOT NULL,
MatKhau VARCHAR(50) NOT NULL,
Email VARCHAR(50) NOT NULL,
DiaChi NVARCHAR(max) NOT NULL,
idUserGroup VARCHAR(50) REFERENCES dbo.UserGroup(id)
)
GO
------tạo bảng đơn hàng -----
CREATE TABLE DonHang
(
MaDonHang INT IDENTITY  PRIMARY KEY NOT NULL,
NgayGiao DATETIME  NULL,
NgayDat DATETIME NOT NULL,
DaThanhToan int NOT NULL,
TinhTrangGiaoHang INT NOT NULL,
MaKH INT REFERENCES dbo.KhachHang(MaKH),
)
GO

------------tạo bảng chi tiết ---------------
CREATE TABLE ChiTietDonHang
(
MaDonHang INT REFERENCES dbo.DonHang(MaDonHang),
MaSach    INT REFERENCES dbo.Sach(MaSach),
SoLuong INT NULL,
DonGia INT ,
PRIMARY KEY(MaDonHang,MaSach),
)
GO

--------dữ liệu chi tiết--------
-- nhóm người sử dụng
INSERT dbo.UserGroup VALUES  ( 'ADMIN',  N'Quản trị'   )
INSERT dbo.UserGroup VALUES  ( 'MEMBER',  N'Thành Viên'   )
INSERT dbo.UserGroup VALUES  ( 'MANAGER',  N'Quản lý'   )
INSERT dbo.UserGroup VALUES  ( 'CUSTOMER',  N'Khách hàng'   )
GO
-- quyền 
INSERT dbo.Role VALUES  ( 'VIEW',  N'Xem' )
INSERT dbo.Role VALUES  ( 'ADD',  N'Thêm' )
INSERT dbo.Role VALUES  ( 'EDIT',  N'Sửa' )
INSERT dbo.Role VALUES  ( 'DELETE',  N'Xóa' )

GO
-- phân quyền
INSERT dbo.Permission VALUES  ( 'VIEW', 'ADMIN' )
INSERT dbo.Permission VALUES  ( 'ADD', 'ADMIN' )
INSERT dbo.Permission VALUES  ( 'EDIT', 'ADMIN' )
INSERT dbo.Permission VALUES  ( 'DELETE', 'ADMIN' )

INSERT dbo.Permission VALUES  ( 'VIEW', 'MEMBER' )

INSERT dbo.Permission VALUES  ( 'ADD', 'MANAGER' )
INSERT dbo.Permission VALUES  ( 'EDIT', 'MANAGER' )
INSERT dbo.Permission VALUES  ( 'VIEW', 'MANAGER' )

---------------dữ liệu khách hàng-------------

INSERT [dbo].[KhachHang]  VALUES ( N'Nguyễn Nam Long', '1992-02-01', N'Nam', '0961023696', 'kh1', N'1', 'user1@gmail.com', N'Tây Hồ, Hà Nội','CUSTOMER')
INSERT [dbo].[KhachHang]  VALUES ( N'Trần Văn Dự', '1992-02-01', N'Nam', '0961023696', 'kh2', N'1', 'user2@gmail.com', N'Quảng An, Tây Hồ','CUSTOMER')
INSERT [dbo].[KhachHang]  VALUES ( N'Nguyễn Chí Công', '1992-02-01', N'Nữ', '0961023696', 'kh3', N'1', 'user3@gmail.com', N'Hàng Đào, Hoàn Kiếm, Hà Nội','CUSTOMER')
INSERT [dbo].[KhachHang]  VALUES ( N'Trần Duy Hưng', '1992-02-01', N'Nam', '0961023696', 'kh4', N'1', 'user4@gmail.com', N'Cầu Giấy, Hà Nội','CUSTOMER')

GO
---------- dữ liệu đơn hàng ---------------- 
INSERT [dbo].[DonHang]  VALUES ( NULL, CAST(N'2014-11-20T01:29:55.143' AS DateTime), 0, 0,1)
INSERT [dbo].[DonHang]  VALUES ( NULL, CAST(N'2014-11-20T01:34:05.900' AS DateTime), 0, 0,2)
INSERT [dbo].[DonHang]  VALUES ( NULL, CAST(N'2014-11-20T01:35:43.047' AS DateTime), 0, 0,3)
INSERT [dbo].[DonHang]  VALUES ( NULL, CAST(N'2017-07-05T15:31:42.647' AS DateTime), 0, 0,4)
GO



GO
-------------------dữ liệu chủ đề--------
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (501, N'Công nghệ thông tin')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (502, N'Ngoại ngữ')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (503, N'Phật Giáo')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (504, N'Sách học làm người')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (505, N'Văn học nước ngoài')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (506, N'Kinh Tế')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (507, N'Khoa học Vật lý')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (508, N'Khoa học Xã hội')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (509, N'Luật')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (510, N'Từ điển')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (511, N'Lịch sử, địa lý')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (512, N'Vật nuôi - Cây cảnh')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (513, N'Khoa học kỹ thuật')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (514, N'Mỹ thuật')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (515, N'Nghệ thuật')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (516, N'Âm nhạc')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (517, N'Sách giáo khoa')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (518, N'Sách tham khảo')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (519, N'Danh nhân')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (520, N'Tâm lý giáo dục')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (521, N'Thể thao - Võ thuật')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (522, N'Văn hóa - Xã hội')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (523, N'Nữ công gia chánh')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (524, N'Nghệ thuật làm đẹp')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (525, N'Du lịch')
INSERT [dbo].[ChuDe] ([MaChuDe], [TenChuDe]) VALUES (526, N'Y Học dân tộc vn')
go



INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB1', N'Nhà xuất bản Trẻ', N'124 Nguyễn Văn Cừ Q.1 Tp.HCM', 1900156045)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB2', N'NXB Thống kê', N'Biên Hòa-Đồng Nai', 1900151112)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB3', N'Kim đồng', N'Tp.HCM', 1900157090)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB4', N'Đại học quốc gia', N'Tp.HCM', 908419981)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB5', N'Văn hóa nghệ thuật', N'Đà Nẵng', 903118833)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB6', N'Văn hóa', N'Bình Dương', 913336677)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB7', N'NXB Lao động - Xã hội', N'Tp.HCM', 989888888)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB8', N'Khoa Học & Kỹ Thuật', N'Hà Nội', 903118824)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB9', N'Thanh Niên', N'Tp.HCM', 903118811)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB10', N'NXB Tài Chính', N'Huế', 903118833)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB11', N'NXB Phụ Nữ', N'Tp.HCM', 989888885)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB12', N'NXB Hồng Đức ', N'Tp.HCM', 989888885)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB13', N'NXB Phương Đông', N'Tp.HCM', 989888889)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB14', N'NXB Thời Đại', N'Tp.HCM', 903118865)
INSERT [dbo].[NhaXuatBan] ([MaNXB], [TenNXB], [DiaChi], [DienThoai]) VALUES ('NXB15', N'NXB Tổng hợp TP.HCM', N'Tp.HCM',903118878)
GO

INSERT [dbo].[Sach]  VALUES ( N'Sketchup & Vray Trong Thiết Kế 1 Kiến Trúc', 85000, N'SketchUp Pro là một chương trình đồ họa kiến trúc tuyệt vời, dễ học cũng như dễ sử dụng. Ngay từ khi xuất hiện vào năm 2000, SketchUp giúp cho việc phác thảo và thiết kế ý tưởng được thuận tiện, chương trình tập hợp nhiều công cụ tiện ích giúp cho việc thể hiện ý tưởng cho việc phác thảo những phối cảnh trong kiến trúc. Ứng dụng trong Sketchup rất linh hoạt. Chương trình đoạt nhiều giải thưởng về thiết kế sáng tạo và được nhiều người công nhận. ', CAST(N'2014-11-09T00:00:00.000' AS DateTime), N'000001.jpg', 100, 501, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'3DS Max-Thủ Thuật Render Phối Cảnh kiến Trúc Ban Ngày Và Đêm Với V-Ray 1.50 RC3', 75000, N'Cuốn sách 3DS Max giới thiệu đến các bạn những kỹ năng sử dụng phần mềm hỗ trợ V-ray mới nhất đang được nhiều người trên thế giới quan tâm. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000002.jpg', 50, 501, 'NXB2', 1)
INSERT [dbo].[Sach]  VALUES ( N'Tự Học InDesign CS3', 55000, N'InDesign CS3 là chương trình dàn trang rất hiện đại và tiện dụng dành cho việc trình bày sách, báo, tạp chí...', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000003.jpg', 10, 501, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Đắc Nhân Tâm - Cuốn Sách Hay Nhất Của Mọi Thời Đại Đưa Bạn Đến Thành Công!', 60000, N'Đắc nhân tâm – How to win friends and Influence People của Dale Carnegie là quyển sách nổi tiếng nhất, bán chạy nhất và có tầm ảnh hưởng nhất của mọi thời đại. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000004.jpg', 10, 504, 'NXB2', 1)
INSERT [dbo].[Sach]  VALUES ( N'Tự Học Photoshop CS5 Qua Hình Ảnh Minh Họa (Sách Kèm CD)',62000, N'Nhằm đáp ứng nhu cầu tự học Photoshop, một phần mềm xử lý ảnh ngày càng nhiều. Sách " Tự Học Photoshop CS5 Qua Hình Ảnh Minh Họa" được chia thành 11 chương kèm với hình ảnh minh họa và CD bài tập được kèm theo sách. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000005.jpg', 10, 501, 'NXB3', 1)
INSERT [dbo].[Sach]  VALUES ( N'180 Thủ Thuật Và Mẹo Hay Trong Flash CS4', 71000, N'Adobe Flash Professional CS4 là phiên bản mới nhất của công cụ thiết kế Web đang rất thịnh hành hiện nay. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000006.jpg', 10, 501, 'NXB3', 1)
INSERT [dbo].[Sach]  VALUES ( N'Microsoft Office 2010 - Dành Cho Người Tự Học', 18000, N'Trong lĩnh vực tin học văn phòng, Microsoft Word, Excel, PowerPoint, Visio là những chương trình thuộc bộ Microsoft Office đã và đang được ứng dụng rộng rãi trong nhiều lĩnh vực: kinh tế, kế toán, thương mại, quản lý, vẽ kỹ thuật và nhiều hơn nữa. Với Office 2010, bạn có trong tay đầy đủ các công cụ và lệnh để thực hiện các tiện ích trong diện toán văn phòng .', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000007.jpg', 10, 501, 'NXB11', 1)
INSERT [dbo].[Sach]  VALUES ( N'Tự học Microsoft Excel 2010', 37000, N'Sách được chia thành 11 bài, từ căn bản đến nâng cao kèm theo CD bài tập thực hành nhằm giúp bạn học một cách nhanh chóng và dễ hiểu như:', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000008.jpg', 10,501, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'C# Dành Cho Người Tự Học - Tập 1', 67000, N'Sách được chia thành 11 bài, từ căn bản đến nâng cao kèm theo CD bài tập thực hành nhằm giúp bạn học một cách nhanh chóng và dễ hiểu như:', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000009.jpg', 10, 501, 'NXB11', 1)
INSERT [dbo].[Sach]  VALUES ( N'C# Dành Cho Người Tự Học - Tập 2', 69000, N'Trong tập 2 này, các bạn sẽ tìm hiểu ứng dụng C# trong Windows Form qua 2 phần, mỗi phần là một bài tập lớn xây dựng lên ứng dụng Quản lý bán hàng và Quản lý tuyển sinh để bạn đọc hiểu rõ và khai thác có hiệu quả những công cụ và lệnh của C# đã trình bày trong tập 1.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000010.jpg', 10, 501, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Nghệ Thuật Sống An Lạc ', 69000, N'"Nghệ thuật sống An lạc là tuyển tập các bài giảng liên quan tới chủ đề nghệ thuật sống của Đức Nhiếp Chính Vương Khamtrul Rinpoche đời thứ IX Jigme Pema Nyinjadh . ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000011.jpg', 10, 503, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Phương Pháp Quản Lý Nhân Sự Trong Công Ty', 69000, N'Những người sử dụng lao động đã hiểu dần các giá trị mà con người tạo ra cho tổ chức của họ. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000012.jpg', 10, 506, 'NXB5', 1)
INSERT [dbo].[Sach]  VALUES ( N'Ngọc Sáng Trong Hoa Sen', 69000, N'Trong nửa thế kỷ qua, số người phương Tây thăm viếng phương Đông không phải là ít nhưng đã có mấy ai lĩnh hội được tinh hoa của phương Đông? ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000013.jpg', 10, 503, 'NXB5', 1)
INSERT [dbo].[Sach]  VALUES ( N'Hành Trình Về Phương Đông', 18000, N'"Hành trình về phương đông" kể về những trải nghiệm của một đoàn khoa học gồm các chuyên gia hàng đầu của Hội Khoa Học Hoàng Gia Anh được cử sang Ấn Độ nghiên cứu về huyền học và những khả năng siêu nhiên của con người. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000014.jpg', 10, 503, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Lập Bản Đồ Tư Duy - Công Cụ Tư Duy Tối Ưu Sẽ Làm Thay Đổi Cuộc Sống Của Bạn', 18000, N'Lập Bản Đồ Tư Duy - Công Cụ Tư Duy Tối Ưu Sẽ Làm Thay Đổi Cuộc Sống Của Bạn:', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000015.jpg', 10, 504, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Đơn Giản Và Thuần Khiết', 18000, N'Giới thiệu về nội dung Tác phẩm này là tổng hợp của nhiều bài Pháp được giảng từ những năm 1954 đến 1977 của Upasika Kee Nanayon. Mỗi phần có thể là một bài giảng ở một thời điểm khác nhau, vì thế khi tập hợp lại, điều này tạo cho chúng ta cảm tưởng của sự lặp đi lặp lại nhiều ý tưởng. Đó có thể là lý do khiến cho một số độc giả thiếu kiên nhẫn khi theo dõi, riêng đối với những người sơ cơ thì điều đó lại là một ân huệ. Ngoài ra văn phong của Upasika Kee Nanayon rất giản dị, chân tình. Đôi khi chúng ta sẽ có cảm giác như đang nghe những lời nhắc nhở, dạy dỗ của một người thầy, người mẹ, dầu hơi nghiêm khắc, nhưng luôn tràn đầy tâm từ bi, muốn cho người nghe, người đọc phải tinh tấn thêm lên, gấp rút thêm lên trên con đường tu học của mình.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000016.jpg', 10, 503, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Cách Sống - Từ Bình Thường Trở Nên Phi Thường', 18000, N'Inamori Kazuo một doanh nhân hết sức thành đạt trong việc sáng lập và điều hành tập đoàn Kyocera lớn mạnh của Nhật Bản. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000017.jpg', 50, 506, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Những Quy Luật Mới Trong Bán Lẻ', 18000, N'Ngành bán lẻ đang chứng kiến một sự thay đổi trọng đại. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000018.jpg', 50, 506, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Lavina Và Hầu Tước Elswick (Cuộc Chạy Trốn Nữ Hoàng)', 75000, N'Khi Hoàng tử Stanislaus của xứ Balkan yêu cầu có một cô dâu của Anh quốc, Nữ hoàng Victoria đã quyết định chọn tiểu thư Lavina gửi cho hắn. Gia đình nàng có quan hệ họ hàng xa với hoàng tộc.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000019.jpg', 50, 505, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Hành Vi Tổ Chức - Organizational Behavior', 75000, N'"Vũ trụ cũng không khó hiểu bằng hành động của con người." Marcel Proust Tiến sĩ Timothy A. Judge từng là giáo sư giảng dạy tại trường Đại Học Cornell và đại học Lowa. Ông nghiên cứu chuyên sâu vào các lĩnh vực liên quan đến sự khác biệt cá nhân, thuật lãnh đạo và ảnh hưởng hành vi con người...Ông đã được trao nhiều giải thưởng quan trọng như Emest J.McCormick Award, Larry L. Cummings Award...', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000020.jpg', 50, 506, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'17 Nguyên Tắc Vàng Trong Làm Việc Nhóm', 75000, N'Khi trở thành thành viên của một nhóm nào đó thì vấn đề bạn cần băn khoăn không phải là “Có nên tham gia các hoạt động của nhóm không?” mà là “Những đóng góp của bạn có mang lại thành công cho nhóm không?” Các cá nhân không thể gắn kết với nhau là nguyên nhân làm tan rã nhóm. Một số người nghĩ rằng chìa khoá để thành công là nguyên tắc làm việc rõ ràng. Nhưng trên thực tế, có nhiều người rất siêng năng, khả năng làm việc độc lập rất tốt nhưng lại không thể làm việc cùng nhau để phát huy hết tiềm lực của họ. Thực chất, nhóm phải là nhóm những cá nhân luôn tương trợ, giúp đỡ lẫn nhau, tạo động lực cho nhau phát triển. Giữa các cá nhân phải có sự tương tác với nhau như một chuỗi phản ứng hoá học. Đó là cách thức để xây dựng nhóm của riêng bạn. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000021.jpg', 50, 506, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Essential Words For The IELTS (Kèm 1 Đĩa CD)', 75000, N'Extensive practice in vocabulary building and correct English usage, with emphasis on 600 words that appear frequently on the IELTS.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000022.jpg', 50, 502, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Tiếng Hàn Trong Giao Tiếp Hàng Ngày', 75000, N'Extensive practice in vocabulary building and correct English usage, with emphasis on 600 words that appear frequently on the IELTS.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000023.jpg', 50, 502, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'80 Chiêu Thức Kinh Doanh Thành Công', 75000, N'Làm sao để nắm bắt và khai thác cơ hội kinh doanh hiệu quả nhất, doanh số tăng, lợi nhuận cao nhưng chi phí giảm? Làm sao để tạo được ấn tượng trong trí nhớ khách hàng? Làm sao để thị trường công nhận rằng bạn cung cấp các sản phẩm tốt nhất, có dịch vụ hậu mãi hoàn hảo nhất? Làm sao để tạo nên một tập thể nhân viên làm việc tích cực và sáng tạo?... Những câu hỏi đó luôn làm trăn trở các nhà quản trị doanh nghiệp, và bí mật sẽ được tiết lộ trong cuốn sách này', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000024.jpg', 50, 506, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Những Công Cụ Thiết Yếu Trong Phân Tích Kỹ Thuật Thị Trường Tài Chính ',48000, N'Một cuốn sách nghiêm túc thiết thực, sự giới thiệu tuyệt vời về phát triển kỹ thuật. Chen mang lại cho những người mới bắt đầu những ví dụ rõ ràng về các phương pháp và kinh tế, từ đó người đọc có thể chọn ra một hướng chuyên môn hóa', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000025.jpg', 50, 505, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Nàng Lọ Lem Và Đàn Chuột Mất Tích', 75000, N'Những chú chuột nhỏ đã trải qua một đêm lạnh cóng trên gác mái của lâu đài, chúng tìm vào phòng Lọ Lem mong được sưởi ấm. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000026.jpg', 50, 505, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Công Chúa Aurora Và Chú Rồng Nhỏ', 48000, N'Hãy thử tưởng tượng xem mình sẽ làm gì nếu kết bạn với một chú rồng nhỏ? Chắc chắn sẽ có những điều rất thú vị phải không? Vậy công chúa Aurora đã làm những gì khi tình cờ gặp chú rồng nhỏ trên đường đi dạo cùng hoàng tử ?', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000027.jpg', 50, 501, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'3ds Max 2009 ', 48000, N'Bộ sách “Dựng Các Mô Hình Kiến Trúc Phức Tạp Và Mô Phỏng Nội Thất - Ngoại Thất 3D” được biên soạn nhằm mục đích hướng dẫn những bạn đọc yêu thích đồ họa 3D thực hiện dễ dàng với chương trình 3ds Max 2009 Pro. Đây là chương trình có nhiều tính năng thiết kế 3D tuyệt vời mà bạn có thể ứng dụng trong kiến trúc xây dựng và trang trí nội ngoại thất.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000028.jpg', 50, 501, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Công Nghệ Mạng Máy Tính', 48000, N'Cuốn sách gồm các nội dung chính sau:', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000029.jpg', 50, 501, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Tính Toán Thiết Kế Kết Cấu Với SAP 14', 48000, N'Extensive practice in vocabulary building and correct English usage, with emphasis on 600 words that appear frequently on the IELTS.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000030.jpg', 50, 501, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'Revit Architecture 2011 Từ A Đến Z - Tập 2', 48000, N'Revit Architecture 2011 từ A đến Z (Tập 2) là 1 trong những chuyên đề thuộc họ sách CAD trong kiến trúc-xây dựng do nhà sách STK biên soạn dùng làm tài liệu tham khảo, chủ yếu là thực hành hướng dẫn sử dụng chương trình Revit Architecture đã và đang sử dụng rộng rãi trong các trường Cao đẳng, Đại học khối công nghệ chuyên ngành, cũng như tại các văn phòng thiết kế. Nó cung cấp cho học sinh, sinh viên, giáo viên, kiến trúc sư, họa viên những kiến thức và kỹ năng cơ bản nhất về ứng dụng CAD trong thiết kế kiến trúc.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000031.jpg', 50, 501, 'NXB1', 1)
INSERT [dbo].[Sach]  VALUES ( N'CoreIDraw X5 - Dành Cho Người Tự Học', 48000, N'Coreldraw X5 dành cho người tự học được biên soạn cho người mới bắt đầu sử dụng coreldraw trong thiết kế, học tập và nhiều hơn nữa. Quyển sách này được minh họa bằng hình ảnh cả lý thuyết lẫn thực hành sẽ giúp bạn dễ dàng tìm hiểu và khám phá các đặc tính của Coreldraw x5 để ứng dụng trong công việc thực tế và hiệu quả nhất.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000032.jpg', 50, 501, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Chế Bản Điện Tử Với Ilustrator CS5', 15000, N'Sách cần thiết cho học sinh, sinh viên, những bạn đã biết hoặc chua từng tiếp xúc với chương trình Illustrator cũng như các giáo viên dạy thực hành tại các trung tâm chuyên đồ họa, multimedia, mỹ thuật công nghiệp ...', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000033.jpg', 50, 501, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Cẩm Nang Tin Học Văn Phòng', 15000, N'Với những tiến bộ của khoa học kỹ thuật, máy vi tính ra đời và được sử dụng trong khắp các văn phòng, công sở, gia đình... đã trở thành công cụ không thể thiếu đối với mỗi người', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000034.jpg', 50,501, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Xử Lý Ảnh Photoshop CS5 Dành Cho Người Tự Học - Tập 1', 15000, N'Bộ sách được chia làm nhiều chuyên đề đi sâu vào từng tính năng quan trọng của Photoshop. Chuyên đề đâu tiên này sẽ tập trung trình bày cách tạo vùng chọn. Đây là phần cơ bản nhưng rất quan trọng sách khi sử dụng Photoshop. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000035.jpg', 50, 501, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'71 Kỹ Thuật Thâm Nhập Windows Vista Pro', 74000, N'71 Kỹ Thuật Thâm Nhập Windows Vista Pro:', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000036.jpg', 50, 501, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Hướng Dẫn Học Từng Bước Excel 2010 Dành Cho Người Tự Học', 15000, N'Nội dung sách trình bày những kiến thức không quá sâu, nhằm phục vụ cho những người mới bắt đầu làm quen với điện toán văn phòng, đồng thời là tài liệu tham khảo để giảng dạy liên quan đến chương trình Excel.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000037.jpg', 50, 511, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'SQL Server 2005 - Xây Dựng Ứng Dụng Quản Lý Kế Toán Bằng C# 2005 ', 74000, N'Giáo trình bao gồm 10 chương và phần phụ lục tham khảo được nhấn mạnh xuyên suốt từ giao diện, hàm, phát biểu SQL động, phát biểu SQL phức tạp, phát biểu điều khiển, thủ tục nội tại, trigger, giúp cho bạn sử dụng chúng trong ứng dụng kế toán cùng với sự kết hợp hoàn hảo bằng ngôn ngữ lập trình C# 2005.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000038.jpg', 50, 501, 'NXB5', 0)
INSERT [dbo].[Sach]  VALUES ( N'Lập Trình Web Bằng ASP.Net Với Macromedia Dreamweaver MX - Tập 2', 74000, N'ASP.NET khác biệt rất nhiều so với các công nghệ Web đi trước. Macromedia Dreamweaver MX tuy vẫn duy trì sức mạnh của công cụ thiết kế trang nhã, nhưng đã chuyển từ công nghệ cổ điển sang ASP.NET bằng cách cung cấp nhiều công cụ đơn giản bớt quá trình tự động hoá ứng dụng Web. Nhờ kết hợp sức mạnh của ASP.NET với Dreamweaver, các nhà phát triển sẽ nắm bắt được ASP.NET chỉ trong nháy mắt.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000039.jpg', 50, 501, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Tạo Website Hướng Database Bằng PHP Và MYSQL - Tập 2', 74000, N'Nội dung là yếu tố quyết định tất cả! Ừm… nghe thì hơi “kêu” thật, nhưng không thể nào đúng hơn. Chỉ cần nắm vững HTML và học thêm vài bí quyết cơ bản về JavaScript và Dynamic HTML là ta đã có thể thiết kế một Website đầy ấn tượng được rồi. Nhưng muốn thu hút một lượng fan đông đảo thì nội dung của Website phải mới mẻ và liên tục được cập nhật. Trong thiết kế Web truyền thống, nội dung được quyết định bở tập tin HTML…', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000040.jpg', 50, 501, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Tạo Bản Thuyết Trình Trong Microsoft Office PowerPoint 2007 For Windows', 74000, N'Tạo bản thuyết trình trong Microsoft Office PowerPoint 2007 for Windows mang lại cho bạn phương pháp nghiên cứu công nghệ mới độc đáo nhất từ trước đến nay. Thay vì làm nản lòng độc giả bằng những giải thích dông dài mang nặng tính lý thuyết, tập sách sử dụng hình ảnh minh họa đi kèm hướng dẫn cụ thể hầu giúp bạn hoàn thành dự án chỉ trong nháy mắt', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000041.jpg', 50, 501, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Shambhala - Vùng Đất Tây Tạng Huyền Bí Hay Cuộc Hành Trình Tìm Về Bản Thể', 74000, N'Tu viện Tashilumbo thuộc thành phố Phật giáo Shigatze, nằm ở miền Tây của Tây Tạng. Nơi đây, gió thường thổi xuyên qua các hành lang rải đầy đá, để lại những luồng không khí mát rượu giữa cái nóng dịu nhẹ của buổi chiều tà. Vào thời khắc này, người ta thường cảm thấy trào dâng niềm cảm xúc động khi ngắm nhìn những tia sáng chói lòa chiếu rọi qua cao nguyên Himalaya. Cảm xúc ấy càng trở nên mãnh liệt hơn khi mặt trời dần khuất bóng.Shambhala là bản kinh cổ xưa viết bằng tay, được lưu giữ tại Tu viện Tashilumbo. Kinh Shambhala miêu tả những noi như "Hồ Độc Dược", "Hồ Ác Quỷ" và cả hiện tượng quầng cực quang ở dãy núi Himalaya, khi "Một trăm ngọn núi cùng phát sáng sau khi màn đêm buông xuống". Tất cả những nơi này đều có thực. Chúng nằm ở Ngari, một vùng xa xôi hẻo lánh ở cực tây của Tây Tạng.Ở một góc độ khác, bản kinh không chỉ đơn thuần là một cuốn sách dẫn đường theo nghĩa đen nữa, nó còn có thể là một tấm bản đồ chỉ dẫn thiền định cho mỗi cá nhân trên con đường khám phá nội tâm của chính mình. Ở góc độ này, Kinh Shambhala mang ý nghĩa phức tạp hơn. Nó dạy chúng ta cách khống chế những năng lượng tiêu cực và chuyển hóa chúng thành năng lượng tiêu cực và chuyển hóa chúng thành năng lượng tích cực....', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000042.jpg', 50,503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Sức Mạnh Của Đạo Phật - Để Sống Tốt Hơn Trong Thế Giới Ngày Nay', 74000, N'Nói đến Đạo Phật là nói đến giác ngộ, chủ trương của Đạo Phật là giác ngộ. Đạo Phật có mặt trên thế giới đến nay là 2556 năm (tính đến thời điểm hiện tại năm 2008). ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000043.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Điều Trị Bệnh Tận Gốc - Năng Lực Của Tâm Bi Mẫn ', 74000, N'"Điều trị bệnh tận gốc" không chỉ là một cuốn sách với những lời cầu nguyện cho bệnh tật cơ thể được giảm bớt. Nội dung của cuốn sách này còn chứa đựng nhiều hơn thế nữa. Các phần lý thuyết và thực hành chứa đựng trong sách này có tác dụng dẫn dắt tâm chúng ta đến chỗ thấu hiểu sâu xa hơn về sự sống và cái chết, về vô thường và khổ đau. Sự thấu hiểu sâu sắc như thế sẽ cho phép chúng ta bắt đầu nhìn ngắm cơn đau và bệnh tật bằng một tầm nhìn bao quát hơn. Với tầm nhìn này thì khái niệm về nghiệp quả, về tái sinh và về phẩm chất của sự tái sinh, tát cả những khái niệm đó sẽ mang những ý nghĩa mới có năng lực làm dịu cơn đau và chữa lành tận gốc các căn bệnh của chúng ta', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000044.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Nhập Môn Windows Vista Tập 1', 32000, N'Nhập Môn Windows Vista - Tập 1 gồm những nôi dung sau:', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000045.jpg', 50, 501, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Hành Trình Tâm Linh Siêu Việt', 32000, N'Một cuốn sách của tác giả Gyalwang Drukpa, một bậc thầy về tâm linh, người đang dẫn dắt dòng truyền thừa Drukpa, một dòng truyền thừa với những hành giả thực hành tâm linh trải khắp Ấn Độ và các nước tại Châu Á, Châu Âu và Châu Mỹ. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000046.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Nghiệp Lực - Nhìn Lại Quá Khứ & Nhận Biết Tương Lai', 32000, N'Nỗi hoang mang bối rối của con người về nghiệp không khiến bà ngạc nhiên. Hỏi mười người ý nghĩa của từ này, bạn sẽ nhận được mười câu trả lời khác nhau. ', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000047.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Tỉnh Thức', 32000, N'"Con người còn luôn mãi khổ đau một khi chưa tỉnh thức."', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000048.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'13 Nguyên Tắc Nghĩ Giàu, Làm Giàu - Think And Grow Rich', 32000, N'"Think and Grow Rich - 13 nguyên tắc nghĩ giàu, làm giàu" là cuốn sách "chỉ dẫn" duy nhất chỉ ra những nguồn lực bạn phải có để thành công. Cuốn sách sẽ giúp bạn trở nên giàu có, làm giàu thêm cho cuộc sống của bạn trên tất cả các phương diện của cuộc sống chứ không chỉ về tài chính và vật chất. Những ý tưởng trong sách "Think and Grow Rich - 13 nguyên tắc nghĩ giàu, làm giàu" bắt nguồn từ những động lực tốt đẹp: "Thành công cá nhân" và "Quan điểm suy nghĩ tích cực".', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000049.jpg', 50, 506, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Đạo Kỷ Nguyên Mới', 32000, N'"Think and Grow Rich - 13 nguyên tắc nghĩ giàu, làm giàu" là cuốn sách "chỉ dẫn" duy nhất chỉ ra những nguồn lực bạn phải có để thành công. Cuốn sách sẽ giúp bạn trở nên giàu có, làm giàu thêm cho cuộc sống của bạn trên tất cả các phương diện của cuộc sống chứ không chỉ về tài chính và vật chất. Những ý tưởng trong sách "Think and Grow Rich - 13 nguyên tắc nghĩ giàu, làm giàu" bắt nguồn từ những động lực tốt đẹp: "Thành công cá nhân" và "Quan điểm suy nghĩ tích cực".', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000050.jpg', 50, 503, 'NXB8', 0)
INSERT [dbo].[Sach]  VALUES ( N'The Power Of Compassion - Sức mạnh của lòng từ',32000, N'Từ ngày 11 đến ngày 11 tháng 6 năm 2008 này, Đức Đạt Lai Lạt Ma sẽ viếng thăm Úc Châu, đây là chuyến thăm Úc lần thứ năm của Ngài để giảng dạy Phật Pháp. Mọi người đang trông đợi sự xuất hiện của ngài.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000051.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Con Đường Mây Trắng - DER WEG DER WEISSEN WOLKEN', 32000, N'Trong thế kỷ hai muơi này, phương Tây có hai người tìm hiểu đất nước Tây Tạng rất sâu sắc, đó là bà Alexandra David Nesel và ông Anagarika Govinda. Cả hai vị này đã từng sống nhiều năm tại tây Tạng, từng tu tập thiền định và đi khắp nơi trong xứ sở huyền bí này hơn bất cứ người nước ngoài nào khác. Có thế nói họ hiểu tây Tạng với tất cả những khía cạnh tâm linh, tâm lý, địa lý nhiều hơn cả phần đông người tây Tạng.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000052.jpg', 50, 503, 'NXB8', 0)
INSERT [dbo].[Sach]  VALUES ( N'Đức Đạt Lai Lạt Ma Tại Harvard', 43000, N'Đức Đạt lai Lạt ma tại Harvard là một loạt bài thuyết giảng tại Đại Học Harvard do Viện nghiên cứu Phật học Hoa Kỳ (AIRS) và Trung tâm nghiên cứu các tôn giáo bảo trợ. Các bài thuyết giảng của Đức Đạt-lai-Lạt-ma, chủ yếu do giáo sư Robert Thurman sắp xếp, đã được thực hiện tại Giảng đường Emerson trong khuôn viên của Havard.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000053.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Những Con Đường Của Ánh Sáng - Tập 1', 43000, N'Những Con Đường Của Ánh Sáng - Tập 1: Vật Lý Siêu Hình Học Của Ánh Sáng Và Bóng Tối (Tái Bản)', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000054.jpg', 50, 507, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Những Con Đường Của Ánh Sáng - Tập 2', 43000, N'Những con đường của ánh sáng được coi là bản sử thi về cuộc hành trình của con người đi vào vương quốc ánh sáng và giải mã những bí mật của nó. Và trong cuốn sách này tác giả đã thảo luận về ánh sáng, và liên qua tới nó là bóng tối, trên nhiều phương diện bao gồm tầm quan trọng của nó đối với sự sống, đối với khoa học, sự diễn giải ánh sáng của bộ não, nghệ thuật của các họa sĩ thuộc trường phái ấn tượng, việc sử dụng ánh sáng trong kiến trúc và các khía cạnh tâm linh của ánh sáng....', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000055.jpg', 50, 507, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Cái Vô Hạn Trong Lòng Bàn Tay (Từ Big Bang Đến Giác Ngộ)', 43000, N'Cái Vô Hạn Trong Lòng Bàn Tay (Từ Big Bang Đến Giác Ngộ):', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000056.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Nghệ Thuật Thiền Định', 43000, N'Nếu như học thiền là một con đường mà các bậc cao minh nhất đã theo đuổi trong suốt cuộc đời thì thực hành thiền trong cuộc sống hằng ngày sẽ làm thay đổi cách nhìn của chúng ta về chính bản thân mình và thế giới. Đó là thông điệp mà cuốn sách Nghệ thuật thiền định muốn gửi đến chúng ta. Cuốn sách vừa như người dẵn dắt cụ thể cho chúng ta cách thực hành thiền.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000057.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Bàn Về Hạnh Phúc',43000, N'Tất cả chúng ta đều khát khao hạnh phúc, song làm cách nào để có được, giữ gìn nó và thậm chí để định nghĩa nó? Trước câu hỏi mang đầy tính triết lý đang bị giằng xé giữa chủ nghĩa bi quan và thái độ giễu cợt trong tư tưởng phương Tây này, Matthieu Ricard đã mang lại lời giải đáp của đạo Phật: một câu trả lời rất khắt khe, song làm chúng ta yên lòng, lạc quan và ai cũng có thể chấp nhận được.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000058.jpg', 50, 503,'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Lượng tử hoa và sen',43000, N'Lưỡng Tử và Hoa Sen là sự khai phá mở rộng tri thức, tầm nhìn về những tương đương thú vị giữa tư tưởng sắc sảo về vật lý học và Phật giáo - một cuộc trò chuyện mà bất kỳ ai có suy nghĩ đều thích thú dù chỉ tình cờ nghe thấy.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000059.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Đối Thoại Giữa Triết Học Và Phật Giáo', 43000, N'Dựa theo quan niệm cũ kỹ lâu đời, phương Tây hình dung Phật giáo như là một sự minh triết nhưng thụ động và tiêu cực, và xem Niết Bàn như là một sự quay về sống với nội tâm, không màng đến thế sự bên ngoài, kể cả sinh hoạt trong các thành phố.', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000060.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Phật giáo truyền thống Đại Thừa', 43000, N'... Cái tâm cảm thấy mình gần gũi với tất cả mọi chúng sinh như thế chính là tâm từ vô thượng. Một người có được tình yêu này đối với tất cả hữu tình không phân biệt, thì không phải là một người thường. Chắc chắn một con người như vậy đang nắm giữ những thực chứng nội tâm trong tâm thức họ. Khi một người nào có được thứ tình yêu này gặp hoặc nhìn thấy người khác, thì một cảm giác hạnh phúc hồn nhiên sinh khởi. Một người như thế không bao giờ sinh tâm giận dữ hay ganh tị, và do hậu quả của điều này, mọi người sẽ trở thành bạn của vị ấy, có niềm kính trọng lớn lao đối với vị ấy. Một người thực tập tâm từ thuần tịnh thì kết quả cũng sẽ có nội tâm rất an bình', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000061.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Tình Yêu Phổ Quát', 43000, N'...Tất cả chúng sinh đều có hạt giống Phật hay Phật tính. Phương pháp khiến cho hạt giống này nảy nở chính là thực hành những chỉ giáo về pháp luyện tâm. Những kinh nghiệm hay thực chứng trong pháp luyện tâm chính là con đường đến giác ngộ, bởi thế điểm thiết yếu là tất cả chúng sinh cần đạt được kinh nghiệm về pháp tu này. Kết thúc kinh Tiểu phẩm Bát-nhã, đức Phật đã dạy:', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000062.jpg', 50, 503, 'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Rộng Mở Tâm Hồn - Tu Tập Từ Bi Trong Đời Sống Hàng Ngày', 43000, N'Rộng Mở Tâm Hồn - Tu Tập Từ Bi Trong Đời Sống Hàng Ngày', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000063.jpg', 50, 503,'NXB1', 0)
INSERT [dbo].[Sach]  VALUES ( N'Cuộc Đời Là Vô Thường', 43000, N'Cuộc Đời Là Vô Thường', CAST(N'2012-03-31T00:00:00.000' AS DateTime), N'000064.jpg', 50, 503, 'NXB1', 0)
GO

GO
INSERT [dbo].[ChiTietDonHang]  VALUES (1, 1, 1, 85000)
INSERT [dbo].[ChiTietDonHang]  VALUES (1, 2, 2, 85000)
INSERT [dbo].[ChiTietDonHang]  VALUES (2, 3, 1, 85000)
INSERT [dbo].[ChiTietDonHang]  VALUES (2, 4, 1, 85000)
INSERT [dbo].[ChiTietDonHang]  VALUES (2, 5, 1, 85000)
GO


INSERT [dbo].[TacGia] VALUES (201, N'Tenzin Gyatso - Đức Đạt Lai Lạt Ma 14', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (202, N'Trịnh Xuân Thuận', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Trịnh Xuân Thuận ', N'123456789')
INSERT [dbo].[TacGia] VALUES (203, N'Matthieu Ricard', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Matthieu-Ricard', N'123456789')
INSERT [dbo].[TacGia] VALUES (204, N'Kyabje Khamtrul Rinpoche', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Kyabje-Khamtrul-Rinpoche', N'123456789')
INSERT [dbo].[TacGia] VALUES (205, N'Đức Pháp Vương GYALWANG DRUKPA XII', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Kyabje-Khamtrul-Rinpoche', N'123456789')
INSERT [dbo].[TacGia] VALUES (206, N'Nguyên Phong', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Kyabje-Khamtrul-Rinpoche', N'123456789')
INSERT [dbo].[TacGia] VALUES (207, N'Lama Zopa Rinpoche', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Kyabje-Khamtrul-Rinpoche', N'123456789')
INSERT [dbo].[TacGia] VALUES (208, N'Lama Anagarika Govinda', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Kyabje-Khamtrul-Rinpoche', N'123456789')
INSERT [dbo].[TacGia] VALUES (209, N'Ni sư Thích Nữ Trí Hải', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Phó viện trưởng viện Nghiên cứu Phật học Việt Nam', N'123456789')
INSERT [dbo].[TacGia] VALUES (210, N'Ngọc Bích', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Kyabje-Khamtrul-Rinpoche', N'123456789')
INSERT [dbo].[TacGia] VALUES (211, N'Quỳnh Nga', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Kyabje-Khamtrul-Rinpoche', N'123456789')
INSERT [dbo].[TacGia] VALUES (212, N'Edward Peppitt', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Kyabje-Khamtrul-Rinpoche', N'123456789')
INSERT [dbo].[TacGia] VALUES (213, N'Nhân Văn', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Kyabje-Khamtrul-Rinpoche', N'123456789')
INSERT [dbo].[TacGia] VALUES (214, N'Blair T.Spalding', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Kyabje-Khamtrul-Rinpoche', N'123456789')
INSERT [dbo].[TacGia] VALUES (215, N'FPT Polytechnic', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Kyabje-Khamtrul-Rinpoche', N'123456789')
INSERT [dbo].[TacGia] VALUES (216, N'Upasika Kee Nanayon', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (217, N'Inamori Kazuo', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (218, N'Robin Lewis', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (219, N'Michael Dart', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (220, N'Mary T.Browne', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (221, N'Minh Đức', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatsolai ', N'123456789')
INSERT [dbo].[TacGia] VALUES (222, N'Th.S Nguyễn Công Minh', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (223, N'TS. Phạm Thế Quế', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (224, N'Đổ Thái Hòa', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (225, N'Barbara Bazaldua', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (226, N'Th.S Nguyễn Nam Thuận', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (227, N'Lê Thuận', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (228, N'Trần Tuấn Mẫn', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'', N'123456789')
INSERT [dbo].[TacGia] VALUES (229, N'Dr. Prashant Kakode', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso.', N'123456789')
INSERT [dbo].[TacGia] VALUES (230, N'John Blofeld', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (231, N'Nguyễn Bá Tiến', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (232, N'Vô Úy', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (233, N'Quang Hiển', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (234, N'Tường Thụy', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (235, N'Huyền Cơ', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (236, N'Phương Thảo', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (237, N'Tony Buzan', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso.', N'123456789')
INSERT [dbo].[TacGia] VALUES (238, N'Dale Carnegie ', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (239, N'Stephen P. Robbins .Timothy A. Judge', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (240, N'Vương Chí Cương', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (241, N'James Chen. Lê Đạt Chí', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (242, N'Th.S Nguyễn Công Minh', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (243, N'TS. Phạm Thế Quế', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (244, N'Phạm Quang Hiển', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (245, N'Phạm Hữu Khang', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (246, N'Laurence J. Brahm', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (247, N'Nguyễn Tường Bách', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso,', N'123456789')
INSERT [dbo].[TacGia] VALUES (248, N'Thích Nguyên Tạng', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso,', N'123456789')
INSERT [dbo].[TacGia] VALUES (249, N'Thanh Tâm', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso,', N'123456789')
INSERT [dbo].[TacGia] VALUES (250, N'Trần Hà', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso,', N'123456789')
INSERT [dbo].[TacGia] VALUES (251, N'Phan Lê Nhật Hý', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso,', N'123456789')
INSERT [dbo].[TacGia] VALUES (252, N'Quang Huy', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
INSERT [dbo].[TacGia] VALUES (253, N'Geshe Kelsang Gyatso', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso,', N'123456789')
INSERT [dbo].[TacGia] VALUES (254, N'Nguyễn Minh Tiến', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso,', N'123456789')
INSERT [dbo].[TacGia] VALUES (255, N'Ngọc Cầm', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'Tenzin Gyatso', N'123456789')
GO

INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (1, 233, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (1, 234, N'Tác giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (2, 251, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (3, 250, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (4, 238, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (5, 231, N'Chủ biên', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (5, 250, N'Tác giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (6, 226, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (7, 227, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (7, 249, N'Tác giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (7, 252, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (8, 249, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (9, 210, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (9, 211, N'Tác giả', N'3')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (9, 234, N'Tác giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (10, 210, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (10, 211, N'Tác giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (10, 234, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (11, 204, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (11, 232, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (12, 212, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (12, 213, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (13, 206, N'Tác giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (13, 230, N'Dịch giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (14, 206, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (14, 214, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (15, 237, N'Dịch giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (16, 216, N'Chủ biên', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (17, 217, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (18, 218, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (18, 219, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (19, 225, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (20, 215, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (20, 239, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (21, 222, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (22, 223, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (23, 224, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (24, 240, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (25, 241, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (26, 225, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (27, 225, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (28, 242, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (29, 243, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (30, 244, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (31, 249, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (31, 252, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (32, 227, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (32, 249, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (32, 252, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (33, 227, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (33, 249, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (33, 252, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (34, 227, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (34, 249, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (34, 252, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (35, 227, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (35, 249, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (35, 252, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (36, 236, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (37, 226, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (38, 245, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (39, 210, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (39, 234, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (40, 226, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (41, 226, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (42, 246, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (43, 201, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (44, 207, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (45, 246, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (46, 205, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (46, 221, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (47, 220, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (47, 221, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (48, 229, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (49, 235, N'Dịch giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (49, 236, N'Tác giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (50, 201, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (51, 201, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (51, 248, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (52, 208, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (52, 247, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (53, 201, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (53, 228, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (54, 202, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (55, 202, N'Tác giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (56, 202, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (56, 203, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (57, 203, N'Tác giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (58, 203, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (59, 203, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (60, 203, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (61, 209, N'Dịch giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (61, 253, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (62, 209, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (62, 253, N'Tác giả', N'1')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (63, 201, N'Tác giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (63, 235, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (63, 254, N'Dịch giả', N'2')
INSERT [dbo].[ThamGia] ([MaSach], [MaTacGia], [VaiTro], [ViTri]) VALUES (63, 255, N'Tác giả', N'2')
GO
-- test table
SELECT * FROM dbo.ChuDe
SELECT * FROM dbo.ChiTietDonHang
SELECT * FROM dbo.DonHang
SELECT * FROM dbo.KhachHang
SELECT * FROM dbo.NhaXuatBan
SELECT * FROM dbo.Sach
SELECT * FROM dbo.TacGia
SELECT * FROM dbo.ThamGia

SELECT * FROM dbo.Permission
SELECT * FROM dbo.UserGroup

SELECT *FROM dbo.Permission
 INNER JOIN dbo.Role ON Role.id = Permission.idRole 
 INNER JOIN dbo.UserGroup ON UserGroup.id = Permission.idUser
WHERE dbo.UserGroup.id='ADMIN'
GO

-- text insert admin
INSERT [dbo].[KhachHang]  VALUES ( N'Nguyễn Nam Long', '1992-02-01', N'Nam', '0961023696', 'kh1', N'1', 'user1@gmail.com', N'Tây Hồ, Hà Nội','ADMIN')
INSERT [dbo].[KhachHang]  VALUES ( N'Nguyễn Nam Long', '1992-02-01', N'Nam', '0961023696', 'kh6', N'1', 'user1@gmail.com', N'Tây Hồ, Hà Nội','MEMBER')

-- test bảng

SELECT * FROM	dbo.Sach
 INNER JOIN dbo.ThamGia ON ThamGia.MaSach = Sach.MaSach
 INNER JOIN dbo.TacGia ON	TacGia.MaTacGia = ThamGia.MaTacGia
 WHERE TacGia.MaTacGia= 233 AND 
 Sach.GiaBan >= 30000 AND 
 Sach.GiaBan <= 300000 AND
 dbo.Sach.MaChuDe = 2

 go
 SELECT * FROM dbo.TacGia
 SELECT * FROM dbo.Sach WHERE TenSach LIKE N'%phật giáo%'
SELECT * FROM dbo.TacGia WHERE TenTacGia LIKE N'minh đức'
SELECT * FROM dbo.ThamGia WHERE MaTacGia=221
SELECT * FROM dbo.ChuDe WHERE TenChuDe LIKE N'%công nghệ%'
SELECT * FROM dbo.Sach WHERE MaChuDe= 501
SELECT * FROM dbo.DonHang
SELECT * FROM dbo.KhachHang
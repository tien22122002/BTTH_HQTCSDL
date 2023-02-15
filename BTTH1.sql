
CREATE DATABASE Sales

USE Sales
-- 1. Kiểu dữ liệu tự định nghĩa
Exec sp_addtype 'Mota', 'nvarchar(40)', 'null'
Exec sp_addtype 'IDKH', 'char(10)', 'Not null'
Exec sp_addtype 'DT', 'char(12)', 'null'


-- 2. Tạo table
CREATE TABLE SanPham (
MaSP CHAR(6) NOT NULL,
TenSP VARCHAR(20),
NgayNhap Date,
DVT CHAR(10),
SoLuongTon INT,
DonGiaNhap money,
)
CREATE TABLE HoaDon (
MaHD CHAR(10) NOT NULL,
NgayLap Date,
NgayGiao Date,
MaKH IDKH,
DienGiai Mota,
)
CREATE TABLE KhachHang (
MaKH IDKH,
TenKH NVARCHAR(30),
DiaCHi NVARCHAR(40),
DienThoai DT,
)
CREATE TABLE ChiTietHD (
MaHD CHAR(10) NOT NULL,
MaSP CHAR(6) NOT NULL,
SoLuong INT
)

-- 3. Trong Table HoaDon, sửa cột DienGiai thành nvarchar(100).
ALTER TABLE HoaDon
ALTER COLUMN DienGiai NVARCHAR(100)
-- 4. Thêm vào bảng SanPham cột TyLeHoaHong float
ALTER TABLE SanPham
ADD TyLeHoaHong float
-- 5. Xóa cột NgayNhap trong bảng SanPham
ALTER TABLE SanPham
DROP COLUMN NgayNhap
-- 6. Tạo các ràng buộc khóa chính và khóa ngoại
ALTER TABLE SanPham
add CONSTRAINT sanpham_pk PRIMARY KEY (Masp)

ALTER TABLE KhachHang
add CONSTRAINT khachhang_pk PRIMARY KEY (MaKH)

ALTER TABLE HoaDon
ADD CONSTRAINT pk_hd primary key(MaHD)

ALTER TABLE HoaDon
ADD CONSTRAINT fk_khachhang_hoadon FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH)

ALTER TABLE ChiTietHD
ADD CONSTRAINT fk_hoadon_chitiethd FOREIGN KEY(MaHD) REFERENCES HoaDon(MaHD)

ALTER TABLE ChiTietHD
ADD CONSTRAINT fk_sanpham_chitiethd FOREIGN KEY(MaSP) REFERENCES SanPham(MaSP)
----- 7.Thêm vào bảng HoaDon các ràng buộc
ALTER TABLE HoaDon
ADD CHECK (NgayGiao > NgayLap)

ALTER TABLE HoaDon
ADD CHECK (MaHD like '[A-Z][A-Z][0-9][0-9][0-9][0-9]')

ALTER TABLE HoaDon

ADD CONSTRAINT df_ngaylap DEFAULT GETDATE() FOR NgayLap
-----8. Thêm vào bảng Sản phẩm các ràng buộc
ALTER TABLE SanPham
ADD CHECK (SoLuongTon > 0 and SoLuongTon < 50)

ALTER TABLE SanPham
ADD CHECK (DonGiaNhap > 0)

ALTER TABLE SanPham
ADD CONSTRAINT df_ngaynhap DEFAULT GETDATE() FOR NgayNhap

ALTER TABLE SanPham
ADD CHECK (DVT like 'KG''Thùng''Hộp''Cái')
-- 9. Dùng lệnh T-SQL nhập dữ liệu vào 4 table trên, dữ liệu tùy ý, chú ý các ràng buộc của mỗi TableINSERT INTO SanPham
VALUES ('sp01', 'ip14promax', 'đồng', 10, 25000000,0.5),
		('sp02', 'ip15promax', 'đồng', 12, 30000000,0.5),
		('sp03', 'ip16promax', 'đồng', 150, 35000000,0.5),
		('sp04', 'ip17promax', 'đồng', 20, 40000000,0.5),
		('sp05', 'ip18promax', 'đồng', 25, 45000000,0.5);
insert into KhachHang
values ('kh01', 'Thảo Quyên', 'Campuchia', 01232145633),
		('kh02', 'Hồng Phước', 'HCM', 01232567891),
		('kh03', 'Minh Hiền', 'HaNoi', 01233456782),
		('kh04', 'Văn Tú', 'Can Tho', 01234567890);
insert into HoaDon
values  ('hd01', '2023/2/15','2023/2/30','kh01','hihi'),
		('hd02', '2023/3/15','2023/3/30','kh02','haha'),
		('hd03', '2023/4/15','2023/4/30','kh03','hehe'),
		('hd04', '2023/5/15','2023/5/30','kh04','hoho');
insert into ChiTietHD
values ('hd01','sp01', 10),
		('hd02','sp02', 10),
		('hd03','sp03', 10),
		('hd04','sp04', 10);
--10.Xóa 1 hóa đơn bất kỳ trong bảng HoaDon. Có xóa được không? Tại sao? Nếu vẫn muốn xóa thì phải dùng cách nào?

--11.Nhập 2 bản ghi mới vào bảng ChiTietHD với MaHD = ‘HD999999999’ và MaHD=’1234567890’. Có nhập được không? Tại sao? 
-- trả lời: không nhập được vì kiểu dữ liệu của MaHD là char(6) nên tối đa chỉ có 6 ký tự thôi

-- 12. 
ALTER DATABASE Sales MODIFY NAME = BanHang;
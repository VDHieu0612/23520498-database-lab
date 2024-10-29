CREATE DATABASE QLYKHACHHANG

USE QLYKHACHHANG

CREATE TABLE KHACHHANG(
MAKH char(4) NOT NULL CONSTRAINT PK_KH PRIMARY KEY,
HOTEN varchar(40),
DCHI varchar(50),
SODT varchar(20),
NGSINH smalldatetime,
NGDK smalldatetime,
DOANHSO money,
)

CREATE TABLE NHANVIEN(
MANV char(4) NOT NULL CONSTRAINT PK_NV PRIMARY KEY,
HOTEN varchar(40),
SODT varchar(20),
NGVL smalldatetime,
)

CREATE TABLE SANPHAM(
MASP char(4) NOT NULL CONSTRAINT PK_SP PRIMARY KEY,
TENSP varchar(40),
DVT varchar(20),
NUOCSX varchar(40),
GIA money,
)

CREATE TABLE HOADON(
SOHD int NOT NULL CONSTRAINT PK_HD PRIMARY KEY,
NGHD smalldatetime,
MAKH char(4) CONSTRAINT FK_HD_KH FOREIGN KEY REFERENCES KHACHHANG(MAKH),
MANV char(4) CONSTRAINT FK_HD_NV FOREIGN KEY REFERENCES NHANVIEN(MANV),
TRIGIA money,
)

CREATE TABLE CTHD(
SOHD int CONSTRAINT FK_CTHD_HD FOREIGN KEY REFERENCES HOADON(SOHD),
MASP char(4) CONSTRAINT FK_CTHD_SP FOREIGN KEY REFERENCES SANPHAM(MASP),
SL int,
CONSTRAINT PK_CTHD PRIMARY KEY (SOHD,MASP)
)

/*2. Them vao tt GHICHU co kieu du lieu varchar(20) cho quan ha SANPHAM.*/
ALTER TABLE SANPHAM
ADD GHICHU varchar(20)

/*3. Them vao thuoc tinh LOAIKH co kieu du lieu la tinyint cho quan he KHACHHANG.*/ALTER TABLE KHACHHANGADD LOAIKH tinyint/*4. Sua kieu du lieu cua thuoc tinh GHICHU trong quan he SANPHAM thanh varchar(100).*/ALTER TABLE SANPHAMALTER COLUMN GHICHU varchar(100)/*5. Xoa thuoc tinh GHICHU trong quan he SANPHAM.*/ALTER TABLE SANPHAMDROP COLUMN GHICHU/*6. Lam sao de thuoc tinh LOAIKH trong quan he KHACHHANG co the luu cac gia tri la: “Vang lai”, “Thuong xuyen”, “Vip”…*/ALTER TABLE KHACHHANGALTER COLUMN LOAIKH varchar(20)ALTER TABLE KHACHHANGADD CONSTRAINT LOAI_KH CHECK (LOAIKH in ('Vang lai','Thuong xuyen','Vip')) /*7. Don vi tinh cua san pham chi co the la (“cay”,”hop”,”cai”,”quyen”,”chuc”)*/ALTER TABLE SANPHAMADD CONSTRAINT LOAI_DVT CHECK (DVT in ('cay','hop','cai','quyen','chuc'))/*8. Gia ban cua san pham tu 500 dong tro len.*/ALTER TABLE SANPHAMADD CONSTRAINT GIA_SP CHECK (GIA >= 500)/*9. Moi lan mua hang, khach hang phai mua it nhat 1 san pham*/ALTER TABLE CTHDADD CONSTRAINT SL_MUA CHECK (SL >= 1)/*10. Ngay khach hang dang ky la khach hang thanh vien phai lon hon ngay sinh cua nguoi do.*/ALTER TABLE KHACHHANGADD CONSTRAINT NGSINH_NGDK CHECK (NGDK > NGSINH)

/*BUOI 1*/
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

/*3. Them vao thuoc tinh LOAIKH co kieu du lieu la tinyint cho quan he KHACHHANG.*/
ALTER TABLE KHACHHANG
ADD LOAIKH tinyint

/*4. Sua kieu du lieu cua thuoc tinh GHICHU trong quan he SANPHAM thanh varchar(100).*/
ALTER TABLE SANPHAM
ALTER COLUMN GHICHU varchar(100)

/*5. Xoa thuoc tinh GHICHU trong quan he SANPHAM.*/
ALTER TABLE SANPHAM
DROP COLUMN GHICHU

/*6. Lam sao de thuoc tinh LOAIKH trong quan he KHACHHANG co the luu cac gia tri la: “Vang lai”, “Thuong xuyen”, “Vip”…*/
ALTER TABLE KHACHHANG
ALTER COLUMN LOAIKH varchar(20)
ALTER TABLE KHACHHANG
ADD CONSTRAINT LOAI_KH CHECK (LOAIKH in ('Vang lai','Thuong xuyen','Vip')) 

/*7. Don vi tinh cua san pham chi co the la (“cay”,”hop”,”cai”,”quyen”,”chuc”)*/
ALTER TABLE SANPHAM
ADD CONSTRAINT LOAI_DVT CHECK (DVT in ('cay','hop','cai','quyen','chuc'))

/*8. Gia ban cua san pham tu 500 dong tro len.*/
ALTER TABLE SANPHAM
ADD CONSTRAINT GIA_SP CHECK (GIA >= 500)

/*9. Moi lan mua hang, khach hang phai mua it nhat 1 san pham*/
ALTER TABLE CTHD
ADD CONSTRAINT SL_MUA CHECK (SL >= 1)

/*10. Ngay khach hang dang ky la khach hang thanh vien phai lon hon ngay sinh cua nguoi do.*/
ALTER TABLE KHACHHANG
ADD CONSTRAINT NGSINH_NGDK CHECK (NGDK > NGSINH)

----------------------------------------------------------------------------------------------------------------
/*BUOI 2*/
set dateformat dmy

INSERT INTO NHANVIEN(MANV, HOTEN, SODT, NGVL)
VALUES 
    ('NV01', N'Nguyen Nhu Nhut', '0927345678', '13-04-2006'),
    ('NV02', N'Le Thi Phi Yen', '0987567390', '21-04-2006'),
    ('NV03', N'Nguyen Van B', '0997047382', '27-04-2006'),
    ('NV04', N'Ngo Thanh Tuan', '0913758498', '24-06-2006'),
    ('NV05', N'Nguyen Thi Truc Thanh', '0918590387', '20-07-2006');

INSERT INTO KHACHHANG(MAKH, HOTEN, DCHI, SODT, NGSINH, DOANHSO, NGDK)
VALUES 
    ('KH01', N'Nguyen Van A', N'731 Tran Hung Dao, Q5, TpHCM', '08823451', '22-10-1960', 13060000, '22-07-2006'),
    ('KH02', N'Tran Ngoc Han', N'23/5 Nguyen Trai, Q5, TpHCM', '0908256478', '03-04-1974', 280000, '30-07-2006'),
    ('KH03', N'Tran Ngoc Linh', N'45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', '12-06-1980', 3860000, '05-08-2006'),
    ('KH04', N'Tran Minh Long', N'50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', '09-03-1965', 250000, '02-10-2006'),
    ('KH05', N'Le Nhat Minh', N'34 Truong Dinh, Q3, TpHCM', '08246108', '10-03-1950', 21000, '28-10-2006'),
    ('KH06', N'Le Hoai Thuong', N'227 Nguyen Van Cu, Q5, TpHCM', '08631738', '31-12-1981', 915000, '24-11-2006'),
    ('KH07', N'Nguyen Van Tam', N'32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '06-04-1971', 12500, '01-12-2006'),
    ('KH08', N'Phan Thi Thanh', N'45/2 An Duong Vuong, Q5, TpHCM', '0938435756', '10-01-1971', 365000, '13-12-2006'),
    ('KH09', N'Le Ha Vinh', N'873 Le Hong Phong, Q5, TpHCM', '08654763', '03-09-1979', 70000, '14-01-2007'),
    ('KH10', N'Ha Duy Lap', N'34/34B Nguyen Trai, Q1, TpHCM', '08768904', '02-05-1983', 67500, '16-01-2007');

INSERT INTO SANPHAM(MASP, TENSP, DVT, NUOCSX, GIA)
VALUES 
    ('BC01', N'But chi', N'cay', N'Singapore', 3000),
    ('BC02', N'But chi', N'cay', N'Singapore', 5000),
    ('BC03', N'But chi', N'cay', N'Viet Nam', 3500),
    ('BC04', N'But hop', N'cay', N'Viet Nam', 30000),
    ('BB01', N'But bi', N'cay', N'Viet Nam', 5000),
    ('BB02', N'But bi', N'cay', N'Trung Quoc', 7000),
    ('BB03', N'But bi', N'hop', N'Thai Lan', 100000),
    ('TV01', N'Tap 100 giay mong', N'quyen', N'Trung Quoc', 2500),
    ('TV02', N'Tap 200 giay mong', N'quyen', N'Trung Quoc', 4500),
    ('TV03', N'Tap 100 giay tot', N'quyen', N'Viet Nam', 3000),
    ('TV04', N'Tap 200 giay tot', N'quyen', N'Viet Nam', 5500),
    ('TV05', N'Tap 100 trang', N'chuc', N'Viet Nam', 23000),
    ('TV06', N'Tap 200 trang', N'chuc', N'Viet Nam', 53000),
    ('TV07', N'Tap 100 trang', N'chuc', N'Trung Quoc', 34000),
    ('ST01', N'So tay 500 trang', N'quyen', N'Trung Quoc', 40000),
    ('ST02', N'So tay loai 1', N'quyen', N'Viet Nam', 55000),
    ('ST03', N'So tay loai 2', N'quyen', N'Viet Nam', 51000),
    ('ST04', N'So tay', N'quyen', N'Thai Lan', 55000),
    ('ST05', N'So tay mong', N'quyen', N'Thai Lan', 20000),
    ('ST06', N'Phan viet bang', N'hop', N'Viet Nam', 5000),
    ('ST07', N'Phan khong bui', N'hop', N'Viet Nam', 7000),
    ('ST08', N'Bong bang', N'cai', N'Viet Nam', 1000),
    ('ST09', N'But long', N'cay', N'Viet Nam', 5000),
    ('ST10', N'But long', N'cay', N'Trung Quoc', 7000);

SET DATEFORMAT dmy;

INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)
VALUES 
    (1001, '23-07-2006', 'KH01', 'NV01', 320000),
    (1002, '12-08-2006', 'KH01', 'NV02', 840000),
    (1003, '23-08-2006', 'KH02', 'NV01', 100000),
    (1004, '01-09-2006', 'KH02', 'NV01', 180000),
    (1005, '20-10-2006', 'KH01', 'NV02', 3800000),
    (1006, '16-10-2006', 'KH01', 'NV03', 2430000),
    (1007, '28-10-2006', 'KH03', 'NV03', 510000),
    (1008, '28-10-2006', 'KH01', 'NV03', 440000),
    (1009, '28-10-2006', 'KH03', 'NV04', 200000),
    (1010, '01-11-2006', 'KH01', 'NV01', 5200000),
    (1011, '04-11-2006', 'KH04', 'NV03', 250000),
    (1012, '30-11-2006', 'KH05', 'NV03', 21000),
    (1013, '12-12-2006', 'KH06', 'NV01', 5000),
    (1014, '31-12-2006', 'KH03', 'NV02', 3150000),
    (1015, '01-01-2007', 'KH06', 'NV01', 910000),
    (1016, '01-01-2007', 'KH07', 'NV02', 12500),
    (1017, '02-01-2007', 'KH08', 'NV03', 35000),
    (1018, '13-01-2007', 'KH08', 'NV03', 330000),
    (1019, '13-01-2007', 'KH01', 'NV03', 30000),
    (1020, '14-01-2007', 'KH09', 'NV04', 70000),
    (1021, '16-01-2007', 'KH10', 'NV03', 67500),
    (1022, '16-01-2007', NULL, 'NV03', 7000),
    (1023, '17-01-2007', NULL, 'NV01', 330000);

INSERT INTO CTHD (SOHD, MASP, SL)
VALUES 
    (1001, 'TV02', 10),
    (1001, 'ST01', 5),
    (1001, 'BC01', 5),
    (1001, 'BC02', 10),
    (1001, 'ST08', 10),
    (1002, 'BC04', 20),
    (1002, 'BB01', 20),
    (1002, 'BB02', 20),
    (1003, 'BB03', 10),
    (1004, 'TV01', 20),
    (1004, 'TV02', 10),
    (1004, 'TV03', 10),
    (1004, 'TV04', 10),
    (1005, 'TV05', 50),
    (1005, 'TV06', 50),
    (1006, 'TV07', 20),
    (1006, 'ST01', 30),
    (1006, 'ST02', 10),
    (1007, 'ST03', 10),
    (1008, 'ST04', 8),
    (1009, 'ST05', 10),
    (1010, 'TV07', 50),
    (1010, 'ST07', 50),
    (1010, 'ST08', 100),
    (1010, 'ST04', 50),
    (1010, 'TV03', 100),
    (1011, 'ST06', 50),
    (1012, 'ST07', 3),
    (1013, 'ST08', 5),
    (1014, 'BC02', 80),
    (1014, 'BB02', 100),
    (1014, 'BC04', 60),
    (1014, 'BB01', 50),
    (1015, 'BB02', 30),
    (1015, 'BB03', 7),
    (1016, 'TV01', 5),
    (1017, 'TV02', 1),
    (1017, 'TV03', 1),
    (1017, 'TV04', 5),
    (1018, 'ST04', 6),
    (1019, 'ST05', 1),
    (1019, 'ST06', 2),
    (1020, 'ST07', 10),
    (1021, 'ST08', 5),
    (1021, 'TV01', 7),
    (1021, 'TV02', 10),
    (1022, 'ST07', 1),
    (1023, 'ST04', 6);

/*2. Tao quan he SANPHAM1 chua toan bo du lieu cua quan he SANPHAM. Tao quan he KHACHHANG1 chua toan bo du lieu cua quan he KHACHHANG.*/
SELECT * INTO SANPHAM1 FROM SANPHAM
SELECT * INTO KHACHHANG1 FROM KHACHHANG

/*3. Cap nhat gia tang 5% doi voi nhung san pham do "Thai Lan" san xuat (cho quan he SANPHAM1)*/
UPDATE SANPHAM1
SET GIA = GIA * 1.05
WHERE NUOCSX = 'Thai Lan'

/*4. Cap nhat gia giam 5% doi voi nhung san pham do "Trung Quoc" san xuat co gia tu 10.000 tro xuong (cho quan he SANPHAM1).*/
UPDATE SANPHAM1
SET GIA	= GIA * 0.95
WHERE NUOCSX = 'Trung Quoc' AND GIA <= 10000
/*5. Cap nhat gia tri LOAIKH la "Vip" doi voi nhung khach hang dang ky thanh vien truoc ngay 1/1/2007 co doanh so tu 10.000.000 tro len hoac khach hang dang ky thanh vien tu 1/1/2007 tro ve sau co doanh so tu 2.000.000 tro len (cho quan he KHACHHANG1).*/
UPDATE KHACHHANG1
SET LOAIKH = 'Vip'
WHERE (NGDK < '1/1/2007' AND DOANHSO >= 10000000) OR (NGDK >= '1/1/2007' AND DOANHSO >= 2000000)

/*1. In ra danh sach cac san pham (MASP, TENSP) do "Trung Quoc" san xuat.*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'

/*2. In ra danh sach cac san pham (MASP, TENSP) co don vi tinh la "cay", "quyen".*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE DVT = 'cay' OR DVT = 'quyen'

/*3. In ra danh sach cac san pham (MASP, TENSP) co ma san pham bat dau la "B" va ket thuc la "01".*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE 'B%' AND MASP LIKE '%01'

/*4. In ra danh sach cac san pham (MASP, TENSP) do "Trung Quoc" san xuat co gia tu 30.000 den 40.000.*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND (GIA BETWEEN 30000 AND 40000)

/*5. In ra danh sach cac san pham (MASP, TENSP) do "Trung Quoc" hoac "Thai Lan" san xuat co gia tu 30.000 den 40.000.*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX IN ('Trung Quoc', 'Thai Lan') AND (GIA BETWEEN 30000 AND 40000)

/*6. In ra cac so hoa don, tri gia hoa don ban ra trong ngay 1/1/2007 va ngay 2/1/2007.*/
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD = '1/1/2007'
UNION
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD = '2/1/2007'

/*7. In ra cac so hoa don, tri gia hoa don trong thang 1/2007, sap xep theo ngay (tang dan) va tri gia cua hoa don (giam dan).*/
SELECT SOHD, TRIGIA
FROM HOADON
WHERE MONTH(NGHD) = 1 AND YEAR(NGHD) = 2007
ORDER BY NGHD ASC, TRIGIA DESC

/*8. In ra danh sach cac khach hang (MAKH, HOTEN) da mua hang trong ngay 1/1/2007.*/
SELECT KHACHHANG.MAKH, HOTEN
FROM KHACHHANG INNER JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
WHERE NGHD = '1/1/2007'

/*9. In ra so hoa don, tri gia cac hoa don do nhan vien co ten "Nguyen Van B" lap trong ngay 28/10/2006.*/
SELECT SOHD, TRIGIA
FROM NHANVIEN INNER JOIN HOADON ON NHANVIEN.MANV = HOADON.MANV
WHERE NHANVIEN.HOTEN = 'Nguyen Van B' AND NGHD = '28/10/2006'

/*10. In ra danh sach cac san pham (MASP, TENSP) duoc khach hang co ten "Nguyen Van A" mua trong thang 10/2006.*/
SELECT SANPHAM.MASP, TENSP
FROM KHACHHANG
	INNER JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
	INNER JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
	INNER JOIN SANPHAM ON CTHD.MASP = SANPHAM.MASP
WHERE HOTEN = 'Nguyen Van A' AND MONTH(NGHD) = 10 AND YEAR(NGHD) = 2006

/*11. Tim cac so hoa don da mua san pham co ma so "BB01" hoac "BB02".*/
SELECT SOHD
FROM CTHD
WHERE MASP = 'BB01' OR MASP = 'BB02'

-------------------------------------------------------------------------------------------------------------------------
/*BUOI 3*/

/*12. Tim cac so hoa don da mua san pham co ma so “BB01” hoac “BB02”, moi san pham mua voi so luong tu 10 den 20.*/
SELECT SOHD 
FROM CTHD
WHERE MASP = 'BB01' AND SL BETWEEN 10 AND 20
UNION
SELECT SOHD
FROM CTHD
WHERE MASP = 'BB02' AND SL BETWEEN 10 AND 20

/*13. Tim cac so hoa don mua cung luc 2 san pham co ma so “BB01” va “BB02”, moi san pham mua voi so luong tu 10 den 20.*/
SELECT SOHD 
FROM CTHD
WHERE MASP = 'BB01' AND SL BETWEEN 10 AND 20
INTERSECT
SELECT SOHD
FROM CTHD
WHERE MASP = 'BB02' AND SL BETWEEN 10 AND 20

/*14. In ra danh sach cac san pham (MASP, TENSP) do “Trung Quoc” san xuat hoac cac san pham duoc ban ra trong ngay 1/1/2007.*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
UNION
SELECT CTHD.MASP, TENSP
FROM CTHD
	INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
	INNER JOIN SANPHAM ON CTHD.MASP = SANPHAM.MASP
WHERE NGHD = '1/1/2007'

/*15. In ra danh sach cac san pham (MASP, TENSP) khong ban duoc.*/
SELECT MASP, TENSP
FROM SANPHAM
EXCEPT
SELECT CTHD.MASP, TENSP
FROM CTHD
	INNER JOIN SANPHAM ON CTHD.MASP = SANPHAM.MASP

/*16. In ra danh sach cac san pham (MASP, TENSP) khong ban duoc trong nam 2006.*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP NOT IN (SELECT MASP
				   FROM CTHD 
						INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
				   WHERE YEAR(NGHD) = 2006)

/*17. In ra danh sach cac san pham (MASP, TENSP) do “Trung Quoc” san xuat khong ban duoc trong nam 2006.*/
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND MASP NOT IN (SELECT MASP
											 FROM CTHD 
										          INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
											 WHERE YEAR(NGHD) = 2006)

/*18. Tim so hoa don trong nam 2006 da mua it nhat tat ca cac san pham do Singapore san xuat.*/
SELECT SOHD
FROM HOADON
WHERE YEAR(NGHD) = 2006 AND NOT EXISTS (SELECT *
										FROM SANPHAM
										WHERE NUOCSX = 'Singapore' AND NOT EXISTS (SELECT *
																				   FROM CTHD
																				   WHERE SANPHAM.MASP = CTHD.MASP AND CTHD.SOHD = HOADON.SOHD))

--------------------------------------------------------------------------------------------------------------------------------------------------------
/*BUOI 3.2*/

-- 1. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20, và tổng trị giá hóa đơn lớn hơn 500.000.
SELECT DISTINCT HD.SOHD
FROM HOADON HD
	 INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
WHERE CT.MASP IN ('BB01', 'BB02')
  AND CT.SL BETWEEN 10 AND 20
  AND HD.TRIGIA > 500000

-- 2. Tìm các số hóa đơn mua cùng lúc 3 sản phẩm có mã số “BB01”, “BB02” và “BB03”, mỗi sản phẩm mua với số lượng từ 10 đến 20, và ngày mua hàng trong năm 2023.
SELECT HD.SOHD
FROM HOADON HD
	 INNER JOIN CTHD CT1 ON HD.SOHD = CT1.SOHD AND CT1.MASP = 'BB01' AND CT1.SL BETWEEN 10 AND 20
	 INNER JOIN CTHD CT2 ON HD.SOHD = CT2.SOHD AND CT2.MASP = 'BB02' AND CT2.SL BETWEEN 10 AND 20
	 INNER JOIN CTHD CT3 ON HD.SOHD = CT3.SOHD AND CT3.MASP = 'BB03' AND CT3.SL BETWEEN 10 AND 20
WHERE YEAR(HD.NGHD) = 2023

-- 3. Tìm các khách hàng đã mua ít nhất một sản phẩm có mã số “BB01” với số lượng từ 10 đến 20, và tổng trị giá tất cả các hóa đơn của họ lớn hơn hoặc bằng 1 triệu đồng.
SELECT DISTINCT KH.MAKH, KH.HOTEN
FROM KHACHHANG KH
	 INNER JOIN HOADON HD ON KH.MAKH = HD.MAKH
	 INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
WHERE CT.MASP = 'BB01' AND CT.SL BETWEEN 10 AND 20
GROUP BY KH.MAKH, KH.HOTEN
HAVING SUM(HD.TRIGIA) >= 1000000

-- 4. Tìm các nhân viên bán hàng đã thực hiện giao dịch bán ít nhất một sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm bán với số lượng từ 15 trở lên, và tổng trị giá của tất cả các hóa đơn mà nhân viên đó xử lý lớn hơn hoặc bằng 2 triệu đồng.
SELECT DISTINCT NV.MANV, NV.HOTEN
FROM NHANVIEN NV
	 INNER JOIN HOADON HD ON NV.MANV = HD.MANV
	 INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
WHERE CT.MASP IN ('BB01', 'BB02') AND CT.SL >= 15
GROUP BY NV.MANV, NV.HOTEN
HAVING SUM(HD.TRIGIA) >= 2000000

-- 5. Tìm các khách hàng đã mua ít nhất hai loại sản phẩm khác nhau với tổng số lượng từ tất cả các hóa đơn của họ lớn hơn hoặc bằng 50 và tổng trị giá của họ lớn hơn hoặc bằng 5 triệu đồng.
SELECT KH.MAKH, KH.HOTEN
FROM KHACHHANG KH
	 INNER JOIN HOADON HD ON KH.MAKH = HD.MAKH
	 INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
GROUP BY KH.MAKH, KH.HOTEN
HAVING COUNT(DISTINCT CT.MASP) >= 2
   AND SUM(CT.SL) >= 50
   AND SUM(HD.TRIGIA) >= 5000000

-- 6. Tìm những khách hàng đã mua cùng lúc ít nhất ba sản phẩm khác nhau trong cùng một hóa đơn và mỗi sản phẩm đều có số lượng từ 5 trở lên.
SELECT HD.SOHD, KH.MAKH, KH.HOTEN
FROM HOADON HD
	 INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
	 INNER JOIN KHACHHANG KH ON HD.MAKH = KH.MAKH
WHERE CT.SL >= 5
GROUP BY HD.SOHD, KH.MAKH, KH.HOTEN
HAVING COUNT(DISTINCT CT.MASP) >= 3

-- 7. Tìm các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất và đã được bán ra ít nhất 5 lần trong năm 2007.
SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP
	 INNER JOIN CTHD CT ON SP.MASP = CT.MASP
	 INNER JOIN HOADON HD ON CT.SOHD = HD.SOHD
WHERE SP.NUOCSX = 'Trung Quoc' AND YEAR(HD.NGHD) = 2007
GROUP BY SP.MASP, SP.TENSP
HAVING COUNT(HD.SOHD) >= 5

-- 8. Tìm các khách hàng đã mua ít nhất một sản phẩm do “Singapore” sản xuất trong năm 2006 và tổng trị giá hóa đơn của họ trong năm đó lớn hơn 1 triệu đồng.
SELECT DISTINCT KH.MAKH, KH.HOTEN
FROM KHACHHANG KH
	 INNER JOIN HOADON HD ON KH.MAKH = HD.MAKH
	 INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
	 INNER JOIN SANPHAM SP ON CT.MASP = SP.MASP
WHERE SP.NUOCSX = 'Singapore' AND YEAR(HD.NGHD) = 2006
GROUP BY KH.MAKH, KH.HOTEN
HAVING SUM(HD.TRIGIA) > 1000000

-- 9. Tìm những nhân viên bán hàng đã thực hiện giao dịch bán nhiều nhất các sản phẩm do “Trung Quoc” sản xuất trong năm 2006.
SELECT NV.MANV, NV.HOTEN, SUM(CT.SL) AS TONG_SOLUONG
FROM NHANVIEN NV
	 INNER JOIN HOADON HD ON NV.MANV = HD.MANV
	 INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
	 INNER JOIN SANPHAM SP ON CT.MASP = SP.MASP
WHERE SP.NUOCSX = 'Trung Quoc' AND YEAR(HD.NGHD) = 2006
GROUP BY NV.MANV, NV.HOTEN
HAVING SUM(CT.SL) = (SELECT TOP 1 SUM(CT.SL)
					 FROM NHANVIEN NV
						  INNER JOIN HOADON HD ON NV.MANV = HD.MANV
						  INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
						  INNER JOIN SANPHAM SP ON CT.MASP = SP.MASP
					 WHERE SP.NUOCSX = 'Trung Quoc' AND YEAR(HD.NGHD) = 2006
					 GROUP BY NV.MANV, NV.HOTEN
					 ORDER BY SUM(CT.SL) DESC)

-- 10. Tìm những khách hàng chưa từng mua bất kỳ sản phẩm nào do “Singapore” sản xuất nhưng đã mua ít nhất một sản phẩm do “Trung Quoc” sản xuất.
SELECT KH.MAKH, KH.HOTEN
FROM KHACHHANG KH
WHERE KH.MAKH IN (
    SELECT DISTINCT HD.MAKH
    FROM HOADON HD
		 INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
		 INNER JOIN SANPHAM SP ON CT.MASP = SP.MASP
    WHERE SP.NUOCSX = 'Trung Quoc'
) AND KH.MAKH NOT IN (
    SELECT DISTINCT HD.MAKH
    FROM HOADON HD
		 INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
		 INNER JOIN SANPHAM SP ON CT.MASP = SP.MASP
    WHERE SP.NUOCSX = 'Singapore'
)

-- 11. Tìm những hóa đơn có chứa tất cả các sản phẩm do “Singapore” sản xuất và trị giá hóa đơn lớn hơn tổng trị giá trung bình của tất cả các hóa đơn trong hệ thống.
SELECT HD.SOHD
FROM HOADON HD
WHERE HD.TRIGIA > (SELECT AVG(TRIGIA) FROM HOADON)
AND NOT EXISTS (
    SELECT *
    FROM SANPHAM SP
    WHERE SP.NUOCSX = 'Singapore'
    AND NOT EXISTS (
        SELECT *
        FROM CTHD CT
        WHERE CT.SOHD = HD.SOHD AND CT.MASP = SP.MASP
    )
)

-- 12. Tìm danh sách các nhân viên có tổng số lượng bán ra của tất cả các loại sản phẩm vượt quá số lượng trung bình của tất cả các nhân viên khác.
SELECT NV.MANV, NV.HOTEN, SUM(CT.SL) AS TONG_SOLUONG
FROM NHANVIEN NV
	 INNER JOIN HOADON HD ON NV.MANV = HD.MANV
	 INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
GROUP BY NV.MANV, NV.HOTEN
HAVING SUM(CT.SL) > (SELECT AVG(TONG_SOLUONG)
					 FROM (SELECT NV.MANV, SUM(CT.SL) AS TONG_SOLUONG
						   FROM NHANVIEN NV
								INNER JOIN HOADON HD ON NV.MANV = HD.MANV
								INNER JOIN CTHD CT ON HD.SOHD = CT.SOHD
						   GROUP BY NV.MANV
						   ) AS TB_SOLUONG      )

-- 13. Tìm danh sách các hóa đơn có chứa ít nhất một sản phẩm từ mỗi nước sản xuất khác nhau có trong hệ thống.
SELECT HD.SOHD
FROM HOADON HD
WHERE NOT EXISTS (
    SELECT SP.NUOCSX
    FROM SANPHAM SP
    GROUP BY SP.NUOCSX
    HAVING NOT EXISTS (
        SELECT CT.MASP
        FROM CTHD CT
			 INNER JOIN SANPHAM SP1 ON CT.MASP = SP1.MASP
        WHERE SP1.NUOCSX = SP.NUOCSX AND CT.SOHD = HD.SOHD
    )
)





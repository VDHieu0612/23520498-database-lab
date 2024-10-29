/*BUOI1*/
CREATE DATABASE QLYGIAOVU

USE QLYGIAOVU

CREATE TABLE KHOA(
MAKHOA varchar(4) NOT NULL CONSTRAINT PK_KHOA PRIMARY KEY,
TENKHOA varchar(40),
NGTLAP smalldatetime,
TRGKHOA char(4),
)

CREATE TABLE MONHOC(
MAMH varchar(10) NOT NULL CONSTRAINT PK_MH PRIMARY KEY,
TENMH varchar(40),
TCLT tinyint,
TCTH tinyint,
MAKHOA varchar(4) CONSTRAINT FK_MH_KH FOREIGN KEY REFERENCES KHOA(MAKHOA)
)

CREATE TABLE DIEUKIEN(
MAMH varchar(10) CONSTRAINT FK_MMH FOREIGN KEY REFERENCES MONHOC(MAMH),
MAMH_TRUOC varchar(10) CONSTRAINT FK_MH_TRUOC FOREIGN KEY REFERENCES MONHOC(MAMH),
CONSTRAINT PK_DK PRIMARY KEY (MAMH,MAMH_TRUOC)
)

CREATE TABLE GIAOVIEN(
MAGV char(4) NOT NULL CONSTRAINT PK_GV PRIMARY KEY,
HOTEN varchar(40),
HOCVI varchar(10),
HOCHAM varchar(10),
GIOITINH varchar(3),
NGSINH smalldatetime,
NGVL smalldatetime,
HESO numeric(4,2),
MUCLUONG money,
MAKHOA varchar(4) CONSTRAINT FK_GV_KH FOREIGN KEY REFERENCES KHOA(MAKHOA)
)

CREATE TABLE LOP(
MALOP char(3) NOT NULL CONSTRAINT PK_LOP PRIMARY KEY,
TENLOP varchar(40),
TRGLOP char(5),
SISO tinyint,
MAGVCN char(4) CONSTRAINT FK_GV_LOP FOREIGN KEY REFERENCES GIAOVIEN(MAGV)
)

CREATE TABLE HOCVIEN(
MAHV char(5) NOT NULL CONSTRAINT PK_HV PRIMARY KEY,
HO varchar(40),
TEN varchar(10),
NGSINH smalldatetime,
GIOITINH varchar(3),
NOISINH varchar(40),
MALOP char(3) CONSTRAINT FK_HV_L FOREIGN KEY REFERENCES LOP(MALOP)
)

CREATE TABLE GIANGDAY(
MALOP char(3) CONSTRAINT FK_GD_L FOREIGN KEY REFERENCES LOP(MALOP),
MAMH varchar(10) CONSTRAINT FK_GD_MH FOREIGN KEY REFERENCES MONHOC(MAMH),
MAGV char(4) CONSTRAINT FK_GV_GD FOREIGN KEY REFERENCES GIAOVIEN(MAGV),
HOCKY tinyint,
NAM smallint,
TUNGAY smalldatetime,
DENNGAY smalldatetime,
CONSTRAINT PK_GD PRIMARY KEY (MALOP,MAMH)
)

CREATE TABLE KETQUATHI(
MAHV char(5) CONSTRAINT FK_KQ_HV FOREIGN KEY REFERENCES HOCVIEN(MAHV),
MAMH varchar(10) CONSTRAINT FK_KQ_MH FOREIGN KEY REFERENCES MONHOC(MAMH),
LANTHI tinyint,
NGTHI smalldatetime,
DIEM numeric(4,2),
KQUA varchar(10),
CONSTRAINT PK_KQ PRIMARY KEY (MAHV,MAMH,LANTHI)
)

ALTER TABLE KHOA
ADD CONSTRAINT FK_TRGK FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV)
ALTER TABLE LOP
ADD CONSTRAINT FK_TRGL FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN(MAHV)


/*3. Thuoc tinh GIOITINH chi có gia tri la “Nam” hoac “Nu”.*/
ALTER TABLE GIAOVIEN
ADD CONSTRAINT GT CHECK (GIOITINH = 'Nam' OR GIOITINH = 'Nu')
ALTER TABLE HOCVIEN
ADD CONSTRAINT GT_HV CHECK (GIOITINH = 'Nam' OR GIOITINH = 'Nu')

/*4. Diem so cua mot lan thi co gia tri tu 0 den 10 va can luu den 2 so le*/
ALTER TABLE KETQUATHI
ADD CONSTRAINT DIEM_C CHECK (DIEM BETWEEN 0 AND 10)

/*5. Ket qua thi la “Dat” neu diem tu 5 den 10 va “Khong dat” neu diem nho hon 5*/
ALTER TABLE KETQUATHI
ADD CONSTRAINT KQT CHECK (KQUA = IIF((DIEM BETWEEN 5 AND 10), 'Dat', 'Khong dat'))

/*6. Hoc vien thi mot mon toi da 3 lan*/
ALTER TABLE KETQUATHI
ADD CONSTRAINT LAN_CHECK CHECK (LANTHI >= 1 AND LANTHI <= 3)

/*7. Hoc ky chi co gia tri tu 1 den 3*/
ALTER TABLE GIANGDAY
ADD CONSTRAINT HK_CHECK CHECK (HOCKY BETWEEN 1 AND 3)

/*8. Hoc vi cua giao vien chi co the la “CN”, “KS”, “Ths”, ”TS”, ”PTS”*/
ALTER TABLE GIAOVIEN
ADD CONSTRAINT HOCVI_CHECK CHECK (HOCVI in ('CN', 'KS', 'Ths', 'TS', 'PTS'))

------------------------------------------------------------------------------------------------
/*BUOI 2*/
ALTER TABLE KHOA
DROP CONSTRAINT FK_TRGK /*Xoa rang buoc khoa ngoai de nhap du lieu*/

set dateformat ymd

INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA)
VALUES 
('KHMT', 'Khoa hoc may tinh', '2005-06-07', 'GV01'),
('HTTT', 'He thong thong tin', '2005-06-07', 'GV02'),
('CNPM', 'Cong nghe phan mem', '2005-06-07', 'GV04'),
('MTT', 'Mang va truyen thong', '2005-10-20', 'GV03'),
('KTMT', 'Ky thuat may tinh', '2005-12-20', NULL);
SELECT * FROM KHOA

INSERT INTO LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN)
VALUES 
('K11', 'Lop 1 khoa 1', 'K1108', 11, 'GV07'),
('K12', 'Lop 2 khoa 1', 'K1205', 12, 'GV09'),
('K13', 'Lop 3 khoa 1', 'K1305', 12, 'GV14');
SELECT * FROM LOP

INSERT INTO GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA)
VALUES 
('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '1950-05-02', '2004-01-11', 5.00, 2250000, 'KHMT'),
('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '1965-12-17', '2004-04-20', 4.50, 2025000, 'HTTT'),
('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '1950-08-01', '2004-09-23', 4.00, 1800000, 'CNPM'),
('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '1961-02-22', '2005-01-12', 4.50, 2025000, 'KTMT'),
('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '1958-03-12', '2005-01-12', 3.00, 1350000, 'HTTT'),
('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '1953-03-11', '2005-01-12', 4.50, 2025000, 'KHMT'),
('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '1971-11-23', '2005-03-01', 4.00, 1800000, 'KHMT'),
('GV08', 'Le Thi Tran', 'KS', NULL, 'Nu', '1974-03-26', '2005-03-01', 1.69, 760500, 'KHMT'),
('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '1966-12-31', '2005-03-01', 4.00, 1800000, 'HTTT'),
('GV10', 'Le Tran Anh Loan', 'KS', NULL, 'Nu', '1972-07-17', '2005-03-01', 1.86, 837000, 'CNPM'),
('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '1980-01-12', '2005-05-15', 2.67, 1201500, 'MTT'),
('GV12', 'Tran Van Anh', 'CN', NULL, 'Nu', '1981-03-29', '2005-05-15', 1.69, 760500, 'CNPM'),
('GV13', 'Nguyen Linh Dan', 'CN', NULL, 'Nu', '1980-05-23', '2005-05-15', 1.69, 760500, 'KTMT'),
('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '1976-11-30', '2005-05-15', 3.00, 1350000, 'MTT'),
('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '1978-05-04', '2005-05-15', 3.00, 1350000, 'KHMT');
SELECT * FROM GIAOVIEN

INSERT INTO MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA)
VALUES 
('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT'),
('CTRR', 'Cau truc roi rac', 5, 2, 'KHMT'),
('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT'),
('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT'),
('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT'),
('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
('HDH', 'He dieu hanh', 4, 1, 'KTMT'),
('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM'),
('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM'),
('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM');
SELECT * FROM MONHOC

INSERT INTO DIEUKIEN (MAMH, MAMH_TRUOC)
VALUES 
('CSDL', 'CTRR'),
('CSDL', 'CTDLGT'),
('CTDLGT', 'THDC'),
('PTTKTT', 'THDC'),
('PTTKTT', 'CTDLGT'),
('DHMT', 'THDC'),
('LTHDT', 'THDC'),
('PTTKHTTT', 'CSDL');
SELECT * FROM DIEUKIEN

INSERT INTO HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP)
VALUES 
('K1101', 'Nguyen Van', 'A', '1986-01-27', 'Nam', 'TpHCM', 'K11'),
('K1102', 'Tran Ngoc', 'Han', '1986-03-14', 'Nu', 'Kien Giang', 'K11'),
('K1103', 'Ha Duy', 'Lap', '1986-04-18', 'Nam', 'Nghe An', 'K11'),
('K1104', 'Tran Ngoc', 'Linh', '1986-03-30', 'Nu', 'Tay Ninh', 'K11'),
('K1105', 'Tran Minh', 'Long', '1986-02-27', 'Nam', 'TpHCM', 'K11'),
('K1106', 'Le Nhat', 'Minh', '1986-01-24', 'Nam', 'TpHCM', 'K11'),
('K1107', 'Nguyen Nhu', 'Nhut', '1986-01-27', 'Nam', 'Ha Noi', 'K11'),
('K1108', 'Nguyen Manh', 'Tam', '1986-02-27', 'Nam', 'Kien Giang', 'K11'),
('K1109', 'Phan Thi', 'Tam', '1986-01-27', 'Nu', 'Vinh Long', 'K11'),
('K1110', 'Le Hoai', 'Thuong', '1986-02-05', 'Nu', 'Can Tho', 'K11'),
('K1111', 'Le Ha', 'Vinh', '1986-12-25', 'Nam', 'Vinh Long', 'K11'),
('K1201', 'Nguyen Van', 'B', '1986-02-11', 'Nam', 'TpHCM', 'K12'),
('K1202', 'Nguyen Thi', 'Duyen', '1986-01-18', 'Nu', 'TpHCM', 'K12'),
('K1203', 'Tran Thi', 'Duyen', '1986-09-17', 'Nu', 'TpHCM', 'K12'),
('K1204', 'Truong My', 'Hanh', '1986-05-19', 'Nu', 'Dong Nai', 'K12'),
('K1205', 'Nguyen Thanh', 'Nam', '1986-04-17', 'Nam', 'TpHCM', 'K12'),
('K1206', 'Nguyen Thi', 'Thanh', '1986-03-04', 'Nu', 'Kien Giang', 'K12'),
('K1207', 'Tran Thi', 'Thuy', '1986-02-08', 'Nu', 'Nghe An', 'K12'),
('K1208', 'Huynh Thi', 'Trieu', '1986-04-08', 'Nu', 'Tay Ninh', 'K12'),
('K1209', 'Pham Thanh', 'Trieu', '1986-02-23', 'Nam', 'TpHCM', 'K12'),
('K1210', 'Ngo Thanh', 'Tuan', '1986-02-14', 'Nam', 'TpHCM', 'K12'),
('K1211', 'Do Thi', 'Xuan', '1986-03-09', 'Nu', 'Ha Noi', 'K12'),
('K1212', 'Le Thi', 'Yen', '1986-03-12', 'Nu', 'TpHCM', 'K12'),
('K1301', 'Nguyen Thi', 'Cuc', '1986-06-09', 'Nu', 'Kien Giang', 'K13'),
('K1302', 'Truong Thi', 'Hien', '1986-03-18', 'Nu', 'Nghe An', 'K13'),
('K1303', 'Le Duc', 'Hien', '1986-03-21', 'Nam', 'Tay Ninh', 'K13'),
('K1304', 'Le Quang', 'Hien', '1986-04-18', 'Nam', 'TpHCM', 'K13'),
('K1305', 'Le Thi', 'Huong', '1986-03-27', 'Nu', 'TpHCM', 'K13'),
('K1306', 'Nguyen Thai', 'Huu', '1986-03-30', 'Nam', 'Ha Noi', 'K13'),
('K1307', 'Tran Minh', 'Man', '1986-05-28', 'Nam', 'TpHCM', 'K13'),
('K1308', 'Nguyen Hieu', 'Nghia', '1986-04-08', 'Nam', 'Kien Giang', 'K13'),
('K1309', 'Nguyen Trung', 'Nghia', '1987-01-18', 'Nam', 'Nghe An', 'K13'),
('K1310', 'Tran Thi', 'Tham', '1986-04-22', 'Nu', 'Tay Ninh', 'K13'),
('K1311', 'Tran Minh', 'Thuc', '1986-04-04', 'Nam', 'TpHCM', 'K13'),
('K1312', 'Nguyen Thi', 'Yen', '1986-09-07', 'Nu', 'TpHCM', 'K13');
SELECT * FROM HOCVIEN

INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY)
VALUES 
('K11', 'THDC', 'GV07', 1, 2006, '2006-01-02', '2006-05-12'),
('K12', 'THDC', 'GV06', 1, 2006, '2006-01-02', '2006-05-12'),
('K13', 'THDC', 'GV15', 1, 2006, '2006-01-02', '2006-05-12'),
('K11', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K12', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K13', 'CTRR', 'GV08', 1, 2006, '2006-01-09', '2006-05-17'),
('K11', 'CSDL', 'GV05', 2, 2006, '2006-06-01', '2006-07-15'),
('K12', 'CSDL', 'GV09', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CTDLGT', 'GV15', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CSDL', 'GV05', 3, 2006, '2006-08-01', '2006-12-15'),
('K13', 'DHMT', 'GV07', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K12', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-02-18'),
('K12', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-03-20'),
('K11', 'DHMT', 'GV07', 1, 2007, '2007-02-18', '2007-03-20');
SELECT * FROM GIANGDAY

INSERT INTO KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA)
VALUES 
('K1101', 'CSDL', 1, '2006-07-20', 10.00, 'Dat'),
('K1101', 'CTDLGT', 1, '2006-12-28', 9.00, 'Dat'),
('K1101', 'THDC', 1, '2006-05-20', 9.00, 'Dat'),
('K1101', 'CTRR', 1, '2006-05-13', 9.50, 'Dat'),
('K1102', 'CSDL', 1, '2006-07-20', 4.00, 'Khong Dat'),
('K1102', 'CSDL', 2, '2006-07-27', 4.25, 'Khong Dat'),
('K1102', 'CSDL', 3, '2006-08-10', 4.50, 'Khong Dat'),
('K1102', 'CTDLGT', 1, '2006-12-28', 4.50, 'Khong Dat'),
('K1102', 'CTDLGT', 2, '2007-01-05', 4.00, 'Khong Dat'),
('K1102', 'CTDLGT', 3, '2007-01-15', 6.00, 'Dat'),
('K1102', 'THDC', 1, '2006-05-20', 5.00, 'Dat'),
('K1102', 'CTRR', 1, '2006-05-13', 7.00, 'Dat'),
('K1103', 'CSDL', 1, '2006-07-20', 3.50, 'Khong Dat'),
('K1103', 'CSDL', 2, '2006-07-27', 8.25, 'Dat'),
('K1103', 'CTDLGT', 1, '2006-12-28', 7.00, 'Dat'),
('K1103', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1103', 'CTRR', 1, '2006-05-13', 6.50, 'Dat'),
('K1104', 'CSDL', 1, '2006-07-20', 3.75, 'Khong Dat'),
('K1104', 'CTDLGT', 1, '2006-12-28', 4.00, 'Khong Dat'),
('K1104', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1104', 'CTRR', 1, '2006-05-13', 4.00, 'Khong Dat'),
('K1104', 'CTRR', 2, '2006-05-20', 3.50, 'Khong Dat'),
('K1104', 'CTRR', 3, '2006-06-30', 4.00, 'Khong Dat'),
('K1201', 'CSDL', 1, '2006-07-20', 6.00, 'Dat'),
('K1201', 'CTDLGT', 1, '2006-12-28', 5.00, 'Dat'),
('K1201', 'THDC', 1, '2006-05-20', 8.50, 'Dat'),
('K1201', 'CTRR', 1, '2006-05-13', 9.00, 'Dat'),
('K1202', 'CSDL', 1, '2006-07-20', 8.00, 'Dat'),
('K1202', 'CTDLGT', 1, '2006-12-28', 4.00, 'Khong Dat'),
('K1202', 'CTDLGT', 2, '2007-01-05', 5.00, 'Dat'),
('K1202', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1202', 'THDC', 2, '2006-05-27', 4.00, 'Khong Dat'),
('K1202', 'CTRR', 1, '2006-05-13', 3.00, 'Khong Dat'),
('K1202', 'CTRR', 2, '2006-05-20', 4.00, 'Khong Dat'),
('K1202', 'CTRR', 3, '2006-06-30', 6.25, 'Dat'),
('K1203', 'CSDL', 1, '2006-07-20', 9.25, 'Dat'),
('K1203', 'CTDLGT', 1, '2006-12-28', 9.50, 'Dat'),
('K1203', 'THDC', 1, '2006-05-20', 10.00, 'Dat'),
('K1203', 'CTRR', 1, '2006-05-13', 10.00, 'Dat'),
('K1204', 'CSDL', 1, '2006-07-20', 8.50, 'Dat'),
('K1204', 'CTDLGT', 1, '2006-12-28', 6.75, 'Dat'),
('K1204', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1204', 'CTRR', 1, '2006-05-13', 6.00, 'Dat'),
('K1301', 'CSDL', 1, '2006-12-20', 4.25, 'Khong Dat'),
('K1301', 'CTDLGT', 1, '2006-07-25', 8.00, 'Dat'),
('K1301', 'THDC', 1, '2006-05-20', 7.75, 'Dat'),
('K1301', 'CTRR', 1, '2006-05-13', 8.00, 'Dat'),
('K1302', 'CSDL', 1, '2006-12-20', 6.75, 'Dat'),
('K1302', 'CTDLGT', 1, '2006-07-25', 5.00, 'Dat'),
('K1302', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1302', 'CTRR', 1, '2006-05-13', 8.50, 'Dat'),
('K1303', 'CSDL', 1, '2006-12-20', 4.00, 'Khong Dat'),
('K1303', 'CTDLGT', 1, '2006-07-25', 4.50, 'Khong Dat'),
('K1303', 'CTDLGT', 2, '2006-08-07', 4.00, 'Khong Dat'),
('K1303', 'CTDLGT', 3, '2006-08-15', 4.25, 'Khong Dat'),
('K1303', 'THDC', 1, '2006-05-20', 4.50, 'Khong Dat'),
('K1303', 'CTRR', 1, '2006-05-13', 3.25, 'Khong Dat'),
('K1303', 'CTRR', 2, '2006-05-20', 5.00, 'Dat'),
('K1304', 'CSDL', 1, '2006-12-20', 7.75, 'Dat'),
('K1304', 'CTDLGT', 1, '2006-07-25', 9.75, 'Dat'),
('K1304', 'THDC', 1, '2006-05-20', 5.50, 'Dat'),
('K1304', 'CTRR', 1, '2006-05-13', 5.00, 'Dat'),
('K1305', 'CSDL', 1, '2006-12-20', 9.25, 'Dat'),
('K1305', 'CTDLGT', 1, '2006-07-25', 10.00, 'Dat'),
('K1305', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1305', 'CTRR', 1, '2006-05-13', 10.00, 'Dat');
SELECT * FROM KETQUATHI

/*11. Hoc vien it nhat la 18 tuoi.*/
ALTER TABLE HOCVIEN
ADD CONSTRAINT AGE_CH CHECK (DATEDIFF(YEAR,NGSINH,GETDATE()) >= 18)
/*12. Giang day mot mon hoc, ngay bat dau (TUNGAY) phai nho hon ngay ket thuc (DENNGAY).*/
ALTER TABLE GIANGDAY
ADD CONSTRAINT BD_KT CHECK (TUNGAY < DENNGAY)
/*13. Giao vien khi vao lam it nhat la 22 tuoi.*/
ALTER TABLE GIAOVIEN
ADD CONSTRAINT AGE_LV CHECK (DATEDIFF(YEAR,NGSINH,GETDATE()) >= 22)
/*14. Tat ca cac mon hoc deu co so tin chi ly thuyet va tin chi thuc hanh chenh lech nhau khong qua 3.*/
ALTER TABLE MONHOC
ADD CONSTRAINT LT_TH_CH CHECK (ABS(TCLT - TCTH) <= 3)

/*1. In ra danh sach (ma hoc vien, ho ten, ngay sinh, ma lop) lop truong cua cac lop.*/
SELECT MAHV, HO, TEN, NGSINH, HOCVIEN.MALOP
FROM HOCVIEN INNER JOIN LOP ON HOCVIEN.MAHV = LOP.TRGLOP

/*2. In ra bang diem khi thi (ma hoc vien, ho ten, lan thi, diem so) mon CTRR cua lop "K12", sap xep theo ten, ho hoc vien.*/
SELECT KETQUATHI.MAHV, HO, TEN, LANTHI, DIEM
FROM KETQUATHI
	INNER JOIN HOCVIEN ON KETQUATHI.MAHV = HOCVIEN.MAHV
WHERE MAMH = 'CTRR' AND MALOP = 'K12'
ORDER BY TEN, HO

/*3. In ra danh sach nhung hoc vien (ma hoc vien, ho ten) va nhung mon hoc ma hoc vien do thi lan thu nhat da dat.*/
SELECT KETQUATHI.MAHV, HO, TEN, MAMH
FROM KETQUATHI
	INNER JOIN HOCVIEN ON KETQUATHI.MAHV = HOCVIEN.MAHV
WHERE LANTHI = 1 AND KQUA = 'Dat'

/*4. In ra danh sach hoc vien (ma hoc vien, ho ten) cua lop "K11" thi mon CTRR khong dat (o lan thi 1).*/
SELECT KETQUATHI.MAHV, HO, TEN
FROM KETQUATHI 
	INNER JOIN HOCVIEN ON KETQUATHI.MAHV = HOCVIEN.MAHV
WHERE MALOP ='K11' AND MAMH = 'CTRR' AND LANTHI = 1 AND KQUA = 'Khong Dat'

/*5. *Danh sach hoc vien (ma hoc vien, ho ten) cua lop "K" thi mon CTRR khong dat (o tat ca cac lan thi).*/
SELECT DISTINCT KETQUATHI.MAHV, HO, TEN
FROM KETQUATHI
	INNER JOIN HOCVIEN ON KETQUATHI.MAHV = HOCVIEN.MAHV
WHERE MALOP LIKE 'K%' AND MAMH = 'CTRR' AND KQUA = 'Khong Dat'
EXCEPT
SELECT DISTINCT KETQUATHI.MAHV, HO, TEN
FROM KETQUATHI
	INNER JOIN HOCVIEN ON KETQUATHI.MAHV = HOCVIEN.MAHV
WHERE MALOP LIKE 'K%' AND MAMH = 'CTRR' AND KQUA = 'Dat'

---------------------------------------------------------------------------------------------------------------
/*BUOI 3*/
/*1. Tang he so luong them 0.2 cho nhung giao vien la truong khoa*/
UPDATE GIAOVIEN
SET HESO = HESO + 0.2
WHERE MAGV IN (SELECT TRGKHOA
			   FROM KHOA)

/*2. Cap nhat gia tri diem trung binh tat ca cac mon hoc (DIEMTB) cua moi hoc vien (tat ca cac mon hoc deu co he so 1 va neu hoc vien thi mot mon nhieu lan, chi lay diem cua lan thi sau cung).*/
ALTER TABLE HOCVIEN
ADD DIEMTB numeric(4,2)
UPDATE HOCVIEN
SET DIEMTB = DTB_HOCVIEN.DTB
FROM HOCVIEN HV LEFT JOIN (SELECT A.MAHV, AVG(A.DIEM) DTB 
						   FROM KETQUATHI A INNER JOIN (SELECT MAHV, MAMH, MAX(LANTHI) LANTHIMAX
														FROM KETQUATHI
														GROUP BY MAHV, MAMH) B 
						   ON A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI = B.LANTHIMAX 
						   GROUP BY A.MAHV) DTB_HOCVIEN
ON HV.MAHV = DTB_HOCVIEN.MAHV

/*3. Cap nhat gia tri cho cot GHICHU la “Cam thi” doi voi truong hop: hoc vien co mot mon bat ky thi lan thu 3 duoi 5 diem.*/
ALTER TABLE HOCVIEN
ADD GHICHU varchar(20)

UPDATE HOCVIEN
SET GHICHU = 'Cam thi'
WHERE MAHV IN (SELECT MAHV
			   FROM KETQUATHI
			   WHERE LANTHI = 3 AND DIEM < 5)
/*4. Cap nhat gia tri cho cot XEPLOAI trong quan he HOCVIEN.*/
ALTER TABLE HOCVIEN
ADD XEPLOAI varchar(5)

UPDATE HOCVIEN
SET XEPLOAI = CASE
	WHEN DIEMTB >= 9 THEN 'XS'
	WHEN DIEMTB >= 8 THEN 'G'
	WHEN DIEMTB >= 6.5 THEN 'K'
	WHEN DIEMTB >= 5 THEN 'TB'
	WHEN DIEMTB IS NULL THEN NULL
	ELSE 'Y'
END

/*6. Tim ten nhung mon hoc ma giao vien co ten “Tran Tam Thanh” day trong hoc ky 1 nam 2006.*/
SELECT TENMH
FROM MONHOC
WHERE MAMH IN (SELECT DISTINCT MAMH
			   FROM GIANGDAY
			   WHERE HOCKY = 1 AND NAM = 2006 AND MAGV IN (SELECT MAGV
														   FROM GIAOVIEN
														   WHERE HOTEN = 'Tran Tam Thanh'))

/*7. Tim nhung mon hoc (ma mon hoc, ten mon hoc) ma giao vien chu nhiem lop “K11” day trong hoc ky 1 nam 2006.*/
SELECT MAMH, TENMH
FROM MONHOC
WHERE MAMH IN (SELECT DISTINCT MAMH	
			   FROM GIANGDAY
			   WHERE HOCKY = 1 AND NAM = 2006 AND MAGV IN (SELECT MAGVCN
														   FROM LOP
														   WHERE MALOP = 'K11'))

/*8. Tim ho ten lop truong cua cac lop ma giao vien co ten “Nguyen To Lan” day mon “Co So Du Lieu”.*/
SELECT HO + ' ' + TEN AS HOTEN
FROM HOCVIEN
WHERE MAHV IN (SELECT TRGLOP
			   FROM LOP
			   WHERE MALOP IN (SELECT MALOP
							   FROM GIANGDAY
							   WHERE MAMH IN (SELECT MAMH
							                  FROM MONHOC
											  WHERE TENMH = 'Co So Du Lieu') AND MAGV IN (SELECT MAGV
																		FROM GIAOVIEN
																		WHERE HOTEN = 'Nguyen To Lan')))

/*9. In ra danh sach nhung mon hoc (ma mon hoc, ten mon hoc) phai hoc lien truoc mon “Co So Du Lieu”.*/
SELECT MAMH, TENMH
FROM MONHOC
WHERE MAMH IN (SELECT MAMH_TRUOC
			   FROM DIEUKIEN
			   WHERE MAMH = 'CSDL')

/*10.Mon “Cau Truc Roi Rac” la mon bat buoc phai hoc lien truoc nhung mon hoc (ma mon hoc, ten mon hoc) nao.*/
SELECT MAMH, TENMH
FROM MONHOC
WHERE MAMH IN (SELECT MAMH
			   FROM DIEUKIEN
			   WHERE MAMH_TRUOC = 'CTRR')

/*11.Tim ho ten giao vien day mon CTRR cho ca hai lop “K11” va “K12” trong cung hoc ky 1 nam 2006.*/
SELECT MAGV, HOTEN
FROM GIAOVIEN
WHERE MAGV IN (SELECT MAGV
			   FROM GIANGDAY
			   WHERE MALOP = 'K11' AND HOCKY = 1 AND NAM = 2006
			   INTERSECT
			   SELECT MAGV
			   FROM GIANGDAY
			   WHERE MALOP = 'K12' AND HOCKY = 1 AND NAM = 2006)

/*12.Tim nhung hoc vien (ma hoc vien, ho ten) thi khong dat mon CSDL o lan thi thu 1 nhung chua thi lai mon nay.*/
SELECT MAHV, HO + ' ' + TEN AS HOTEN
FROM HOCVIEN
WHERE MAHV IN (SELECT B.MAHV
			   FROM (SELECT MAHV, COUNT(*) SL_THIROT
					 FROM (SELECT MAHV  
						   FROM KETQUATHI
					       WHERE MAMH = 'CSDL' AND KQUA = 'Khong Dat'
						   EXCEPT
						   SELECT MAHV  
						   FROM KETQUATHI
					       WHERE MAMH = 'CSDL' AND KQUA = 'Dat') AS A
					 GROUP BY A.MAHV) AS B
			   WHERE B.SL_THIROT = 1)
					
/*13.Tim giao vien (ma giao vien, ho ten) khong duoc phan cong giang day bat ky mon hoc nao.*/
SELECT MAGV, HOTEN
FROM GIAOVIEN
WHERE MAGV NOT IN (SELECT DISTINCT MAGV
				   FROM GIANGDAY)

/*14.Tim giao vien (ma giao vien, ho ten) khong duoc phan cong giang day bat ky mon hoc nao thuoc khoa giao vien do phu trach.*/
SELECT MAGV, HOTEN
FROM GIAOVIEN
WHERE MAGV NOT IN (SELECT GIANGDAY.MAGV
				   FROM GIANGDAY
						INNER JOIN GIAOVIEN ON GIANGDAY.MAGV = GIAOVIEN.MAGV
						INNER JOIN MONHOC ON GIANGDAY.MAMH = MONHOC.MAMH
				   WHERE GIAOVIEN.MAKHOA = MONHOC.MAKHOA)

/*15.Tim ho ten cac hoc vien thuoc lop “K11” thi mot mon bat ky qua 3 lan van “Khong dat” hoac thi lan thu 2 mon CTRR duoc 5 diem.*/
SELECT HO + ' ' + TEN AS HOTEN FROM HOCVIEN
WHERE MAHV IN (
	SELECT MAHV FROM KETQUATHI A
	WHERE LEFT(MAHV, 3) = 'K11' AND ((
		NOT EXISTS (
			SELECT 1 FROM KETQUATHI B 
			WHERE A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
		)  AND LANTHI = 3 AND KQUA = 'Khong Dat'
	) OR MAMH = 'CTRR' AND LANTHI = 2 AND DIEM = 5))

/*16.Tim ho ten giao vien day mon CTRR cho it nhat hai lop trong cung mot hoc ky cua mot nam hoc.*/
SELECT HOTEN
FROM GIAOVIEN
WHERE MAGV IN (SELECT MAGV
			   FROM GIANGDAY
			   WHERE MAMH = 'CTRR'
			   GROUP BY MAGV, HOCKY, NAM
			   HAVING COUNT(MALOP) >= 2)

/*17.Danh sach hoc vien va diem thi mon CSDL (chi lay diem cua lan thi sau cung).*/
SELECT A.MAHV, HO + ' ' + TEN AS HOTEN, KETQUATHI.DIEM
FROM HOCVIEN
INNER JOIN  (SELECT MAHV, MAX(LANTHI) LT_SAUCUNG
			 FROM KETQUATHI
			 WHERE MAMH = 'CSDL'
			 GROUP BY MAHV) A
			 ON A.MAHV = HOCVIEN.MAHV
INNER JOIN KETQUATHI ON KETQUATHI.MAHV = A.MAHV
WHERE LANTHI = A.LT_SAUCUNG AND MAMH = 'CSDL'
ORDER BY A.MAHV

/*18.Danh sach hoc vien va diem thi mon “Co So Du Lieu” (chi lay diem cao nhat cua cac lan thi).*/
SELECT A.MAHV, HO + ' ' + TEN AS HOTEN, KETQUATHI.DIEM
FROM HOCVIEN
INNER JOIN  (SELECT MAHV, MAX(DIEM) DIEM_CAO_NHAT
			 FROM KETQUATHI
			 WHERE MAMH = 'CSDL'
			 GROUP BY MAHV) A
			 ON A.MAHV = HOCVIEN.MAHV
INNER JOIN KETQUATHI ON KETQUATHI.MAHV = A.MAHV
WHERE DIEM = A.DIEM_CAO_NHAT AND MAMH = 'CSDL'
ORDER BY A.MAHV













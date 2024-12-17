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
-----------------------------------------------------------------------------------------------
/*BUOI 3.2*/
-- 1. Tìm danh sách các giáo viên có mức lương cao nhất trong mỗi khoa, kèm theo tên khoa và hệ số lương.
SELECT khoa.TENKHOA, gv.HOTEN, gv.HESO
FROM GIAOVIEN gv
	 JOIN KHOA khoa ON gv.MAKHOA = khoa.MAKHOA
WHERE gv.MUCLUONG = (SELECT MAX(MUCLUONG)
				 FROM GIAOVIEN
				 WHERE MAKHOA = gv.MAKHOA)

-- 2. Liệt kê danh sách các học viên có điểm trung bình cao nhất trong mỗi lớp, kèm theo tên lớp và mã lớp.
SELECT lop.TENLOP, hv.HO + ' ' + hv.TEN AS TEN_HV, lop.MALOP
FROM HOCVIEN hv
	 JOIN LOP lop ON hv.MALOP = lop.MALOP
WHERE hv.MAHV IN (SELECT MAHV
				  FROM KETQUATHI
				  WHERE LANTHI = (SELECT MAX(LANTHI)
								  FROM KETQUATHI
								  WHERE MAHV = hv.MAHV)
						AND DIEM = (SELECT MAX(DIEM)
									FROM KETQUATHI
									WHERE MAHV = hv.MAHV)
)

-- 3. Tính tổng số tiết lý thuyết (TCLT) và thực hành (TCTH) mà mỗi giáo viên đã giảng dạy trong năm học 2023, sắp xếp theo tổng số tiết từ cao xuống thấp.
SELECT gv.HOTEN, SUM(mh.TCLT) AS TONG_TCLT, SUM(mh.TCTH) AS TONG_TCTH
FROM GIAOVIEN gv
	 INNER JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV
	 INNER JOIN MONHOC mh ON gd.MAMH = mh.MAMH
WHERE gd.NAM = 2023
GROUP BY gv.HOTEN
ORDER BY (SUM(mh.TCLT)+SUM(mh.TCTH)) DESC

-- 4. Tìm những học viên thi cùng một môn học nhiều hơn 2 lần nhưng chưa bao giờ đạt điểm trên 7, kèm theo mã học viên và mã môn học.
SELECT kq.MAHV, kq.MAMH
FROM KETQUATHI kq
GROUP BY kq.MAHV, kq.MAMH
HAVING COUNT(kq.LANTHI) > 2 AND MAX(kq.DIEM) <= 7

-- 5. Xác định những giáo viên đã giảng dạy ít nhất 3 môn học khác nhau trong cùng một năm học, kèm theo năm học và số lượng môn giảng dạy.
SELECT gv.HOTEN, gd.NAM, COUNT(DISTINCT gd.MAMH) AS SO_MON
FROM GIAOVIEN gv
	 JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV
GROUP BY gv.HOTEN, gd.NAM
HAVING COUNT(DISTINCT gd.MAMH) >= 3

-- 6. Tìm những học viên có sinh nhật trùng với ngày thành lập của khoa mà họ đang theo học, kèm theo tên khoa và ngày sinh của học viên.
SELECT hv.HO + ' ' + hv.TEN AS TEN_HV, hv.NGSINH, K.TENKHOA
FROM HOCVIEN hv
	 JOIN LOP L ON hv.MALOP = L.MALOP
	 JOIN GIAOVIEN GV ON L.MAGVCN = GV.MAGV
	 JOIN KHOA K ON GV.MAKHOA = K.MAKHOA
WHERE hv.NGSINH = K.NGTLAP
/*giả sử gvcn của lớp cũng là gv trong khoa sv đang học*/

-- 7. Liệt kê các môn học không có điều kiện tiên quyết (không yêu cầu môn học trước), kèm theo mã môn và tên môn học.
SELECT MAMH, TENMH
FROM MONHOC
WHERE MAMH NOT IN (SELECT MAMH_TRUOC FROM DIEUKIEN)

-- 8. Tìm danh sách các giáo viên dạy nhiều môn học nhất trong học kỳ 1 năm 2006, kèm theo số lượng môn học mà họ đã dạy.
SELECT gv.HOTEN, COUNT(DISTINCT gd.MAMH) AS SO_MON
FROM GIAOVIEN gv
	 JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV
WHERE gd.HOCKY = 1 AND gd.NAM = 2006
GROUP BY gv.HOTEN
HAVING COUNT(DISTINCT gd.MAMH) >= ALL (SELECT COUNT(DISTINCT gd.MAMH) AS SO_MON
									   FROM GIAOVIEN gv
											JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV
									   WHERE gd.HOCKY = 1 AND gd.NAM = 2006
									   GROUP BY gv.HOTEN)

-- 9. Tìm những giáo viên đã dạy cả môn “Co So Du Lieu” và “Cau Truc Roi Rac” trong cùng một học kỳ, kèm theo học kỳ và năm học.
SELECT gv.HOTEN, gd.HOCKY, gd.NAM
FROM GIAOVIEN gv
	 JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV
	 JOIN MONHOC mh ON gd.MAMH = mh.MAMH
WHERE mh.TENMH = 'Co So Du Lieu'
GROUP BY gv.HOTEN, gd.HOCKY, gd.NAM
INTERSECT
SELECT gv.HOTEN, gd.HOCKY, gd.NAM
FROM GIAOVIEN gv
	 JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV
	 JOIN MONHOC mh ON gd.MAMH = mh.MAMH
WHERE mh.TENMH = 'Cau truc roi rac'
GROUP BY gv.HOTEN, gd.HOCKY, gd.NAM

-- 10. Liệt kê danh sách các môn học mà tất cả các giáo viên trong khoa “CNTT” đều đã giảng dạy ít nhất một lần trong năm 2006.
SELECT mh.MAMH, mh.TENMH
FROM MONHOC mh
WHERE NOT EXISTS (
    SELECT *
    FROM KHOA khoa
    WHERE khoa.TENKHOA = 'CNTT'
    AND NOT EXISTS (
        SELECT *
        FROM GIANGDAY gd
        WHERE gd.MAMH = mh.MAMH
        AND gd.MAGV IN (
            SELECT MAGV
            FROM GIAOVIEN gv
            WHERE gv.MAKHOA = khoa.MAKHOA
        )
        AND gd.NAM = 2006
    )
)

-- 11. Tìm những giáo viên có hệ số lương cao hơn mức lương trung bình của tất cả giáo viên trong khoa của họ, kèm theo tên khoa và hệ số lương của giáo viên đó.
SELECT gv.HOTEN, khoa.TENKHOA, gv.HESO
FROM GIAOVIEN gv
	 JOIN KHOA khoa ON gv.MAKHOA = khoa.MAKHOA
WHERE gv.HESO > (SELECT AVG(GIAOVIEN.HESO)
				 FROM GIAOVIEN
				 WHERE MAKHOA = gv.MAKHOA) 

-- 12. Xác định những lớp có sĩ số lớn hơn 40 nhưng không có giáo viên nào dạy quá 2 môn trong học kỳ 1 năm 2006, kèm theo tên lớp và sĩ số.
SELECT lop.TENLOP, lop.SISO
FROM LOP lop
WHERE lop.SISO > 40
AND NOT EXISTS (
    SELECT gd.MAGV
    FROM GIANGDAY gd
    WHERE gd.MALOP = lop.MALOP AND gd.HOCKY = 1 AND gd.NAM = 2006
    GROUP BY gd.MAGV
    HAVING COUNT(DISTINCT gd.MAMH) > 2
)

-- 13. Tìm những môn học mà tất cả các học viên của lớp “K11” đều đạt điểm trên 7 trong lần thi cuối cùng của họ, kèm theo mã môn và tên môn học.
SELECT kq.MAMH, mh.TENMH
FROM KETQUATHI kq
	 JOIN MONHOC mh ON kq.MAMH = mh.MAMH
WHERE kq.MAHV IN (
    SELECT MAHV
    FROM HOCVIEN
    WHERE MALOP = 'K11'
)
GROUP BY kq.MAMH, mh.TENMH
HAVING MIN(kq.DIEM) > 7

-- 14. Liệt kê danh sách các giáo viên đã dạy ít nhất một môn học trong mỗi học kỳ của năm 2006, kèm theo mã giáo viên và số lượng học kỳ mà họ đã giảng dạy.
SELECT gv.HOTEN, gv.MAGV, COUNT(DISTINCT gd.HOCKY) AS SO_HOCKY
FROM GIAOVIEN gv
	 JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV
WHERE gd.NAM = 2006
GROUP BY gv.HOTEN, gv.MAGV
HAVING COUNT(DISTINCT gd.HOCKY) = 3

-- 15. Tìm những giáo viên vừa là trưởng khoa vừa giảng dạy ít nhất 2 môn khác nhau trong năm 2006, kèm theo tên khoa và mã giáo viên.
SELECT gv.HOTEN, khoa.TENKHOA, gv.MAGV
FROM GIAOVIEN gv
	 JOIN KHOA khoa ON gv.MAKHOA = khoa.MAKHOA
WHERE khoa.TRGKHOA = gv.MAGV
AND EXISTS (
    SELECT *
    FROM GIANGDAY gd
    WHERE gd.MAGV = gv.MAGV
    AND gd.NAM = 2006
    GROUP BY gd.MAGV
    HAVING COUNT(DISTINCT gd.MAMH) >= 2
)

-- 16. Xác định những môn học mà tất cả các lớp do giáo viên chủ nhiệm “Nguyen To Lan” đều phải học trong năm 2006, kèm theo mã lớp và tên lớp.
SELECT DISTINCT gd.MAMH, mh.TENMH, l.MALOP, l.TENLOP
FROM GIANGDAY gd
	 JOIN LOP l ON gd.MALOP = l.MALOP
	 JOIN MONHOC mh ON gd.MAMH = mh.MAMH
	 JOIN GIAOVIEN gv ON l.MAGVCN = gv.MAGV
WHERE gv.HOTEN = 'Nguyen To Lan' AND gd.NAM = 2006
GROUP BY gd.MAMH, mh.TENMH, l.MALOP, l.TENLOP
HAVING COUNT(l.MALOP) = (SELECT COUNT(DISTINCT MALOP)
						 FROM LOP
							  INNER JOIN GIAOVIEN ON LOP.MAGVCN = GIAOVIEN.MAGV
						 WHERE HOTEN = 'Nguyen To Lan')

-- 17. Liệt kê danh sách các môn học mà không có điều kiện tiên quyết (không cần phải học trước bất kỳ môn nào), nhưng lại là điều kiện tiên quyết cho ít nhất 2 môn khác nhau, kèm theo mã môn và tên môn học.
SELECT dk.MAMH_TRUOC, mh.TENMH
FROM DIEUKIEN dk
	 JOIN MONHOC mh ON dk.MAMH_TRUOC = mh.MAMH
WHERE dk.MAMH NOT IN (SELECT MAMH_TRUOC FROM DIEUKIEN)
GROUP BY dk.MAMH_TRUOC, mh.TENMH
HAVING COUNT(DISTINCT dk.MAMH) >= 2

-- 18. Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này và cũng chưa thi bất kỳ môn nào khác sau lần đó.
SELECT hv.MAHV, CONCAT(hv.HO, ' ', hv.TEN) AS HOTEN
FROM HOCVIEN hv
	 JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV
WHERE kq.MAMH = 'CSDL' AND kq.LANTHI = 1 AND kq.KQUA = 'Khong dat'
AND NOT EXISTS (
    SELECT 1
    FROM KETQUATHI kq2
    WHERE kq2.MAHV = hv.MAHV AND kq2.MAMH = 'CSDL' AND kq2.LANTHI > 1
)
AND NOT EXISTS (
    SELECT 1
    FROM KETQUATHI kq3
    WHERE kq3.MAHV = hv.MAHV AND kq3.LANTHI > 1
)

-- 19. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào trong năm 2006, nhưng đã từng giảng dạy trước đó.
SELECT gv.MAGV, gv.HOTEN
FROM GIAOVIEN gv
WHERE NOT EXISTS (
    SELECT 1
    FROM GIANGDAY gd
    WHERE gd.MAGV = gv.MAGV AND gd.NAM = 2006
)
AND EXISTS (
    SELECT 1
    FROM GIANGDAY gd
    WHERE gd.MAGV = gv.MAGV AND gd.NAM < 2006
)

-- 20. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách trong năm 2006, nhưng đã từng giảng dạy các môn khác của khoa khác.
SELECT gv.MAGV, gv.HOTEN
FROM GIAOVIEN gv
WHERE NOT EXISTS (
    SELECT 1
    FROM GIANGDAY gd
    JOIN MONHOC mh ON gd.MAMH = mh.MAMH
    WHERE gd.MAGV = gv.MAGV AND gd.NAM = 2006 AND mh.MAKHOA = gv.MAKHOA
)
AND EXISTS (
    SELECT 1
    FROM GIANGDAY gd2
    JOIN MONHOC mh2 ON gd2.MAMH = mh2.MAMH
    WHERE gd2.MAGV = gv.MAGV AND gd2.NAM < 2006 AND mh2.MAKHOA != gv.MAKHOA
)

-- 21. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn "Khong dat", nhưng có điểm trung bình tất cả các môn khác trên 7.
SELECT CONCAT(hv.HO, hv.TEN) HOTEN
FROM HOCVIEN hv
JOIN LOP l ON hv.MALOP = l.MALOP
WHERE l.TENLOP = 'K11'
AND EXISTS (
    SELECT 1
    FROM KETQUATHI kq
    WHERE kq.MAHV = hv.MAHV AND kq.LANTHI > 3 AND kq.KQUA = 'Khong dat'
)
AND (
    SELECT AVG(kq.DIEM)
    FROM KETQUATHI kq
    WHERE kq.MAHV = hv.MAHV AND kq.KQUA = 'Dat'
) > 7

-- 22. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn "Khong dat" và thi lần thứ 2 của môn CTRR đạt đúng 5 điểm, nhưng điểm trung bình của tất cả các môn khác đều dưới 6.
SELECT CONCAT(hv.HO, hv.TEN) HOTEN
FROM HOCVIEN hv
	 INNER JOIN LOP l ON hv.MALOP = l.MALOP
WHERE l.TENLOP = 'K11'
AND EXISTS (
    SELECT 1
    FROM KETQUATHI kq
    WHERE kq.MAHV = hv.MAHV AND kq.LANTHI > 3 AND kq.KQUA = 'Khong dat'
)
AND EXISTS (
    SELECT 1
    FROM KETQUATHI kq
    WHERE kq.MAHV = hv.MAHV AND kq.MAMH = 'CTRR' AND kq.LANTHI = 2 AND kq.DIEM = 5
)
AND (
    SELECT AVG(kq.DIEM)
    FROM KETQUATHI kq
    WHERE kq.MAHV = hv.MAHV AND kq.MAMH != 'CTRR' AND kq.KQUA = 'Dat'
) < 6

-- 23. Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học và có tổng số tiết giảng dạy (TCLT + TCTH) lớn hơn 30 tiết.
SELECT gv.HOTEN
FROM GIAOVIEN gv
	JOIN GIANGDAY gd ON gv.MAGV = gd.MAGV
	JOIN MONHOC mh ON gd.MAMH = mh.MAMH
WHERE mh.TENMH = 'CTRR'
GROUP BY gv.HOTEN, gd.HOCKY, gd.NAM
HAVING COUNT(DISTINCT gd.MALOP) >= 2 AND SUM(mh.TCLT + mh.TCTH) > 30

-- 24. Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng), kèm theo số lần thi của mỗi học viên cho môn này.
SELECT hv.MAHV, CONCAT(hv.HO, ' ', hv.TEN) AS HOTEN, kq.DIEM, 
       (SELECT COUNT(*) FROM KETQUATHI kq2 WHERE kq2.MAHV = hv.MAHV AND kq2.MAMH = 'CSDL') AS SO_LAN_THI
FROM HOCVIEN hv
	 JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV
WHERE kq.MAMH = 'CSDL'
  AND kq.LANTHI = (SELECT MAX(kq2.LANTHI) 
                   FROM KETQUATHI kq2 
                   WHERE kq2.MAHV = hv.MAHV AND kq2.MAMH = 'CSDL')

-- 25. Danh sách học viên và điểm trung bình tất cả các môn (chỉ lấy điểm của lần thi sau cùng), kèm theo số lần thi trung bình cho tất cả các môn mà mỗi học viên đã tham gia.
SELECT hv.MAHV, 
       CONCAT(hv.HO, ' ', hv.TEN) AS HOTEN, 
       AVG(kq_final.DIEM) AS DIEM_TB, 
       AVG(lanthi_count.SO_LAN_THI) AS SO_LAN_THI_TB
FROM HOCVIEN hv
JOIN (
    SELECT MAHV, MAMH, DIEM
    FROM KETQUATHI
    WHERE LANTHI = (SELECT MAX(LANTHI) 
                    FROM KETQUATHI kq2 
                    WHERE kq2.MAHV = KETQUATHI.MAHV AND kq2.MAMH = KETQUATHI.MAMH)
) kq_final ON hv.MAHV = kq_final.MAHV
JOIN (
    SELECT MAHV, MAMH, COUNT(LANTHI) AS SO_LAN_THI
    FROM KETQUATHI
    GROUP BY MAHV, MAMH
) lanthi_count ON hv.MAHV = lanthi_count.MAHV AND kq_final.MAMH = lanthi_count.MAMH
GROUP BY hv.MAHV, hv.HO, hv.TEN
---------------------------------------------------------------------------------------------------------------------
/*BUOI 4*/
--19.	Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
SELECT MAKHOA, TENKHOA FROM (
	SELECT MAKHOA, TENKHOA, RANK() OVER (ORDER BY NGTLAP) RANK_NGTLAP FROM KHOA 
) A
WHERE RANK_NGTLAP = 1

--20.	Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
SELECT HOCHAM, COUNT(HOCHAM) SL FROM GIAOVIEN 
WHERE HOCHAM IN ('GS', 'PGS') 
GROUP BY HOCHAM

--21.	Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
SELECT MAKHOA, HOCVI, COUNT(HOCVI) SL FROM GIAOVIEN 
GROUP BY MAKHOA, HOCVI
ORDER BY MAKHOA

--22.	Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
SELECT MAMH, KQUA, COUNT(MAHV) SL
FROM KETQUATHI A
WHERE NOT EXISTS (
	SELECT 1 
	FROM KETQUATHI B 
	WHERE A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
)
GROUP BY MAMH, KQUA

--23.	Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.
SELECT MAGV, HOTEN 
FROM GIAOVIEN 
WHERE MAGV IN(
	SELECT DISTINCT MAGV
	FROM GIANGDAY GD INNER JOIN LOP
	ON GD.MALOP = LOP.MALOP
	WHERE MAGV = MAGVCN 
)

--24.	Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
SELECT HO + ' ' + TEN HOTEN FROM LOP INNER JOIN HOCVIEN HV
ON LOP.TRGLOP = HV.MAHV
WHERE SISO = (
	SELECT MAX(SISO) FROM LOP
)

--25.	* Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
SELECT HO + ' ' + TEN HOTEN FROM HOCVIEN
WHERE MAHV IN (
	SELECT MAHV FROM KETQUATHI A
	WHERE MAHV IN (
		SELECT TRGLOP FROM LOP
	) AND NOT EXISTS (
		SELECT 1 FROM KETQUATHI B 
		WHERE A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
	) AND KQUA = 'Khong Dat'
	GROUP BY MAHV
	HAVING COUNT(MAMH) >= 3
)

--26.	Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT A.MAHV, HO + ' ' + TEN HOTEN FROM (
	SELECT MAHV, RANK () OVER (ORDER BY COUNT(MAMH) DESC) RANK_MH FROM KETQUATHI KQ 
	WHERE DIEM BETWEEN 9 AND 10
	GROUP BY KQ.MAHV
) A INNER JOIN HOCVIEN HV
ON A.MAHV = HV.MAHV
WHERE RANK_MH = 1

--27.	Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT LEFT(A.MAHV, 3) AS MALOP, A.MAHV, HO + ' ' + TEN AS HOTEN
FROM (
    SELECT 
        MAHV, 
        LEFT(MAHV, 3) AS MALOP, 
        COUNT(MAMH) AS SO_MON, 
        RANK() OVER (PARTITION BY LEFT(MAHV, 3) ORDER BY COUNT(MAMH) DESC) AS RANK_MH
    FROM KETQUATHI
    WHERE DIEM BETWEEN 9 AND 10
    GROUP BY MAHV, LEFT(MAHV, 3)
) A
INNER JOIN HOCVIEN HV 
ON A.MAHV = HV.MAHV
WHERE RANK_MH = 1

--28.	Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp.
SELECT HOCKY, NAM, MAGV, COUNT(MAMH) SOMH, COUNT(MALOP) SOLOP FROM GIANGDAY
GROUP BY HOCKY, NAM, MAGV

--29.	Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.
SELECT HOCKY, NAM, A.MAGV, HOTEN FROM (
	SELECT HOCKY, NAM, MAGV, RANK() OVER (PARTITION BY HOCKY, NAM ORDER BY COUNT(MAMH) DESC) RANK_SOMH FROM GIANGDAY
	GROUP BY HOCKY, NAM, MAGV
) A INNER JOIN GIAOVIEN GV 
ON A.MAGV = GV.MAGV
WHERE RANK_SOMH = 1

--30.	Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
SELECT A.MAMH, TENMH FROM (
	SELECT MAMH, RANK() OVER (ORDER BY COUNT(MAHV) DESC) RANK_SOHV FROM KETQUATHI
	WHERE LANTHI = 1 AND KQUA = 'Khong Dat'
	GROUP BY MAMH
) A INNER JOIN MONHOC MH
ON A.MAMH = MH.MAMH
WHERE RANK_SOHV = 1

--31.	Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
SELECT A.MAHV, HO + ' ' + TEN HOTEN FROM (
	SELECT MAHV, COUNT(KQUA) SODAT FROM KETQUATHI 
	WHERE LANTHI = 1 AND KQUA = 'Dat'
	GROUP BY MAHV
	INTERSECT
	SELECT MAHV, COUNT(MAMH) SOMH FROM KETQUATHI 
	WHERE LANTHI = 1
	GROUP BY MAHV
) A INNER JOIN HOCVIEN HV
ON A.MAHV = HV.MAHV

--32.	* Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
SELECT C.MAHV, HO + ' ' + TEN HOTEN FROM (
	SELECT MAHV, COUNT(KQUA) SODAT FROM KETQUATHI A
	WHERE NOT EXISTS (
		SELECT 1 
		FROM KETQUATHI B 
		WHERE A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
	) AND KQUA = 'Dat'
	GROUP BY MAHV
	INTERSECT
	SELECT MAHV, COUNT(MAMH) SOMH FROM KETQUATHI 
	WHERE LANTHI = 1
	GROUP BY MAHV
) C INNER JOIN HOCVIEN HV
ON C.MAHV = HV.MAHV

--33.	* Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi thứ 1).
SELECT A.MAHV, HO + ' ' + TEN HOTEN FROM (
	SELECT MAHV, COUNT(KQUA) SODAT FROM KETQUATHI 
	WHERE LANTHI = 1 AND KQUA = 'Dat'
	GROUP BY MAHV
	INTERSECT
	SELECT MAHV, COUNT(MAMH) SOMH FROM KETQUATHI 
	WHERE LANTHI = 1
	GROUP BY MAHV
) A INNER JOIN HOCVIEN HV
ON A.MAHV = HV.MAHV

--34.	* Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt  (chỉ xét lần thi sau cùng).
SELECT C.MAHV, HO + ' ' + TEN HOTEN FROM (
	SELECT MAHV, COUNT(KQUA) SODAT FROM KETQUATHI A
	WHERE NOT EXISTS (
		SELECT 1 FROM KETQUATHI B 
		WHERE A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
	) AND KQUA = 'Dat'
	GROUP BY MAHV
	INTERSECT
	SELECT MAHV, COUNT(MAMH) SOMH FROM KETQUATHI 
	WHERE LANTHI = 1
	GROUP BY MAHV
) C INNER JOIN HOCVIEN HV
ON C.MAHV = HV.MAHV

--35.	** Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng).
SELECT A.MAHV, HO + ' ' + TEN HOTEN FROM (
	SELECT B.MAMH, MAHV, DIEM, DIEMMAX
	FROM KETQUATHI B INNER JOIN (
		SELECT MAMH, MAX(DIEM) DIEMMAX FROM KETQUATHI
		GROUP BY MAMH
	) C 
	ON B.MAMH = C.MAMH
	WHERE NOT EXISTS (
		SELECT 1 FROM KETQUATHI D 
		WHERE B.MAHV = D.MAHV AND B.MAMH = D.MAMH AND B.LANTHI < D.LANTHI
	) AND DIEM = DIEMMAX
) A INNER JOIN HOCVIEN HV
ON A.MAHV = HV.MAHV

--------------------------------------------------------------------------------------------------------------------------
/*BUOI 5*/
--câu 9
GO
CREATE TRIGGER trg_validate_classleader ON LOP
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @trglop CHAR(5)
    DECLARE @malop CHAR(3)
    SELECT @trglop = TRGLOP FROM INSERTED
    SELECT @malop = MALOP FROM INSERTED
    IF @trglop NOT IN (SELECT MAHV FROM HOCVIEN WHERE HOCVIEN.MALOP= @malop)
    BEGIN
        PRINT N'học sinh này không thuộc lớp'
        ROLLBACK TRAN
    END
END

--câu 10
GO
CREATE TRIGGER trg_validate_trgkhoa ON KHOA
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @trgkhoa CHAR(5)
    DECLARE @makhoa CHAR(3)
    DECLARE @hocvi VARCHAR(10)
    SELECT @trgkhoa = TRGKHOA FROM INSERTED
    SELECT @makhoa = MAKHOA FROM INSERTED
    SELECT @hocvi = HOCVI FROM GIAOVIEN WHERE @trgkhoa = MAGV

    IF @hocvi NOT IN ('TS','PTS')
    BEGIN
        PRINT N'Học vị của trường khoa không phù hợp'
        ROLLBACK TRANSACTION
    END
END

--câu 15
GO
CREATE TRIGGER trg_kiem_tra_ngay_thi ON KETQUATHI
AFTER UPDATE, INSERT
AS
BEGIN
    DECLARE @mahv CHAR(5)
    DECLARE @malop CHAR(3)
    DECLARE @mamh VARCHAR(10)
    DECLARE @ngaykt DATETIME
    DECLARE @ngaythi DATETIME

    SELECT @mahv = MAHV FROM INSERTED
    SELECT @mamh = MAMH FROM INSERTED
    SELECT @ngaythi =NGTHI FROM INSERTED
    SELECT @malop = MALOP FROM HOCVIEN WHERE @mahv = MAHV
    SELECT @ngaykt = DENNGAY FROM GIANGDAY WHERE @malop = MALOP AND @mamh = MAMH

    IF @ngaykt >= @ngaythi
    BEGIN
        ROLLBACK TRAN
    END
END

--câu 16
GO
CREATE TRIGGER trg_test_cau16 ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @MALOP CHAR(3)
	DECLARE @HOCKY TINYINT
	DECLARE @NAM SMALLINT
	DECLARE @SL TINYINT

	SELECT @MALOP=MALOP FROM inserted
	SELECT @HOCKY=HOCKY FROM inserted
	SELECT @NAM=NAM FROM inserted
	SELECT @SL=COUNT(MAMH) FROM GIANGDAY
	WHERE @MALOP=MALOP
	AND @HOCKY=HOCKY
	AND @NAM=NAM
	IF(@SL>3)
	BEGIN
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		PRINT 'THEM THANH CONG'
	END
END

--câu 17
GO
CREATE TRIGGER ins_lop_cau17 ON LOP
AFTER INSERT
AS
BEGIN
    DECLARE @MALOP CHAR(3)
    SELECT @MALOP = MALOP FROM inserted
    UPDATE LOP
    SET SISO = 0
    WHERE MALOP = @MALOP
END

GO
CREATE OR ALTER TRIGGER ins_hv_cau17 ON HOCVIEN
AFTER INSERT
AS
BEGIN
    DECLARE @MALOP CHAR(3)
    SELECT @MALOP = MALOP FROM INSERTED
    UPDATE LOP
    SET SISO = SISO + 1
    WHERE MALOP = @MALOP
END

GO
CREATE OR ALTER TRIGGER upd_hv_cau17 ON HOCVIEN
AFTER UPDATE
AS
BEGIN
    DECLARE @MLM CHAR(3), @MLC CHAR(3)
    SELECT @MLM = MALOP FROM INSERTED
    SELECT @MLC = MALOP FROM DELETED
    UPDATE LOP SET SISO = SISO + 1 WHERE MALOP = @MLM
    UPDATE LOP SET SISO = SISO - 1 WHERE MALOP = @MLC
END

GO
CREATE OR ALTER TRIGGER del_hv_cau17 ON HOCVIEN
AFTER DELETE
AS
BEGIN
    DECLARE @MALOP CHAR(3)
    SELECT @MALOP = MALOP FROM DELETED
    UPDATE LOP
    SET SISO = SISO - 1
    WHERE MALOP = @MALOP
END

--câu 18
GO
CREATE OR ALTER TRIGGER dk_cau18 ON DIEUKIEN
AFTER INSERT ,UPDATE
AS
BEGIN
    DECLARE @MAMH VARCHAR(10), @MAMH_TRUOC VARCHAR(10)
    SELECT @MAMH = MAMH, @MAMH_TRUOC = MAMH_TRUOC FROM INSERTED
    IF (@MAMH = @MAMH_TRUOC)
    BEGIN
        ROLLBACK TRAN
        PRINT 'MAMH VA MAMHTRUOC KHONG DUOC GIONG NHAU'
    END
    ELSE
    BEGIN
        IF (EXISTS(SELECT * FROM DIEUKIEN WHERE MAMH = @MAMH_TRUOC AND MAMH_TRUOC = @MAMH))
        BEGIN
            ROLLBACK TRAN
            PRINT 'DIEU KIEN KHONG THOA MAN'
        END
    END
END

--câu 19
GO
CREATE TRIGGER trg_cau19 ON GIAOVIEN
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @MAGV CHAR(4)
	DECLARE @HOCVI VARCHAR(10)
	DECLARE @HOCHAM VARCHAR(10)
	DECLARE @HESO NUMERIC(4,2)
	DECLARE @MUCLUONG MONEY

	SELECT @MUCLUONG=MUCLUONG FROM inserted
	SELECT @MAGV=MAGV FROM inserted
	SELECT @HOCVI=HOCVI FROM inserted
	SELECT @HOCHAM=HOCHAM FROM inserted
	SELECT @HESO=HESO FROM inserted
	SELECT MAGV=@MAGV FROM GIAOVIEN 
	WHERE HOCVI=@HOCVI
	AND @HOCHAM=HOCHAM
	AND @HESO=HESO
	IF(@MUCLUONG <> (SELECT MUCLUONG FROM GIAOVIEN WHERE MAGV<>@MAGV AND HOCVI=@HOCVI AND HOCHAM=@HOCHAM AND HESO=@HESO))
	BEGIN
		ROLLBACK TRAN
	END
END

--câu 20
GO
CREATE TRIGGER trg_cau20 ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @LANTHI TINYINT, @MAHV CHAR(5), @MAMH VARCHAR(10),@DIEMTHILANTRUOC NUMERIC(4,2)
    SELECT @MAHV = MAHV , @MAMH = MAMH, @LANTHI = LANTHI FROM inserted
    IF(@LANTHI > 1)
    BEGIN
        SELECT @DIEMTHILANTRUOC = DIEM
        FROM KETQUATHI
        WHERE MAHV = @MAHV
        AND MAMH = @MAMH
        AND LANTHI = @LANTHI - 1
        IF(@DIEMTHILANTRUOC > 5)
        BEGIN
            PRINT 'KHONG DUOC THI LAI'
            ROLLBACK TRANSACTION
        END
    END
END

--câu 21
GO
CREATE TRIGGER trg_cau21 ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @MAHV CHAR(5)
	DECLARE @MAMH VARCHAR(10)
	DECLARE @LANTHI TINYINT
	DECLARE @NGTHISAU SMALLDATETIME
	DECLARE @NGTHITRUOC SMALLDATETIME

	SELECT @MAHV=MAHV FROM inserted
	SELECT @MAMH=MAMH FROM inserted
	SELECT @LANTHI=LANTHI FROM inserted
	SELECT @NGTHISAU=NGTHI FROM inserted
	IF(@LANTHI>1)
	BEGIN
		SELECT @NGTHITRUOC=NGTHI
		FROM KETQUATHI
		WHERE MAHV=@MAHV
		AND MAMH=@MAMH
		AND LANTHI=@LANTHI-1
		IF(@NGTHISAU<=@NGTHITRUOC)
		BEGIN
			ROLLBACK TRAN
		END
	END
END

--câu 22
GO
CREATE OR ALTER TRIGGER gd_cau22 ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MALOP CHAR(3), @MAMH VARCHAR(10), @MAMH_TRUOC VARCHAR(10)
    SELECT @MALOP = MALOP, @MAMH = MAMH FROM INSERTED
    SELECT @MAMH_TRUOC = MAMH_TRUOC FROM DIEUKIEN WHERE MAMH = @MAMH
    IF NOT EXISTS (SELECT 1 FROM GIANGDAY WHERE MAMH = @MAMH_TRUOC
                                        AND MALOP = @MALOP)
    BEGIN
        PRINT 'MON HOC TRUOC CHUA DUOC HOC'
        ROLLBACK TRANSACTION
    END
END

--câu 23
GO
CREATE TRIGGER trg_cau23 ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @MAGV CHAR(4)
	DECLARE @MAMH VARCHAR(10)
	DECLARE @MAKHOAMH VARCHAR(4)
	DECLARE @MAKHOAGV VARCHAR(4)
	
	SELECT @MAGV=MAGV FROM inserted
	SELECT @MAMH=MAMH FROM inserted
	SELECT @MAKHOAMH=MAKHOA FROM MONHOC WHERE @MAMH=MAMH
	SELECT @MAKHOAGV=MAKHOA FROM GIAOVIEN WHERE @MAGV=MAGV
	IF(@MAKHOAMH<>@MAKHOAGV)
	BEGIN
		ROLLBACK TRAN
	END
END















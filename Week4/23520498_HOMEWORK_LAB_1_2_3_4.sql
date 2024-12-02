/*BTVN BUOI 1*/
CREATE DATABASE CTY

use CTY

-- Tạo bảng Chuyên gia
CREATE TABLE ChuyenGia (
    MaChuyenGia INT PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    Email NVARCHAR(100),
    SoDienThoai NVARCHAR(20),
    ChuyenNganh NVARCHAR(50),
    NamKinhNghiem INT
);

-- Tạo bảng Công ty
CREATE TABLE CongTy (
    MaCongTy INT PRIMARY KEY,
    TenCongTy NVARCHAR(100),
    DiaChi NVARCHAR(200),
    LinhVuc NVARCHAR(50),
    SoNhanVien INT
);

-- Tạo bảng Dự án
CREATE TABLE DuAn (
    MaDuAn INT PRIMARY KEY,
    TenDuAn NVARCHAR(200),
    MaCongTy INT,
    NgayBatDau DATE,
    NgayKetThuc DATE,
    TrangThai NVARCHAR(50),
    FOREIGN KEY (MaCongTy) REFERENCES CongTy(MaCongTy)
);

-- Tạo bảng Kỹ năng
CREATE TABLE KyNang (
    MaKyNang INT PRIMARY KEY,
    TenKyNang NVARCHAR(100),
    LoaiKyNang NVARCHAR(50)
);

-- Tạo bảng Chuyên gia - Kỹ năng
CREATE TABLE ChuyenGia_KyNang (
    MaChuyenGia INT,
    MaKyNang INT,
    CapDo INT,
    PRIMARY KEY (MaChuyenGia, MaKyNang),
    FOREIGN KEY (MaChuyenGia) REFERENCES ChuyenGia(MaChuyenGia),
    FOREIGN KEY (MaKyNang) REFERENCES KyNang(MaKyNang)
);

-- Tạo bảng Chuyên gia - Dự án
CREATE TABLE ChuyenGia_DuAn (
    MaChuyenGia INT,
    MaDuAn INT,
    VaiTro NVARCHAR(50),
    NgayThamGia DATE,
    PRIMARY KEY (MaChuyenGia, MaDuAn),
    FOREIGN KEY (MaChuyenGia) REFERENCES ChuyenGia(MaChuyenGia),
    FOREIGN KEY (MaDuAn) REFERENCES DuAn(MaDuAn)
);

-- Chèn dữ liệu mẫu vào bảng Chuyên gia
INSERT INTO ChuyenGia (MaChuyenGia, HoTen, NgaySinh, GioiTinh, Email, SoDienThoai, ChuyenNganh, NamKinhNghiem)
VALUES 
(1, N'Nguyễn Văn An', '1985-05-10', N'Nam', 'nguyenvanan@email.com', '0901234567', N'Phát triển phần mềm', 10),
(2, N'Trần Thị Bình', '1990-08-15', N'Nữ', 'tranthiminh@email.com', '0912345678', N'An ninh mạng', 7),
(3, N'Lê Hoàng Cường', '1988-03-20', N'Nam', 'lehoangcuong@email.com', '0923456789', N'Trí tuệ nhân tạo', 9),
(4, N'Phạm Thị Dung', '1992-11-25', N'Nữ', 'phamthidung@email.com', '0934567890', N'Khoa học dữ liệu', 6),
(5, N'Hoàng Văn Em', '1987-07-30', N'Nam', 'hoangvanem@email.com', '0945678901', N'Điện toán đám mây', 8),
(6, N'Ngô Thị Phượng', '1993-02-14', N'Nữ', 'ngothiphuong@email.com', '0956789012', N'Phân tích dữ liệu', 5),
(7, N'Đặng Văn Giang', '1986-09-05', N'Nam', 'dangvangiang@email.com', '0967890123', N'IoT', 11),
(8, N'Vũ Thị Hương', '1991-12-20', N'Nữ', 'vuthihuong@email.com', '0978901234', N'UX/UI Design', 7),
(9, N'Bùi Văn Inh', '1989-04-15', N'Nam', 'buivaninch@email.com', '0989012345', N'DevOps', 8),
(10, N'Lý Thị Khánh', '1994-06-30', N'Nữ', 'lythikhanh@email.com', '0990123456', N'Blockchain', 4);

-- Chèn dữ liệu mẫu vào bảng Công ty
INSERT INTO CongTy (MaCongTy, TenCongTy, DiaChi, LinhVuc, SoNhanVien)
VALUES 
(1, N'TechViet Solutions', N'123 Đường Lê Lợi, TP.HCM', N'Phát triển phần mềm', 200),
(2, N'DataSmart Analytics', N'456 Đường Nguyễn Huệ, Hà Nội', N'Phân tích dữ liệu', 150),
(3, N'CloudNine Systems', N'789 Đường Trần Hưng Đạo, Đà Nẵng', N'Điện toán đám mây', 100),
(4, N'SecureNet Vietnam', N'101 Đường Võ Văn Tần, TP.HCM', N'An ninh mạng', 80),
(5, N'AI Innovate', N'202 Đường Lý Tự Trọng, Hà Nội', N'Trí tuệ nhân tạo', 120);

-- Chèn dữ liệu mẫu vào bảng Dự án
INSERT INTO DuAn (MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai)
VALUES 
(1, N'Phát triển ứng dụng di động cho ngân hàng', 1, '2023-01-01', '2023-06-30', N'Hoàn thành'),
(2, N'Xây dựng hệ thống phân tích dữ liệu khách hàng', 2, '2023-03-15', '2023-09-15', N'Đang thực hiện'),
(3, N'Triển khai giải pháp đám mây cho doanh nghiệp', 3, '2023-02-01', '2023-08-31', N'Đang thực hiện'),
(4, N'Nâng cấp hệ thống bảo mật cho tập đoàn viễn thông', 4, '2023-04-01', '2023-10-31', N'Đang thực hiện'),
(5, N'Phát triển chatbot AI cho dịch vụ khách hàng', 5, '2023-05-01', '2023-11-30', N'Đang thực hiện');

-- Chèn dữ liệu mẫu vào bảng Kỹ năng
INSERT INTO KyNang (MaKyNang, TenKyNang, LoaiKyNang)
VALUES 
(1, 'Java', N'Ngôn ngữ lập trình'),
(2, 'Python', N'Ngôn ngữ lập trình'),
(3, 'Machine Learning', N'Công nghệ'),
(4, 'AWS', N'Nền tảng đám mây'),
(5, 'Docker', N'Công cụ'),
(6, 'Kubernetes', N'Công cụ'),
(7, 'SQL', N'Cơ sở dữ liệu'),
(8, 'NoSQL', N'Cơ sở dữ liệu'),
(9, 'React', N'Framework'),
(10, 'Angular', N'Framework');

-- Chèn dữ liệu mẫu vào bảng Chuyên gia - Kỹ năng
INSERT INTO ChuyenGia_KyNang (MaChuyenGia, MaKyNang, CapDo)
VALUES 
(1, 1, 5), (1, 7, 4), (1, 9, 3),
(2, 2, 4), (2, 3, 3), (2, 8, 4),
(3, 2, 5), (3, 3, 5), (3, 4, 3),
(4, 2, 4), (4, 7, 5), (4, 8, 4),
(5, 4, 5), (5, 5, 4), (5, 6, 4),
(6, 2, 4), (6, 3, 3), (6, 7, 5),
(7, 1, 3), (7, 2, 4), (7, 5, 3),
(8, 9, 5), (8, 10, 4),
(9, 5, 5), (9, 6, 5), (9, 4, 4),
(10, 2, 3), (10, 3, 3), (10, 8, 4);

-- Chèn dữ liệu mẫu vào bảng Chuyên gia - Dự án
INSERT INTO ChuyenGia_DuAn (MaChuyenGia, MaDuAn, VaiTro, NgayThamGia)
VALUES 
(1, 1, N'Trưởng nhóm phát triển', '2023-01-01'),
(2, 4, N'Chuyên gia bảo mật', '2023-04-01'),
(3, 5, N'Kỹ sư AI', '2023-05-01'),
(4, 2, N'Chuyên gia phân tích dữ liệu', '2023-03-15'),
(5, 3, N'Kiến trúc sư đám mây', '2023-02-01'),
(6, 2, N'Chuyên gia phân tích dữ liệu', '2023-03-15'),
(7, 3, N'Kỹ sư IoT', '2023-02-01'),
(8, 1, N'Nhà thiết kế UX/UI', '2023-01-01'),
(9, 3, N'Kỹ sư DevOps', '2023-02-01'),
(10, 5, N'Kỹ sư Blockchain', '2023-05-01');

-- 51. Hiển thị tất cả thông tin của bảng ChuyenGia.
SELECT * FROM ChuyenGia
-- 52. Liệt kê họ tên và email của tất cả chuyên gia.
SELECT HoTen, Email
FROM ChuyenGia
-- 53. Hiển thị tên công ty và số nhân viên của tất cả các công ty.
SELECT TenCongTy, SoNhanVien
FROM CongTy
-- 54. Liệt kê tên các dự án đang trong trạng thái 'Đang thực hiện'.
SELECT TenDuAn 
FROM DuAn
WHERE TrangThai = N'Đang thực hiện'
-- 55. Hiển thị tên và loại của tất cả các kỹ năng.
SELECT TenKyNang, LoaiKyNang
FROM KyNang
-- 56. Liệt kê họ tên và chuyên ngành của các chuyên gia nam.
SELECT HoTen, ChuyenNganh
FROM ChuyenGia
WHERE GioiTinh = N'Nam'
-- 57. Hiển thị tên công ty và lĩnh vực của các công ty có trên 150 nhân viên.
SELECT TenCongTy, LinhVuc
FROM CongTy
WHERE SoNhanVien > 150
-- 58. Liệt kê tên các dự án bắt đầu trong năm 2023.
SELECT TenDuAn
FROM DuAn
WHERE YEAR(NgayBatDau) = 2023
-- 59. Hiển thị tên kỹ năng thuộc loại 'Công cụ'.
SELECT TenKyNang
FROM KyNang
WHERE LoaiKyNang = N'Công cụ'
-- 60. Liệt kê họ tên và số năm kinh nghiệm của các chuyên gia có trên 5 năm kinh nghiệm.
SELECT HoTen, NamKinhNghiem
FROM ChuyenGia
WHERE NamKinhNghiem > 5
-- 61. Hiển thị tên công ty và địa chỉ của các công ty trong lĩnh vực 'Phát triển phần mềm'.
SELECT TenCongTy, DiaChi
FROM CongTy
WHERE LinhVuc = N'Phát triển phần mềm'
-- 62. Liệt kê tên các dự án có ngày kết thúc trong năm 2023.
SELECT TenDuAn
FROM DuAn
WHERE YEAR(NgayKetThuc) = 2023
-- 63. Hiển thị tên và cấp độ của các kỹ năng trong bảng ChuyenGia_KyNang.
SELECT TenKyNang, CapDo
FROM ChuyenGia_KyNang INNER JOIN KyNang ON ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
-- 64. Liệt kê mã chuyên gia và vai trò trong các dự án từ bảng ChuyenGia_DuAn.
SELECT MaChuyenGia, VaiTro
FROM ChuyenGia_DuAn
-- 65. Hiển thị họ tên và ngày sinh của các chuyên gia sinh năm 1990 trở về sau.
SELECT HoTen, NgaySinh
FROM ChuyenGia
WHERE YEAR(NgaySinh) >= 1990
-- 66. Liệt kê tên công ty và số nhân viên, sắp xếp theo số nhân viên giảm dần.
SELECT TenCongTy, SoNhanVien
FROM CongTy
ORDER BY SoNhanVien DESC
-- 67. Hiển thị tên dự án và ngày bắt đầu, sắp xếp theo ngày bắt đầu tăng dần.
SELECT TenDuAn, NgayBatDau
FROM DuAn
ORDER BY NgayBatDau ASC
-- 68. Liệt kê tên kỹ năng, chỉ hiển thị mỗi tên một lần (loại bỏ trùng lặp).
SELECT DISTINCT TenKyNang
FROM KyNang
-- 69. Hiển thị họ tên và email của 5 chuyên gia đầu tiên trong danh sách.
SELECT TOP 5 HoTen, Email
FROM ChuyenGia
-- 70. Liệt kê tên công ty có chứa từ 'Tech' trong tên.
SELECT TenCongTy
FROM CongTy
WHERE TenCongTy LIKE '%Tech%'
-- 71. Hiển thị tên dự án và trạng thái, không bao gồm các dự án đã hoàn thành.
SELECT TenDuAn, TrangThai
FROM DuAn
WHERE TrangThai <> N'Hoàn Thành'
-- 72. Liệt kê họ tên và chuyên ngành của các chuyên gia, sắp xếp theo chuyên ngành và họ tên.
SELECT HoTen, ChuyenNganh
FROM ChuyenGia
ORDER BY ChuyenNganh, HoTen
-- 73. Hiển thị tên công ty và lĩnh vực, chỉ bao gồm các công ty có từ 100 đến 200 nhân viên.
SELECT TenCongTy, LinhVuc
FROM CongTy
WHERE SoNhanVien BETWEEN 100 AND 200
-- 74. Liệt kê tên kỹ năng và loại kỹ năng, sắp xếp theo loại kỹ năng giảm dần và tên kỹ năng tăng dần.
SELECT TenKyNang, LoaiKyNang
FROM KyNang
ORDER BY LoaiKyNang DESC /*SX theo loai ky nang giam dan*/
SELECT TenKyNang, LoaiKyNang
FROM KyNang
ORDER BY TenKyNang ASC /*SX theo ten ky nang tang dan*/
-- 75. Hiển thị họ tên và số điện thoại của các chuyên gia có email sử dụng tên miền 'email.com'.
SELECT HoTen, SoDienThoai
FROM ChuyenGia
WHERE Email LIKE N'%email.com'

-----------------------------------------------------------------------------------------------------
/*BTVN BUOI 2*/
--1 Liệt kê tất cả các chuyên gia và sắp xếp theo họ tên.
SELECT * FROM ChuyenGia
ORDER BY HoTen

--2 Hiển thị tên và số điện thoại của các chuyên gia có chuyên ngành 'Phát triển phần mềm'.
SELECT HoTen, SoDienThoai
FROM ChuyenGia
WHERE ChuyenNganh = N'Phát triển phần mềm'

--3 Liệt kê tất cả các công ty có trên 100 nhân viên.
SELECT * FROM CongTy
WHERE SoNhanVien > 100

--4 Hiển thị tên và ngày bắt đầu của các dự án bắt đầu trong năm 2023.
SELECT TenDuAn, NgayBatDau
FROM DuAn
WHERE YEAR(NgayBatDau) = 2023

--5 Liệt kê tất cả các kỹ năng và sắp xếp theo tên kỹ năng.
SELECT TenKyNang
FROM KyNang
ORDER BY TenKyNang

--6 Hiển thị tên và email của các chuyên gia có tuổi dưới 35 (tính đến năm 2024).
SELECT HoTen, Email
FROM ChuyenGia
WHERE DATEDIFF(YEAR, NgaySinh, '1/1/2024') < 35

--7 Hiển thị tên và chuyên ngành của các chuyên gia nữ.
SELECT HoTen, ChuyenNganh
FROM ChuyenGia
WHERE GioiTinh = N'Nữ'

--8 Liệt kê tên các kỹ năng thuộc loại 'Công nghệ'.
SELECT TenKyNang
FROM KyNang
WHERE LoaiKyNang = N'Công Nghệ'

--9 Hiển thị tên và địa chỉ của các công ty trong lĩnh vực 'Phân tích dữ liệu'.
SELECT TenCongTy, DiaChi
FROM CongTy
WHERE LinhVuc = N'Phân tích dữ liệu'

--10 Liệt kê tên các dự án có trạng thái 'Hoàn thành'.
SELECT TenDuAn
FROM DuAn
WHERE TrangThai = N'Hoàn thành'

--11 Hiển thị tên và số năm kinh nghiệm của các chuyên gia, sắp xếp theo số năm kinh nghiệm giảm dần.
SELECT HoTen, NamKinhNghiem
FROM ChuyenGia
ORDER BY NamKinhNghiem DESC

--12 Liệt kê tên các công ty và số lượng nhân viên, chỉ hiển thị các công ty có từ 100 đến 200 nhân viên.
SELECT TenCongTy, SoNhanVien
FROM CongTy
WHERE SoNhanVien BETWEEN 100 AND 200

--13 Hiển thị tên dự án và ngày kết thúc của các dự án kết thúc trong năm 2023.
SELECT TenDuAn, NgayKetThuc
FROM DuAn
WHERE YEAR(NgayKetThuc) = 2023

--14 Liệt kê tên và email của các chuyên gia có tên bắt đầu bằng chữ 'N'.
SELECT HoTen, Email
FROM ChuyenGia
WHERE RIGHT(HoTen, (CHARINDEX(' ', REVERSE(HoTen)) - 1)) LIKE 'N%'

--15 Hiển thị tên kỹ năng và loại kỹ năng, không bao gồm các kỹ năng thuộc loại 'Ngôn ngữ lập trình'.
SELECT TenKyNang, LoaiKyNang
FROM KyNang
WHERE LoaiKyNang <> N'Ngôn ngữ lập trình'

--16 Hiển thị tên công ty và lĩnh vực hoạt động, sắp xếp theo lĩnh vực.
SELECT TenCongTy, LinhVuc
FROM CongTy
ORDER BY LinhVuc
--17 Hiển thị tên và chuyên ngành của các chuyên gia nam có trên 5 năm kinh nghiệm.
SELECT HoTen, ChuyenNganh
FROM ChuyenGia
WHERE (GioiTinh = 'Nam') AND (NamKinhNghiem > 5)

--18 Liệt kê tất cả các chuyên gia trong cơ sở dữ liệu.
SELECT * FROM ChuyenGia

--19 Hiển thị tên và email của tất cả các chuyên gia nữ.
SELECT HoTen, Email
FROM ChuyenGia
WHERE GioiTinh = N'Nữ'

--20 Liệt kê tất cả các công ty và số nhân viên của họ, sắp xếp theo số nhân viên giảm dần.
SELECT *
FROM CongTy
ORDER BY SoNhanVien DESC

--21 Hiển thị tất cả các dự án đang trong trạng thái "Đang thực hiện".
SELECT * 
FROM DuAn
WHERE TrangThai = N'Đang thực hiện'

--22 Liệt kê tất cả các kỹ năng thuộc loại "Ngôn ngữ lập trình".
SELECT *
FROM KyNang
WHERE LoaiKyNang = N'Ngôn ngữ lập trình'

--23 Hiển thị tên và chuyên ngành của các chuyên gia có trên 8 năm kinh nghiệm.
SELECT HoTen, ChuyenNganh
FROM ChuyenGia
WHERE NamKinhNghiem > 8

--24 Liệt kê tất cả các dự án của công ty có MaCongTy là 1.
SELECT *
FROM DuAn
WHERE MaCongTy = 1

--25 Đếm số lượng chuyên gia trong mỗi chuyên ngành.
SELECT ChuyenNganh, COUNT(MaChuyenGia) SL
FROM ChuyenGia
GROUP BY ChuyenNganh

--26 Tìm chuyên gia có số năm kinh nghiệm cao nhất.
SELECT MaChuyenGia, HoTen, NamKinhNghiem
FROM ChuyenGia
WHERE NamKinhNghiem = ( SELECT MAX(NamKinhNghiem) FROM ChuyenGia)

--27 Liệt kê tổng số nhân viên cho mỗi công ty mà có số nhân viên lớn hơn 100. Sắp xếp kết quả theo số nhân viên tăng dần.
SELECT MaCongTy, TenCongTy, SoNhanVien
FROM CongTy
WHERE SoNhanVien > 100
ORDER BY SoNhanVien ASC
--28 Xác định số lượng dự án mà mỗi công ty tham gia có trạng thái 'Đang thực hiện'. Chỉ bao gồm các công ty có hơn một dự án đang thực hiện. Sắp xếp kết quả theo số lượng dự án giảm dần.
SELECT CongTy.MaCongTy, TenCongTy, CK.SL
FROM 
(
	SELECT MaCongTy, COUNT(MaDuAn) SL
	FROM DuAn
	WHERE TrangThai = N'Đang thực hiện'
	GROUP BY MaCongTy
	HAVING COUNT(MaDuAn) > 1
) CK
INNER JOIN CongTy ON CK.MaCongTy = CongTy.MaCongTy
ORDER BY SL DESC

--29 Tìm kiếm các kỹ năng mà chuyên gia có cấp độ từ 4 trở lên và tính tổng số chuyên gia cho mỗi kỹ năng đó. Chỉ bao gồm những kỹ năng có tổng số chuyên gia lớn hơn 2. Sắp xếp kết quả theo tên kỹ năng tăng dần.
SELECT CK.MaKyNang, TenKyNang, CK.SL
FROM 
(
	SELECT MaKyNang, COUNT(MaKyNang) SL
	FROM ChuyenGia_KyNang
	WHERE CapDo >= 4
	GROUP BY ChuyenGia_KyNang.MaKyNang
	HAVING COUNT(MaChuyenGia) > 2
) CK
INNER JOIN KyNang ON CK.MaKyNang = KyNang.MaKyNang
ORDER BY TenKyNang ASC

--30 Liệt kê tên các công ty có lĩnh vực 'Điện toán đám mây' và tính tổng số nhân viên của họ. Sắp xếp kết quả theo tổng số nhân viên tăng dần.
SELECT TenCongTy, SoNhanVien
FROM CongTy
WHERE LinhVuc = N'Điện toán đám mây'
ORDER BY SoNhanVien ASC
SELECT SUM(SoNhanVien) TongNV
FROM CongTy
WHERE LinhVuc = N'Điện toán đám mây'

--31 Liệt kê tên các công ty có số nhân viên từ 50 đến 150 và tính trung bình số nhân viên của họ. Sắp xếp kết quả theo tên công ty tăng dần.
SELECT TenCongTy, SoNhanVien
FROM CongTy
WHERE SoNhanVien BETWEEN 50 AND 150
ORDER BY TenCongTy ASC
SELECT ROUND(AVG(SoNhanVien),2) TB_NV
FROM CongTy
WHERE SoNhanVien BETWEEN 50 AND 150

--32 Xác định số lượng kỹ năng cho mỗi chuyên gia có cấp độ tối đa là 5 và chỉ bao gồm những chuyên gia có ít nhất một kỹ năng đạt cấp độ tối đa này. Sắp xếp kết quả theo tên chuyên gia tăng dần.
SELECT KQ.MaChuyenGia, HoTen, KQ.SLKN
FROM
(
	SELECT CK.MaChuyenGia, COUNT(MaKyNang) SLKN
	FROM
	(
		SELECT MaChuyenGia
		FROM ChuyenGia_KyNang
		WHERE CapDo = 5
		EXCEPT
		SELECT MaChuyenGia
		FROM ChuyenGia_KyNang
		WHERE CapDo > 5 
	) CK
	INNER JOIN ChuyenGia_KyNang ON CK.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
	GROUP BY CK.MaChuyenGia
) KQ
INNER JOIN ChuyenGia ON KQ.MaChuyenGia = ChuyenGia.MaChuyenGia
ORDER BY (LTRIM(RIGHT(HoTen, CHARINDEX(' ', REVERSE(HoTen)))))

--33 Liệt kê tên các kỹ năng mà chuyên gia có cấp độ từ 4 trở lên và tính tổng số chuyên gia cho mỗi kỹ năng đó. Chỉ bao gồm những kỹ năng có tổng số chuyên gia lớn hơn 2. Sắp xếp kết quả theo tên kỹ năng tăng dần.
SELECT TenKyNang, CK.SLCG
FROM
(
	SELECT MaKyNang, COUNT(MaChuyenGia) SLCG
	FROM ChuyenGia_KyNang
	WHERE CapDo >= 4
	GROUP BY MaKyNang
	HAVING COUNT(MaChuyenGia) > 2
) CK
INNER JOIN KyNang ON CK.MaKyNang = KyNang.MaKyNang
ORDER BY TenKyNang ASC

--34 Tìm kiếm tên của các chuyên gia trong lĩnh vực 'Phát triển phần mềm' và tính trung bình cấp độ kỹ năng của họ. Chỉ bao gồm những chuyên gia có cấp độ trung bình lớn hơn 3. Sắp xếp kết quả theo cấp độ trung bình giảm dần.
SELECT HoTen, KQ.TB
FROM
(	
	(
		SELECT MaChuyenGia
		FROM ChuyenGia
		WHERE ChuyenNganh = N'Phát triển phần mềm'
	) CK
	INNER JOIN
	(	
		SELECT MaChuyenGia, AVG(CapDo) TB
		FROM ChuyenGia_KyNang
		GROUP BY MaChuyenGia
		HAVING AVG(CapDo) > 3
	) KQ ON KQ.MaChuyenGia = CK.MaChuyenGia
)
INNER JOIN ChuyenGia ON KQ.MaChuyenGia = ChuyenGia.MaChuyenGia
ORDER BY TB DESC

/*
SELECT HoTen, CK.TB
FROM
(	
	SELECT MaChuyenGia, AVG(CapDo) TB
	FROM ChuyenGia_KyNang
	GROUP BY MaChuyenGia
	HAVING AVG(CapDo) > 3
) CK
INNER JOIN ChuyenGia ON CK.MaChuyenGia = ChuyenGia.MaChuyenGia
WHERE ChuyenNganh = N'Phát triển phần mềm'
ORDER BY TB DESC
*/

------------------------------------------------------------------------------------------------------------------
/*BTVN BUOI 3.1*/
-- 8. Hiển thị tên và cấp độ của tất cả các kỹ năng của chuyên gia có MaChuyenGia là 1.
SELECT (SELECT TenKyNang FROM KyNang WHERE KyNang.MaKyNang = ChuyenGia_KyNang.MaKyNang) AS TenKyNang, ChuyenGia_KyNang.CapDo
FROM ChuyenGia_KyNang
WHERE MaChuyenGia = 1

-- 9. Liệt kê tên các chuyên gia tham gia dự án có MaDuAn là 2.
SELECT HoTen
FROM ChuyenGia
WHERE MaChuyenGia IN (SELECT MaChuyenGia
					  FROM ChuyenGia_DuAn
					  WHERE MaDuAn = 2)

-- 10. Hiển thị tên công ty và tên dự án của tất cả các dự án.
SELECT (SELECT TenCongTy FROM CongTy WHERE CongTy.MaCongTy = DuAn.MaCongTy) AS TenCongTy, DuAn.TenDuAn
FROM DuAn

-- 11. Đếm số lượng chuyên gia trong mỗi chuyên ngành.
SELECT ChuyenNganh, COUNT(MaChuyenGia) SLCG
FROM ChuyenGia
GROUP BY ChuyenNganh

-- 12. Tìm chuyên gia có số năm kinh nghiệm cao nhất.
SELECT MaChuyenGia, HoTen
FROM ChuyenGia
WHERE NamKinhNghiem = (SELECT MAX(NamKinhNghiem)
					   FROM ChuyenGia)

-- 13. Liệt kê tên các chuyên gia và số lượng dự án họ tham gia.
SELECT HoTen, A.SLDA
FROM ChuyenGia
	 INNER JOIN (SELECT MaChuyenGia, COUNT(MaDuAn) SLDA
				 FROM ChuyenGia_DuAn
				 GROUP BY MaChuyenGia) A ON A.MaChuyenGia = ChuyenGia.MaChuyenGia

-- 14. Hiển thị tên công ty và số lượng dự án của mỗi công ty.
SELECT TenCongTy, A.SLDA
FROM CongTy
	 INNER JOIN (SELECT MaCongTy, COUNT(MaDuAn) SLDA
				 FROM DuAn
				 GROUP BY MaCongTy) A ON A.MaCongTy = CongTy.MaCongTy

-- 15. Tìm kỹ năng được sở hữu bởi nhiều chuyên gia nhất.
SELECT TenKyNang
FROM KyNang
WHERE MaKyNang IN (SELECT A.MaKyNang
				   FROM (SELECT MaKyNang, COUNT(MaChuyenGia) SLCGSH
						 FROM ChuyenGia_KyNang
						 GROUP BY MaKyNang) A
				   WHERE A.SLCGSH = (SELECT MAX(B.SLCGSH)
									 FROM (SELECT COUNT(MaChuyenGia) SLCGSH
										   FROM ChuyenGia_KyNang
										   GROUP BY MaKyNang) B)
)

-- 16. Liệt kê tên các chuyên gia có kỹ năng 'Python' với cấp độ từ 4 trở lên.
SELECT HoTen
FROM ChuyenGia
WHERE MaChuyenGia IN (SELECT MaChuyenGia
					  FROM ChuyenGia_KyNang
					  WHERE CapDo >= 4 AND MaKyNang IN (SELECT MaKyNang
														FROM KyNang
														WHERE TenKyNang = 'Python'))

-- 17. Tìm dự án có nhiều chuyên gia tham gia nhất.
SELECT MaDuAn
FROM (SELECT MaDuAn, COUNT(MaChuyenGia) SLCGTG
	  FROM ChuyenGia_DuAn
	  GROUP BY MaDuAn) A
	  WHERE A.SLCGTG = (SELECT MAX(B.SLCGTG)
						FROM (SELECT MaDuAn, COUNT(MaChuyenGia) SLCGTG
							  FROM ChuyenGia_DuAn
							  GROUP BY MaDuAn) B)

-- 18. Hiển thị tên và số lượng kỹ năng của mỗi chuyên gia.
SELECT HoTen, A.SLKN
FROM ChuyenGia
	 INNER JOIN (SELECT MaChuyenGia, COUNT(MaKyNang) SLKN
				 FROM ChuyenGia_KyNang
				 GROUP BY MaChuyenGia) A ON A.MaChuyenGia = ChuyenGia.MaChuyenGia

-- 19. Tìm các cặp chuyên gia làm việc cùng dự án.
SELECT DuAn.TenDuAn, CG1.MaChuyenGia AS MaChuyenGia1, CG2.MaChuyenGia AS MaChuyenGia2
FROM ChuyenGia_DuAn AS CG1
	 INNER JOIN ChuyenGia_DuAn AS CG2 ON CG1.MaDuAn = CG2.MaDuAn AND CG1.MaChuyenGia < CG2.MaChuyenGia
	 INNER JOIN DuAn ON CG1.MaDuAn = DuAn.MaDuAn
	
-- 20. Liệt kê tên các chuyên gia và số lượng kỹ năng cấp độ 5 của họ.
SELECT HoTen, A.SLKNC5
FROM ChuyenGia
	 INNER JOIN (SELECT MaChuyenGia, COUNT(MaKyNang) SLKNC5
				 FROM ChuyenGia_KyNang
				 WHERE CapDo = 5
				 GROUP BY MaChuyenGia) A ON A.MaChuyenGia = ChuyenGia.MaChuyenGia

-- 21. Tìm các công ty không có dự án nào.
SELECT MaCongTY
FROM CongTy
WHERE MaCongTy NOT IN (SELECT MaCongTy
					   FROM DuAn)
-- 22. Hiển thị tên chuyên gia và tên dự án họ tham gia, bao gồm cả chuyên gia không tham gia dự án nào.
SELECT HoTen, TenDuAn
FROM ChuyenGia
	 LEFT JOIN (SELECT MaChuyenGia, ChuyenGia_DuAn.MaDuAn, TenDuAn
				FROM ChuyenGia_DuAn
					 INNER JOIN DuAn ON ChuyenGia_DuAn.MaDuAn = DuAn.MaDuAn) A ON A.MaChuyenGia = ChuyenGia.MaChuyenGia

-- 23. Tìm các chuyên gia có ít nhất 3 kỹ năng.
SELECT A.MaChuyenGia
FROM (SELECT MaChuyenGia, COUNT(MaKyNang) SLKN
	  FROM ChuyenGia_KyNang
	  GROUP BY MaChuyenGia
	  HAVING COUNT(MaKyNang) >= 3) A
-- 24. Hiển thị tên công ty và tổng số năm kinh nghiệm của tất cả chuyên gia trong các dự án của công ty đó.
SELECT TenCongTy, A.SNKNCG
FROM CongTy
	 INNER JOIN (SELECT MaCongTy, ChuyenGia_DuAn.MaDuAn, SUM(NamKinhNghiem) SNKNCG
				 FROM ChuyenGia_DuAn
					  INNER JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
					  INNER JOIN DuAn ON ChuyenGia_DuAn.MaDuAn = DuAn.MaDuAn
				 GROUP BY ChuyenGia_DuAn.MaDuAn, MaCongTy) A ON CongTy.MaCongTy = A.MaCongTy

-- 25. Tìm các chuyên gia có kỹ năng 'Java' nhưng không có kỹ năng 'Python'.
SELECT MaChuyenGia
FROM ChuyenGia_KyNang
WHERE MaKyNang IN (SELECT MaKyNang
				   FROM KyNang
				   WHERE TenKyNang = 'Java' AND MaKyNang NOT IN (SELECT MaKyNang
																 FROM KyNang
																 WHERE TenKyNang = 'Python'))
-- 76. Tìm chuyên gia có số lượng kỹ năng nhiều nhất.
SELECT A.MaChuyenGia
FROM (SELECT MaChuyenGia, COUNT(MaKyNang) SLKN
	  FROM ChuyenGia_KyNang
	  GROUP BY MaChuyenGia) A
	  WHERE A.SLKN = (SELECT MAX(B.SLKN) 
					  FROM (SELECT COUNT(MaKyNang) SLKN
							FROM ChuyenGia_KyNang
							GROUP BY MaChuyenGia) B)

-- 77. Liệt kê các cặp chuyên gia có cùng chuyên ngành.
SELECT CG1.ChuyenNganh, CG1.MaChuyenGia AS MaChuyenGia1, CG2.MaChuyenGia AS MaChuyenGia2
FROM ChuyenGia AS CG1
	 INNER JOIN ChuyenGia AS CG2 ON CG1.ChuyenNganh = CG2.ChuyenNganh AND CG1.MaChuyenGia < CG2.MaChuyenGia

-- 78. Tìm công ty có tổng số năm kinh nghiệm của các chuyên gia trong dự án cao nhất.
SELECT TenCongTy, A.SNKNCG
FROM CongTy
	 INNER JOIN (SELECT MaCongTy, ChuyenGia_DuAn.MaDuAn, SUM(NamKinhNghiem) SNKNCG
				 FROM ChuyenGia_DuAn
					  INNER JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
					  INNER JOIN DuAn ON ChuyenGia_DuAn.MaDuAn = DuAn.MaDuAn
				 GROUP BY ChuyenGia_DuAn.MaDuAn, MaCongTy) A ON CongTy.MaCongTy = A.MaCongTy
WHERE A.SNKNCG = (SELECT MAX(B.SNKNCG)
				  FROM (SELECT ChuyenGia_DuAn.MaDuAn, SUM(NamKinhNghiem) SNKNCG
						FROM ChuyenGia_DuAn
							 INNER JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
						GROUP BY ChuyenGia_DuAn.MaDuAn) B)

-- 79. Tìm kỹ năng được sở hữu bởi tất cả các chuyên gia.
SELECT TenKyNang
FROM KyNang KN
WHERE NOT EXISTS (SELECT *
				  FROM ChuyenGia CG
				  WHERE NOT EXISTS (SELECT *
									FROM ChuyenGia_KyNang CG_KN
									WHERE CG_KN.MaChuyenGia = CG.MaChuyenGia AND CG_KN.MaKyNang = KN.MaKyNang))

--------------------------------------------------------------------------------------------------------
/*BUOI 3.2*/
--1. Hiển thị tên và cấp độ của tất cả các kỹ năng của chuyên gia có MaChuyenGia là 1, đồng thời lọc ra những kỹ năng có cấp độ thấp hơn 3.
SELECT (SELECT TenKyNang FROM KyNang WHERE KyNang.MaKyNang = ChuyenGia_KyNang.MaKyNang) AS TenKyNang, ChuyenGia_KyNang.CapDo
FROM ChuyenGia_KyNang
WHERE MaChuyenGia = 1 AND CapDo < 3

--2. Liệt kê tên các chuyên gia tham gia dự án có MaDuAn là 2 và có ít nhất 2 kỹ năng khác nhau.
SELECT HoTen
FROM ChuyenGia
WHERE MaChuyenGia IN (SELECT MaChuyenGia
					  FROM ChuyenGia_DuAn
					  WHERE MaDuAn = 2
					  INTERSECT
					  SELECT MaChuyenGia
					  FROM ChuyenGia_KyNang
					  GROUP BY MaChuyenGia
					  HAVING COUNT(MaKyNang) >= 2) 

--3. Hiển thị tên công ty và tên dự án của tất cả các dự án, sắp xếp theo tên công ty và số lượng chuyên gia tham gia dự án.
SELECT TenCongTy, TenDuAn
FROM CongTy
	 INNER JOIN DuAn ON CongTy.MaCongTy = DuAn.MaCongTy
WHERE CongTy.MaCongTy IN (SELECT A.MaCongTy
				   FROM (SELECT CongTy.MaCongTy, DuAn.MaDuAn, COUNT(MaChuyenGia) AS SLCG
						 FROM CongTy
							  INNER JOIN DuAn ON CongTy.MaCongTy = DuAn.MaCongTy
							  INNER JOIN ChuyenGia_DuAn ON ChuyenGia_DuAn.MaDuAn = DuAn.MaDuAn
						 GROUP BY CongTy.MaCongTy, DuAn.MaDuAn) A)
ORDER BY TenCongTy

--4. Đếm số lượng chuyên gia trong mỗi chuyên ngành và hiển thị chỉ những chuyên ngành có hơn 5 chuyên gia.
SELECT ChuyenNganh, COUNT(MaChuyenGia) SLCG
FROM ChuyenGia
GROUP BY ChuyenNganh
HAVING COUNT(MaChuyenGia) > 5

--5. Tìm chuyên gia có số năm kinh nghiệm cao nhất và hiển thị cả danh sách kỹ năng của họ.
SELECT ChuyenGia.MaChuyenGia, MaKyNang
FROM ChuyenGia
	 INNER JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
WHERE NamKinhNghiem >= ALL(SELECT NamKinhNghiem
						   FROM ChuyenGia)

--6. Liệt kê tên các chuyên gia và số lượng dự án họ tham gia, đồng thời tính toán tỷ lệ phần trăm so với tổng số dự án trong hệ thống.
SELECT HoTen,
       COUNT(ChuyenGia_DuAn.MaDuAn) AS SoLuongDuAn,
       (COUNT(ChuyenGia_DuAn.MaDuAn) * 100.0 / (SELECT COUNT(DISTINCT MaDuAn) FROM DuAn)) AS TyLePhanTram
FROM ChuyenGia
LEFT JOIN ChuyenGia_DuAn ON ChuyenGia.MaChuyenGia = ChuyenGia_DuAn.MaChuyenGia
GROUP BY HoTen

--7. Hiển thị tên công ty và số lượng dự án của mỗi công ty, bao gồm cả những công ty không có dự án nào.
SELECT TenCongTy, COUNT(MaDuAn) AS SLDA
FROM CongTy
LEFT JOIN DuAn ON CongTy.MaCongTy = DuAn.MaCongTy
GROUP BY TenCongTy

--8. Tìm kỹ năng được sở hữu bởi nhiều chuyên gia nhất, đồng thời hiển thị số lượng chuyên gia sở hữu kỹ năng đó.
SELECT MaKyNang, COUNT(MaChuyenGia) AS SLCG
FROM ChuyenGia_KyNang
GROUP BY MaKyNang
HAVING COUNT(MaChuyenGia) >= ALL (SELECT COUNT(MaChuyenGia) AS SLCG
								  FROM ChuyenGia_KyNang
								  GROUP BY MaKyNang)

--9. Liệt kê tên các chuyên gia có kỹ năng 'Python' với cấp độ từ 4 trở lên, đồng thời tìm kiếm những người cũng có kỹ năng 'Java'.
SELECT HoTen
FROM ChuyenGia
WHERE MaChuyenGia IN (SELECT MaChuyenGia
					  FROM ChuyenGia_KyNang
						   INNER JOIN KyNang ON ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
					  WHERE TenKyNang = 'Python' AND CapDo >= 4
					  INTERSECT
					  SELECT MaChuyenGia
					  FROM ChuyenGia_KyNang
						   INNER JOIN KyNang ON ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
					  WHERE TenKyNang = 'Java')

--10. Tìm dự án có nhiều chuyên gia tham gia nhất và hiển thị danh sách tên các chuyên gia tham gia vào dự án đó.
SELECT ChuyenGia_DuAn.MaDuAn, HoTen
FROM (SELECT MaDuAn
	  FROM ChuyenGia_DuAn
	  GROUP BY MaDuAn
	  HAVING COUNT(MaChuyenGia) >= ALL (SELECT COUNT(MaChuyenGia)
									    FROM ChuyenGia_DuAn
										GROUP BY MaDuAn)) AS A
INNER JOIN ChuyenGia_DuAn ON A.MaDuAn = ChuyenGia_DuAn.MaDuAn
INNER JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia	  

--11. Hiển thị tên và số lượng kỹ năng của mỗi chuyên gia, đồng thời lọc ra những người có ít nhất 5 kỹ năng.
SELECT HoTen, COUNT(MaKyNang) AS SLKN
FROM ChuyenGia_KyNang
	 INNER JOIN ChuyenGia ON ChuyenGia_KyNang.MaChuyenGia = ChuyenGia.MaChuyenGia
GROUP BY ChuyenGia_KyNang.MaChuyenGia, HoTen
HAVING COUNT(MaKyNang) >= 5

--12. Tìm các cặp chuyên gia làm việc cùng dự án và hiển thị thông tin về số năm kinh nghiệm của từng cặp.
SELECT DA.MaDuAn,
	   CG1.HoTen AS TenChuyenGia1, 
       CG1.NamKinhNghiem AS SoNamKinhNghiem1,
       CG2.HoTen AS TenChuyenGia2, 
       CG2.NamKinhNghiem AS SoNamKinhNghiem2
FROM ChuyenGia_DuAn DA
	 INNER JOIN ChuyenGia_DuAn DA2 ON DA.MaDuAn = DA2.MaDuAn AND DA.MaChuyenGia < DA2.MaChuyenGia
	 INNER JOIN ChuyenGia CG1 ON DA.MaChuyenGia = CG1.MaChuyenGia
	 INNER JOIN ChuyenGia CG2 ON DA2.MaChuyenGia = CG2.MaChuyenGia

--13. Liệt kê tên các chuyên gia và số lượng kỹ năng cấp độ 5 của họ, đồng thời tính toán tỷ lệ phần trăm so với tổng số kỹ năng mà họ sở hữu.
SELECT ChuyenGia.HoTen,
       COUNT(CASE WHEN ChuyenGia_KyNang.CapDo = 5 THEN 1 END) AS SLKNC5,
       (COUNT(CASE WHEN ChuyenGia_KyNang.CapDo = 5 THEN 1 END) * 100.0 / 
           COUNT(ChuyenGia_KyNang.MaKyNang)
       ) AS TyLePhanTram
FROM ChuyenGia
LEFT JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
GROUP BY ChuyenGia.HoTen

--14. Tìm các công ty không có dự án nào và hiển thị cả thông tin về số lượng nhân viên trong mỗi công ty đó.
SELECT MaCongTy, TenCongTy, SoNhanVien
FROM CongTy
WHERE MaCongTy NOT IN (SELECT MaCongTy
					   FROM DuAn)

--15. Hiển thị tên chuyên gia và tên dự án họ tham gia, bao gồm cả những chuyên gia không tham gia dự án nào, sắp xếp theo tên chuyên gia.
SELECT HoTen, TenDuAn
FROM ChuyenGia CG
	 LEFT JOIN (SELECT DuAn.MaDuAn, MaChuyenGia, TenDuAn
				FROM ChuyenGia_DuAn
					 INNER JOIN DuAn ON ChuyenGia_DuAn.MaDuAn = DuAn.MaDuAn) A ON CG.MaChuyenGia = A.MaChuyenGia
ORDER BY HoTen

--16. Tìm các chuyên gia có ít nhất 3 kỹ năng, đồng thời lọc ra những người không có bất kỳ kỹ năng nào ở cấp độ cao hơn 3.
SELECT MaChuyenGia
FROM ChuyenGia_KyNang
GROUP BY MaChuyenGia
HAVING COUNT(MaKyNang) >= 3
INTERSECT
SELECT MaChuyenGia
FROM ChuyenGia_KyNang
WHERE CapDo > 3

--17. Hiển thị tên công ty và tổng số năm kinh nghiệm của tất cả chuyên gia trong các dự án của công ty đó, chỉ hiển thị những công ty có tổng số năm kinh nghiệm lớn hơn 10 năm.
SELECT TenCongTy, A.SNKNCG
FROM CongTy
	 INNER JOIN (SELECT MaCongTy, ChuyenGia_DuAn.MaDuAn, SUM(NamKinhNghiem) SNKNCG
				 FROM ChuyenGia_DuAn
					  INNER JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
					  INNER JOIN DuAn ON ChuyenGia_DuAn.MaDuAn = DuAn.MaDuAn
				 GROUP BY ChuyenGia_DuAn.MaDuAn, MaCongTy) A ON CongTy.MaCongTy = A.MaCongTy
WHERE SNKNCG > 10

--18. Tìm các chuyên gia có kỹ năng 'Java' nhưng không có kỹ năng 'Python', đồng thời hiển thị danh sách các dự án mà họ đã tham gia.
SELECT MaChuyenGia, MaDuAn
FROM ChuyenGia_DuAn
WHERE MaChuyenGia IN (SELECT MaChuyenGia
					  FROM ChuyenGia_KyNang
						   INNER JOIN KyNang ON ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
					  WHERE TenKyNang = 'Java'
					  EXCEPT 
					  SELECT MaChuyenGia
					  FROM ChuyenGia_KyNang
						   INNER JOIN KyNang ON ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
					  WHERE TenKyNang = 'Python')

--19. Tìm chuyên gia có số lượng kỹ năng nhiều nhất và hiển thị cả danh sách các dự án mà họ đã tham gia.
SELECT MaChuyenGia, MaDuAn
FROM ChuyenGia_DuAn
WHERE MaChuyenGia IN (SELECT MaChuyenGia
					  FROM ChuyenGia_KyNang
					  GROUP BY MaChuyenGia
					  HAVING COUNT(MaKyNang) >= ALL (SELECT COUNT(MaKyNang)
													FROM ChuyenGia_KyNang
													GROUP BY MaChuyenGia))

--20. Liệt kê các cặp chuyên gia có cùng chuyên ngành và hiển thị thông tin về số năm kinh nghiệm của từng người trong cặp đó.
SELECT CG1.ChuyenNganh, CG1.MaChuyenGia AS MaChuyenGia1, CG1.NamKinhNghiem AS SoNamKNCG1, CG2.MaChuyenGia AS MaChuyenGia2, CG2.NamKinhNghiem AS SoNamKNCG2
FROM ChuyenGia AS CG1
	 INNER JOIN ChuyenGia AS CG2 ON CG1.ChuyenNganh = CG2.ChuyenNganh AND CG1.MaChuyenGia < CG2.MaChuyenGia

--21. Tìm công ty có tổng số năm kinh nghiệm của các chuyên gia trong dự án cao nhất và hiển thị danh sách tất cả các dự án mà công ty đó đã thực hiện.
SELECT TenCongTy, A.SNKNCG, A.MaDuAn
FROM CongTy
	 INNER JOIN (SELECT MaCongTy, ChuyenGia_DuAn.MaDuAn, SUM(NamKinhNghiem) SNKNCG
				 FROM ChuyenGia_DuAn
					  INNER JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
					  INNER JOIN DuAn ON ChuyenGia_DuAn.MaDuAn = DuAn.MaDuAn
				 GROUP BY ChuyenGia_DuAn.MaDuAn, MaCongTy) A ON CongTy.MaCongTy = A.MaCongTy
WHERE A.SNKNCG = (SELECT MAX(B.SNKNCG)
				  FROM (SELECT ChuyenGia_DuAn.MaDuAn, SUM(NamKinhNghiem) SNKNCG
						FROM ChuyenGia_DuAn
							 INNER JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
						GROUP BY ChuyenGia_DuAn.MaDuAn) B)

--22. Tìm kỹ năng được sở hữu bởi tất cả các chuyên gia và hiển thị danh sách chi tiết về từng chuyên gia sở hữu kỹ năng đó cùng với cấp độ của họ.
-- Tìm các kỹ năng được sở hữu bởi tất cả các chuyên gia

WITH KyNangToanBo AS (
    SELECT MaKyNang
    FROM ChuyenGia_KyNang
    GROUP BY MaKyNang
    HAVING COUNT(DISTINCT MaChuyenGia) = (SELECT COUNT(*) FROM ChuyenGia)
)
SELECT cg.HoTen, kn.TenKyNang, cgk.CapDo
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang cgk ON cg.MaChuyenGia = cgk.MaChuyenGia
JOIN KyNang kn ON cgk.MaKyNang = kn.MaKyNang
WHERE cgk.MaKyNang IN (SELECT MaKyNang FROM KyNangToanBo)

--23. Tìm tất cả các chuyên gia có ít nhất 2 kỹ năng thuộc cùng một lĩnh vực và hiển thị tên chuyên gia cùng với tên lĩnh vực đó.
SELECT cg.HoTen, kn.LoaiKyNang
FROM ChuyenGia cg
	 INNER JOIN ChuyenGia_KyNang cgk ON cg.MaChuyenGia = cgk.MaChuyenGia
	 INNER JOIN KyNang kn ON cgk.MaKyNang = kn.MaKyNang
GROUP BY cg.HoTen, kn.LoaiKyNang
HAVING COUNT(*) >= 2

--24. Hiển thị tên các dự án và số lượng chuyên gia tham gia cho mỗi dự án, chỉ hiển thị những dự án có hơn 3 chuyên gia tham gia.
SELECT TenDuAn, COUNT(MaChuyenGia) AS SLCG
FROM ChuyenGia_DuAn
	 INNER JOIN DuAn ON ChuyenGia_DuAn.MaDuAn = DuAn.MaDuAn
GROUP BY DuAn.MaDuAn, TenDuAn
HAVING COUNT(MaChuyenGia) > 3

--25.Tìm công ty có số lượng dự án lớn nhất và hiển thị tên công ty cùng với số lượng dự án.
SELECT MaCongTy, COUNT(MaDuAn) AS SLDA
FROM DuAn
GROUP BY MaCongTy
HAVING COUNT(MaDuAn) >= ALL (SELECT COUNT(MaDuAn)
							 FROM DuAn
							 GROUP BY MaCongTy)

--26. Liệt kê tên các chuyên gia có kinh nghiệm từ 5 năm trở lên và có ít nhất 4 kỹ năng khác nhau.
SELECT ChuyenGia.MaChuyenGia, HoTen
FROM ChuyenGia 
	 INNER JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
WHERE NamKinhNghiem >= 5
GROUP BY ChuyenGia.MaChuyenGia, HoTen
HAVING COUNT(MaKyNang) >= 4

--27. Tìm tất cả các kỹ năng mà không có chuyên gia nào sở hữu.
SELECT MaKyNang, TenKyNang
FROM KyNang
WHERE MaKyNang NOT IN (SELECT MaKyNang
					   FROM ChuyenGia_KyNang)

--28. Hiển thị tên chuyên gia và số năm kinh nghiệm của họ, sắp xếp theo số năm kinh nghiệm giảm dần.
SELECT HoTen, NamKinhNghiem
FROM ChuyenGia
ORDER BY NamKinhNghiem DESC

--29. Tìm tất cả các cặp chuyên gia có ít nhất 2 kỹ năng giống nhau.
SELECT cg1.MaChuyenGia AS ChuyenGia1, cg2.MaChuyenGia AS ChuyenGia2, COUNT(*) AS SoLuongKyNangChung
FROM ChuyenGia_KyNang cgk1
JOIN ChuyenGia_KyNang cgk2 ON cgk1.MaKyNang = cgk2.MaKyNang
JOIN ChuyenGia cg1 ON cgk1.MaChuyenGia = cg1.MaChuyenGia
JOIN ChuyenGia cg2 ON cgk2.MaChuyenGia = cg2.MaChuyenGia
WHERE cgk1.MaChuyenGia < cgk2.MaChuyenGia
GROUP BY cg1.MaChuyenGia, cg2.MaChuyenGia
HAVING COUNT(*) >= 2;

--30. Tìm các công ty có ít nhất một chuyên gia nhưng không có dự án nào.
/*Chuyên gia trong dự án, nếu công ty không có dự án thì không thể có Chuyên gia*/

--31. Liệt kê tên các chuyên gia cùng với số lượng kỹ năng cấp độ cao nhất mà họ sở hữu.
SELECT cg.HoTen, COUNT(ck.MaKyNang) AS SoLuongKyNangCapCaoNhat
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang ck ON cg.MaChuyenGia = ck.MaChuyenGia
WHERE ck.CapDo = (
    SELECT MAX(CapDo)
    FROM ChuyenGia_KyNang
    WHERE MaChuyenGia = cg.MaChuyenGia
)
GROUP BY cg.HoTen

--32. Tìm dự án mà tất cả các chuyên gia đều tham gia và hiển thị tên dự án cùng với danh sách tên chuyên gia tham gia.
SELECT HoTen, TenDuAn
FROM ChuyenGia_DuAn
	 INNER JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
	 INNER JOIN DuAn ON ChuyenGia_DuAn.MaDuAn = DuAn.MaDuAn
WHERE DuAn.MaDuAn IN (SELECT d.MaDuAn
				 FROM DuAn d
					  INNER JOIN ChuyenGia_DuAn cgda ON d.MaDuAn = cgda.MaDuAn
					  INNER JOIN ChuyenGia cg ON cgda.MaChuyenGia = cg.MaChuyenGia
				 GROUP BY d.MaDuAn, d.TenDuAn
				 HAVING COUNT(DISTINCT cgda.MaChuyenGia) = (SELECT COUNT(*) FROM ChuyenGia))

--33. Tìm tất cả các kỹ năng mà ít nhất một chuyên gia sở hữu nhưng không thuộc về nhóm kỹ năng 'Python' hoặc 'Java'.
SELECT KyNang.MaKyNang
FROM ChuyenGia_KyNang
	 INNER JOIN KyNanG ON ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
WHERE TenKyNang <> 'Python' AND TenKyNang <> 'Java'
-----------------------------------------------------------------------------------------------------------------------------------
/*BUOI 4*/
-- 76. Liệt kê top 3 chuyên gia có nhiều kỹ năng nhất và số lượng kỹ năng của họ.
	SELECT TOP 3 CG_KN.MaChuyenGia, COUNT(MaKyNang)
	FROM ChuyenGia_KyNang CG_KN 
	GROUP BY CG_KN.MaChuyenGia
	ORDER BY COUNT(MaKyNang) DESC
-- 77. Tìm các cặp chuyên gia có cùng chuyên ngành và số năm kinh nghiệm chênh lệch không quá 2 năm.
	SELECT CG1.MaChuyenGia, CG2.MaChuyenGia
	FROM ChuyenGia CG1 
	INNER JOIN ChuyenGia CG2 ON CG1.ChuyenNganh = CG2.ChuyenNganh
	WHERE CG1.MaChuyenGia > CG2.MaChuyenGia
	AND ABS(CG1.NamKinhNghiem - CG2.NamKinhNghiem) <= 2
-- 78. Hiển thị tên công ty, số lượng dự án và tổng số năm kinh nghiệm của các chuyên gia tham gia dự án của công ty đó.
	SELECT TenCongTy, COUNT(DA.MaDuAn), SUM(NamKinhNghiem)
	FROM CongTy CT
	INNER JOIN DuAn DA ON DA.MaCongTy = CT.MaCongTy
	INNER JOIN ChuyenGia_DuAn CG_DA ON CG_DA.MaDuAn = DA.MaDuAn
	INNER JOIN ChuyenGia CG ON CG.MaChuyenGia = CG_DA.MaChuyenGia
	GROUP BY TenCongTy
-- 79. Tìm các chuyên gia có ít nhất một kỹ năng cấp độ 5 nhưng không có kỹ năng nào dưới cấp độ 3.
	SELECT DISTINCT MaChuyenGia
	FROM ChuyenGia_KyNang CG_KN1
	WHERE CapDo = 5 
	AND NOT EXISTS (SELECT MaChuyenGia
					FROM ChuyenGia_KyNang CG_KN2
					WHERE CapDo < 3
					AND CG_KN1.MaChuyenGia = CG_KN2.MaChuyenGia)

-- 80. Liệt kê các chuyên gia và số lượng dự án họ tham gia, bao gồm cả những chuyên gia không tham gia dự án nào.
	SELECT CG.MaChuyenGia, COUNT(MaDuAn)
	FROM ChuyenGia CG
	LEFT JOIN ChuyenGia_DuAn CG_DA ON CG.MaChuyenGia = CG_DA.MaChuyenGia
	GROUP BY CG.MaChuyenGia

-- 81*. Tìm chuyên gia có kỹ năng ở cấp độ cao nhất trong mỗi loại kỹ năng.
	SELECT DISTINCT MaChuyenGia, LoaiKyNang, CapDo
	FROM ChuyenGia_KyNang CG_KN
	INNER JOIN KyNang KN ON CG_KN.MaKyNang = KN.MaKyNang
	WHERE CapDo = (SELECT MAX(CapDo)
				   FROM ChuyenGia_KyNang CG_KN1
				   INNER JOIN KyNang KN1 ON CG_KN1.MaKyNang = KN1.MaKyNang
				   WHERE KN.LoaiKyNang = KN1.LoaiKyNang)
	ORDER BY LoaiKyNang, MaChuyenGia

-- 82. Tính tỷ lệ phần trăm của mỗi chuyên ngành trong tổng số chuyên gia.
	SELECT ChuyenNganh, 
		   ROUND((COUNT(MaChuyenGia) * 100.0 / (SELECT COUNT(DISTINCT MaChuyenGia) FROM ChuyenGia)),2) AS TyLePhanTram
	FROM ChuyenGia CG
	GROUP BY ChuyenNganh

-- 83. Tìm các cặp kỹ năng thường xuất hiện cùng nhau nhất trong hồ sơ của các chuyên gia.
	SELECT CG_KN1.MaKyNang, CG_KN2.MaKyNang, COUNT(CG_KN1.MaChuyenGia)
	FROM ChuyenGia_KyNang CG_KN1
	INNER JOIN ChuyenGia_KyNang CG_KN2 ON CG_KN1.MaChuyenGia = CG_KN2.MaChuyenGia
	WHERE CG_KN1.MaKyNang > CG_KN2.MaKyNang
	GROUP BY CG_KN1.MaKyNang, CG_KN2.MaKyNang
	ORDER BY COUNT(CG_KN1.MaChuyenGia) DESC

-- 84. Tính số ngày trung bình giữa ngày bắt đầu và ngày kết thúc của các dự án cho mỗi công ty.
	SELECT MaCongTy, AVG(DATEDIFF(day, NgayBatDau, NgayKetThuc)) SoNgayTrungBinh
	FROM DuAn DA
	WHERE DA.NgayKetThuc IS NOT NULL
	GROUP BY MaCongTy
-- 85*. Tìm chuyên gia có sự kết hợp độc đáo nhất của các kỹ năng (kỹ năng mà chỉ họ có).
SELECT MaChuyenGia
FROM ChuyenGia_KyNang CG_KN
GROUP BY MaChuyenGia
HAVING COUNT(DISTINCT MaKyNang) = 
       (SELECT MAX(SoLuong)
        FROM (SELECT COUNT(DISTINCT MaKyNang) AS SoLuong, MaChuyenGia
              FROM ChuyenGia_KyNang
              GROUP BY MaChuyenGia) AS SubQuery)

-- 86*. Tạo một bảng xếp hạng các chuyên gia dựa trên số lượng dự án và tổng cấp độ kỹ năng.
SELECT CG.MaChuyenGia,
       COUNT(DISTINCT CG_DA.MaDuAn) AS SoDuAn,
       SUM(CG_KN.CapDo) AS TongCapDo,
       (COUNT(DISTINCT CG_DA.MaDuAn) * 0.5 + SUM(CG_KN.CapDo) * 0.5) AS DiemXepHang
FROM ChuyenGia CG
LEFT JOIN ChuyenGia_DuAn CG_DA ON CG.MaChuyenGia = CG_DA.MaChuyenGia
LEFT JOIN ChuyenGia_KyNang CG_KN ON CG.MaChuyenGia = CG_KN.MaChuyenGia
GROUP BY CG.MaChuyenGia
ORDER BY DiemXepHang DESC

-- 87. Tìm các dự án có sự tham gia của chuyên gia từ tất cả các chuyên ngành.
SELECT DA.MaDuAn
FROM DuAn DA
INNER JOIN ChuyenGia_DuAn CG_DA ON DA.MaDuAn = CG_DA.MaDuAn
INNER JOIN ChuyenGia CG ON CG.MaChuyenGia = CG_DA.MaChuyenGia
GROUP BY DA.MaDuAn
HAVING COUNT(DISTINCT CG.ChuyenNganh) = 
       (SELECT COUNT(DISTINCT ChuyenNganh) FROM ChuyenGia)

-- 88. Tính tỷ lệ thành công của mỗi công ty dựa trên số dự án hoàn thành so với tổng số dự án.
SELECT CT.TenCongTy,
       COUNT(CASE WHEN DA.TrangThai = 'HoanThanh' THEN 1 END) * 100.0 / COUNT(*) AS TyLeThanhCong
FROM CongTy CT
INNER JOIN DuAn DA ON CT.MaCongTy = DA.MaCongTy
GROUP BY CT.TenCongTy

-- 89. Tìm các chuyên gia có kỹ năng "bù trừ" nhau (một người giỏi kỹ năng A nhưng yếu kỹ năng B, người kia ngược lại).
SELECT CG_KN1.MaChuyenGia AS ChuyenGia1, CG_KN2.MaChuyenGia AS ChuyenGia2, KN1.MaKyNang AS KyNangA, KN2.MaKyNang AS KyNangB
FROM ChuyenGia_KyNang CG_KN1
INNER JOIN ChuyenGia_KyNang CG_KN2 ON CG_KN1.MaChuyenGia != CG_KN2.MaChuyenGia
INNER JOIN KyNang KN1 ON CG_KN1.MaKyNang = KN1.MaKyNang
INNER JOIN KyNang KN2 ON CG_KN2.MaKyNang = KN2.MaKyNang
WHERE CG_KN1.CapDo > 3 AND CG_KN2.CapDo < 3
AND CG_KN1.MaKyNang = KN1.MaKyNang
AND CG_KN2.MaKyNang != KN1.MaKyNang
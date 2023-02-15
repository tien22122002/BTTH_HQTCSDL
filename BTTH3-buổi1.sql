﻿CREATE DATABASE  MarkManagement;
use MarkManagement
CREATE TABLE Students (
StudentID NVARCHAR(12) PRIMARY KEY,
StudentName NVARCHAR(25) not null,
DateofBirth Datetime not null,
Email NVARCHAR(40),
Phone NVARCHAR(12),
Class NVARCHAR(10),
)
CREATE TABLE Subjects (
SubjectID NVARCHAR(10) PRIMARY KEY,
SubjectName NVARCHAR(25) not null,
)
CREATE TABLE Mark (
StudentID NVARCHAR(12),
SubjectID NVARCHAR(10),
Date Datetime not null,
theory Tinyint,
Practical Tinyint,
PRIMARY KEY (StudentID, SubjectID),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

INSERT INTO Students 
VALUES ('AV0807005', 'Mail Trung Hiếu', '1989/10/11', 'trunghieu@yahoo.com', '0904115116', 'AV1'),
('AV0807006', 'Nguyễn Quý Hùng', '1988/12/02', 'quyhung@yahoo.com', '0955667787', 'AV2'),
('AV0807007', 'Đỗ Đắc Huỳnh', '1990/01/02', 'dachuynh@yahoo.com', '0988574747', 'AV2'),
('AV0807009', 'An Đăng Khuê', '1986/03/06', 'dangkhue@yahoo.com', '0986757463', 'AV1'),
('AV0807010', 'Nguyễn T. Tuyết Lan', '1989/07/12', 'tuyetlan@gmail.com', '0983310342', 'AV2'),
('AV0807011', 'Đinh Phụng Long', '1990/12/02', 'phunglong@yahoo.com', NULL, 'AV1'),
('AV0807012', 'Nguyễn Tuấn Nam', '1990/03/02', 'tuannam@yahoo.com', NULL, 'AV1');

INSERT INTO Subjects 
VALUES ('S001', 'SQL'),
('S002', 'Java Simplefield'),
('S003', 'Active Server Page');

INSERT INTO Mark 
VALUES ('AV0807005', 'S001', '2008/05/06', 8, 25),
('AV0807006', 'S002', '2008/05/06', 16, 30),
('AV0807007', 'S001', '2008/05/06', 10, 25),
('AV0807009', 'S003', '2008/05/06', 7, 13),
('AV0807010', 'S003', '2008/05/06', 9, 16),
('AV0807011', 'S002', '2008/05/06', 8, 30),
('AV0807012', 'S001', '2008/05/06', 7, 31),
('AV0807005', 'S002', '2008/06/06', 12, 11),
('AV0807009', 'S002', '2008/06/06', 11, 20),
('AV0807010', 'S001', '2008/06/06', 7, 6);

-- phần D
-- câu 1  Hiển thị nội dung bảng Students
SELECT * FROM Students;
-- câu 2 Hiển thị nội dung danh sách sinh viên lớp AV1
SELECT * FROM Students WHERE Class = 'AV1';
-- câu 3 . Sử dụng lệnh UPDATE để chuyển sinh viên có mã AV0807012 sang lớp AV2
UPDATE Students
SET Class = 'AV2'
WHERE StudentID = 'AV0807012';
-- câu 4 Tính tổng số sinh viên của từng lớp
SELECT Class, COUNT(*) AS 'Tổng số sinh viên'
FROM Students
GROUP BY Class;
-- câu 5 Hiển thị danh sách sinh viên lớp AV2 được sắp xếp tăng dần theo StudentName
SELECT StudentName 
FROM Students
WHERE Class = 'AV2'
ORDER BY StudentName ASC;
-- câu 6 Hiển thị danh sách sinh viên không đạt lý thuyết môn S001 (theory <10) thi ngày 6/5/2008
SELECT StudentName 
FROM Students S INNER JOIN Mark M 
ON S.StudentID = M.StudentID 
WHERE M.SubjectID = 'S001' AND  M.theory < 10 AND M.Date = '2008/5/6'
ORDER BY StudentName ASC;
-- câu 7 Hiển thị tổng số sinh viên không đạt lý thuyết môn S001. (theory <10)
SELECT COUNT(*) 
FROM Students S INNER JOIN Mark M
ON S.StudentID = M.StudentID
WHERE M.SubjectID = 'S001' AND  M.theory < 10 
-- câu 8 
SELECT * 
FROM Students 
WHERE Class = 'AV1' AND DateofBirth > '1980/1/1';
-- câu 9
DELETE 
FROM Students 
WHERE StudentID = 'AV0807011';
--câu 10
SELECT Students.StudentID, StudentName, SubjectName, Theory, Practical, Date 
FROM Mark 
INNER JOIN Subjects ON Mark.SubjectID = Subjects.SubjectID 
INNER JOIN Students ON Mark.StudentID = Students.StudentID 
WHERE Subjects.SubjectID = 'S001' AND Date = '2008/05/06';

 
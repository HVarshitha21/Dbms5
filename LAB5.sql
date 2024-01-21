-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 21, 2024 at 06:46 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lab2`
--
CREATE DATABASE IF NOT EXISTS `lab2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab2`;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `Customer_id` int(11) NOT NULL,
  `Cust_Name` varchar(25) NOT NULL,
  `City` varchar(15) NOT NULL,
  `Grade` int(11) NOT NULL,
  `Salesman_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`Customer_id`, `Cust_Name`, `City`, `Grade`, `Salesman_id`) VALUES
(501, 'Rajesh', 'Mandya', 2, 101),
(502, 'Vinod', 'Maddur', 3, 102),
(503, 'Sushma', 'Dharwad', 1, 103),
(504, 'Pooja', 'Davangere', 1, 104),
(505, 'Harshi', 'Banglore', 1, 105);

-- --------------------------------------------------------

--
-- Stand-in structure for view `highorder`
-- (See below for the actual view)
--
CREATE TABLE `highorder` (
`Salesman_id` int(11)
,`Customer_id` int(11)
,`Purchase_Amt` int(11)
,`Ord_Date` date
);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `Ord_No` int(11) NOT NULL,
  `Purchase_Amt` int(11) NOT NULL,
  `Ord_Date` date NOT NULL,
  `Customer_id` int(11) DEFAULT NULL,
  `Salesman_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`Ord_No`, `Purchase_Amt`, `Ord_Date`, `Customer_id`, `Salesman_id`) VALUES
(1001, 4500, '2021-12-15', 501, 101),
(1002, 4500, '2021-12-14', 502, 102),
(1003, 4000, '2022-01-11', 503, 103),
(1004, 4600, '2022-02-09', 504, 104),
(1005, 4600, '2021-11-18', 504, 105);

-- --------------------------------------------------------

--
-- Table structure for table `salesman`
--

CREATE TABLE `salesman` (
  `Salesman_id` int(11) NOT NULL,
  `Name` varchar(25) NOT NULL,
  `City` varchar(15) NOT NULL,
  `Commission` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salesman`
--

INSERT INTO `salesman` (`Salesman_id`, `Name`, `City`, `Commission`) VALUES
(101, 'Aishu', 'Mysore', 10),
(102, 'yashu', 'Mandya', 15),
(103, 'anu', 'Hassan', 20),
(104, 'sinchu', 'Banglore', 10),
(105, 'roopa', 'Manglore', 5);

-- --------------------------------------------------------

--
-- Structure for view `highorder`
--
DROP TABLE IF EXISTS `highorder`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `highorder`  AS SELECT `x`.`Salesman_id` AS `Salesman_id`, `x`.`Customer_id` AS `Customer_id`, `x`.`Purchase_Amt` AS `Purchase_Amt`, `x`.`Ord_Date` AS `Ord_Date` FROM `orders` AS `x` WHERE `x`.`Purchase_Amt` = (select max(`y`.`Purchase_Amt`) from `orders` `y` where `x`.`Ord_Date` = `y`.`Ord_Date`) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`Customer_id`),
  ADD KEY `Salesman_id` (`Salesman_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Ord_No`),
  ADD KEY `Customer_id` (`Customer_id`),
  ADD KEY `Salesman_id` (`Salesman_id`);

--
-- Indexes for table `salesman`
--
ALTER TABLE `salesman`
  ADD PRIMARY KEY (`Salesman_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`Salesman_id`) REFERENCES `salesman` (`Salesman_id`) ON DELETE SET NULL;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Customer_id`) REFERENCES `customer` (`Customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`Salesman_id`) REFERENCES `salesman` (`Salesman_id`) ON DELETE CASCADE;
--
-- Database: `lab3`
--
CREATE DATABASE IF NOT EXISTS `lab3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab3`;

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE `actor` (
  `Act_id` int(11) NOT NULL,
  `Act_Name` varchar(25) NOT NULL,
  `Act_Gender` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE `director` (
  `Dir_id` int(11) NOT NULL,
  `Dir_Name` varchar(25) NOT NULL,
  `Dir_Phone` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `Mov_id` int(11) NOT NULL,
  `Mov_Title` varchar(50) NOT NULL,
  `Mov_Year` year(4) NOT NULL,
  `Mov_Lang` varchar(15) NOT NULL,
  `Dir_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `movie_cast`
--

CREATE TABLE `movie_cast` (
  `Act_id` int(11) NOT NULL,
  `Mov_id` int(11) NOT NULL,
  `Role` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `Mov_id` int(11) DEFAULT NULL,
  `Rev_Stars` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`Act_id`);

--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`Dir_id`);

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`Mov_id`),
  ADD KEY `Dir_id` (`Dir_id`);

--
-- Indexes for table `movie_cast`
--
ALTER TABLE `movie_cast`
  ADD PRIMARY KEY (`Act_id`,`Mov_id`),
  ADD KEY `Mov_id` (`Mov_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD KEY `Mov_id` (`Mov_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `movies`
--
ALTER TABLE `movies`
  ADD CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`Dir_id`) REFERENCES `director` (`Dir_id`);

--
-- Constraints for table `movie_cast`
--
ALTER TABLE `movie_cast`
  ADD CONSTRAINT `movie_cast_ibfk_1` FOREIGN KEY (`Act_id`) REFERENCES `actor` (`Act_id`),
  ADD CONSTRAINT `movie_cast_ibfk_2` FOREIGN KEY (`Mov_id`) REFERENCES `movies` (`Mov_id`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`Mov_id`) REFERENCES `movies` (`Mov_id`);
--
-- Database: `lab4`
--
CREATE DATABASE IF NOT EXISTS `lab4` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab4`;

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `USN` char(10) NOT NULL,
  `SSID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`USN`, `SSID`) VALUES
('1BI15CS100', 101),
('1BI15CS101', 101),
('1BI15CS102', 102),
('1BI15CS103', 102),
('1BI15CS104', 103);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `Subcode` char(7) NOT NULL,
  `Title` varchar(20) DEFAULT NULL,
  `Sem` int(11) DEFAULT NULL,
  `CREDITS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `iamarks`
--

CREATE TABLE `iamarks` (
  `USN` char(10) NOT NULL,
  `Subcode` char(7) NOT NULL,
  `SSID` int(11) NOT NULL,
  `Test1` int(11) NOT NULL,
  `Test2` int(11) NOT NULL,
  `Test3` int(11) NOT NULL,
  `FinalIA` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `semsec`
--

CREATE TABLE `semsec` (
  `SSID` int(11) NOT NULL,
  `Sem` int(11) NOT NULL,
  `Sec` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `semsec`
--

INSERT INTO `semsec` (`SSID`, `Sem`, `Sec`) VALUES
(101, 4, 'C'),
(102, 4, 'A'),
(103, 5, 'A'),
(104, 5, 'B'),
(105, 8, 'A'),
(106, 7, 'B'),
(107, 3, 'A');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `USN` varchar(10) NOT NULL,
  `SNAME` varchar(30) NOT NULL,
  `ADDRESS` varchar(30) NOT NULL,
  `PHONE` bigint(10) DEFAULT NULL,
  `GENDER` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`USN`, `SNAME`, `ADDRESS`, `PHONE`, `GENDER`) VALUES
('1BI15CS100', 'JEEVI', 'PIRIYA PATTANA', 9164922644, 'F'),
('1BI15CS101', 'RAYAN', 'MANDYA', 9164001122, 'M'),
('1BI15CS102', 'CHAI', 'K R PETE', 9888899123, 'F'),
('1BI15CS103', 'VARUN', 'BANGALORE', 9164024259, 'M'),
('1BI15CS104', 'VARSHI', 'HUNSUR', 9164024990, 'M');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`USN`),
  ADD KEY `SSID` (`SSID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`Subcode`);

--
-- Indexes for table `iamarks`
--
ALTER TABLE `iamarks`
  ADD PRIMARY KEY (`USN`,`Subcode`,`SSID`),
  ADD KEY `Subcode` (`Subcode`),
  ADD KEY `SSID` (`SSID`);

--
-- Indexes for table `semsec`
--
ALTER TABLE `semsec`
  ADD PRIMARY KEY (`SSID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`USN`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `class_ibfk_1` FOREIGN KEY (`USN`) REFERENCES `student` (`USN`),
  ADD CONSTRAINT `class_ibfk_2` FOREIGN KEY (`SSID`) REFERENCES `semsec` (`SSID`);

--
-- Constraints for table `iamarks`
--
ALTER TABLE `iamarks`
  ADD CONSTRAINT `iamarks_ibfk_1` FOREIGN KEY (`USN`) REFERENCES `student` (`USN`),
  ADD CONSTRAINT `iamarks_ibfk_2` FOREIGN KEY (`Subcode`) REFERENCES `course` (`Subcode`),
  ADD CONSTRAINT `iamarks_ibfk_3` FOREIGN KEY (`SSID`) REFERENCES `semsec` (`SSID`);
--
-- Database: `lab5`
--
CREATE DATABASE IF NOT EXISTS `lab5` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab5`;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `DNo` int(11) NOT NULL,
  `DName` varchar(20) DEFAULT NULL,
  `MgrSSN` int(11) DEFAULT NULL,
  `MgrStartDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`DNo`, `DName`, `MgrSSN`, `MgrStartDate`) VALUES
(1, 'HEAD EUATERS', 103, '0000-00-00'),
(2, 'BANK', 101, '2022-08-22'),
(3, 'SURVEY', 102, '2021-08-22'),
(4, 'ACCOUNTS', 104, '2019-01-01'),
(5, 'RESEARCH', 105, '2021-07-22');

-- --------------------------------------------------------

--
-- Table structure for table `dlocation`
--

CREATE TABLE `dlocation` (
  `DNo` int(11) NOT NULL,
  `DLoc` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dlocation`
--

INSERT INTO `dlocation` (`DNo`, `DLoc`) VALUES
(1, 'HOUSTON'),
(4, 'STAFFORD'),
(5, 'BELOW'),
(5, 'HOUSTON'),
(5, 'NAGAR');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `SSN` int(11) NOT NULL,
  `FName` varchar(20) NOT NULL,
  `LName` varchar(20) NOT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  `Salary` double DEFAULT NULL,
  `SuperSSN` int(11) DEFAULT NULL,
  `DNo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`SSN`, `FName`, `LName`, `Address`, `Gender`, `Salary`, `SuperSSN`, `DNo`) VALUES
(101, 'John', 'scott', 'houston', 'M', 30000, 103, 1),
(102, 'Varun', 'Sharma', 'Mysore', 'M', 30000, 104, 4),
(103, 'Chai', 'B M', 'Mandya', 'F', 40000, 105, 5),
(104, 'Yashi', 'Khandelwal', 'Hassan', 'F', 45000, 104, 4),
(105, 'William', 'Shakesphere', 'Hassan', 'M', 45000, 105, 5),
(106, 'CHOLI', 'HUMBLE', 'MADKER\nI', 'M', 62000, 103, 1),
(107, 'JEEVITHA', 'SHARMA', 'S', 'F', 61000, 103, 1),
(108, 'ROOPA', 'C', 'N', 'F', 60000, 103, 1),
(109, 'LAVANYA', 'D', 'SPRINS', 'M', 61000, 103, 1),
(110, 'RAMA', 'SEETHA', 'HUMBLE', 'F', 61000, 103, 1);

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `PNo` int(11) NOT NULL,
  `PName` varchar(20) DEFAULT NULL,
  `PLocation` varchar(20) DEFAULT NULL,
  `DNo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`PNo`, `PName`, `PLocation`, `DNo`) VALUES
(1, 'PRODUCT X', 'BELLAR', 5),
(2, 'PRODUCT Y', 'SUHARLAND', 5),
(3, 'IOT', 'HOUSTON', 5),
(10, 'PRODUCT Z', 'STAFFORD', 4),
(20, 'REORGANIZATION', 'HOUSTON', 1),
(30, 'NEW BENIFITS', 'STAFFORD', 4);

-- --------------------------------------------------------

--
-- Table structure for table `workson`
--

CREATE TABLE `workson` (
  `SSN` int(11) NOT NULL,
  `PNo` int(11) NOT NULL,
  `Hours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `workson`
--

INSERT INTO `workson` (`SSN`, `PNo`, `Hours`) VALUES
(101, 1, 33),
(101, 2, 8),
(102, 1, 20),
(102, 2, 10),
(102, 3, 40),
(103, 3, 10),
(104, 1, 15),
(105, 2, 10);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`DNo`),
  ADD KEY `MgrSSN` (`MgrSSN`);

--
-- Indexes for table `dlocation`
--
ALTER TABLE `dlocation`
  ADD PRIMARY KEY (`DNo`,`DLoc`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`SSN`),
  ADD KEY `SuperSSN` (`SuperSSN`),
  ADD KEY `DNo` (`DNo`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`PNo`),
  ADD KEY `DNo` (`DNo`);

--
-- Indexes for table `workson`
--
ALTER TABLE `workson`
  ADD PRIMARY KEY (`SSN`,`PNo`),
  ADD KEY `PNo` (`PNo`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `department_ibfk_1` FOREIGN KEY (`MgrSSN`) REFERENCES `employee` (`SSN`);

--
-- Constraints for table `dlocation`
--
ALTER TABLE `dlocation`
  ADD CONSTRAINT `dlocation_ibfk_1` FOREIGN KEY (`DNo`) REFERENCES `department` (`DNo`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`SuperSSN`) REFERENCES `employee` (`SSN`),
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`DNo`) REFERENCES `department` (`DNo`);

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `project_ibfk_1` FOREIGN KEY (`DNo`) REFERENCES `department` (`DNo`);

--
-- Constraints for table `workson`
--
ALTER TABLE `workson`
  ADD CONSTRAINT `workson_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `employee` (`SSN`),
  ADD CONSTRAINT `workson_ibfk_2` FOREIGN KEY (`PNo`) REFERENCES `project` (`PNo`);
--
-- Database: `lp1`
--
CREATE DATABASE IF NOT EXISTS `lp1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lp1`;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `BOOK_Id` int(11) NOT NULL,
  `TITLE` varchar(40) DEFAULT NULL,
  `PUBLISHER_NAME` varchar(20) DEFAULT NULL,
  `PUB_YEAR` year(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`BOOK_Id`, `TITLE`, `PUBLISHER_NAME`, `PUB_YEAR`) VALUES
(101, 'PYTHON', 'YASHITA', '2000'),
(102, 'JAVA', 'VARSHI', '2001'),
(103, 'C++', 'NEHA', '2003'),
(104, 'C', 'CHAI', '2002');

-- --------------------------------------------------------

--
-- Stand-in structure for view `books_avail`
-- (See below for the actual view)
--
CREATE TABLE `books_avail` (
`Book_Id` int(11)
,`Title` varchar(40)
,`No_of_Copies` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `book_authors`
--

CREATE TABLE `book_authors` (
  `BOOK_ID` int(11) NOT NULL,
  `AUTHOR_NAME` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_authors`
--

INSERT INTO `book_authors` (`BOOK_ID`, `AUTHOR_NAME`) VALUES
(101, 'WILLIAM'),
(102, 'CHARLES'),
(103, 'SUDHAMURTHY'),
(104, 'SAVITHA');

-- --------------------------------------------------------

--
-- Table structure for table `book_copies`
--

CREATE TABLE `book_copies` (
  `BOOK_ID` int(11) NOT NULL,
  `PROGRAM_ID` int(11) NOT NULL,
  `NO_OF_COPIES` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_copies`
--

INSERT INTO `book_copies` (`BOOK_ID`, `PROGRAM_ID`, `NO_OF_COPIES`) VALUES
(101, 51, 20),
(102, 52, 10),
(103, 53, 5),
(104, 54, 10);

-- --------------------------------------------------------

--
-- Table structure for table `book_lending`
--

CREATE TABLE `book_lending` (
  `BOOK_ID` int(11) NOT NULL,
  `PROGRAM_ID` int(11) NOT NULL,
  `CARD_NO` int(11) NOT NULL,
  `DATE_OUT` date DEFAULT NULL,
  `DUE_DATE` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_lending`
--

INSERT INTO `book_lending` (`BOOK_ID`, `PROGRAM_ID`, `CARD_NO`, `DATE_OUT`, `DUE_DATE`) VALUES
(101, 51, 1, '2017-01-01', '2017-04-03'),
(102, 52, 1, '2017-02-02', '2017-03-15'),
(103, 53, 2, '2017-01-10', '2017-06-01'),
(104, 51, 1, '2017-01-10', '2017-03-15'),
(104, 54, 2, '2018-02-10', '2018-03-15');

-- --------------------------------------------------------

--
-- Stand-in structure for view `book_view`
-- (See below for the actual view)
--
CREATE TABLE `book_view` (
`PUB_YEAR` year(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `book_view1`
-- (See below for the actual view)
--
CREATE TABLE `book_view1` (
`PUB_YEAR` year(4)
);

-- --------------------------------------------------------

--
-- Table structure for table `library_program`
--

CREATE TABLE `library_program` (
  `PROGRAM_ID` int(11) NOT NULL,
  `PROGRAM_NAME` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `library_program`
--

INSERT INTO `library_program` (`PROGRAM_ID`, `PROGRAM_NAME`, `ADDRESS`) VALUES
(51, 'CSE', 'MYSORE'),
(52, 'ISE', 'MANDYA'),
(53, 'ECE', 'BANGLORE'),
(54, 'EEE', 'MANGLORE'),
(55, 'CV', 'HASSAN');

-- --------------------------------------------------------

--
-- Stand-in structure for view `p1`
-- (See below for the actual view)
--
CREATE TABLE `p1` (
`BOOK_Id` int(11)
,`TITLE` varchar(40)
,`PUBLISHER_NAME` varchar(20)
,`PUB_YEAR` year(4)
);

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

CREATE TABLE `publisher` (
  `NAME` varchar(20) NOT NULL,
  `ADDRESS` varchar(40) DEFAULT NULL,
  `PHONE` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `publisher`
--

INSERT INTO `publisher` (`NAME`, `ADDRESS`, `PHONE`) VALUES
('CHAI', 'MANDYA', 9844503039),
('NEHA', 'MANGLORE', 6364218780),
('NISHU', 'MADDUR', 7272851230),
('VARSHI', 'BANGLORE', 8726454980),
('YASHITA', 'MYSORE', 9153644670);

-- --------------------------------------------------------

--
-- Structure for view `books_avail`
--
DROP TABLE IF EXISTS `books_avail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `books_avail`  AS SELECT `b`.`BOOK_Id` AS `Book_Id`, `b`.`TITLE` AS `Title`, `c`.`NO_OF_COPIES` AS `No_of_Copies` FROM (`book` `b` join `book_copies` `c`) WHERE `b`.`BOOK_Id` = `c`.`BOOK_ID` ;

-- --------------------------------------------------------

--
-- Structure for view `book_view`
--
DROP TABLE IF EXISTS `book_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `book_view`  AS SELECT `book`.`PUB_YEAR` AS `PUB_YEAR` FROM `book` ;

-- --------------------------------------------------------

--
-- Structure for view `book_view1`
--
DROP TABLE IF EXISTS `book_view1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `book_view1`  AS SELECT `book`.`PUB_YEAR` AS `PUB_YEAR` FROM `book` WHERE `book`.`PUB_YEAR` between 2001 and 2004 ;

-- --------------------------------------------------------

--
-- Structure for view `p1`
--
DROP TABLE IF EXISTS `p1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `p1`  AS SELECT `book`.`BOOK_Id` AS `BOOK_Id`, `book`.`TITLE` AS `TITLE`, `book`.`PUBLISHER_NAME` AS `PUBLISHER_NAME`, `book`.`PUB_YEAR` AS `PUB_YEAR` FROM `book` WHERE `book`.`PUB_YEAR` between '2000' and '2004' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`BOOK_Id`),
  ADD KEY `PUBLISHER_NAME` (`PUBLISHER_NAME`);

--
-- Indexes for table `book_authors`
--
ALTER TABLE `book_authors`
  ADD PRIMARY KEY (`BOOK_ID`);

--
-- Indexes for table `book_copies`
--
ALTER TABLE `book_copies`
  ADD PRIMARY KEY (`BOOK_ID`,`PROGRAM_ID`),
  ADD KEY `PROGRAM_ID` (`PROGRAM_ID`);

--
-- Indexes for table `book_lending`
--
ALTER TABLE `book_lending`
  ADD PRIMARY KEY (`BOOK_ID`,`PROGRAM_ID`,`CARD_NO`),
  ADD KEY `PROGRAM_ID` (`PROGRAM_ID`);

--
-- Indexes for table `library_program`
--
ALTER TABLE `library_program`
  ADD PRIMARY KEY (`PROGRAM_ID`);

--
-- Indexes for table `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`NAME`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`PUBLISHER_NAME`) REFERENCES `publisher` (`NAME`);

--
-- Constraints for table `book_authors`
--
ALTER TABLE `book_authors`
  ADD CONSTRAINT `book_authors_ibfk_1` FOREIGN KEY (`BOOK_ID`) REFERENCES `book` (`BOOK_Id`) ON DELETE CASCADE;

--
-- Constraints for table `book_copies`
--
ALTER TABLE `book_copies`
  ADD CONSTRAINT `book_copies_ibfk_1` FOREIGN KEY (`BOOK_ID`) REFERENCES `book` (`BOOK_Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `book_copies_ibfk_2` FOREIGN KEY (`PROGRAM_ID`) REFERENCES `library_program` (`PROGRAM_ID`) ON DELETE CASCADE;

--
-- Constraints for table `book_lending`
--
ALTER TABLE `book_lending`
  ADD CONSTRAINT `book_lending_ibfk_1` FOREIGN KEY (`BOOK_ID`) REFERENCES `book` (`BOOK_Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `book_lending_ibfk_2` FOREIGN KEY (`PROGRAM_ID`) REFERENCES `library_program` (`PROGRAM_ID`) ON DELETE CASCADE;
--
-- Database: `lp2`
--
CREATE DATABASE IF NOT EXISTS `lp2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lp2`;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `Customer_id` int(11) NOT NULL,
  `Cust_Name` varchar(25) NOT NULL,
  `City` varchar(15) NOT NULL,
  `Grade` int(11) NOT NULL,
  `Salesman_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`Customer_id`, `Cust_Name`, `City`, `Grade`, `Salesman_id`) VALUES
(501, 'Rajesh', 'Mandya', 2, 101),
(502, 'Vinod', 'Maddur', 3, 102),
(503, 'Sushma', 'Dharwad', 1, 103),
(504, 'Pooja', 'Davangere', 1, 104),
(505, 'Harshi', 'Banglore', 1, 105);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `Ord_No` int(11) NOT NULL,
  `Purchase_Amt` int(11) NOT NULL,
  `Ord_Date` date NOT NULL,
  `Customer_id` int(11) DEFAULT NULL,
  `Salesman_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salesman`
--

CREATE TABLE `salesman` (
  `Salesman_id` int(11) NOT NULL,
  `Name` varchar(25) NOT NULL,
  `City` varchar(15) NOT NULL,
  `Commission` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salesman`
--

INSERT INTO `salesman` (`Salesman_id`, `Name`, `City`, `Commission`) VALUES
(101, 'Aishu', 'Mysore', 10),
(102, 'yashu', 'Mandya', 15),
(103, 'anu', 'Hassan', 20),
(104, 'sinchu', 'Banglore', 10),
(105, 'roopa', 'Manglore', 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`Customer_id`),
  ADD KEY `Salesman_id` (`Salesman_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Ord_No`),
  ADD KEY `Customer_id` (`Customer_id`),
  ADD KEY `Salesman_id` (`Salesman_id`);

--
-- Indexes for table `salesman`
--
ALTER TABLE `salesman`
  ADD PRIMARY KEY (`Salesman_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`Salesman_id`) REFERENCES `salesman` (`Salesman_id`) ON DELETE SET NULL;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Customer_id`) REFERENCES `customer` (`Customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`Salesman_id`) REFERENCES `salesman` (`Salesman_id`) ON DELETE CASCADE;
--
-- Database: `lp3`
--
CREATE DATABASE IF NOT EXISTS `lp3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lp3`;

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE `actor` (
  `Act_id` int(11) NOT NULL,
  `Act_Name` varchar(25) NOT NULL,
  `Act_Gender` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `actor`
--

INSERT INTO `actor` (`Act_id`, `Act_Name`, `Act_Gender`) VALUES
(101, 'Darshan', 'M'),
(102, 'Anushka', 'F'),
(103, 'Punith', 'M'),
(104, 'Rachitha', 'F'),
(510, 'Yash', 'M');

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE `director` (
  `Dir_id` int(11) NOT NULL,
  `Dir_Name` varchar(25) NOT NULL,
  `Dir_Phone` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `director`
--

INSERT INTO `director` (`Dir_id`, `Dir_Name`, `Dir_Phone`) VALUES
(1000, 'Jajmouli', '9185789644'),
(1001, 'Steven', '9164024255'),
(1002, 'Kishore', '8276549800'),
(1003, 'Munirathna', '9164600800'),
(1004, 'Ramesh', '8264900800');

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `Mov_id` int(11) NOT NULL,
  `Mov_Title` varchar(50) NOT NULL,
  `Mov_Year` year(4) NOT NULL,
  `Mov_Lang` varchar(15) NOT NULL,
  `Dir_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`Mov_id`, `Mov_Title`, `Mov_Year`, `Mov_Lang`, `Dir_id`) VALUES
(20, 'Bahubali-1', '2015', 'Telagu', 1000),
(21, 'Bahubali-2', '2018', 'Telagu', 1000),
(22, 'Kaatera', '2023', 'Kannada', 1001),
(23, 'warhouse', '2010', 'English', 1002),
(24, '12th Fail', '2023', 'Hindi', 1004);

-- --------------------------------------------------------

--
-- Table structure for table `movie_cast`
--

CREATE TABLE `movie_cast` (
  `Act_id` int(11) NOT NULL,
  `Mov_id` int(11) NOT NULL,
  `Role` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_cast`
--

INSERT INTO `movie_cast` (`Act_id`, `Mov_id`, `Role`) VALUES
(101, 21, 'Heroine'),
(102, 22, 'Hero'),
(103, 23, 'villan'),
(104, 24, 'Hero');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `Mov_id` int(11) DEFAULT NULL,
  `Rev_Stars` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`Act_id`);

--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`Dir_id`);

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`Mov_id`),
  ADD KEY `Dir_id` (`Dir_id`);

--
-- Indexes for table `movie_cast`
--
ALTER TABLE `movie_cast`
  ADD PRIMARY KEY (`Act_id`,`Mov_id`),
  ADD KEY `Mov_id` (`Mov_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD KEY `Mov_id` (`Mov_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `movies`
--
ALTER TABLE `movies`
  ADD CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`Dir_id`) REFERENCES `director` (`Dir_id`);

--
-- Constraints for table `movie_cast`
--
ALTER TABLE `movie_cast`
  ADD CONSTRAINT `movie_cast_ibfk_1` FOREIGN KEY (`Act_id`) REFERENCES `actor` (`Act_id`),
  ADD CONSTRAINT `movie_cast_ibfk_2` FOREIGN KEY (`Mov_id`) REFERENCES `movies` (`Mov_id`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`Mov_id`) REFERENCES `movies` (`Mov_id`);
--
-- Database: `lp4`
--
CREATE DATABASE IF NOT EXISTS `lp4` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lp4`;

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `USN` char(10) NOT NULL,
  `SSID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`USN`, `SSID`) VALUES
('1BI15CS100', 101),
('1BI15CS101', 101),
('1BI15CS102', 102),
('1BI15CS103', 102),
('1BI15CS104', 103);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `Subcode` char(7) NOT NULL,
  `Title` varchar(20) DEFAULT NULL,
  `Sem` int(11) DEFAULT NULL,
  `CREDITS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`Subcode`, `Title`, `Sem`, `CREDITS`) VALUES
('18CS51', 'MEIT', 3, 5),
('18CS52', 'CNS', 8, 6),
('18CS53', 'DBMS', 5, 4),
('18CS54', 'ATC', 5, 3),
('18CS55', 'ADP', 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `iamarks`
--

CREATE TABLE `iamarks` (
  `USN` char(10) NOT NULL,
  `Subcode` char(7) NOT NULL,
  `SSID` int(11) NOT NULL,
  `Test1` int(11) NOT NULL,
  `Test2` int(11) NOT NULL,
  `Test3` int(11) NOT NULL,
  `FinalIA` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `iamarks`
--

INSERT INTO `iamarks` (`USN`, `Subcode`, `SSID`, `Test1`, `Test2`, `Test3`, `FinalIA`) VALUES
('1BI15CS100', '18CS51', 101, 21, 20, 21, 21),
('1BI15CS101', '18CS53', 101, 22, 20, 20, 21),
('1BI15CS102', '18CS52', 101, 22, 20, 21, 21.5),
('1BI15CS103', '18CS54', 103, 13, 20, 20, 20),
('1BI15CS104', '18CS55', 103, 24, 20, 20, 22);

-- --------------------------------------------------------

--
-- Stand-in structure for view `mark`
-- (See below for the actual view)
--
CREATE TABLE `mark` (
`SUBCODE` char(7)
,`TEST1` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `semsec`
--

CREATE TABLE `semsec` (
  `SSID` int(11) NOT NULL,
  `Sem` int(11) NOT NULL,
  `Sec` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `semsec`
--

INSERT INTO `semsec` (`SSID`, `Sem`, `Sec`) VALUES
(101, 4, 'C'),
(102, 4, 'A'),
(103, 5, 'A'),
(104, 5, 'B'),
(105, 8, 'A'),
(106, 7, 'B'),
(107, 3, 'A');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `USN` varchar(10) NOT NULL,
  `SNAME` varchar(30) NOT NULL,
  `ADDRESS` varchar(30) NOT NULL,
  `PHONE` bigint(10) DEFAULT NULL,
  `GENDER` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`USN`, `SNAME`, `ADDRESS`, `PHONE`, `GENDER`) VALUES
('1BI15CS100', 'JEEVI', 'PIRIYA PATTANA', 9164922644, 'F'),
('1BI15CS101', 'RAYAN', 'MANDYA', 9164001122, 'M'),
('1BI15CS102', 'CHAI', 'K R PETE', 9888899123, 'F'),
('1BI15CS103', 'VARUN', 'BANGALORE', 9164024259, 'M'),
('1BI15CS104', 'VARSHI', 'HUNSUR', 9164024990, 'M');

-- --------------------------------------------------------

--
-- Structure for view `mark`
--
DROP TABLE IF EXISTS `mark`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mark`  AS SELECT `iamarks`.`Subcode` AS `SUBCODE`, `iamarks`.`Test1` AS `TEST1` FROM `iamarks` WHERE `iamarks`.`USN` = '1BI15CS101' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`USN`),
  ADD KEY `SSID` (`SSID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`Subcode`);

--
-- Indexes for table `iamarks`
--
ALTER TABLE `iamarks`
  ADD PRIMARY KEY (`USN`,`Subcode`,`SSID`),
  ADD KEY `Subcode` (`Subcode`),
  ADD KEY `SSID` (`SSID`);

--
-- Indexes for table `semsec`
--
ALTER TABLE `semsec`
  ADD PRIMARY KEY (`SSID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`USN`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `class_ibfk_1` FOREIGN KEY (`USN`) REFERENCES `student` (`USN`),
  ADD CONSTRAINT `class_ibfk_2` FOREIGN KEY (`SSID`) REFERENCES `semsec` (`SSID`);

--
-- Constraints for table `iamarks`
--
ALTER TABLE `iamarks`
  ADD CONSTRAINT `iamarks_ibfk_1` FOREIGN KEY (`USN`) REFERENCES `student` (`USN`),
  ADD CONSTRAINT `iamarks_ibfk_2` FOREIGN KEY (`Subcode`) REFERENCES `course` (`Subcode`),
  ADD CONSTRAINT `iamarks_ibfk_3` FOREIGN KEY (`SSID`) REFERENCES `semsec` (`SSID`);
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2019-10-21 13:37:09', '{\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `pro1`
--
CREATE DATABASE IF NOT EXISTS `pro1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pro1`;
--
-- Database: `pro3`
--
CREATE DATABASE IF NOT EXISTS `pro3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pro3`;

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE `actor` (
  `Act_id` int(11) NOT NULL,
  `Act_Name` varchar(25) NOT NULL,
  `Act_Gender` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `actor`
--

INSERT INTO `actor` (`Act_id`, `Act_Name`, `Act_Gender`) VALUES
(101, 'Darshan', 'M'),
(102, 'Anushka', 'F'),
(103, 'Punith', 'M'),
(104, 'Rachitha', 'F'),
(105, 'Yash', 'M');

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE `director` (
  `Dir_id` int(11) NOT NULL,
  `Dir_Name` varchar(25) NOT NULL,
  `Dir_Phone` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `director`
--

INSERT INTO `director` (`Dir_id`, `Dir_Name`, `Dir_Phone`) VALUES
(1000, 'Jajmouli', '9185789644'),
(1001, 'Steven', '9164024255'),
(1002, 'Kishore', '8276549800'),
(1003, 'Munirathna', '9164600800'),
(1004, 'Ramesh', '8264900800');

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `Mov_id` int(11) NOT NULL,
  `Mov_Title` varchar(50) NOT NULL,
  `Mov_Year` year(4) NOT NULL,
  `Mov_Lang` varchar(15) NOT NULL,
  `Dir_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`Mov_id`, `Mov_Title`, `Mov_Year`, `Mov_Lang`, `Dir_id`) VALUES
(20, 'Bahubali-1', '2015', 'Telagu', 1000),
(21, 'Bahubali-2', '2018', 'Telagu', 1000),
(22, 'Kaatera', '2023', 'Kannada', 1001),
(23, 'warhouse', '2010', 'English', 1002),
(24, '12th Fail', '2023', 'Hindi', 1004),
(25, 'kantara', '1988', 'Kannada', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `movie_cast`
--

CREATE TABLE `movie_cast` (
  `Act_id` int(11) NOT NULL,
  `Mov_id` int(11) NOT NULL,
  `Role` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_cast`
--

INSERT INTO `movie_cast` (`Act_id`, `Mov_id`, `Role`) VALUES
(101, 21, 'Heroine'),
(102, 22, 'Hero'),
(103, 23, 'villan'),
(104, 24, 'Hero');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `Mov_id` int(11) DEFAULT NULL,
  `Rev_Stars` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`Mov_id`, `Rev_Stars`) VALUES
(20, 4),
(20, 3),
(20, 3),
(21, 5),
(21, 3),
(23, 5),
(23, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`Act_id`);

--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`Dir_id`);

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`Mov_id`),
  ADD KEY `Dir_id` (`Dir_id`);

--
-- Indexes for table `movie_cast`
--
ALTER TABLE `movie_cast`
  ADD PRIMARY KEY (`Act_id`,`Mov_id`),
  ADD KEY `Mov_id` (`Mov_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD KEY `Mov_id` (`Mov_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `movies`
--
ALTER TABLE `movies`
  ADD CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`Dir_id`) REFERENCES `director` (`Dir_id`);

--
-- Constraints for table `movie_cast`
--
ALTER TABLE `movie_cast`
  ADD CONSTRAINT `movie_cast_ibfk_1` FOREIGN KEY (`Act_id`) REFERENCES `actor` (`Act_id`),
  ADD CONSTRAINT `movie_cast_ibfk_2` FOREIGN KEY (`Mov_id`) REFERENCES `movies` (`Mov_id`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`Mov_id`) REFERENCES `movies` (`Mov_id`);
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

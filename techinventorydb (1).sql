-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 12, 2024 at 05:08 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `techinventorydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `audittrail`
--

CREATE TABLE `audittrail` (
  `AuditID` int(11) NOT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Action` varchar(50) NOT NULL,
  `ActionDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `ItemName` varchar(100) DEFAULT NULL,
  `Category` varchar(50) DEFAULT NULL,
  `Brand` varchar(50) DEFAULT NULL,
  `PreviousStockLevel` int(11) DEFAULT NULL,
  `NewStockLevel` int(11) DEFAULT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `ItemID` int(11) NOT NULL,
  `ItemName` varchar(100) NOT NULL,
  `Category` varchar(50) DEFAULT NULL,
  `Brand` varchar(50) DEFAULT NULL,
  `StockLevel` int(11) DEFAULT 0,
  `MinimumStockLevel` int(11) DEFAULT 0,
  `UnitPrice` decimal(10,2) NOT NULL,
  `StockStatus` enum('In Stock','Out of Stock','Low Stock') DEFAULT 'In Stock',
  `ItemImage` longblob DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SupplierName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`ItemID`, `ItemName`, `Category`, `Brand`, `StockLevel`, `MinimumStockLevel`, `UnitPrice`, `StockStatus`, `ItemImage`, `CreatedAt`, `UpdatedAt`, `SupplierName`) VALUES
(1, 'Inspiron 15 3000', 'Laptops', 'Dell', 20, 5, 1200.00, 'In Stock', NULL, '2024-12-06 03:10:31', '2024-12-12 03:48:32', ''),
(2, 'ThinkPadT14', 'Laptops', 'Lenovo', 0, 3, 800.00, 'Out of Stock', NULL, '2024-12-06 03:10:31', '2024-12-12 03:49:06', ''),
(3, 'Macbook Pro 14-inch', 'Laptops', 'Apple', 25, 20, 45000.00, 'In Stock', NULL, '2024-12-10 02:29:13', '2024-12-12 03:50:17', ''),
(4, 'Pavilion Desktop ', 'Desktop', 'HP', 0, 5, 20000.00, 'Out of Stock', NULL, '2024-12-10 02:29:13', '2024-12-12 03:51:07', ''),
(5, 'XPS 13 Plus', 'Laptops', 'Dell', 5, 10, 35000.00, 'Low Stock', NULL, '2024-12-10 02:29:13', '2024-12-12 03:51:42', ''),
(6, 'Surface Laptop 5 ', 'Laptops', 'Microsoft', 7, 10, 12000.00, 'Low Stock', NULL, '2024-12-10 02:29:13', '2024-12-12 03:52:28', ''),
(7, 'iMac 24-inch', 'Desktop', 'Apple', 18, 10, 10000.00, 'In Stock', NULL, '2024-12-10 02:29:13', '2024-12-12 03:54:04', ''),
(8, 'Keyboard', 'Accessories', 'Logitech', 30, 20, 1500.00, 'In Stock', NULL, '2024-12-10 02:29:13', '2024-12-10 02:36:39', ''),
(9, 'Mouse', 'Accessories', 'Razer', 20, 10, 2000.00, 'In Stock', NULL, '2024-12-10 02:29:13', '2024-12-10 07:51:37', ''),
(10, 'Router', 'Networking', 'TP-Link', 8, 15, 3000.00, 'Low Stock', NULL, '2024-12-10 02:29:13', '2024-12-10 02:29:13', ''),
(11, 'External Hard Drive', 'Storage', 'Seagate', 16, 15, 6000.00, 'In Stock', NULL, '2024-12-10 02:29:13', '2024-12-10 07:55:17', ''),
(12, 'Headphones Y1', 'Audio', 'Sony', 0, 10, 8000.00, 'Out of Stock', NULL, '2024-12-10 02:29:13', '2024-12-12 03:53:00', '');

-- --------------------------------------------------------

--
-- Table structure for table `purchaseorderitems`
--

CREATE TABLE `purchaseorderitems` (
  `PurchaseOrderItemID` int(11) NOT NULL,
  `PurchaseOrderID` int(11) DEFAULT NULL,
  `ItemID` int(11) DEFAULT NULL,
  `Quantity` int(11) NOT NULL,
  `UnitPrice` decimal(10,2) NOT NULL,
  `TotalPrice` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchaseorderitems`
--

INSERT INTO `purchaseorderitems` (`PurchaseOrderItemID`, `PurchaseOrderID`, `ItemID`, `Quantity`, `UnitPrice`, `TotalPrice`) VALUES
(1, 1, NULL, 10, 1200.00, 12000.00),
(2, 2, NULL, 5, 800.00, 4000.00);

-- --------------------------------------------------------

--
-- Table structure for table `purchaseorders`
--

CREATE TABLE `purchaseorders` (
  `PurchaseOrderID` int(11) NOT NULL,
  `SupplierID` int(11) DEFAULT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  `ItemID` int(11) DEFAULT NULL,
  `ItemName` varchar(100) DEFAULT NULL,
  `Brand` varchar(50) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Receiver` varchar(100) DEFAULT NULL,
  `TotalPrice` decimal(10,2) DEFAULT NULL,
  `PurchaseDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `Status` enum('Pending','Completed','Cancelled') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchaseorders`
--

INSERT INTO `purchaseorders` (`PurchaseOrderID`, `SupplierID`, `CreatedBy`, `ItemID`, `ItemName`, `Brand`, `Quantity`, `Receiver`, `TotalPrice`, `PurchaseDate`, `Status`) VALUES
(1, 1, 1, 1, 'Laptop Pro', 'BrandA', 10, 'Admin User', 12000.00, '2024-12-06 03:10:31', 'Completed'),
(2, 2, 2, 2, 'Desktop Basic', 'BrandB', 5, 'John Doe', 4000.00, '2024-12-06 03:10:31', 'Completed'),
(3, NULL, NULL, NULL, 'lap', 'das', 2, 'sas', NULL, '2024-12-06 13:38:19', 'Completed'),
(4, NULL, NULL, NULL, 'asdasdsa', 'asdasdas', 1, 'sdasdas', NULL, '2024-12-07 13:38:19', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `restockrequests`
--

CREATE TABLE `restockrequests` (
  `RequestID` int(11) NOT NULL,
  `RequestedBy` varchar(50) DEFAULT NULL,
  `QuantityRequested` int(11) DEFAULT NULL,
  `RequestStatus` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `RequestDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `ApprovedBy` varchar(50) DEFAULT NULL,
  `ApprovalDate` timestamp NULL DEFAULT NULL,
  `ItemName` varchar(100) DEFAULT NULL,
  `Brand` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `restockrequests`
--

INSERT INTO `restockrequests` (`RequestID`, `RequestedBy`, `QuantityRequested`, `RequestStatus`, `RequestDate`, `ApprovedBy`, `ApprovalDate`, `ItemName`, `Brand`, `price`) VALUES
(1, 'Greiss', 10, 'Approved', '2024-12-06 03:10:31', 'Shaine', '2024-12-12 02:48:24', 'Laptop Pro', 'BrandA', NULL),
(2, 'Jolly', 5, 'Pending', '2024-12-06 03:10:31', 'Greiss', '2024-12-12 02:33:16', 'Office Chair', 'BrandC', NULL),
(3, 'Russel', 4, 'Rejected', '2024-12-06 04:02:06', 'Jolly', '2024-12-06 06:51:29', 'Laptop Pro', 'BrandA', NULL),
(5, 'Guest', 40, 'Rejected', '2024-12-06 06:13:57', 'Shaine', '2024-12-11 04:04:37', 'Desktop Basic', 'BrandB', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `SaleID` int(11) NOT NULL,
  `ItemID` int(11) DEFAULT NULL,
  `ItemName` varchar(100) DEFAULT NULL,
  `Brand` varchar(50) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Receiver` varchar(100) DEFAULT NULL,
  `OrderStatus` enum('Pending','Shipped','Completed','Cancelled') DEFAULT 'Pending',
  `SaleDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `TotalPrice` decimal(10,2) GENERATED ALWAYS AS (`Quantity` * `Price`) STORED,
  `DeliveryDate` date DEFAULT NULL,
  `ApprovedBy` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`SaleID`, `ItemID`, `ItemName`, `Brand`, `Quantity`, `Price`, `Receiver`, `OrderStatus`, `SaleDate`, `DeliveryDate`, `ApprovedBy`) VALUES
(1, 1, 'Laptop Pro', 'BrandA', 2, 2400.00, 'Jane Doe', 'Completed', '2024-12-06 03:10:32', NULL, ''),
(2, 2, 'Desktop Basic', 'BrandB', 1, 800.00, 'Company XYZ', 'Shipped', '2024-12-06 03:10:32', NULL, ''),
(5, 2, 'Desktop Basic', 'BrandB', 2, 800.00, 'sdasda', 'Completed', '2024-12-10 02:25:11', '2024-12-10', ''),
(6, 12, 'Headphones', 'Sony', 5, 8000.00, 'shaine', '', '2024-12-10 02:36:03', '2024-12-10', ''),
(7, 8, 'Keyboard', 'Logitech', 20, 1500.00, 'shaine', 'Shipped', '2024-12-10 02:36:39', '2024-12-10', ''),
(8, 12, 'Headphones', 'Sony', 4, 8000.00, 'dasd', '', '2024-12-10 07:43:03', '2024-12-10', ''),
(9, 9, 'Mouse', 'Razer', 100, 2000.00, 'asdas', 'Cancelled', '2023-12-21 07:51:37', '2024-12-10', ''),
(10, 11, 'External Hard Drive', 'Seagate', 60, 6000.00, 'sasas', 'Shipped', '2024-11-12 07:55:17', '2024-12-08', ''),
(11, 4, 'Smartphone', 'Samsung', 15, 20000.00, 'sass', 'Pending', '2024-12-11 04:35:17', '2024-12-08', ''),
(12, 12, 'Headphones', 'Sony', 3, 8000.00, 'ILO', 'Pending', '2024-12-11 22:28:30', '2024-12-08', '');

-- --------------------------------------------------------

--
-- Table structure for table `salesreturn`
--

CREATE TABLE `salesreturn` (
  `ReturnID` int(11) NOT NULL,
  `SaleID` int(11) DEFAULT NULL,
  `ItemID` int(11) DEFAULT NULL,
  `ItemName` varchar(100) DEFAULT NULL,
  `Brand` varchar(50) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `TotalPrice` decimal(10,2) DEFAULT NULL,
  `ReturnDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `Reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salesreturn`
--

INSERT INTO `salesreturn` (`ReturnID`, `SaleID`, `ItemID`, `ItemName`, `Brand`, `Quantity`, `TotalPrice`, `ReturnDate`, `Reason`) VALUES
(1, 1, 1, 'Laptop Pro', 'BrandA', 1, 1200.00, '2024-12-06 03:10:32', 'Defective product'),
(2, 2, 2, 'Desktop Basic', 'BrandB', 1, 800.00, '2024-12-06 03:10:32', 'Customer returned due to wrong order');

-- --------------------------------------------------------

--
-- Table structure for table `shipmentdetails`
--

CREATE TABLE `shipmentdetails` (
  `ShipmentID` int(11) NOT NULL,
  `PurchaseOrderID` int(11) NOT NULL,
  `ItemID` int(11) NOT NULL,
  `QuantityShipped` int(11) NOT NULL,
  `ShippedDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `ShippingStatus` enum('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shipmentdetails`
--

INSERT INTO `shipmentdetails` (`ShipmentID`, `PurchaseOrderID`, `ItemID`, `QuantityShipped`, `ShippedDate`, `ShippingStatus`) VALUES
(1, 1, 1, 10, '2024-12-06 03:10:32', 'Delivered'),
(2, 2, 2, 5, '2024-12-06 03:10:32', 'Shipped');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `SupplierID` int(11) NOT NULL,
  `SupplierName` varchar(100) NOT NULL,
  `ContactEmail` varchar(100) DEFAULT NULL,
  `ContactPhone` varchar(20) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`SupplierID`, `SupplierName`, `ContactEmail`, `ContactPhone`, `Address`, `CreatedAt`) VALUES
(1, 'Tech Supplies Inc.', 'contact@techsupplies.com', '123-456-7890', '123 Main St, Cityville', '2024-12-06 03:10:31'),
(2, 'Office Equipment Co.', 'support@officeequip.com', '987-654-3210', '456 Office Blvd, Townsville', '2024-12-06 03:10:31'),
(3, 'MissingSupplierName', NULL, NULL, NULL, '2024-12-09 21:35:48'),
(4, '', NULL, NULL, NULL, '2024-12-09 21:38:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `AccountPassword` varchar(255) NOT NULL,
  `Role` enum('Admin','Staff') NOT NULL,
  `ProfilePicture` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(15) NOT NULL,
  `Address` text NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Username`, `FirstName`, `LastName`, `Email`, `AccountPassword`, `Role`, `ProfilePicture`, `PhoneNumber`, `Address`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 'Russel', 'Russel', 'De Vera', 'rdevera.a12345071@umak.edu.ph', 'password123', 'Admin', NULL, '09151714135', '2510 Eloriaga St. Brgy. 779 Manila', '2024-12-06 03:10:04', '2024-12-11 11:09:02'),
(2, 'Greiss', 'Greiss', 'Feliciano', 'gfeliciano.a12345589@umak.edu.ph', 'password123', 'Admin', NULL, '09293291583', '1099 Delpan St. Brgy. Kasilawan, Makati', '2024-12-06 03:10:04', '2024-12-11 11:09:56'),
(3, 'Jolly', 'Jolly', 'Padlan', 'jpadlan@example.com', 'password123', 'Admin', NULL, '0', '', '2024-12-06 03:10:04', '2024-12-06 03:10:04'),
(4, 'Guest', 'Guest', 'Guest', 'guest@example.com', 'password123', 'Staff', NULL, '0', '', '2024-12-06 03:10:04', '2024-12-06 03:10:04'),
(5, 'Shaine', 'Shaine', 'Bambico', 'sbambico.k12150990@umak.edu.ph', 'password123', 'Staff', NULL, '09770348492', 'Blk. 275 L.7 Lawin St. Brgy. Rizal Taguig City', '2024-12-09 23:04:10', '2024-12-11 11:11:39');

-- --------------------------------------------------------

--
-- Table structure for table `user_audit_trail`
--

CREATE TABLE `user_audit_trail` (
  `AuditTrailID` int(11) NOT NULL,
  `Username` varchar(100) NOT NULL,
  `Action` varchar(255) NOT NULL,
  `ActionTimestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `Details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_audit_trail`
--

INSERT INTO `user_audit_trail` (`AuditTrailID`, `Username`, `Action`, `ActionTimestamp`, `Details`) VALUES
(1, 'admin_user', 'Created Purchase Order', '2024-12-06 03:10:32', 'PO for 10 units of Laptop Pro'),
(2, 'staff_john', 'Updated Inventory', '2024-12-06 03:10:32', 'Reduced stock for Desktop Basic by 2'),
(3, 'guest', 'Login', '2024-12-06 03:14:14', NULL),
(4, 'Greiss', 'Login', '2024-12-06 04:23:25', NULL),
(5, 'Guest', 'Login', '2024-12-06 04:25:08', NULL),
(6, 'Guest', 'Login', '2024-12-06 04:42:15', NULL),
(7, 'Jolly', 'Login', '2024-12-06 06:00:09', NULL),
(8, 'Jolly', 'Login', '2024-12-06 06:04:45', NULL),
(9, 'Guest', 'Login', '2024-12-06 06:12:15', NULL),
(10, 'Jolly', 'Login', '2024-12-06 06:14:30', NULL),
(11, 'Jolly', 'Login', '2024-12-06 06:23:09', NULL),
(12, 'Jolly', 'Login', '2024-12-06 06:28:24', NULL),
(13, 'Jolly', 'Login', '2024-12-06 06:33:47', NULL),
(14, 'Jolly', 'Login', '2024-12-06 06:49:57', NULL),
(15, 'Jolly', 'Login', '2024-12-06 20:20:46', NULL),
(16, 'Guest', 'Login', '2024-12-07 00:44:41', NULL),
(17, 'Jolly', 'Login', '2024-12-07 00:45:38', NULL),
(18, 'Jolly', 'Login', '2024-12-07 00:49:32', NULL),
(19, 'Jolly', 'Login', '2024-12-07 00:51:23', NULL),
(20, 'Jolly', 'Login', '2024-12-07 00:53:51', NULL),
(21, 'Jolly', 'Login', '2024-12-08 07:50:38', NULL),
(22, 'Jolly', 'Login', '2024-12-08 08:01:43', NULL),
(23, 'Shaine', 'Login', '2024-12-09 23:04:21', NULL),
(24, 'shaine', 'Login', '2024-12-11 03:28:00', NULL),
(25, 'Shaine', 'Login', '2024-12-11 03:56:13', NULL),
(26, 'shaine', 'Login', '2024-12-11 04:01:34', NULL),
(27, 'shaine', 'Login', '2024-12-11 04:02:33', NULL),
(28, 'shaine', 'Login', '2024-12-11 04:09:28', NULL),
(29, 'Shaine', 'Login', '2024-12-11 04:29:33', NULL),
(30, 'Guest', 'Login', '2024-12-11 04:31:04', NULL),
(31, 'Guest', 'Login', '2024-12-11 04:33:34', NULL),
(32, 'gUEST', 'Login', '2024-12-11 04:47:38', NULL),
(33, 'shaine', 'Login', '2024-12-11 09:04:25', NULL),
(34, 'shaine', 'Login', '2024-12-11 09:11:28', NULL),
(35, 'shaine', 'Login', '2024-12-11 09:36:30', NULL),
(36, 'shaine', 'Login', '2024-12-11 09:48:29', NULL),
(37, 'shaine', 'Login', '2024-12-11 10:19:06', NULL),
(38, 'shaine', 'Login', '2024-12-11 10:19:50', NULL),
(39, 'shaine', 'Login', '2024-12-11 10:28:56', NULL),
(40, 'shaine', 'Login', '2024-12-11 10:36:29', NULL),
(41, 'shaine', 'Login', '2024-12-11 10:37:03', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audittrail`
--
ALTER TABLE `audittrail`
  ADD PRIMARY KEY (`AuditID`),
  ADD KEY `Username` (`Username`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`ItemID`),
  ADD UNIQUE KEY `ItemName` (`ItemName`,`Brand`,`Category`),
  ADD KEY `FK_SupplierName` (`SupplierName`);

--
-- Indexes for table `purchaseorderitems`
--
ALTER TABLE `purchaseorderitems`
  ADD PRIMARY KEY (`PurchaseOrderItemID`),
  ADD KEY `PurchaseOrderID` (`PurchaseOrderID`),
  ADD KEY `ItemID` (`ItemID`);

--
-- Indexes for table `purchaseorders`
--
ALTER TABLE `purchaseorders`
  ADD PRIMARY KEY (`PurchaseOrderID`),
  ADD KEY `SupplierID` (`SupplierID`),
  ADD KEY `CreatedBy` (`CreatedBy`),
  ADD KEY `purchaseordes_ibfk_3` (`ItemID`);

--
-- Indexes for table `restockrequests`
--
ALTER TABLE `restockrequests`
  ADD PRIMARY KEY (`RequestID`),
  ADD KEY `fk_requestedby` (`RequestedBy`),
  ADD KEY `fk_approvedby` (`ApprovedBy`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`SaleID`),
  ADD KEY `ItemID` (`ItemID`);

--
-- Indexes for table `salesreturn`
--
ALTER TABLE `salesreturn`
  ADD PRIMARY KEY (`ReturnID`),
  ADD KEY `SaleID` (`SaleID`),
  ADD KEY `ItemID` (`ItemID`);

--
-- Indexes for table `shipmentdetails`
--
ALTER TABLE `shipmentdetails`
  ADD PRIMARY KEY (`ShipmentID`),
  ADD KEY `PurchaseOrderID` (`PurchaseOrderID`),
  ADD KEY `ItemID` (`ItemID`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`SupplierID`),
  ADD UNIQUE KEY `SupplierName` (`SupplierName`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `Username` (`Username`);

--
-- Indexes for table `user_audit_trail`
--
ALTER TABLE `user_audit_trail`
  ADD PRIMARY KEY (`AuditTrailID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audittrail`
--
ALTER TABLE `audittrail`
  MODIFY `AuditID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `ItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `purchaseorderitems`
--
ALTER TABLE `purchaseorderitems`
  MODIFY `PurchaseOrderItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchaseorders`
--
ALTER TABLE `purchaseorders`
  MODIFY `PurchaseOrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `restockrequests`
--
ALTER TABLE `restockrequests`
  MODIFY `RequestID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `SaleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `salesreturn`
--
ALTER TABLE `salesreturn`
  MODIFY `ReturnID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `shipmentdetails`
--
ALTER TABLE `shipmentdetails`
  MODIFY `ShipmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `SupplierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_audit_trail`
--
ALTER TABLE `user_audit_trail`
  MODIFY `AuditTrailID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audittrail`
--
ALTER TABLE `audittrail`
  ADD CONSTRAINT `audittrail_ibfk_1` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `FK_SupplierName` FOREIGN KEY (`SupplierName`) REFERENCES `suppliers` (`SupplierName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchaseorderitems`
--
ALTER TABLE `purchaseorderitems`
  ADD CONSTRAINT `purchaseorderitems_ibfk_1` FOREIGN KEY (`PurchaseOrderID`) REFERENCES `purchaseorders` (`PurchaseOrderID`),
  ADD CONSTRAINT `purchaseorderitems_ibfk_2` FOREIGN KEY (`ItemID`) REFERENCES `inventory` (`ItemID`) ON DELETE CASCADE;

--
-- Constraints for table `purchaseorders`
--
ALTER TABLE `purchaseorders`
  ADD CONSTRAINT `purchaseorders_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`),
  ADD CONSTRAINT `purchaseorders_ibfk_2` FOREIGN KEY (`CreatedBy`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `purchaseorders_ibfk_3` FOREIGN KEY (`ItemID`) REFERENCES `inventory` (`ItemID`),
  ADD CONSTRAINT `purchaseordes_ibfk_2` FOREIGN KEY (`ItemID`) REFERENCES `inventory` (`ItemID`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchaseordes_ibfk_3` FOREIGN KEY (`ItemID`) REFERENCES `inventory` (`ItemID`) ON DELETE CASCADE;

--
-- Constraints for table `restockrequests`
--
ALTER TABLE `restockrequests`
  ADD CONSTRAINT `fk_approvedby` FOREIGN KEY (`ApprovedBy`) REFERENCES `users` (`Username`),
  ADD CONSTRAINT `fk_requestedby` FOREIGN KEY (`RequestedBy`) REFERENCES `users` (`Username`) ON UPDATE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `inventory` (`ItemID`);

--
-- Constraints for table `salesreturn`
--
ALTER TABLE `salesreturn`
  ADD CONSTRAINT `salesreturn_ibfk_1` FOREIGN KEY (`SaleID`) REFERENCES `sales` (`SaleID`),
  ADD CONSTRAINT `salesreturn_ibfk_2` FOREIGN KEY (`ItemID`) REFERENCES `inventory` (`ItemID`);

--
-- Constraints for table `shipmentdetails`
--
ALTER TABLE `shipmentdetails`
  ADD CONSTRAINT `shipmentdetails_ibfk_1` FOREIGN KEY (`PurchaseOrderID`) REFERENCES `purchaseorders` (`PurchaseOrderID`),
  ADD CONSTRAINT `shipmentdetails_ibfk_2` FOREIGN KEY (`ItemID`) REFERENCES `inventory` (`ItemID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

USE `fukoji`;
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 05, 2025 lúc 03:54 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `fukoji`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `access_token` varchar(40) NOT NULL,
  `client_id` varchar(80) NOT NULL,
  `user_id` varchar(80) DEFAULT NULL,
  `expires` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `scope` varchar(4000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_authorization_codes`
--

CREATE TABLE `oauth_authorization_codes` (
  `authorization_code` varchar(40) NOT NULL,
  `client_id` varchar(80) NOT NULL,
  `user_id` varchar(80) DEFAULT NULL,
  `redirect_uri` varchar(2000) DEFAULT NULL,
  `expires` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `scope` varchar(4000) DEFAULT NULL,
  `id_token` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `client_id` varchar(80) NOT NULL,
  `client_secret` varchar(80) DEFAULT NULL,
  `redirect_uri` varchar(2000) DEFAULT NULL,
  `grant_types` varchar(80) DEFAULT NULL,
  `scope` varchar(4000) DEFAULT NULL,
  `user_id` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_clients`
--

INSERT INTO `oauth_clients` (`client_id`, `client_secret`, `redirect_uri`, `grant_types`, `scope`, `user_id`) VALUES
('testclient', 'testsecret', NULL, 'client_credentials', 'app', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_jwt`
--

CREATE TABLE `oauth_jwt` (
  `client_id` varchar(80) NOT NULL,
  `subject` varchar(80) DEFAULT NULL,
  `public_key` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `refresh_token` varchar(40) NOT NULL,
  `client_id` varchar(80) NOT NULL,
  `user_id` varchar(80) DEFAULT NULL,
  `expires` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `scope` varchar(4000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_scopes`
--

CREATE TABLE `oauth_scopes` (
  `scope` varchar(80) NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_users`
--

CREATE TABLE `oauth_users` (
  `username` varchar(80) NOT NULL,
  `password` varchar(80) DEFAULT NULL,
  `first_name` varchar(80) DEFAULT NULL,
  `last_name` varchar(80) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `email_verified` tinyint(1) DEFAULT NULL,
  `scope` varchar(4000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_users`
--

INSERT INTO `oauth_users` (`username`, `password`, `first_name`, `last_name`, `email`, `email_verified`, `scope`) VALUES
('zakir200', '1234', 'Zakir', 'Islam', 'zakir@gmail.com', 1, 'app');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_access`
--

CREATE TABLE `tbl_access` (
  `id` int(11) NOT NULL,
  `module_name` varchar(100) DEFAULT NULL,
  `function_name` varchar(100) DEFAULT NULL,
  `label_name` varchar(100) DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `main_module_id` int(11) DEFAULT NULL,
  `del_status` varchar(15) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_access`
--

INSERT INTO `tbl_access` (`id`, `module_name`, `function_name`, `label_name`, `parent_id`, `main_module_id`, `del_status`) VALUES
(1, 'dashboard', '', 'dashboard', 0, 1, 'Live'),
(2, '', 'view', 'view', 1, NULL, 'Live'),
(3, 'SaaS', '', 'Saas', 0, 2, 'Live'),
(4, '', 'view', 'view', 3, NULL, 'Live'),
(5, '', 'update', 'update', 3, NULL, 'Live'),
(6, 'Site Setting', '', 'site_setting', 0, 2, 'Live'),
(7, '', 'view', 'view', 6, NULL, 'Deleted'),
(8, '', 'update', 'update', 6, NULL, 'Live'),
(9, 'Email Setting', '', 'email_setting', 0, 2, 'Live'),
(10, '', 'view', 'view', 9, NULL, 'Live'),
(11, '', 'update', 'update', 9, NULL, 'Live'),
(12, 'Payment Setting', '', 'Payment_Setting', 0, 2, 'Live'),
(13, '', 'view', 'view', 12, NULL, 'Live'),
(14, '', 'update', 'update', 12, NULL, 'Live'),
(15, 'Companies', '', 'companies', 0, 2, 'Live'),
(16, '', 'add', 'add', 15, NULL, 'Live'),
(17, '', 'update', 'update', 15, NULL, 'Live'),
(18, '', 'view', 'view', 15, NULL, 'Live'),
(19, '', 'delete', 'delete', 15, NULL, 'Live'),
(20, '', 'show_outlets', 'show_outlets', 15, NULL, 'Live'),
(21, '', 'block_all_user', 'block_all_user', 15, NULL, 'Live'),
(22, 'Payment History', '', 'payment_history', 0, 2, 'Live'),
(23, '', 'add', 'add', 22, NULL, 'Live'),
(24, '', 'view', 'view', 22, NULL, 'Live'),
(25, '', 'delete', 'delete', 22, NULL, 'Live'),
(26, 'Pricing Plans', '', 'Pricing_Plans', 0, 2, 'Live'),
(27, '', 'add', 'add', 26, NULL, 'Live'),
(28, '', 'update', 'update', 26, NULL, 'Live'),
(29, '', 'view', 'view', 26, NULL, 'Live'),
(30, '', 'delete', 'delete', 26, NULL, 'Live'),
(31, 'Setting', '', 'setting', 0, 3, 'Live'),
(32, '', 'view', 'view', 31, NULL, 'Live'),
(33, '', 'update', 'update', 31, NULL, 'Live'),
(34, 'Printer Settings', '', 'Printer_Settings', 0, 3, 'Deleted'),
(35, 'Printers', '', 'Printers', 0, 3, 'Live'),
(36, '', 'add', 'add', 35, NULL, 'Live'),
(37, '', 'update', 'update', 35, NULL, 'Live'),
(38, '', 'view', 'view', 35, NULL, 'Live'),
(39, '', 'delete', 'delete', 35, NULL, 'Live'),
(49, 'White Label', '', 'whitelabel', 0, 3, 'Live'),
(50, '', 'view', 'view', 49, NULL, 'Deleted'),
(51, '', 'update', 'update', 49, NULL, 'Live'),
(52, 'Tax Setting', '', 'Tax_Setting', 0, 3, 'Live'),
(53, '', 'view', 'view', 52, NULL, 'Deleted'),
(54, '', 'update_tax', 'update', 52, NULL, 'Live'),
(55, 'Manage Multiple Currencies', '', 'MultipleCurrencies_btn', 0, 3, 'Live'),
(56, '', 'add', 'add', 55, NULL, 'Live'),
(57, '', 'update', 'update', 55, NULL, 'Live'),
(58, '', 'view', 'view', 55, NULL, 'Live'),
(59, '', 'delete', 'delete', 55, NULL, 'Live'),
(60, 'Software Update', '', 'software_update', 0, 3, 'Live'),
(61, '', 'update', 'update', 60, NULL, 'Live'),
(62, 'License Uninstall', '', 'Uninstall_License', 0, 3, 'Live'),
(63, '', 'uninstall', 'uninstall', 62, NULL, 'Live'),
(64, 'Self Order Setting', '', 'sos_Self_Order_Setting', 0, 3, 'Live'),
(65, '', 'view', 'view', 64, NULL, 'Deleted'),
(66, '', 'update', 'update', 64, NULL, 'Live'),
(67, 'Outlets', '', 'outlets', 0, 1, 'Live'),
(68, '', 'add', 'add', 67, NULL, 'Live'),
(69, '', 'update', 'update', 67, NULL, 'Live'),
(70, '', 'view', 'view', 67, NULL, 'Live'),
(71, '', 'delete', 'delete', 67, NULL, 'Live'),
(72, '', 'enter', 'enter', 67, NULL, 'Live'),
(73, 'pos', '', 'pos', 0, 4, 'Live'),
(74, '', 'pos_1', 'place_order', 73, NULL, 'Live'),
(75, '', 'pos_2', 'cancel_order', 73, NULL, 'Live'),
(76, '', 'pos_3', 'modify_order_', 73, NULL, 'Live'),
(77, '', 'pos_4', 'Provide_Discount', 73, NULL, 'Live'),
(78, '', 'pos_5', 'Modify_Service_Delivery_Charge', 73, NULL, 'Live'),
(79, '', 'pos_6', 'Enter_Tips', 73, NULL, 'Live'),
(80, '', 'pos_7', 'Delete_Item_From_Cart_When_Modifying_Order', 73, NULL, 'Live'),
(81, '', 'pos_8', 'add_customer', 73, NULL, 'Live'),
(82, '', 'pos_9', 'edit_customer', 73, NULL, 'Live'),
(83, '', 'pos_10', 'kot_tooltip', 73, NULL, 'Live'),
(84, '', 'pos_11', 'create_invoice', 73, NULL, 'Live'),
(85, '', 'pos_12', 'Print_Bill', 73, NULL, 'Live'),
(86, '', 'pos_13', 'print_last_invoice', 73, NULL, 'Live'),
(87, '', 'pos_14', 'Delete_Recent_Sales', 73, NULL, 'Live'),
(88, '', 'pos_15', 'Modify_Future_Sale', 73, NULL, 'Live'),
(89, '', 'pos_16', 'Set_as_Running_Order_in_Future_Sale', 73, NULL, 'Live'),
(90, '', 'pos_17', 'Accept_SelfOrder', 73, NULL, 'Live'),
(91, '', 'pos_18', 'DeclineSelfOrder', 73, NULL, 'Live'),
(92, '', 'pos_19', 'ModifySelfOrder', 73, NULL, 'Live'),
(93, '', 'pos_20', 'RemoveKitchenNotification', 73, NULL, 'Live'),
(94, '', 'pos_21', 'close_register', 73, NULL, 'Live'),
(95, '', 'pos_22', 'GotoDashboard', 73, NULL, 'Live'),
(96, '', 'pos_23', 'main_menu', 73, NULL, 'Live'),
(97, '', 'pos_24', 'direct_invoice', 73, NULL, 'Delted'),
(98, 'kitchens', '', 'kitchens', 0, 4, 'Live'),
(99, '', 'add', 'add', 98, NULL, 'Live'),
(100, '', 'update', 'update', 98, NULL, 'Live'),
(101, '', 'view', 'view', 98, NULL, 'Live'),
(102, '', 'delete', 'delete', 98, NULL, 'Live'),
(103, '', 'enter', 'enter', 98, NULL, 'Live'),
(104, 'waiter', '', 'waiter', 0, 4, 'Live'),
(105, '', 'view', 'view', 104, NULL, 'Live'),
(106, 'purchase', '', 'purchase', 0, 5, 'Live'),
(107, '', 'add', 'add', 106, NULL, 'Live'),
(108, '', 'update', 'update', 106, NULL, 'Live'),
(109, '', 'view', 'view', 106, NULL, 'Live'),
(110, '', 'delete', 'delete', 106, NULL, 'Live'),
(111, '', 'view_details', 'view_details', 106, NULL, 'Live'),
(112, 'transfer', '', 'transfer', 0, 1, 'Live'),
(113, '', 'add', 'add', 112, NULL, 'Live'),
(114, '', 'update', 'update', 112, NULL, 'Live'),
(115, '', 'view', 'view', 112, NULL, 'Live'),
(116, '', 'delete', 'delete', 112, NULL, 'Live'),
(117, '', 'view_details', 'view_details', 112, NULL, 'Live'),
(118, 'promotion', '', 'promotion', 0, 1, 'Live'),
(119, '', 'add', 'add', 118, NULL, 'Live'),
(120, '', 'update', 'update', 118, NULL, 'Live'),
(121, '', 'view', 'view', 118, NULL, 'Live'),
(122, '', 'delete', 'delete', 118, NULL, 'Live'),
(123, 'sale', '', 'sale', 0, 6, 'Live'),
(124, '', 'view', 'view', 123, NULL, 'Live'),
(125, '', 'refund', 'refund', 123, NULL, 'Live'),
(126, '', 'view_invoice', 'view_invoice', 123, NULL, 'Live'),
(127, '', 'change_date', 'change_date', 123, NULL, 'Deleted'),
(128, '', 'delete', 'delete', 123, NULL, 'Live'),
(129, 'inventory', '', 'inventory', 0, 1, 'Live'),
(130, '', 'view', 'view', 129, NULL, 'Live'),
(131, 'inventory_Adjustments', '', 'inventory_Adjustments', 0, 1, 'Live'),
(132, '', 'add', 'add', 131, NULL, 'Live'),
(133, '', 'update', 'update', 131, NULL, 'Live'),
(134, '', 'view', 'view', 131, NULL, 'Live'),
(135, '', 'delete', 'delete', 131, NULL, 'Live'),
(136, '', 'view_details', 'view_details', 131, NULL, 'Live'),
(137, 'waste', '', 'waste', 0, 1, 'Live'),
(138, '', 'add', 'add', 137, NULL, 'Live'),
(139, '', 'view', 'view', 137, NULL, 'Live'),
(140, '', 'delete', 'delete', 137, NULL, 'Live'),
(141, '', 'view_details', 'view_details', 137, NULL, 'Live'),
(142, 'expense', '', 'expense', 0, 7, 'Live'),
(143, '', 'add', 'add', 142, NULL, 'Live'),
(144, '', 'update', 'update', 142, NULL, 'Live'),
(145, '', 'view', 'view', 142, NULL, 'Live'),
(146, '', 'delete', 'delete', 142, NULL, 'Live'),
(147, 'supplier_due_payment', '', 'supplier_due_payment', 0, 1, 'Live'),
(148, '', 'add', 'add', 147, NULL, 'Live'),
(149, '', 'view', 'view', 147, NULL, 'Live'),
(150, '', 'delete', 'delete', 147, NULL, 'Live'),
(151, 'customer_due_receive', '', 'customer_due_receive', 0, 1, 'Live'),
(152, '', 'add', 'add', 151, NULL, 'Live'),
(153, '', 'view', 'view', 151, NULL, 'Live'),
(154, '', 'delete', 'delete', 151, NULL, 'Live'),
(155, 'attendance', '', 'attendance', 0, 1, 'Live'),
(156, '', 'add', 'add', 155, NULL, 'Live'),
(157, '', 'view', 'view', 155, NULL, 'Live'),
(158, '', 'delete', 'delete', 155, NULL, 'Live'),
(159, 'register_report', '', 'register_report', 0, 8, 'Live'),
(160, '', 'view', 'view', 159, NULL, 'Live'),
(161, 'daily_summary_report', '', 'daily_summary_report', 0, 8, 'Live'),
(162, '', 'view', 'view', 161, NULL, 'Live'),
(163, 'food_sales_report', '', 'food_sales_report', 0, 8, 'Live'),
(164, '', 'view', 'view', 163, NULL, 'Live'),
(165, 'daily_sale_report', '', 'daily_sale_report', 0, 8, 'Live'),
(166, '', 'view', 'view', 165, NULL, 'Live'),
(167, 'detailed_sale_report', '', 'detailed_sale_report', 0, 8, 'Live'),
(168, '', 'view', 'view', 167, NULL, 'Live'),
(169, 'consumption_report', '', 'consumption_report', 0, 8, 'Live'),
(170, '', 'view', 'view', 169, NULL, 'Live'),
(171, 'inventory_report', '', 'inventory_report', 0, 8, 'Live'),
(172, '', 'view', 'view', 171, NULL, 'Live'),
(173, 'Alert_Inventory', '', 'Alert_Inventory', 0, 8, 'Live'),
(174, '', 'view', 'view', 173, NULL, 'Live'),
(175, 'profit_loss_report', '', 'profit_loss_report', 0, 8, 'Live'),
(176, '', 'view', 'view', 175, NULL, 'Live'),
(177, 'daily_sale_report', '', 'daily_sale_report', 0, 8, 'Deleted'),
(178, '', 'view', 'view', 177, NULL, 'Deleted'),
(179, 'attendance_report', '', 'attendance_report', 0, 8, 'Live'),
(180, '', 'view', 'view', 179, NULL, 'Live'),
(181, 'supplier_ledger_report', '', 'supplier_ledger_report', 0, 8, 'Live'),
(182, '', 'view', 'view', 181, NULL, 'Live'),
(183, 'supplier_due_report', '', 'supplier_due_report', 0, 8, 'Live'),
(184, '', 'view', 'view', 183, NULL, 'Live'),
(185, 'customer_due_report', '', 'customer_due_report', 0, 8, 'Live'),
(186, '', 'view', 'view', 185, NULL, 'Live'),
(187, 'customer_ledger', '', 'customer_ledger', 0, 8, 'Live'),
(188, '', 'view', 'view', 187, NULL, 'Live'),
(189, 'purchase_report', '', 'purchase_report', 0, 8, 'Live'),
(190, '', 'view', 'view', 189, NULL, 'Live'),
(191, 'expense_report', '', 'expense_report', 0, 8, 'Live'),
(192, '', 'view', 'view', 191, NULL, 'Live'),
(193, 'waste_report', '', 'waste_report', 0, 8, 'Live'),
(194, '', 'view', 'view', 193, NULL, 'Live'),
(195, 'vat_report', '', 'vat_report', 0, 8, 'Live'),
(196, '', 'view', 'view', 195, NULL, 'Live'),
(197, 'foodMenuSaleByCategories', '', 'foodMenuSaleByCategories', 0, 8, 'Live'),
(198, '', 'view', 'view', 197, NULL, 'Live'),
(199, 'tips_report', '', 'tips_report', 0, 8, 'Live'),
(200, '', 'view', 'view', 199, NULL, 'Live'),
(201, 'auditLogReport', '', 'auditLogReport', 0, 8, 'Live'),
(202, '', 'view', 'view', 201, NULL, 'Live'),
(203, 'usage_loyalty_point_report', '', 'usage_loyalty_point_report', 0, 8, 'Live'),
(204, '', 'view', 'view', 203, NULL, 'Live'),
(205, 'loyalty_point_report', '', 'loyalty_point_report', 0, 8, 'Live'),
(206, '', 'view', 'view', 205, NULL, 'Live'),
(207, 'ingredient_category', '', 'ingredient_category', 0, 9, 'Live'),
(208, '', 'add', 'add', 207, NULL, 'Live'),
(209, '', 'update', 'update', 207, NULL, 'Live'),
(210, '', 'view', 'view', 207, NULL, 'Live'),
(211, '', 'delete', 'delete', 207, NULL, 'Live'),
(212, 'ingredient_units', '', 'ingredient_units', 0, 9, 'Live'),
(213, '', 'add', 'add', 212, NULL, 'Live'),
(214, '', 'update', 'update', 212, NULL, 'Live'),
(215, '', 'view', 'view', 212, NULL, 'Live'),
(216, '', 'delete', 'delete', 212, NULL, 'Live'),
(217, 'ingredients', '', 'ingredients', 0, 9, 'Live'),
(218, '', 'add', 'add', 217, NULL, 'Live'),
(219, '', 'update', 'update', 217, NULL, 'Live'),
(220, '', 'view', 'view', 217, NULL, 'Live'),
(221, '', 'delete', 'delete', 217, NULL, 'Live'),
(222, '', 'upload_ingredient', 'upload_ingredient', 217, NULL, 'Live'),
(223, 'modifiers', '', 'modifiers', 0, 9, 'Live'),
(224, '', 'add', 'add', 223, NULL, 'Live'),
(225, '', 'update', 'update', 223, NULL, 'Live'),
(226, '', 'view', 'view', 223, NULL, 'Live'),
(227, '', 'delete', 'delete', 223, NULL, 'Live'),
(228, '', 'view_details', 'view_details', 223, NULL, 'Live'),
(229, 'food_menu_category', '', 'food_menu_category', 0, 9, 'Live'),
(230, '', 'add', 'add', 229, NULL, 'Live'),
(231, '', 'update', 'update', 229, NULL, 'Live'),
(232, '', 'view', 'view', 229, NULL, 'Live'),
(233, '', 'delete', 'delete', 229, NULL, 'Live'),
(234, 'food_menus', '', 'food_menus', 0, 9, 'Live'),
(235, '', 'add', 'add', 234, NULL, 'Live'),
(236, '', 'update', 'update', 234, NULL, 'Live'),
(237, '', 'view', 'view', 234, NULL, 'Live'),
(238, '', 'delete', 'delete', 234, NULL, 'Live'),
(239, '', 'view_details', 'view_details', 234, NULL, 'Live'),
(240, '', 'assign_modifier', 'assign_modifier', 234, NULL, 'Live'),
(241, '', 'upload_food_menu', 'upload_food_menu', 234, NULL, 'Live'),
(242, '', 'upload_food_menu_ingredients', 'upload_food_menu_ingredients', 234, NULL, 'Live'),
(243, '', 'item_barcode', 'item_barcode', 234, NULL, 'Live'),
(244, 'suppliers', '', 'suppliers', 0, 5, 'Live'),
(245, '', 'add', 'add', 244, NULL, 'Live'),
(246, '', 'update', 'update', 244, NULL, 'Live'),
(247, '', 'view', 'view', 244, NULL, 'Live'),
(248, '', 'delete', 'delete', 244, NULL, 'Live'),
(249, 'customers', '', 'customers', 0, 6, 'Live'),
(250, '', 'add', 'add', 249, NULL, 'Live'),
(251, '', 'update', 'update', 249, NULL, 'Live'),
(252, '', 'view', 'view', 249, NULL, 'Live'),
(253, '', 'delete', 'delete', 249, NULL, 'Live'),
(254, '', 'upload_customer', 'upload_customer', 249, NULL, 'Live'),
(255, 'expense_items', '', 'expense_items', 0, 7, 'Live'),
(256, '', 'add', 'add', 255, NULL, 'Live'),
(257, '', 'update', 'update', 255, NULL, 'Live'),
(258, '', 'view', 'view', 255, NULL, 'Live'),
(259, '', 'delete', 'delete', 255, NULL, 'Live'),
(260, 'payment_methods', '', 'payment_methods', 0, 3, 'Live'),
(261, '', 'add', 'add', 260, NULL, 'Live'),
(262, '', 'update', 'update', 260, NULL, 'Live'),
(263, '', 'view', 'view', 260, NULL, 'Live'),
(264, '', 'delete', 'delete', 260, NULL, 'Live'),
(265, 'denominations', '', 'denominations', 0, 3, 'Live'),
(266, '', 'add', 'add', 265, NULL, 'Live'),
(267, '', 'update', 'update', 265, NULL, 'Live'),
(268, '', 'view', 'view', 265, NULL, 'Live'),
(269, '', 'delete', 'delete', 265, NULL, 'Live'),
(270, 'deliveryPartners', '', 'deliveryPartners', 0, 3, 'Live'),
(271, '', 'add', 'add', 270, NULL, 'Live'),
(272, '', 'update', 'update', 270, NULL, 'Live'),
(273, '', 'view', 'view', 270, NULL, 'Live'),
(274, '', 'delete', 'delete', 270, NULL, 'Live'),
(275, 'areas', '', 'areas', 0, 3, 'Live'),
(276, '', 'add', 'add', 275, NULL, 'Live'),
(277, '', 'update', 'update', 275, NULL, 'Live'),
(278, '', 'view', 'view', 275, NULL, 'Live'),
(279, '', 'delete', 'delete', 275, NULL, 'Live'),
(280, 'tables', '', 'tables', 0, 3, 'Live'),
(281, '', 'add', 'add', 280, NULL, 'Live'),
(282, '', 'update', 'update', 280, NULL, 'Live'),
(283, '', 'view', 'view', 280, NULL, 'Live'),
(284, '', 'delete', 'delete', 280, NULL, 'Live'),
(285, 'roles', '', 'roles', 0, 10, 'Live'),
(286, '', 'add', 'add', 285, NULL, 'Live'),
(287, '', 'update', 'update', 285, NULL, 'Live'),
(288, '', 'view', 'view', 285, NULL, 'Live'),
(289, '', 'delete', 'delete', 285, NULL, 'Live'),
(290, '', 'copy', 'copy', 285, NULL, 'Live'),
(291, 'users', '', 'users', 0, 10, 'Live'),
(292, '', 'add', 'add', 291, NULL, 'Live'),
(293, '', 'update', 'update', 291, NULL, 'Live'),
(294, '', 'view', 'view', 291, NULL, 'Live'),
(295, '', 'delete', 'delete', 291, NULL, 'Live'),
(296, '', 'activate', 'activate', 291, NULL, 'Live'),
(297, '', 'deactivate', 'deactivate', 291, NULL, 'Live'),
(298, 'change_profile', '', 'change_profile', 0, 10, 'Live'),
(299, '', 'update', 'update', 298, NULL, 'Live'),
(300, 'change_password', '', 'change_password', 0, 10, 'Live'),
(301, '', 'update', 'update', 300, NULL, 'Live'),
(302, 'SetSecurityQuestion', '', 'SetSecurityQuestion', 0, 10, 'Live'),
(303, '', 'update', 'update', 302, NULL, 'Live'),
(304, '', 'change_delivery_address', 'change_delivery_address', 123, NULL, 'Live'),
(305, '', 'exportDailySales', 'exportDailySales', 123, NULL, 'Live'),
(306, '', 'resetDailySales', 'resetDailySales', 123, NULL, 'Live'),
(307, 'transferReport', '', 'transferReport', 0, 8, 'Live'),
(308, '', 'view', 'view', 307, NULL, 'Live'),
(309, '', 'sorting', 'sorting', 260, NULL, 'Live'),
(310, 'check_in_check_out', '', 'check_in_check_out', 0, 1, 'Live'),
(311, '', 'check_in', 'check_in', 310, NULL, 'Live'),
(312, '', 'check_out', 'check_out', 310, NULL, 'Live'),
(313, '', 'view', 'view', 310, NULL, 'Live'),
(314, 'z_report', '', 'z_report', 0, 8, 'Live'),
(315, '', 'view', 'view', 314, NULL, 'Live'),
(316, 'plugins', '', 'plugins', 0, 1, 'Live'),
(317, '', 'view', 'view', 316, NULL, 'Live'),
(318, '', 'delete', 'delete', 316, NULL, 'Live'),
(319, '', 'activate', 'activate', 316, NULL, 'Live'),
(320, '', 'deactivate', 'deactivate', 316, NULL, 'Live'),
(321, 'send_sms', '', 'send_sms', 0, 1, 'Live'),
(322, '', 'view', 'view', 321, NULL, 'Live'),
(325, 'premade_food', '', 'premade_food', 0, 9, 'Live'),
(326, '', 'add', 'add', 325, NULL, 'Live'),
(327, '', 'update', 'update', 325, NULL, 'Live'),
(328, '', 'view', 'view', 325, NULL, 'Live'),
(329, '', 'delete', 'delete', 325, NULL, 'Live'),
(330, 'change_pin', '', 'change_pin', 0, 10, 'Live'),
(331, '', 'update', 'update', 330, NULL, 'Live'),
(332, 'productAnalysisReport', '', 'productAnalysisReport', 0, 8, 'Live'),
(333, '', 'view', 'view', 332, NULL, 'Live'),
(337, 'productionReport', '', 'productionReport', 0, 8, 'Live'),
(338, '', 'view', 'view', 337, NULL, 'Live'),
(339, '', 'sortingForPOS', 'ordering_for_pos', 229, NULL, 'Live'),
(340, 'production', '', 'production', 0, 5, 'Live'),
(341, '', 'add', 'add', 340, NULL, 'Live'),
(342, '', 'update', 'update', 340, NULL, 'Live'),
(343, '', 'view', 'view', 340, NULL, 'Live'),
(344, '', 'delete', 'delete', 340, NULL, 'Live'),
(345, '', 'view_details', 'view_details', 340, NULL, 'Live'),
(346, 'inventory_food_menu', '', 'inventory_food_menu', 0, 8, 'Live'),
(347, '', 'view', 'view', 346, NULL, 'Live'),
(350, 'reset_transactional_data', '', 'reset_transactional_data', 0, 3, 'Live'),
(351, '', 'reset', 'Reset', 350, NULL, 'Live'),
(352, '', 'pos_25', 'direct_invoice', 73, NULL, 'Live'),
(353, 'Counters', '', 'Counters', 0, 3, 'Live'),
(354, '', 'add', 'add', 353, NULL, 'Live'),
(355, '', 'update', 'update', 353, NULL, 'Live'),
(356, '', 'view', 'view', 353, NULL, 'Live'),
(357, '', 'delete', 'delete', 353, NULL, 'Live'),
(358, 'allsettingpermission', '', 'allsettingpermission', 0, 3, 'Live'),
(361, '', 'all_setting', 'all_setting', 358, NULL, 'Live'),
(362, 'kitchenPerformanceReport', '', 'kitchenPerformanceReport', 0, 8, 'Live'),
(363, '', 'view', 'view', 362, NULL, 'Live'),
(364, 'sos_Self_Order_Setting', '', 'sos_Self_Order_Setting', 0, 3, 'Live'),
(365, '', 'all_setting_sel_order', 'all_setting_sel_order', 364, NULL, 'Live'),
(366, 'online_order_setting', '', 'online_order_setting', 0, 3, 'Live'),
(367, '', 'all_setting_online_order', 'all_setting_online_order', 366, NULL, 'Live'),
(368, 'reservationSetting', '', 'reservationSetting', 0, 3, 'Live'),
(369, '', 'all_setting_reservation_order', 'all_setting_reservation_order', 368, NULL, 'Live'),
(370, 'serviceDeliveryChargeReport', '', 'serviceDeliveryChargeReport', 0, 8, 'Live'),
(371, '', 'view', 'view', 370, NULL, 'Live');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_areas`
--

CREATE TABLE `tbl_areas` (
  `id` int(10) NOT NULL,
  `outlet_id` int(11) NOT NULL DEFAULT 0,
  `area_name` varchar(250) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `tbl_border_color` varchar(20) DEFAULT NULL,
  `tbl_bg_color` varchar(20) DEFAULT NULL,
  `tbl_text_color` varchar(20) DEFAULT NULL,
  `ordered_border_color` varchar(20) DEFAULT NULL,
  `ordered_bg_color` varchar(20) DEFAULT NULL,
  `ordered_text_color` varchar(20) DEFAULT NULL,
  `box_border_color` varchar(20) DEFAULT NULL,
  `box_bg_color` varchar(20) DEFAULT NULL,
  `box_text_color` varchar(20) DEFAULT NULL,
  `table_design_content` text DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_attendance`
--

CREATE TABLE `tbl_attendance` (
  `id` int(10) NOT NULL,
  `reference_no` varchar(50) DEFAULT NULL,
  `employee_id` int(10) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `in_time` time DEFAULT NULL,
  `out_time` time DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live',
  `is_closed` int(11) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_audit_logs`
--

CREATE TABLE `tbl_audit_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `event_title` varchar(100) DEFAULT NULL,
  `date_time` varchar(50) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live',
  `outlet_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_carts`
--

CREATE TABLE `tbl_carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `outlet_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `json_content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_combo_food_menus`
--

CREATE TABLE `tbl_combo_food_menus` (
  `id` bigint(50) NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `quantity` float DEFAULT NULL,
  `food_menu_id` int(10) DEFAULT NULL,
  `added_food_menu_id` int(11) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_companies`
--

CREATE TABLE `tbl_companies` (
  `id` int(10) NOT NULL,
  `business_name` varchar(50) DEFAULT NULL,
  `short_name` varchar(2) NOT NULL DEFAULT 'iR',
  `website` text DEFAULT NULL,
  `date_format` varchar(50) DEFAULT NULL,
  `zone_name` varchar(50) DEFAULT NULL,
  `currency` varchar(50) DEFAULT NULL,
  `currency_position` varchar(100) DEFAULT NULL,
  `precision` varchar(10) DEFAULT NULL,
  `default_customer` int(11) DEFAULT 1,
  `default_waiter` int(11) DEFAULT NULL,
  `default_payment` int(11) DEFAULT NULL,
  `payment_settings` text DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `invoice_footer` varchar(500) DEFAULT NULL,
  `print_format_invoice` varchar(500) DEFAULT '80mm',
  `sms_setting_check` varchar(20) DEFAULT NULL,
  `invoice_logo` text DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `collect_tax` varchar(50) DEFAULT NULL,
  `tax_title` varchar(100) DEFAULT NULL,
  `tax_registration_no` varchar(100) DEFAULT NULL,
  `tax_is_gst` varchar(50) DEFAULT NULL,
  `state_code` varchar(50) DEFAULT NULL,
  `tax_setting` text DEFAULT NULL,
  `tax_string` varchar(250) DEFAULT NULL,
  `outlet_qty` int(11) DEFAULT NULL,
  `sms_enable_status` int(11) DEFAULT NULL,
  `sms_details` text DEFAULT NULL,
  `custom_label` varchar(200) DEFAULT NULL,
  `custom_url` text DEFAULT NULL,
  `smtp_enable_status` int(11) DEFAULT NULL,
  `smtp_details` text DEFAULT NULL,
  `whatsapp_share_number` varchar(20) DEFAULT NULL,
  `language_manifesto` varchar(20) DEFAULT NULL,
  `white_label` text DEFAULT NULL,
  `website_white_label` text DEFAULT NULL,
  `company_id_xml` varchar(250) DEFAULT NULL,
  `tax_registration_number` varchar(250) DEFAULT NULL,
  `attendance_type` int(11) NOT NULL DEFAULT 2,
  `tax_accounting_basis` varchar(250) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp(),
  `plan_id` int(11) DEFAULT NULL,
  `monthly_cost` float DEFAULT NULL,
  `number_of_maximum_users` varchar(10) DEFAULT NULL,
  `number_of_maximum_outlets` varchar(10) DEFAULT NULL,
  `number_of_maximum_invoices` varchar(10) DEFAULT NULL,
  `access_day` varchar(10) DEFAULT NULL,
  `payment_clear` varchar(20) DEFAULT 'No',
  `is_block_all_user` varchar(10) DEFAULT 'No',
  `customer_reviewers` text DEFAULT NULL,
  `counter_details` text DEFAULT NULL,
  `social_link_details` text DEFAULT NULL,
  `email_settings` text DEFAULT NULL,
  `export_daily_sale` varchar(20) DEFAULT NULL,
  `printing_invoice` varchar(30) DEFAULT 'web_browser',
  `receipt_printer_invoice` int(11) DEFAULT NULL,
  `printing_bill` varchar(100) DEFAULT 'web_browser',
  `receipt_printer_bill` varchar(100) DEFAULT NULL,
  `print_format_bill` varchar(100) DEFAULT '80mm',
  `printing_kot` varchar(100) DEFAULT 'web_browser',
  `receipt_printer_kot` varchar(100) DEFAULT NULL,
  `print_format_kot` varchar(100) DEFAULT '80mm',
  `print_server_url_invoice` varchar(100) DEFAULT NULL,
  `print_server_url_bill` varchar(100) DEFAULT NULL,
  `languge_manifesto` varchar(50) DEFAULT NULL,
  `print_server_url_kot` varchar(100) DEFAULT NULL,
  `service_type` varchar(20) DEFAULT 'delivery',
  `service_amount` varchar(20) DEFAULT NULL,
  `take_away_service_charge` varchar(50) DEFAULT NULL,
  `delivery_type` varchar(20) DEFAULT NULL,
  `delivery_amount` varchar(20) DEFAULT NULL,
  `languagefcrt_manifesto` varchar(50) DEFAULT NULL,
  `active_code` varchar(20) DEFAULT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `tax_type` int(11) NOT NULL DEFAULT 1,
  `decimals_separator` varchar(20) DEFAULT '.',
  `thousands_separator` varchar(20) DEFAULT '',
  `print_kot_when_placing_order` varchar(5) NOT NULL DEFAULT 'No',
  `open_cash_drawer_when_printing_invoice` varchar(5) DEFAULT 'No',
  `when_clicking_on_item_in_pos` varchar(20) DEFAULT '2',
  `default_order_type` int(11) DEFAULT NULL,
  `default_order_type_delivery_p` int(11) DEFAULT NULL,
  `is_rounding_enable` int(11) DEFAULT NULL,
  `is_loyalty_enable` varchar(20) NOT NULL DEFAULT 'Yes',
  `minimum_point_to_redeem` int(11) NOT NULL DEFAULT 0,
  `loyalty_rate` float DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live',
  `sos_enable_self_order` varchar(20) NOT NULL DEFAULT 'No',
  `sos_enable_online_order` varchar(20) NOT NULL DEFAULT 'No',
  `sos_enable_online_order_frontend_website` int(11) NOT NULL DEFAULT 1,
  `split_bill` int(11) NOT NULL DEFAULT 1,
  `place_order_tooltip` varchar(20) NOT NULL DEFAULT 'show',
  `pre_or_post_payment` int(11) NOT NULL DEFAULT 1,
  `food_menu_tooltip` varchar(20) NOT NULL DEFAULT 'show',
  `reservation_times` text DEFAULT NULL,
  `reservation_status` varchar(20) NOT NULL DEFAULT 'enable',
  `price_interval` varchar(20) DEFAULT NULL,
  `sms_service_provider` int(11) NOT NULL DEFAULT 0,
  `sms_send_auto` int(11) NOT NULL DEFAULT 1,
  `saas_landing_page` int(11) NOT NULL DEFAULT 1,
  `table_bg_color` varchar(50) DEFAULT '#3f50e0',
  `active_login_button` int(11) NOT NULL DEFAULT 1,
  `login_type` int(11) NOT NULL DEFAULT 1,
  `main_banner_section` text DEFAULT NULL,
  `service_section` text DEFAULT NULL,
  `explore_menu_section` text DEFAULT NULL,
  `social_media` text DEFAULT NULL,
  `google_map` text DEFAULT NULL,
  `contact_us_des` text DEFAULT NULL,
  `about_us` text DEFAULT NULL,
  `common_menu_page` text DEFAULT NULL,
  `facebook_app_id` text DEFAULT NULL,
  `facebook_app_secret` text DEFAULT NULL,
  `google_client_id` text DEFAULT NULL,
  `google_client_secret_key` text DEFAULT NULL,
  `administrator_email` varchar(100) DEFAULT NULL,
  `terms_and_condition` varchar(11) DEFAULT NULL,
  `apply_on_delivery_charge` int(11) NOT NULL DEFAULT 2,
  `sos_enable_reservation` varchar(20) DEFAULT 'Yes',
  `kot_print_online_self_order` int(11) NOT NULL DEFAULT 2,
  `show_order_full_short` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_companies`
--

INSERT INTO `tbl_companies` (`id`, `business_name`, `short_name`, `website`, `date_format`, `zone_name`, `currency`, `currency_position`, `precision`, `default_customer`, `default_waiter`, `default_payment`, `payment_settings`, `address`, `phone`, `invoice_footer`, `print_format_invoice`, `sms_setting_check`, `invoice_logo`, `company_id`, `collect_tax`, `tax_title`, `tax_registration_no`, `tax_is_gst`, `state_code`, `tax_setting`, `tax_string`, `outlet_qty`, `sms_enable_status`, `sms_details`, `custom_label`, `custom_url`, `smtp_enable_status`, `smtp_details`, `whatsapp_share_number`, `language_manifesto`, `white_label`, `website_white_label`, `company_id_xml`, `tax_registration_number`, `attendance_type`, `tax_accounting_basis`, `created_date`, `plan_id`, `monthly_cost`, `number_of_maximum_users`, `number_of_maximum_outlets`, `number_of_maximum_invoices`, `access_day`, `payment_clear`, `is_block_all_user`, `customer_reviewers`, `counter_details`, `social_link_details`, `email_settings`, `export_daily_sale`, `printing_invoice`, `receipt_printer_invoice`, `printing_bill`, `receipt_printer_bill`, `print_format_bill`, `printing_kot`, `receipt_printer_kot`, `print_format_kot`, `print_server_url_invoice`, `print_server_url_bill`, `languge_manifesto`, `print_server_url_kot`, `service_type`, `service_amount`, `take_away_service_charge`, `delivery_type`, `delivery_amount`, `languagefcrt_manifesto`, `active_code`, `is_active`, `tax_type`, `decimals_separator`, `thousands_separator`, `print_kot_when_placing_order`, `open_cash_drawer_when_printing_invoice`, `when_clicking_on_item_in_pos`, `default_order_type`, `default_order_type_delivery_p`, `is_rounding_enable`, `is_loyalty_enable`, `minimum_point_to_redeem`, `loyalty_rate`, `del_status`, `sos_enable_self_order`, `sos_enable_online_order`, `sos_enable_online_order_frontend_website`, `split_bill`, `place_order_tooltip`, `pre_or_post_payment`, `food_menu_tooltip`, `reservation_times`, `reservation_status`, `price_interval`, `sms_service_provider`, `sms_send_auto`, `saas_landing_page`, `table_bg_color`, `active_login_button`, `login_type`, `main_banner_section`, `service_section`, `explore_menu_section`, `social_media`, `google_map`, `contact_us_des`, `about_us`, `common_menu_page`, `facebook_app_id`, `facebook_app_secret`, `google_client_id`, `google_client_secret_key`, `administrator_email`, `terms_and_condition`, `apply_on_delivery_charge`, `sos_enable_reservation`, `kot_print_online_self_order`, `show_order_full_short`) VALUES
(1, 'Door Soft', 'iR', 'fireapp.cc', 'Y/m/d', 'Asia/Dhaka', '$', 'Before Amount', '2', 1, 3, 1, '{\"field_2\":\"1\",\"field_3\":\"1\",\"field_5\":\"1\",\"field_2_v\":\"sandbox\",\"field_3_v\":\"demo\",\"field_4_v\":\"demo\",\"field_2_key_1\":\"AU4W5_vh3LbxnLpd6w6-Ctk5juhxfHPOSii3R_sFvTnC0HPgf-9T7-TZ2UTjH_2xaP5rBcOHUaKVtPiK\",\"field_2_key_2\":\"EIH1A6UUFtnIKn1OyIejWckUpRDnCQJC7cHNmiDMOOSNr7zPNGvkWq53ULT1Pg3g3eKA89OaQxrd3gi0\",\"field_3_key_1\":\"sk_test_51GqddZFGCHDmFd2QAXjmjrbYpEiVTjx4VrLifrt2BqPgMEDOvaPpE78MJUQjpRitJYiHgsAVUh3MEPbT3S97WsVq00ErmzU133\",\"field_3_key_2\":\"pk_test_51GqddZFGCHDmFd2QQCHEDkicU2Y6AiRvUQySrQVzaarBO9c4VJvq7F8geZWCV3JOQK4ETUJHhDXPDVVN0PXyqfIT00uWJ56gPB\",\"field_4_key_1\":\"rzp_test_pm0zv2KQ07bwi5\",\"field_4_key_2\":\"2LD1rNucYo9aXxfb1cve1oms\",\"paypal_business_email\":\"sb-xtr47c5533995@business.example.com\",\"url_paypal\":\"https:\\/\\/www.sandbox.paypal.com\\/cgi-bin\\/webscr\"}', '384, KALIBARY ROAD, PIROJPUR-8500', '+923065305216', 'Thank you for visiting us!', '80mm', 'Yes', 'cfdd40ad1c39dd3ec0dd0ab225ad4a71.png', 1, 'Yes', 'Local Taxes', '32132587', 'Yes', '0931232', '[{\"id\":\"1\",\"tax\":\"CGST\",\"tax_rate\":\"9\"},{\"id\":\"1\",\"tax\":\"SGST\",\"tax_rate\":\"9\"},{\"id\":\"1\",\"tax\":\"IGST\",\"tax_rate\":\"6\"},{\"id\":\"1\",\"tax\":\"VAT\",\"tax_rate\":\"5\"}]', 'CGST:SGST:IGST:VAT:', 2, 5, '{\"field_1_0\":\"AC912936630bb5e4a34cf6247ff9d28f07\",\"field_1_1\":\"7183bbecf7b47009dd592f1e80f2cb1a\",\"field_1_2\":\"+15108923589\",\"field_2_0\":\"wwww\",\"field_2_1\":\"wwww\",\"field_2_2\":\"wwww\",\"field_2_3\":\"+880\"}', 'Watch Video', 'https://www.facebook.com/', 1, '{\"email_address\":\"test@gmail.com\",\"password\":\"43241\"}', '+923065305216', 'revhgbrev', '{\"site_name\":\"iRestora PLUS  - Next Gen Restaurant POS\",\"phone\":\"+923065305216\",\"email\":\"info@doorsoft.co\",\"footer_description\":\"iRestora PLUS \\u2013 A smart, simple, and powerful restaurant management software designed to streamline your entire operation. From order taking and billing to inventory control and real-time reporting, iRestora PLUS helps you run your restaurant efficiently and deliver a seamless customer experience.\",\"support_time\":\"24\\/7 \\u2013 We&amp;#039;re here whenever you need us\",\"whatsapp_number\":\"88+923065305216\",\"footer_address\":\"House No: 5, Road No: 4, Nikunja 2, Khilkhet, Dhaka.\",\"footer_copy_right_text\":\"\\u00a9 2025 Door Soft. All rights reserved.\",\"google_map\":\"https:\\/\\/www.google.com\\/maps\\/embed?pb=!1m14!1m8!1m3!1d7299.367291073767!2d90.418476!3d23.829846!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3755c65e93000db3%3A0x53377a56daa4e74e!2sDoor%20Soft!5e0!3m2!1sen!2sbd!4v1738582088186!5m2!1sen!2sbd&amp;amp;quot; width=&amp;amp;quot;600&amp;amp;quot; height=&amp;amp;quot;450&amp;amp;quot; style=&amp;amp;quot;border:0;&amp;amp;quot; allowfullscreen=&amp;amp;quot;&amp;amp;quot; loading=&amp;amp;quot;lazy&amp;amp;quot; referrerpolicy=&amp;amp;quot;no-referrer-when-downgrade\",\"system_logo\":\"320612551b106b790e6f2a113039de3e.png\",\"footer\":\"iRestora PLUS  - Next Gen Restaurant POS\"}', '{\"site_name\":\"Online Order of iRestora PLUS  - Next Gen Restaurant POS\",\"system_logo\":\"def29f6c06e44151f0a807296304ff55.png\",\"favicon\":\"027cd8b5326fecaa6d56a61afd8eecc5.png\",\"footer\":\"Online Order of iRestora PLUS  - Next Gen Restaurant POS\",\"website_theme_color\":\"#ff1010\"}', NULL, NULL, 2, NULL, '2021-03-17 12:42:03', NULL, NULL, NULL, '1', NULL, NULL, 'No', 'No', '[\"{\\\"name\\\":\\\"Colin Smalls\\\",\\\"designation\\\":\\\"Basketball Player\\\",\\\"description\\\":\\\"This cozy restaurant has left the best impressions! Hospitable hosts, delicious dishes, beautiful presentation, wide wine list and wonderful dessert. I recommend to everyone! I would like to come back here again and again.\\\"}\",\"{\\\"name\\\":\\\"Sylvester Stallone\\\",\\\"designation\\\":\\\"Actor\\\",\\\"description\\\":\\\"It\\\\u2019s a great experience. The ambiance is very welcoming and charming. Amazing wines, food and service. Staff are extremely knowledgeable and make great recommendations.\\\"}\",\"{\\\"name\\\":\\\"Billie Eilish\\\",\\\"designation\\\":\\\"Musician\\\",\\\"description\\\":\\\"Excellent food. Menu is extensive and seasonal to a particularly high standard. Definitely fine dining. It can be expensive but worth it and they do different deals on different nights so it\\\\u2019s worth checking them out before you book. Highly recommended.\\\"}\"]', '{\"restaurants\":\"47\",\"users\":\"214\",\"reference\":\"96\",\"daily_transactions\":\"8128\"}', '{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/twitter.com\\/\",\"instagram\":\"https:\\/\\/www.instagram.com\\/\",\"youtube\":\"https:\\/\\/www.youtube.com\\/\"}', '{\"enable_status\":\"1\",\"host_name\":\"smtp.gmail.com\",\"email_send_to\":\"helpdesk@doorsoft.co\",\"port_address\":\"465\",\"user_name\":\"mkraju.doorsoft@gmail.com\",\"password\":\"mhmrpahjwmyyveuc\"}', 'enable', 'live_server_print', 0, 'live_server_print', '23', '80mm', 'direct_print', '2', '80mm', '192.168.1.12', '192.168.1.13', 'stwtyqxst', '192.168.1.14', 'service', '', '', NULL, '10%', 'sGmsJaFJVEFCrt1', '3332444', 1, 1, '.', ',', 'Yes', 'No', '2', 1, 0, 0, 'enable', 40, 0.1, 'Live', 'Yes', 'Yes', 1, 1, 'show', 1, 'show', '[{\"counter\":1,\"status\":\"1\",\"counter_name\":\"Sunday\",\"start_time\":\"01:00 am\",\"end_time\":\"12:00 am\",\"start_time_int\":\"1:00\",\"end_time_int\":24},{\"counter\":2,\"status\":\"1\",\"counter_name\":\"Monday\",\"start_time\":\"01:00 am\",\"end_time\":\"11:00 pm\",\"start_time_int\":\"1:00\",\"end_time_int\":\"23:00\"},{\"counter\":3,\"status\":\"\",\"counter_name\":\"Tuesday\",\"start_time\":\"01:00 pm\",\"end_time\":\"11:00 pm\",\"start_time_int\":\"13:00\",\"end_time_int\":\"23:00\"},{\"counter\":4,\"status\":\"1\",\"counter_name\":\"Wednesday\",\"start_time\":\"05:00 pm\",\"end_time\":\"10:00 pm\",\"start_time_int\":\"17:00\",\"end_time_int\":\"22:00\"},{\"counter\":5,\"status\":\"1\",\"counter_name\":\"Thursday\",\"start_time\":\"01:00 pm\",\"end_time\":\"12:00 am\",\"start_time_int\":\"13:00\",\"end_time_int\":24},{\"counter\":6,\"status\":\"1\",\"counter_name\":\"Friday\",\"start_time\":\"08:00 am\",\"end_time\":\"09:00 pm\",\"start_time_int\":\"8:00\",\"end_time_int\":\"21:00\"},{\"counter\":7,\"status\":\"1\",\"counter_name\":\"Saturday\",\"start_time\":\"11:00 am\",\"end_time\":\"04:30 pm\",\"start_time_int\":\"11:00\",\"end_time_int\":\"16:30\"}]', '', NULL, 1, 1, 1, 'table_bg_1', 1, 3, '{\"main_header\":\"Dine with Delight at Macdonald\",\"short_des\":\"Satisfy your cravings with delicious meals at Macdonald. Whether you&#039;re here for a quick bite or a special celebration\",\"main_banner\":\"08228d971ba94c79229271c56a738ca5.jpg\"}', '{\"service_title\":\"Fresh Ingredients, Great Taste\",\"service_heading\":\"Every Dish Made with Care\",\"service_description\":\"At Macdonald, we know great food starts with fresh ingredients. Our chefs put their heart into every dish, making sure each one is packed with flavor and quality. From tasty appetizers to delicious desserts, we have something for every taste. Each meal is made with care, so you can enjoy a wonderful dining experience from start to finish.\",\"service_image\":\"e9e4f71c0287a5cbec1918aa02c1c3d6.jpg\"}', '{\"explore_menu_title\":\"Explore Our Delicious Menu\",\"explore_menu_heading\":\"Tasty Dishes for Every Taste\"}', '{\"facebook_link\":\"x\",\"pinterest_link\":\"x\",\"google_link\":\"x\",\"twitter_link\":\"x\"}', 'https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d7299.367291073767!2d90.418476!3d23.829846!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3755c65e93000db3%3A0x53377a56daa4e74e!2sDoor%20Soft!5e0!3m2!1sen!2sbd!4v1738582088186!5m2!1sen!2sbd&quot; width=&quot;600&quot; height=&quot;450&quot; style=&quot;border:0;&quot; allowfullscreen=&quot;&quot; loading=&quot;lazy&quot; referrerpolicy=&quot;no-referrer-when-downgrade', 'At Macdonald, we value every customer and believe in creating a connection beyond just great food. If you have questions, feedback, or need assistance, we’re here to help! Reach out to us via phone for quick responses, send us an email for detailed inquiries, or visit us in person to experience our warm hospitality firsthand. Whether it’s about reservations, menu options, catering services, or anything else, we’re always happy to assist. Your thoughts and suggestions mean the world to us, so don’t hesitate to get in touch. We look forward to hearing from you and making your iRestora PLUS experience even better!', '{\"about_us_title\":\"Welcome to Macdonald\",\"abous_us_heading\":\"Good Food, Great Memories\",\"about_us_des\":\"At Macdonald, we are passionate about food and hospitality. We strive to offer a menu full of delicious dishes made with the finest ingredients, all served in a cozy, friendly environment. We believe that every meal should be memorable, and every guest should feel like family.\",\"about_us_image\":\"54f6dcc80b42c9235fefee43c2292e95.png\"}', '{\"common_menu_page_banner\":\"142b5e8c5f982e031f01abb694937b68.jpg\"}', 'd', 'd', 'd', 'd', 'adikhanofficial@gmail.com', NULL, 2, 'Yes', 1, 1),
(4, 'KFC R', 'iR', '', 'd/m/Y', 'Asia/Dhaka', '$', 'Before Amount', '2', 1, NULL, NULL, '{\"field_2\":\"1\",\"field_3\":\"1\",\"field_5\":\"1\",\"field_2_v\":\"sandbox\",\"field_3_v\":\"demo\",\"field_4_v\":\"demo\",\"field_2_key_1\":\"AU4W5_vh3LbxnLpd6w6-Ctk5juhxfHPOSii3R_sFvTnC0HPgf-9T7-TZ2UTjH_2xaP5rBcOHUaKVtPiK\",\"field_2_key_2\":\"EIH1A6UUFtnIKn1OyIejWckUpRDnCQJC7cHNmiDMOOSNr7zPNGvkWq53ULT1Pg3g3eKA89OaQxrd3gi0\",\"field_3_key_1\":\"sk_test_51GqddZFGCHDmFd2QAXjmjrbYpEiVTjx4VrLifrt2BqPgMEDOvaPpE78MJUQjpRitJYiHgsAVUh3MEPbT3S97WsVq00ErmzU133\",\"field_3_key_2\":\"pk_test_51GqddZFGCHDmFd2QQCHEDkicU2Y6AiRvUQySrQVzaarBO9c4VJvq7F8geZWCV3JOQK4ETUJHhDXPDVVN0PXyqfIT00uWJ56gPB\",\"field_4_key_1\":\"rzp_test_pm0zv2KQ07bwi5\",\"field_4_key_2\":\"2LD1rNucYo9aXxfb1cve1oms\",\"paypal_business_email\":\"sb-xtr47c5533995@business.example.com\",\"url_paypal\":\"https:\\/\\/www.sandbox.paypal.com\\/cgi-bin\\/webscr\"}', '', '123546789', '', '80mm', 'Yes', '', NULL, 'Yes', 'Local Taxes', '32132587', 'Yes', '0931232', '[{\"id\":\"1\",\"tax\":\"CGST\",\"tax_rate\":\"9\"},{\"id\":\"1\",\"tax\":\"SGST\",\"tax_rate\":\"9\"},{\"id\":\"1\",\"tax\":\"IGST\",\"tax_rate\":\"6\"},{\"id\":\"1\",\"tax\":\"VAT\",\"tax_rate\":\"5\"}]', 'CGST:SGST:IGST:VAT:', NULL, 5, '{\"field_1_0\":\"AC912936630bb5e4a34cf6247ff9d28f07\",\"field_1_1\":\"7183bbecf7b47009dd592f1e80f2cb1a\",\"field_1_2\":\"+15108923589\",\"field_2_0\":\"wwww\",\"field_2_1\":\"wwww\",\"field_2_2\":\"wwww\",\"field_2_3\":\"+880\"}', NULL, NULL, 1, '{\"email_address\":\"test@gmail.com\",\"password\":\"43241\"}', '+923065305216', 'revhgbrev', '{\"site_name\":\"iRestora PLUS  - Next Gen Restaurant POS\",\"system_logo\":\"320612551b106b790e6f2a113039de3e.png\",\"favicon\":\"b121388844c8a5041ca68911b1256815.ico\",\"footer\":\"iRestora PLUS  - Next Gen Restaurant POS\"}', NULL, NULL, NULL, 2, NULL, '2025-04-24 02:19:53', 2, 20.99, '33', '33', '33', '15', 'Yes', 'No', NULL, NULL, NULL, NULL, NULL, 'web_browser', NULL, 'web_browser', NULL, '80mm', 'web_browser', NULL, '80mm', NULL, NULL, NULL, NULL, 'delivery', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, '.', '', 'No', 'No', '2', NULL, NULL, NULL, 'Yes', 0, NULL, 'Live', 'No', 'No', 1, 1, 'show', 1, 'show', NULL, 'enable', NULL, 0, 1, 1, '#3f50e0', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 'Yes', 2, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_contacts`
--

CREATE TABLE `tbl_contacts` (
  `id` int(11) NOT NULL,
  `first_name` varchar(55) DEFAULT NULL,
  `last_name` varchar(55) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_counters`
--

CREATE TABLE `tbl_counters` (
  `id` int(11) NOT NULL,
  `name` varchar(55) DEFAULT NULL,
  `outlet_id` varchar(11) DEFAULT NULL,
  `invoice_printer_id` int(11) DEFAULT NULL,
  `bill_printer_id` int(11) NOT NULL DEFAULT 0,
  `description` varchar(255) DEFAULT NULL,
  `added_date` varchar(55) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT 0,
  `del_status` varchar(11) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_customers`
--

CREATE TABLE `tbl_customers` (
  `id` int(10) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(300) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `gst_number` varchar(50) DEFAULT NULL,
  `pre_or_post_payment` varchar(20) DEFAULT 'Post Payment',
  `area_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live',
  `date_of_birth` date DEFAULT NULL,
  `date_of_anniversary` date DEFAULT NULL,
  `default_discount` varchar(100) NOT NULL DEFAULT '0',
  `added_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `password_online_user` varchar(250) DEFAULT NULL,
  `same_or_diff_state` int(11) NOT NULL DEFAULT 0,
  `active_code` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_customers`
--

INSERT INTO `tbl_customers` (`id`, `name`, `phone`, `email`, `address`, `password`, `gst_number`, `pre_or_post_payment`, `area_id`, `user_id`, `company_id`, `del_status`, `date_of_birth`, `date_of_anniversary`, `default_discount`, `added_date`, `password_online_user`, `same_or_diff_state`, `active_code`) VALUES
(1, 'Walk-in Customer', '', '', '', NULL, NULL, 'Post Payment', 0, 1, 1, 'Live', NULL, NULL, '', '2022-02-28 11:30:49', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_customer_address`
--

CREATE TABLE `tbl_customer_address` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `del_status` varchar(10) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_customer_due_receives`
--

CREATE TABLE `tbl_customer_due_receives` (
  `id` int(10) NOT NULL,
  `reference_no` varchar(50) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `only_date` date DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live',
  `counter_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_delivery_partners`
--

CREATE TABLE `tbl_delivery_partners` (
  `id` int(10) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `aggregator_tran_code` varchar(30) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `company_id` int(10) UNSIGNED DEFAULT NULL,
  `logo` text DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_denominations`
--

CREATE TABLE `tbl_denominations` (
  `id` int(10) NOT NULL,
  `amount` int(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_denominations`
--

INSERT INTO `tbl_denominations` (`id`, `amount`, `description`, `company_id`, `del_status`) VALUES
(1, 10, '', 1, 'Live'),
(2, 20, '', 1, 'Live'),
(3, 30, '', 1, 'Live'),
(4, 40, '', 1, 'Live'),
(5, 50, '', 1, 'Live'),
(6, 100, '', 1, 'Live');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_expenses`
--

CREATE TABLE `tbl_expenses` (
  `id` int(10) NOT NULL,
  `date` date DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `category_id` int(10) DEFAULT NULL,
  `employee_id` int(10) DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `outlet_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT 0,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `del_status` varchar(10) DEFAULT 'Live',
  `counter_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_expense_items`
--

CREATE TABLE `tbl_expense_items` (
  `id` int(10) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_explores`
--

CREATE TABLE `tbl_explores` (
  `id` int(11) NOT NULL,
  `explore_title` varchar(255) DEFAULT NULL,
  `explore_price` float DEFAULT NULL,
  `explore_des` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(11) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_food_menus`
--

CREATE TABLE `tbl_food_menus` (
  `id` int(10) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternative_name` varchar(100) DEFAULT NULL,
  `category_id` int(10) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `sale_price` float DEFAULT NULL,
  `tax_information` text DEFAULT NULL,
  `tax_string` varchar(250) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `photo` varchar(250) DEFAULT NULL,
  `veg_item` varchar(50) DEFAULT 'Veg No',
  `beverage_item` varchar(50) DEFAULT 'Beverage No',
  `bar_item` varchar(50) DEFAULT 'Bar No',
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `vr_ingr` text DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live',
  `vr_del_details` text DEFAULT NULL,
  `sale_price_take_away` float DEFAULT NULL,
  `sale_price_delivery` float DEFAULT NULL,
  `delivery_price` text DEFAULT NULL,
  `total_cost` float DEFAULT NULL,
  `loyalty_point` float DEFAULT 0,
  `product_type` int(11) NOT NULL DEFAULT 1,
  `purchase_price` float DEFAULT NULL,
  `alert_quantity` float DEFAULT NULL,
  `ing_category_id` int(11) DEFAULT NULL,
  `combo_ids` varchar(50) DEFAULT NULL,
  `is_variation` int(11) NOT NULL DEFAULT 0,
  `show_online` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_food_menus_ingredients`
--

CREATE TABLE `tbl_food_menus_ingredients` (
  `id` bigint(50) NOT NULL,
  `ingredient_id` int(10) DEFAULT NULL,
  `consumption` float(10,2) DEFAULT NULL,
  `food_menu_id` int(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live',
  `cost` float DEFAULT NULL,
  `total` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_food_menus_modifiers`
--

CREATE TABLE `tbl_food_menus_modifiers` (
  `id` bigint(50) NOT NULL,
  `modifier_id` int(10) DEFAULT NULL,
  `food_menu_id` int(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_food_menu_categories`
--

CREATE TABLE `tbl_food_menu_categories` (
  `id` int(10) NOT NULL,
  `category_name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `company_id` int(10) UNSIGNED DEFAULT NULL,
  `order_by` int(11) DEFAULT 0,
  `category_image` varchar(255) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_food_menu_ratings`
--

CREATE TABLE `tbl_food_menu_ratings` (
  `id` int(11) NOT NULL,
  `food_menu_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `del_status` varchar(50) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_galleries`
--

CREATE TABLE `tbl_galleries` (
  `id` int(11) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(10) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_holds`
--

CREATE TABLE `tbl_holds` (
  `id` int(10) NOT NULL,
  `customer_id` varchar(50) DEFAULT NULL,
  `sale_no` varchar(500) NOT NULL DEFAULT '000000',
  `total_items` int(10) DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `due_amount` float DEFAULT NULL,
  `disc` varchar(50) DEFAULT NULL,
  `disc_actual` float DEFAULT NULL,
  `vat` float DEFAULT NULL,
  `total_payable` float DEFAULT NULL,
  `payment_method_id` int(10) DEFAULT NULL,
  `close_time` time NOT NULL,
  `table_id` int(10) DEFAULT NULL,
  `total_item_discount_amount` float NOT NULL,
  `sub_total_with_discount` float NOT NULL,
  `sub_total_discount_amount` float NOT NULL,
  `total_discount_amount` float NOT NULL,
  `charge_type` varchar(30) DEFAULT NULL,
  `delivery_charge` varchar(100) DEFAULT NULL,
  `tips_amount` varchar(100) DEFAULT NULL,
  `tips_amount_actual_charge` float DEFAULT NULL,
  `delivery_charge_actual_charge` float DEFAULT NULL,
  `sub_total_discount_value` varchar(10) NOT NULL,
  `sub_total_discount_type` varchar(20) NOT NULL,
  `sale_date` varchar(20) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_time` time NOT NULL,
  `cooking_start_time` varchar(30) DEFAULT '',
  `cooking_done_time` varchar(30) DEFAULT '',
  `modified` enum('Yes','No') NOT NULL DEFAULT 'No',
  `user_id` int(10) DEFAULT NULL,
  `waiter_id` int(10) NOT NULL DEFAULT 0,
  `outlet_id` int(10) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order, 2=invoiced order, 3=closed order',
  `order_type` tinyint(1) NOT NULL COMMENT '1=dine in, 2 = take away, 3 = delivery',
  `del_status` varchar(50) DEFAULT 'Live',
  `is_merge` int(11) NOT NULL DEFAULT 0,
  `counter_id` int(11) NOT NULL DEFAULT 0,
  `is_accept` int(11) NOT NULL DEFAULT 1,
  `given_amount` float DEFAULT NULL,
  `change_amount` float DEFAULT NULL,
  `sale_vat_objects` text DEFAULT NULL,
  `future_sale_status` int(11) NOT NULL DEFAULT 1,
  `random_code` varchar(50) DEFAULT NULL,
  `is_kitchen_bell` int(11) DEFAULT 1,
  `del_address` varchar(250) DEFAULT NULL,
  `delivery_partner_id` int(11) DEFAULT NULL,
  `rounding_amount_hidden` float DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'Pending',
  `previous_due_tmp` float DEFAULT NULL,
  `used_loyalty_point` int(11) DEFAULT NULL,
  `split_sale_id` int(11) DEFAULT NULL,
  `orders_table_text` varchar(250) DEFAULT NULL,
  `self_order_content` text DEFAULT NULL,
  `is_self_order` varchar(20) NOT NULL DEFAULT 'No',
  `is_online_order` varchar(10) DEFAULT 'No',
  `self_order_ran_code` varchar(50) DEFAULT NULL,
  `self_order_status` varchar(20) NOT NULL DEFAULT 'Pending',
  `token_number` varchar(50) DEFAULT NULL,
  `is_pickup_sale` int(11) NOT NULL DEFAULT 0,
  `order_receiving_id` int(11) NOT NULL DEFAULT 0,
  `pull_update` int(11) NOT NULL DEFAULT 1,
  `is_delete_sender` int(11) NOT NULL DEFAULT 0,
  `is_delete_receiver` int(11) NOT NULL DEFAULT 0,
  `is_update_sender` int(11) NOT NULL DEFAULT 0,
  `is_update_receiver` int(11) NOT NULL DEFAULT 0,
  `online_self_order_receiving_id` int(11) NOT NULL DEFAULT 0,
  `is_update_receiver_admin` int(11) NOT NULL DEFAULT 0,
  `is_delete_receiver_admin` int(11) NOT NULL DEFAULT 0,
  `order_receiving_id_admin` int(11) NOT NULL DEFAULT 0,
  `pull_update_admin` int(11) NOT NULL DEFAULT 1,
  `pull_update_cashier` int(11) NOT NULL DEFAULT 1,
  `combo_items` text DEFAULT NULL,
  `online_payment_details` text DEFAULT NULL,
  `online_order_receiving_id` int(11) NOT NULL DEFAULT 0,
  `is_invoice` int(11) NOT NULL DEFAULT 0,
  `is_kitchen` int(11) NOT NULL DEFAULT 1,
  `zatca_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_holds_details`
--

CREATE TABLE `tbl_holds_details` (
  `id` bigint(50) NOT NULL,
  `food_menu_id` int(10) DEFAULT NULL,
  `menu_name` varchar(50) DEFAULT NULL,
  `qty` int(10) DEFAULT NULL,
  `tmp_qty` int(11) DEFAULT NULL,
  `menu_price_without_discount` float NOT NULL,
  `menu_price_with_discount` float NOT NULL,
  `menu_unit_price` float NOT NULL,
  `menu_vat_percentage` float NOT NULL,
  `menu_taxes` text DEFAULT NULL,
  `menu_discount_value` varchar(20) DEFAULT NULL,
  `discount_type` varchar(20) NOT NULL,
  `menu_note` varchar(150) DEFAULT NULL,
  `menu_combo_items` text DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `item_type` varchar(50) DEFAULT NULL,
  `cooking_status` varchar(30) DEFAULT NULL,
  `cooking_start_time` varchar(30) DEFAULT '',
  `cooking_done_time` varchar(30) DEFAULT '',
  `previous_id` bigint(50) NOT NULL,
  `loyalty_point_earn` float DEFAULT 0,
  `sales_id` int(10) DEFAULT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order,2=invoiced order, 3=closed order',
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `is_free_item` int(11) NOT NULL DEFAULT 0,
  `is_print` int(11) NOT NULL DEFAULT 1,
  `del_status` varchar(50) DEFAULT 'Live',
  `is_merge` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_holds_details_modifiers`
--

CREATE TABLE `tbl_holds_details_modifiers` (
  `id` bigint(50) NOT NULL,
  `modifier_id` int(15) NOT NULL,
  `modifier_price` float NOT NULL,
  `food_menu_id` int(10) NOT NULL,
  `sales_id` int(15) NOT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order,2=invoiced order, 3=closed order',
  `sales_details_id` int(15) NOT NULL,
  `menu_vat_percentage` float DEFAULT NULL,
  `menu_taxes` text DEFAULT NULL,
  `user_id` int(15) NOT NULL,
  `outlet_id` int(15) NOT NULL,
  `customer_id` int(15) NOT NULL,
  `is_print` int(11) NOT NULL DEFAULT 1,
  `is_merge` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_holds_table`
--

CREATE TABLE `tbl_holds_table` (
  `id` bigint(50) NOT NULL,
  `persons` int(5) NOT NULL,
  `booking_time` varchar(50) NOT NULL,
  `hold_id` int(10) NOT NULL,
  `hold_no` varchar(20) NOT NULL,
  `outlet_id` int(10) NOT NULL,
  `table_id` int(10) NOT NULL,
  `del_status` varchar(20) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_ingredients`
--

CREATE TABLE `tbl_ingredients` (
  `id` int(10) NOT NULL,
  `code` varchar(50) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `category_id` int(10) DEFAULT NULL,
  `purchase_price` float DEFAULT NULL,
  `alert_quantity` float DEFAULT NULL,
  `unit_id` int(10) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live',
  `purchase_unit_id` float DEFAULT NULL,
  `conversion_rate` float DEFAULT NULL,
  `consumption_unit_cost` float DEFAULT NULL,
  `average_consumption_per_unit` float NOT NULL DEFAULT 0,
  `is_direct_food` int(11) NOT NULL DEFAULT 1,
  `food_id` int(11) DEFAULT NULL,
  `ing_type` varchar(30) NOT NULL DEFAULT 'Plain Ingredient',
  `unit_type` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_ingredient_categories`
--

CREATE TABLE `tbl_ingredient_categories` (
  `id` int(10) NOT NULL,
  `category_name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_inventory_adjustment`
--

CREATE TABLE `tbl_inventory_adjustment` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(50) DEFAULT NULL,
  `date` date NOT NULL,
  `note` varchar(200) DEFAULT NULL,
  `employee_id` int(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_inventory_adjustment_ingredients`
--

CREATE TABLE `tbl_inventory_adjustment_ingredients` (
  `id` int(11) NOT NULL,
  `ingredient_id` int(10) DEFAULT NULL,
  `consumption_amount` float DEFAULT NULL,
  `inventory_adjustment_id` int(10) DEFAULT NULL,
  `consumption_status` enum('Plus','Minus','') DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_kitchens`
--

CREATE TABLE `tbl_kitchens` (
  `id` int(11) NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `printer_id` int(11) DEFAULT NULL,
  `print_server_url` varchar(250) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(20) NOT NULL DEFAULT 'Live',
  `outlet_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_kitchen_categories`
--

CREATE TABLE `tbl_kitchen_categories` (
  `id` int(11) NOT NULL,
  `kitchen_id` int(11) DEFAULT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `via_printer` int(11) DEFAULT NULL,
  `del_status` varchar(20) NOT NULL DEFAULT 'Live',
  `outlet_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_kitchen_sales`
--

CREATE TABLE `tbl_kitchen_sales` (
  `id` int(10) NOT NULL,
  `customer_id` varchar(50) DEFAULT NULL,
  `sale_no` varchar(500) NOT NULL DEFAULT '000000',
  `total_items` int(10) DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `due_amount` float DEFAULT NULL,
  `disc` varchar(50) DEFAULT NULL,
  `disc_actual` float DEFAULT NULL,
  `vat` float DEFAULT NULL,
  `total_payable` float DEFAULT NULL,
  `payment_method_id` int(10) DEFAULT NULL,
  `close_time` time NOT NULL,
  `table_id` int(10) DEFAULT NULL,
  `total_item_discount_amount` float NOT NULL,
  `sub_total_with_discount` float NOT NULL,
  `sub_total_discount_amount` float NOT NULL,
  `total_discount_amount` float NOT NULL,
  `charge_type` varchar(30) DEFAULT NULL,
  `delivery_charge` varchar(100) DEFAULT NULL,
  `tips_amount` varchar(100) DEFAULT NULL,
  `tips_amount_actual_charge` float DEFAULT NULL,
  `delivery_charge_actual_charge` float DEFAULT NULL,
  `sub_total_discount_value` varchar(10) NOT NULL,
  `sub_total_discount_type` varchar(20) NOT NULL,
  `sale_date` varchar(20) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_time` time NOT NULL,
  `cooking_start_time` varchar(30) DEFAULT '',
  `cooking_done_time` varchar(30) DEFAULT '',
  `modified` enum('Yes','No') NOT NULL DEFAULT 'No',
  `user_id` int(10) DEFAULT NULL,
  `waiter_id` int(10) NOT NULL DEFAULT 0,
  `outlet_id` int(10) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order, 2=invoiced order, 3=closed order',
  `order_type` tinyint(1) NOT NULL COMMENT '1=dine in, 2 = take away, 3 = delivery',
  `del_status` varchar(50) DEFAULT 'Live',
  `is_merge` int(11) NOT NULL DEFAULT 0,
  `counter_id` int(11) NOT NULL DEFAULT 0,
  `is_accept` int(11) NOT NULL DEFAULT 1,
  `given_amount` float DEFAULT NULL,
  `change_amount` float DEFAULT NULL,
  `sale_vat_objects` text DEFAULT NULL,
  `future_sale_status` int(11) NOT NULL DEFAULT 1,
  `random_code` varchar(50) DEFAULT NULL,
  `is_kitchen_bell` int(11) DEFAULT 1,
  `del_address` varchar(250) DEFAULT NULL,
  `delivery_partner_id` int(11) DEFAULT NULL,
  `rounding_amount_hidden` float DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'Pending',
  `previous_due_tmp` float DEFAULT NULL,
  `used_loyalty_point` int(11) DEFAULT NULL,
  `split_sale_id` int(11) DEFAULT NULL,
  `orders_table_text` varchar(250) DEFAULT NULL,
  `self_order_content` text DEFAULT NULL,
  `is_self_order` varchar(20) NOT NULL DEFAULT 'No',
  `is_online_order` varchar(10) DEFAULT 'No',
  `self_order_ran_code` varchar(50) DEFAULT NULL,
  `self_order_status` varchar(20) NOT NULL DEFAULT 'Pending',
  `token_number` varchar(50) DEFAULT NULL,
  `is_pickup_sale` int(11) NOT NULL DEFAULT 0,
  `order_receiving_id` int(11) NOT NULL DEFAULT 0,
  `pull_update` int(11) NOT NULL DEFAULT 1,
  `is_delete_sender` int(11) NOT NULL DEFAULT 0,
  `is_delete_receiver` int(11) NOT NULL DEFAULT 0,
  `is_update_sender` int(11) NOT NULL DEFAULT 0,
  `is_update_receiver` int(11) NOT NULL DEFAULT 0,
  `online_self_order_receiving_id` int(11) NOT NULL DEFAULT 0,
  `is_update_receiver_admin` int(11) NOT NULL DEFAULT 0,
  `is_delete_receiver_admin` int(11) NOT NULL DEFAULT 0,
  `order_receiving_id_admin` int(11) NOT NULL DEFAULT 0,
  `pull_update_admin` int(11) NOT NULL DEFAULT 1,
  `pull_update_cashier` int(11) NOT NULL DEFAULT 1,
  `combo_items` text DEFAULT NULL,
  `online_payment_details` text DEFAULT NULL,
  `online_order_receiving_id` int(11) NOT NULL DEFAULT 0,
  `is_invoice` int(11) NOT NULL DEFAULT 0,
  `is_kitchen` int(11) NOT NULL DEFAULT 1,
  `zatca_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_kitchen_sales_details`
--

CREATE TABLE `tbl_kitchen_sales_details` (
  `id` bigint(50) NOT NULL,
  `food_menu_id` int(10) DEFAULT NULL,
  `menu_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` int(10) DEFAULT NULL,
  `tmp_qty` int(11) DEFAULT NULL,
  `menu_price_without_discount` float NOT NULL,
  `menu_price_with_discount` float NOT NULL,
  `menu_unit_price` float NOT NULL,
  `menu_vat_percentage` float NOT NULL,
  `menu_taxes` text DEFAULT NULL,
  `menu_discount_value` varchar(20) DEFAULT NULL,
  `discount_type` varchar(20) NOT NULL,
  `menu_note` varchar(150) DEFAULT NULL,
  `menu_combo_items` text DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `item_type` varchar(50) DEFAULT NULL,
  `cooking_status` varchar(30) DEFAULT NULL,
  `cooking_start_time` varchar(30) DEFAULT '',
  `cooking_done_time` varchar(30) DEFAULT '',
  `previous_id` bigint(50) NOT NULL,
  `loyalty_point_earn` float DEFAULT 0,
  `sales_id` int(10) DEFAULT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order,2=invoiced order, 3=closed order',
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `is_free_item` int(11) NOT NULL DEFAULT 0,
  `is_print` int(11) NOT NULL DEFAULT 1,
  `del_status` varchar(50) DEFAULT 'Live',
  `discount_reason` varchar(250) DEFAULT NULL,
  `is_merge` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_kitchen_sales_details_modifiers`
--

CREATE TABLE `tbl_kitchen_sales_details_modifiers` (
  `id` bigint(50) NOT NULL,
  `modifier_id` int(15) NOT NULL,
  `modifier_price` float NOT NULL,
  `food_menu_id` int(10) NOT NULL,
  `sales_id` int(15) NOT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order,2=invoiced order, 3=closed order',
  `sales_details_id` int(15) NOT NULL,
  `menu_vat_percentage` float DEFAULT NULL,
  `menu_taxes` text DEFAULT NULL,
  `user_id` int(15) NOT NULL,
  `outlet_id` int(15) NOT NULL,
  `customer_id` int(15) NOT NULL,
  `is_print` int(11) NOT NULL DEFAULT 1,
  `is_merge` int(11) NOT NULL DEFAULT 0,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_main_modules`
--

CREATE TABLE `tbl_main_modules` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `del_status` varchar(15) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_main_modules`
--

INSERT INTO `tbl_main_modules` (`id`, `name`, `del_status`) VALUES
(1, 'common_menu', 'Live'),
(2, 'Saas', 'Live'),
(3, 'Settings', 'Live'),
(4, 'Panel', 'Live'),
(5, 'purchase', 'Live'),
(6, 'sale', 'Live'),
(7, 'expense', 'Live'),
(8, 'report', 'Live'),
(9, 'master', 'Live'),
(10, 'account_user', 'Live'),
(11, 'allsettingpermission', 'Live'),
(12, 'online_order_st', 'Live'),
(13, 'sos_Self_Order', 'Live'),
(14, 'reservationSetting', 'Live');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_modifiers`
--

CREATE TABLE `tbl_modifiers` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `tax_information` text DEFAULT NULL,
  `tax_string` varchar(250) DEFAULT NULL,
  `total_cost` float DEFAULT NULL,
  `del_status` varchar(10) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_modifier_ingredients`
--

CREATE TABLE `tbl_modifier_ingredients` (
  `id` bigint(50) NOT NULL,
  `ingredient_id` int(10) DEFAULT NULL,
  `consumption` float DEFAULT NULL,
  `modifier_id` int(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `cost` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_multiple_currencies`
--

CREATE TABLE `tbl_multiple_currencies` (
  `id` int(11) NOT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `conversion_rate` float DEFAULT NULL,
  `company_id` int(1) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_notifications`
--

CREATE TABLE `tbl_notifications` (
  `id` bigint(50) NOT NULL,
  `notification` text NOT NULL,
  `sale_id` int(15) NOT NULL,
  `waiter_id` int(11) DEFAULT NULL,
  `push_status` int(11) NOT NULL DEFAULT 1,
  `outlet_id` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_notification_bar_kitchen_panel`
--

CREATE TABLE `tbl_notification_bar_kitchen_panel` (
  `id` int(15) NOT NULL,
  `notification` text NOT NULL,
  `sale_id` int(15) NOT NULL,
  `kitchen_id` int(11) DEFAULT NULL,
  `outlet_id` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_orders_table`
--

CREATE TABLE `tbl_orders_table` (
  `id` bigint(50) NOT NULL,
  `persons` int(5) NOT NULL,
  `booking_time` varchar(50) NOT NULL,
  `sale_id` int(10) NOT NULL,
  `sale_no` varchar(20) NOT NULL,
  `outlet_id` int(10) NOT NULL,
  `table_id` int(10) NOT NULL,
  `del_status` varchar(20) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_outlets`
--

CREATE TABLE `tbl_outlets` (
  `id` int(10) NOT NULL,
  `outlet_name` varchar(50) DEFAULT NULL,
  `outlet_code` varchar(10) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `default_waiter` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `food_menus` text DEFAULT NULL,
  `food_menu_prices` text DEFAULT NULL,
  `delivery_price` text DEFAULT NULL,
  `has_kitchen` varchar(10) NOT NULL DEFAULT 'No',
  `active_status` varchar(20) DEFAULT 'active',
  `del_status` varchar(10) DEFAULT 'Live',
  `online_self_order_receiving_id` int(11) NOT NULL DEFAULT 0,
  `created_date` varchar(20) DEFAULT NULL,
  `online_order_module` int(11) NOT NULL DEFAULT 1,
  `available_online_foods` text DEFAULT NULL,
  `thumb_imgs` text DEFAULT NULL,
  `large_imgs` text DEFAULT NULL,
  `explore_section_items` text DEFAULT NULL,
  `online_order_receiving_id` int(11) NOT NULL DEFAULT 0,
  `reservation_order_receiving_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_outlets`
--

INSERT INTO `tbl_outlets` (`id`, `outlet_name`, `outlet_code`, `address`, `phone`, `email`, `default_waiter`, `company_id`, `food_menus`, `food_menu_prices`, `delivery_price`, `has_kitchen`, `active_status`, `del_status`, `online_self_order_receiving_id`, `created_date`, `online_order_module`, `available_online_foods`, `thumb_imgs`, `large_imgs`, `explore_section_items`, `online_order_receiving_id`, `reservation_order_receiving_id`) VALUES
(1, 'Door Soft', '000001', 'House No: 5, Road No: 4, Nikunja 2, Khilkhet, Dhaka.', '+923065305216', 'info@doorsoft.co', 3, 1, '39,45,116,123,25,19,118,125,20,112,126,111,115,31,18,23,114,21,113,22,29,110,109,119,121,26,124,107,41,122,117,37,108,120,35,104,30,38,', '{\"tmp39\":\"49||49||\",\"tmp45\":\"35||35||\",\"tmp116\":\"39||39||\",\"tmp123\":\"149||149||\",\"tmp25\":\"29||29||\",\"tmp19\":\"50||50||\",\"tmp118\":\"99||99||\",\"tmp125\":\"9||9||\",\"tmp20\":\"59||59||\",\"tmp112\":\"299||299||\",\"tmp126\":\"196||196||\",\"tmp111\":\"310||310||\",\"tmp115\":\"199||199||\",\"tmp31\":\"2||2||\",\"tmp18\":\"7||7||\",\"tmp23\":\"49||49||\",\"tmp114\":\"199||199||\",\"tmp21\":\"49||49||\",\"tmp113\":\"249||249||\",\"tmp22\":\"39||39||\",\"tmp29\":\"68||68||\",\"tmp110\":\"89||89||\",\"tmp109\":\"99||99||\",\"tmp119\":\"49||49||\",\"tmp121\":\"49||49||\",\"tmp26\":\"5||5||\",\"tmp124\":\"49||49||\",\"tmp107\":\"150||150||\",\"tmp41\":\"9||9||\",\"tmp122\":\"99||99||\",\"tmp117\":\"99||99||\",\"tmp37\":\"79||79||\",\"tmp108\":\"99||99||\",\"tmp120\":\"49||49||\",\"tmp35\":\"69||69||\",\"tmp104\":\"40||40||\",\"tmp30\":\"6||6||\",\"tmp38\":\"49||49||\"}', '{\"index_39\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_45\":\"{\\\"index_5\\\":\\\"35\\\",\\\"index_4\\\":\\\"35\\\",\\\"index_3\\\":\\\"35\\\",\\\"index_2\\\":\\\"35\\\",\\\"index_1\\\":\\\"35\\\"}\",\"index_116\":\"{\\\"index_5\\\":\\\"39\\\",\\\"index_4\\\":\\\"39\\\",\\\"index_3\\\":\\\"39\\\",\\\"index_2\\\":\\\"39\\\",\\\"index_1\\\":\\\"39\\\"}\",\"index_123\":\"{\\\"index_5\\\":\\\"149\\\",\\\"index_4\\\":\\\"194\\\",\\\"index_3\\\":\\\"149\\\",\\\"index_2\\\":\\\"149\\\",\\\"index_1\\\":\\\"149\\\"}\",\"index_25\":\"{\\\"index_5\\\":\\\"29\\\",\\\"index_4\\\":\\\"29\\\",\\\"index_3\\\":\\\"29\\\",\\\"index_2\\\":\\\"29\\\",\\\"index_1\\\":\\\"29\\\"}\",\"index_19\":\"{\\\"index_5\\\":\\\"50\\\",\\\"index_4\\\":\\\"50\\\",\\\"index_3\\\":\\\"50\\\",\\\"index_2\\\":\\\"50\\\",\\\"index_1\\\":\\\"50\\\"}\",\"index_118\":\"{\\\"index_5\\\":\\\"99\\\",\\\"index_4\\\":\\\"99\\\",\\\"index_3\\\":\\\"99\\\",\\\"index_2\\\":\\\"99\\\",\\\"index_1\\\":\\\"99\\\"}\",\"index_125\":\"{\\\"index_5\\\":\\\"9\\\",\\\"index_4\\\":\\\"9\\\",\\\"index_3\\\":\\\"9\\\",\\\"index_2\\\":\\\"9\\\",\\\"index_1\\\":\\\"9\\\"}\",\"index_20\":\"{\\\"index_5\\\":\\\"59\\\",\\\"index_4\\\":\\\"59\\\",\\\"index_3\\\":\\\"59\\\",\\\"index_2\\\":\\\"59\\\",\\\"index_1\\\":\\\"59\\\"}\",\"index_112\":\"{\\\"index_5\\\":\\\"299\\\",\\\"index_4\\\":\\\"299\\\",\\\"index_3\\\":\\\"299\\\",\\\"index_2\\\":\\\"299\\\",\\\"index_1\\\":\\\"299\\\"}\",\"index_126\":\"{\\\"index_5\\\":\\\"196\\\",\\\"index_4\\\":\\\"196\\\",\\\"index_3\\\":\\\"196\\\",\\\"index_2\\\":\\\"196\\\",\\\"index_1\\\":\\\"196\\\"}\",\"index_111\":\"{\\\"index_5\\\":\\\"315\\\",\\\"index_4\\\":\\\"315\\\",\\\"index_3\\\":\\\"315\\\",\\\"index_2\\\":\\\"315\\\",\\\"index_1\\\":\\\"315\\\"}\",\"index_115\":\"{\\\"index_5\\\":\\\"199\\\",\\\"index_4\\\":\\\"199\\\",\\\"index_3\\\":\\\"199\\\",\\\"index_2\\\":\\\"199\\\",\\\"index_1\\\":\\\"199\\\"}\",\"index_31\":\"{\\\"index_5\\\":\\\"2\\\",\\\"index_4\\\":\\\"2\\\",\\\"index_3\\\":\\\"2\\\",\\\"index_2\\\":\\\"2\\\",\\\"index_1\\\":\\\"2\\\"}\",\"index_18\":\"{\\\"index_5\\\":\\\"7\\\",\\\"index_4\\\":\\\"7\\\",\\\"index_3\\\":\\\"7\\\",\\\"index_2\\\":\\\"7\\\",\\\"index_1\\\":\\\"7\\\"}\",\"index_23\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_114\":\"{\\\"index_5\\\":\\\"205\\\",\\\"index_4\\\":\\\"205\\\",\\\"index_3\\\":\\\"205\\\",\\\"index_2\\\":\\\"205\\\",\\\"index_1\\\":\\\"205\\\"}\",\"index_21\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_113\":\"{\\\"index_5\\\":\\\"259\\\",\\\"index_4\\\":\\\"259\\\",\\\"index_3\\\":\\\"259\\\",\\\"index_2\\\":\\\"259\\\",\\\"index_1\\\":\\\"259\\\"}\",\"index_22\":\"{\\\"index_5\\\":\\\"39\\\",\\\"index_4\\\":\\\"39\\\",\\\"index_3\\\":\\\"39\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"39\\\"}\",\"index_29\":\"{\\\"index_5\\\":\\\"68\\\",\\\"index_4\\\":\\\"68\\\",\\\"index_3\\\":\\\"68\\\",\\\"index_2\\\":\\\"68\\\",\\\"index_1\\\":\\\"68\\\"}\",\"index_110\":\"{\\\"index_5\\\":\\\"95\\\",\\\"index_4\\\":\\\"95\\\",\\\"index_3\\\":\\\"95\\\",\\\"index_2\\\":\\\"95\\\",\\\"index_1\\\":\\\"95\\\"}\",\"index_109\":\"{\\\"index_5\\\":\\\"105\\\",\\\"index_4\\\":\\\"105\\\",\\\"index_3\\\":\\\"105\\\",\\\"index_2\\\":\\\"105\\\",\\\"index_1\\\":\\\"105\\\"}\",\"index_119\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_121\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_26\":\"{\\\"index_5\\\":\\\"5\\\",\\\"index_4\\\":\\\"5\\\",\\\"index_3\\\":\\\"5\\\",\\\"index_2\\\":\\\"5\\\",\\\"index_1\\\":\\\"5\\\"}\",\"index_124\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_107\":\"{\\\"index_5\\\":\\\"160\\\",\\\"index_4\\\":\\\"160\\\",\\\"index_3\\\":\\\"160\\\",\\\"index_2\\\":\\\"160\\\",\\\"index_1\\\":\\\"160\\\"}\",\"index_41\":\"{\\\"index_5\\\":\\\"9\\\",\\\"index_4\\\":\\\"9\\\",\\\"index_3\\\":\\\"9\\\",\\\"index_2\\\":\\\"9\\\",\\\"index_1\\\":\\\"9\\\"}\",\"index_122\":\"{\\\"index_5\\\":\\\"99\\\",\\\"index_4\\\":\\\"99\\\",\\\"index_3\\\":\\\"99\\\",\\\"index_2\\\":\\\"99\\\",\\\"index_1\\\":\\\"99\\\"}\",\"index_117\":\"{\\\"index_5\\\":\\\"99\\\",\\\"index_4\\\":\\\"99\\\",\\\"index_3\\\":\\\"99\\\",\\\"index_2\\\":\\\"99\\\",\\\"index_1\\\":\\\"99\\\"}\",\"index_37\":\"{\\\"index_5\\\":\\\"79\\\",\\\"index_4\\\":\\\"79\\\",\\\"index_3\\\":\\\"79\\\",\\\"index_2\\\":\\\"79\\\",\\\"index_1\\\":\\\"79\\\"}\",\"index_108\":\"{\\\"index_5\\\":\\\"105\\\",\\\"index_4\\\":\\\"105\\\",\\\"index_3\\\":\\\"105\\\",\\\"index_2\\\":\\\"105\\\",\\\"index_1\\\":\\\"105\\\"}\",\"index_120\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_35\":\"{\\\"index_5\\\":\\\"69\\\",\\\"index_4\\\":\\\"69\\\",\\\"index_3\\\":\\\"69\\\",\\\"index_2\\\":\\\"69\\\",\\\"index_1\\\":\\\"69\\\"}\",\"index_104\":\"{\\\"index_5\\\":\\\"55\\\",\\\"index_4\\\":\\\"56\\\",\\\"index_3\\\":\\\"1\\\",\\\"index_2\\\":\\\"1\\\",\\\"index_1\\\":\\\"1\\\"}\",\"index_30\":\"{\\\"index_5\\\":\\\"6\\\",\\\"index_4\\\":\\\"6\\\",\\\"index_3\\\":\\\"6\\\",\\\"index_2\\\":\\\"6\\\",\\\"index_1\\\":\\\"6\\\"}\",\"index_38\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\"}', 'Yes', 'active', 'Live', 4, NULL, 2, '1_18,1_19,1_20,1_21,1_22,1_23,1_25,1_26,1_29,1_30,1_35,1_37,1_38,1_39,1_41,1_31,1_45,1_104,1_107,1_108,1_109,1_110,1_111,1_112,1_113,1_114,1_115,1_116,1_117,1_118,1_119,1_120,1_121,1_122,1_123,1_124,2_125,1_126,1_129', '{\"thumb_18\":\"1738500118.png\",\"thumb_19\":\"1738500077.png\",\"thumb_20\":\"1738740427.png\",\"thumb_21\":\"1738740826.png\",\"thumb_22\":\"1738741673.png\",\"thumb_23\":\"1738741718.png\",\"thumb_25\":\"1738741842.png\",\"thumb_26\":\"1738742663.png\",\"thumb_29\":\"1738742778.png\",\"thumb_30\":\"1738742811.png\",\"thumb_35\":\"1738742940.png\",\"thumb_37\":\"1738742993.png\",\"thumb_38\":\"1738743033.png\",\"thumb_39\":\"1738743066.png\",\"thumb_41\":\"1738743160.png\",\"thumb_31\":\"1738742904.png\",\"thumb_45\":\"1738743183.png\",\"thumb_104\":\"1738743620.png\",\"thumb_107\":\"1738743657.png\",\"thumb_108\":\"1738743680.png\",\"thumb_109\":\"1738743708.png\",\"thumb_110\":\"1738743738.png\",\"thumb_111\":\"1738743766.png\",\"thumb_112\":\"1738743860.png\",\"thumb_113\":\"1738744026.png\",\"thumb_114\":\"1738744053.png\",\"thumb_115\":\"1738744076.png\",\"thumb_116\":\"1738744104.png\",\"thumb_117\":\"1738744133.png\",\"thumb_118\":\"1738744163.png\",\"thumb_119\":\"1738744195.png\",\"thumb_120\":\"1738744222.png\",\"thumb_121\":\"1738744619.png\",\"thumb_122\":\"1738744650.png\",\"thumb_123\":\"1738744694.png\",\"thumb_124\":\"1738744719.png\",\"thumb_125\":\"1738744873.png\",\"thumb_126\":\"1738744910.png\",\"thumb_129\":\"\"}', '{\"large_18\":\"1738500103.png\",\"large_19\":\"1738500089.png\",\"large_20\":\"1738699189.png\",\"large_21\":\"1738699291.png\",\"large_22\":\"1738699514.png\",\"large_23\":\"1738699573.png\",\"large_25\":\"1738699709.png\",\"large_26\":\"1738699727.png\",\"large_29\":\"1738699791.png\",\"large_30\":\"1738699842.png\",\"large_35\":\"1738699868.png\",\"large_37\":\"1738699925.png\",\"large_38\":\"1738699957.png\",\"large_39\":\"1738700025.png\",\"large_41\":\"1738700146.png\",\"large_31\":\"1738738806.png\",\"large_45\":\"1738739028.png\",\"large_104\":\"1738739097.png\",\"large_107\":\"1738739135.png\",\"large_108\":\"1738739166.png\",\"large_109\":\"1738739229.png\",\"large_110\":\"1738739301.png\",\"large_111\":\"1738739367.png\",\"large_112\":\"1738739498.png\",\"large_113\":\"1738739562.png\",\"large_114\":\"1738739601.png\",\"large_115\":\"1738739627.png\",\"large_116\":\"1738739657.png\",\"large_117\":\"1738739684.png\",\"large_118\":\"1738739711.png\",\"large_119\":\"1738739752.png\",\"large_120\":\"1738739799.png\",\"large_121\":\"1738739885.png\",\"large_122\":\"1738739908.png\",\"large_123\":\"1738739941.png\",\"large_124\":\"1738739966.png\",\"large_125\":\"1738739989.png\",\"large_126\":\"1738740133.png\",\"large_129\":\"\"}', '[{\"food_id\":\"18\",\"name\":\"Fish Tacos(02)\",\"sale_price\":\"7\",\"description\":\"Fish tacos are a delicious dish featuring crispy or grilled fish wrapped in soft corn or flour tortillas. They are typically topped with fresh slaw, creamy sauce, and a squeeze of lime for a perfect balance of flavors and textures.\"},{\"food_id\":\"19\",\"name\":\"Black Pepper Beef(03)\",\"sale_price\":\"50\",\"description\":\"Black Pepper Beef is a flavorful stir-fry dish featuring tender beef cooked with bell peppers, onions, and a rich black pepper sauce. Served with rice or noodles, it offers a perfect balance of savory, spicy, and aromatic flavors.\"},{\"food_id\":\"20\",\"name\":\"Ceviche(04)\",\"sale_price\":\"59\",\"description\":\"Ceviche is a refreshing seafood dish made with fresh raw fish cured in citrus juice, mixed with onions, cilantro, and peppers. Served chilled, it offers a perfect balance of tangy, spicy, and savory flavors.\"},{\"food_id\":\"41\",\"name\":\"Shrimp Toast(025)\",\"sale_price\":\"9\",\"description\":\"Shrimp Toast is a crispy appetizer made with seasoned shrimp paste spread on bread, then fried to golden perfection. Served with dipping sauce, it offers a delicious balance of savory, crunchy, and umami flavors.\"}]', 38, 5),
(2, 'KFC Zone', '000002', '328 Bobcat Drive, Washington, United States', '7895478', '', 0, 1, '39,45,116,25,19,118,125,20,112,126,111,115,31,18,23,114,21,113,22,29,110,109,119,121,26,124,107,41,122,117,37,108,120,35,104,30,38,123,', '{\"tmp39\":\"49||49||\",\"tmp45\":\"35||35||\",\"tmp116\":\"39||39||\",\"tmp25\":\"29||29||\",\"tmp19\":\"50||50||\",\"tmp118\":\"99||99||\",\"tmp125\":\"9||9||\",\"tmp20\":\"59||59||\",\"tmp112\":\"299||299||\",\"tmp126\":\"196||196||\",\"tmp111\":\"310||310||\",\"tmp115\":\"199||199||\",\"tmp31\":\"2||2||\",\"tmp18\":\"7||7||\",\"tmp23\":\"49||49||\",\"tmp114\":\"199||199||\",\"tmp21\":\"49||49||\",\"tmp113\":\"249||249||\",\"tmp22\":\"39||39||\",\"tmp29\":\"68||68||\",\"tmp110\":\"89||89||\",\"tmp109\":\"99||99||\",\"tmp119\":\"49||49||\",\"tmp121\":\"49||49||\",\"tmp26\":\"5||5||\",\"tmp124\":\"49||49||\",\"tmp107\":\"150||150||\",\"tmp41\":\"9||9||\",\"tmp122\":\"99||99||\",\"tmp117\":\"99||99||\",\"tmp37\":\"79||79||\",\"tmp108\":\"99||99||\",\"tmp120\":\"49||49||\",\"tmp35\":\"69||69||\",\"tmp104\":\"40||40||\",\"tmp30\":\"6||6||\",\"tmp38\":\"49||49||\",\"tmp123\":\"149||149||\"}', '{\"index_39\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_45\":\"{\\\"index_5\\\":\\\"35\\\",\\\"index_4\\\":\\\"35\\\",\\\"index_3\\\":\\\"35\\\",\\\"index_2\\\":\\\"35\\\",\\\"index_1\\\":\\\"35\\\"}\",\"index_116\":\"{\\\"index_5\\\":\\\"39\\\",\\\"index_4\\\":\\\"39\\\",\\\"index_3\\\":\\\"39\\\",\\\"index_2\\\":\\\"39\\\",\\\"index_1\\\":\\\"39\\\"}\",\"index_25\":\"{\\\"index_5\\\":\\\"29\\\",\\\"index_4\\\":\\\"29\\\",\\\"index_3\\\":\\\"29\\\",\\\"index_2\\\":\\\"29\\\",\\\"index_1\\\":\\\"29\\\"}\",\"index_19\":\"{\\\"index_5\\\":\\\"50\\\",\\\"index_4\\\":\\\"50\\\",\\\"index_3\\\":\\\"50\\\",\\\"index_2\\\":\\\"50\\\",\\\"index_1\\\":\\\"50\\\"}\",\"index_118\":\"{\\\"index_5\\\":\\\"99\\\",\\\"index_4\\\":\\\"99\\\",\\\"index_3\\\":\\\"99\\\",\\\"index_2\\\":\\\"99\\\",\\\"index_1\\\":\\\"99\\\"}\",\"index_125\":\"{\\\"index_5\\\":\\\"9\\\",\\\"index_4\\\":\\\"9\\\",\\\"index_3\\\":\\\"9\\\",\\\"index_2\\\":\\\"9\\\",\\\"index_1\\\":\\\"9\\\"}\",\"index_20\":\"{\\\"index_5\\\":\\\"59\\\",\\\"index_4\\\":\\\"59\\\",\\\"index_3\\\":\\\"59\\\",\\\"index_2\\\":\\\"59\\\",\\\"index_1\\\":\\\"59\\\"}\",\"index_112\":\"{\\\"index_5\\\":\\\"299\\\",\\\"index_4\\\":\\\"299\\\",\\\"index_3\\\":\\\"299\\\",\\\"index_2\\\":\\\"299\\\",\\\"index_1\\\":\\\"299\\\"}\",\"index_126\":\"{\\\"index_5\\\":\\\"196\\\",\\\"index_4\\\":\\\"196\\\",\\\"index_3\\\":\\\"196\\\",\\\"index_2\\\":\\\"196\\\",\\\"index_1\\\":\\\"196\\\"}\",\"index_111\":\"{\\\"index_5\\\":\\\"315\\\",\\\"index_4\\\":\\\"315\\\",\\\"index_3\\\":\\\"315\\\",\\\"index_2\\\":\\\"315\\\",\\\"index_1\\\":\\\"315\\\"}\",\"index_115\":\"{\\\"index_5\\\":\\\"199\\\",\\\"index_4\\\":\\\"199\\\",\\\"index_3\\\":\\\"199\\\",\\\"index_2\\\":\\\"199\\\",\\\"index_1\\\":\\\"199\\\"}\",\"index_31\":\"{\\\"index_5\\\":\\\"2\\\",\\\"index_4\\\":\\\"2\\\",\\\"index_3\\\":\\\"2\\\",\\\"index_2\\\":\\\"2\\\",\\\"index_1\\\":\\\"2\\\"}\",\"index_18\":\"{\\\"index_5\\\":\\\"7\\\",\\\"index_4\\\":\\\"7\\\",\\\"index_3\\\":\\\"7\\\",\\\"index_2\\\":\\\"7\\\",\\\"index_1\\\":\\\"7\\\"}\",\"index_23\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_114\":\"{\\\"index_5\\\":\\\"205\\\",\\\"index_4\\\":\\\"205\\\",\\\"index_3\\\":\\\"205\\\",\\\"index_2\\\":\\\"205\\\",\\\"index_1\\\":\\\"205\\\"}\",\"index_21\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_113\":\"{\\\"index_5\\\":\\\"259\\\",\\\"index_4\\\":\\\"259\\\",\\\"index_3\\\":\\\"259\\\",\\\"index_2\\\":\\\"259\\\",\\\"index_1\\\":\\\"259\\\"}\",\"index_22\":\"{\\\"index_5\\\":\\\"39\\\",\\\"index_4\\\":\\\"39\\\",\\\"index_3\\\":\\\"39\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"39\\\"}\",\"index_29\":\"{\\\"index_5\\\":\\\"68\\\",\\\"index_4\\\":\\\"68\\\",\\\"index_3\\\":\\\"68\\\",\\\"index_2\\\":\\\"68\\\",\\\"index_1\\\":\\\"68\\\"}\",\"index_110\":\"{\\\"index_5\\\":\\\"95\\\",\\\"index_4\\\":\\\"95\\\",\\\"index_3\\\":\\\"95\\\",\\\"index_2\\\":\\\"95\\\",\\\"index_1\\\":\\\"95\\\"}\",\"index_109\":\"{\\\"index_5\\\":\\\"105\\\",\\\"index_4\\\":\\\"105\\\",\\\"index_3\\\":\\\"105\\\",\\\"index_2\\\":\\\"105\\\",\\\"index_1\\\":\\\"105\\\"}\",\"index_119\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_121\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_26\":\"{\\\"index_5\\\":\\\"5\\\",\\\"index_4\\\":\\\"5\\\",\\\"index_3\\\":\\\"5\\\",\\\"index_2\\\":\\\"5\\\",\\\"index_1\\\":\\\"5\\\"}\",\"index_124\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_107\":\"{\\\"index_5\\\":\\\"160\\\",\\\"index_4\\\":\\\"160\\\",\\\"index_3\\\":\\\"160\\\",\\\"index_2\\\":\\\"160\\\",\\\"index_1\\\":\\\"160\\\"}\",\"index_41\":\"{\\\"index_5\\\":\\\"9\\\",\\\"index_4\\\":\\\"9\\\",\\\"index_3\\\":\\\"9\\\",\\\"index_2\\\":\\\"9\\\",\\\"index_1\\\":\\\"9\\\"}\",\"index_122\":\"{\\\"index_5\\\":\\\"99\\\",\\\"index_4\\\":\\\"99\\\",\\\"index_3\\\":\\\"99\\\",\\\"index_2\\\":\\\"99\\\",\\\"index_1\\\":\\\"99\\\"}\",\"index_117\":\"{\\\"index_5\\\":\\\"99\\\",\\\"index_4\\\":\\\"99\\\",\\\"index_3\\\":\\\"99\\\",\\\"index_2\\\":\\\"99\\\",\\\"index_1\\\":\\\"99\\\"}\",\"index_37\":\"{\\\"index_5\\\":\\\"79\\\",\\\"index_4\\\":\\\"79\\\",\\\"index_3\\\":\\\"79\\\",\\\"index_2\\\":\\\"79\\\",\\\"index_1\\\":\\\"79\\\"}\",\"index_108\":\"{\\\"index_5\\\":\\\"105\\\",\\\"index_4\\\":\\\"105\\\",\\\"index_3\\\":\\\"105\\\",\\\"index_2\\\":\\\"105\\\",\\\"index_1\\\":\\\"105\\\"}\",\"index_120\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_35\":\"{\\\"index_5\\\":\\\"69\\\",\\\"index_4\\\":\\\"69\\\",\\\"index_3\\\":\\\"69\\\",\\\"index_2\\\":\\\"69\\\",\\\"index_1\\\":\\\"69\\\"}\",\"index_104\":\"{\\\"index_5\\\":\\\"55\\\",\\\"index_4\\\":\\\"56\\\",\\\"index_3\\\":\\\"1\\\",\\\"index_2\\\":\\\"1\\\",\\\"index_1\\\":\\\"1\\\"}\",\"index_30\":\"{\\\"index_5\\\":\\\"6\\\",\\\"index_4\\\":\\\"6\\\",\\\"index_3\\\":\\\"6\\\",\\\"index_2\\\":\\\"6\\\",\\\"index_1\\\":\\\"6\\\"}\",\"index_38\":\"{\\\"index_5\\\":\\\"49\\\",\\\"index_4\\\":\\\"49\\\",\\\"index_3\\\":\\\"49\\\",\\\"index_2\\\":\\\"49\\\",\\\"index_1\\\":\\\"49\\\"}\",\"index_123\":\"{\\\"index_5\\\":\\\"149\\\",\\\"index_4\\\":\\\"194\\\",\\\"index_3\\\":\\\"149\\\",\\\"index_2\\\":\\\"149\\\",\\\"index_1\\\":\\\"149\\\"}\"}', 'No', 'active', 'Live', 4, NULL, 1, NULL, NULL, NULL, NULL, 5, 3),
(4, 'KFC Modern Zone', '000001', 'kp, uk', '54897', '', 0, 4, NULL, NULL, NULL, 'No', 'active', 'Live', 0, '2025-04-24', 1, NULL, NULL, NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_payment_histories`
--

CREATE TABLE `tbl_payment_histories` (
  `id` int(11) NOT NULL,
  `payment_type` varchar(20) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `payment_date` varchar(20) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `trans_id` varchar(100) DEFAULT NULL,
  `json_details` text DEFAULT NULL,
  `del_status` varchar(10) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_payment_methods`
--

CREATE TABLE `tbl_payment_methods` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `order_by` int(11) DEFAULT NULL,
  `personalinformation` text DEFAULT NULL,
  `del_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_payment_methods`
--

INSERT INTO `tbl_payment_methods` (`id`, `name`, `description`, `user_id`, `company_id`, `order_by`, `personalinformation`, `del_status`) VALUES
(1, 'Cash', '', 1, 1, 1, '', 'Live'),
(2, 'Credit Card', 'Card', 1, 1, 1, NULL, 'Live'),
(3, 'Check', '', 1, 1, 2, NULL, 'Live'),
(4, 'Bank Transfer', '', 1, 1, 3, NULL, 'Live'),
(5, 'Loyalty Point', '', 1, 1, 4, NULL, 'Live');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_plugins`
--

CREATE TABLE `tbl_plugins` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `product_id` int(11) NOT NULL,
  `details` varchar(250) NOT NULL,
  `bestoro` varchar(100) NOT NULL,
  `active_status` varchar(10) NOT NULL DEFAULT 'Active',
  `installation_date` varchar(20) DEFAULT NULL,
  `version` varchar(20) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(10) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_plugins`
--

INSERT INTO `tbl_plugins` (`id`, `name`, `product_id`, `details`, `bestoro`, `active_status`, `installation_date`, `version`, `company_id`, `del_status`) VALUES
(1, 'Saas', 23033741, 'iRestora PLUS - Next Gen Restaurant POS Saas Module', 'fTzfWnSWR', 'Active', '2021-03-22', '1.1', 1, 'Live');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_premade_ingredients`
--

CREATE TABLE `tbl_premade_ingredients` (
  `id` bigint(50) NOT NULL,
  `ingredient_id` int(10) DEFAULT NULL,
  `consumption` float DEFAULT NULL,
  `pre_made_id` int(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live',
  `cost` float DEFAULT NULL,
  `total` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_pricing_plans`
--

CREATE TABLE `tbl_pricing_plans` (
  `id` int(11) NOT NULL,
  `plan_name` varchar(100) DEFAULT NULL,
  `payment_type` text DEFAULT NULL,
  `link_for_paypal` text DEFAULT NULL,
  `link_for_stripe` text DEFAULT NULL,
  `monthly_cost` float DEFAULT NULL,
  `price_for_month2` float DEFAULT NULL,
  `number_of_maximum_users` varchar(100) DEFAULT NULL,
  `number_of_maximum_outlets` varchar(100) DEFAULT NULL,
  `number_of_maximum_invoices` varchar(100) DEFAULT NULL,
  `trail_days` varchar(100) DEFAULT NULL,
  `free_trial_status` varchar(11) DEFAULT 'No',
  `is_recommended` varchar(10) DEFAULT 'No',
  `description` varchar(250) DEFAULT NULL,
  `price_interval` varchar(11) DEFAULT 'monthly',
  `del_status` varchar(10) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_pricing_plans`
--

INSERT INTO `tbl_pricing_plans` (`id`, `plan_name`, `payment_type`, `link_for_paypal`, `link_for_stripe`, `monthly_cost`, `price_for_month2`, `number_of_maximum_users`, `number_of_maximum_outlets`, `number_of_maximum_invoices`, `trail_days`, `free_trial_status`, `is_recommended`, `description`, `price_interval`, `del_status`) VALUES
(1, 'Silver', '2', '', '', 10.99, 9.99, '2', '2', '500', '365', 'No', 'No', '', 'yearly', 'Live'),
(2, 'Gold', '2', '', '', 20.99, 18.99, '5', '5', '2000', '15', 'No', 'No', '', 'monthly', 'Live'),
(3, 'Platinum', '1', '', '', 29.99, 25.99, '9', '4', '4000', '15', 'No', 'Yes', '', 'monthly', 'Live');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_printers`
--

CREATE TABLE `tbl_printers` (
  `id` int(11) NOT NULL,
  `path` varchar(300) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `profile_` varchar(100) DEFAULT NULL,
  `characters_per_line` int(11) DEFAULT NULL,
  `printer_ip_address` varchar(20) DEFAULT NULL,
  `printer_port` varchar(20) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `outlet_id` int(11) NOT NULL DEFAULT 0,
  `printing_choice` varchar(100) DEFAULT NULL,
  `ipvfour_address` varchar(50) DEFAULT NULL,
  `print_format` varchar(100) DEFAULT NULL,
  `inv_qr_code_enable_status` varchar(50) DEFAULT NULL,
  `open_cash_drawer_when_printing_invoice` varchar(20) NOT NULL DEFAULT 'No',
  `del_status` varchar(10) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_production`
--

CREATE TABLE `tbl_production` (
  `id` int(10) NOT NULL,
  `reference_no` varchar(50) DEFAULT NULL,
  `date` varchar(15) NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live',
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_production_ingredients`
--

CREATE TABLE `tbl_production_ingredients` (
  `id` int(10) NOT NULL,
  `ingredient_id` int(10) DEFAULT NULL,
  `quantity_amount` float DEFAULT NULL,
  `production_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live',
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_promotions`
--

CREATE TABLE `tbl_promotions` (
  `id` int(11) NOT NULL,
  `title` varchar(250) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `food_menu_id` varchar(11) DEFAULT NULL,
  `qty` float DEFAULT NULL,
  `get_food_menu_id` varchar(11) DEFAULT NULL,
  `get_qty` float DEFAULT NULL,
  `discount` varchar(10) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `outlet_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `promotion_code` varchar(30) DEFAULT NULL,
  `del_status` varchar(20) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_purchase`
--

CREATE TABLE `tbl_purchase` (
  `id` int(10) NOT NULL,
  `reference_no` varchar(50) DEFAULT NULL,
  `supplier_id` int(10) DEFAULT NULL,
  `date` varchar(15) NOT NULL,
  `subtotal` float DEFAULT NULL,
  `other` float DEFAULT NULL,
  `grand_total` float DEFAULT NULL,
  `paid` float DEFAULT NULL,
  `due` float DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_id` int(11) NOT NULL DEFAULT 0,
  `del_status` varchar(50) DEFAULT 'Live',
  `counter_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_purchase_ingredients`
--

CREATE TABLE `tbl_purchase_ingredients` (
  `id` int(10) NOT NULL,
  `ingredient_id` int(10) DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  `quantity_amount` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `purchase_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live',
  `cost_per_unit` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_register`
--

CREATE TABLE `tbl_register` (
  `id` int(15) NOT NULL,
  `opening_balance` float DEFAULT NULL,
  `opening_details` text DEFAULT NULL,
  `closing_balance` float DEFAULT NULL,
  `opening_balance_date_time` varchar(50) DEFAULT NULL,
  `closing_balance_date_time` varchar(50) DEFAULT NULL,
  `sale_paid_amount` float DEFAULT NULL,
  `refund_amount` float DEFAULT NULL,
  `customer_due_receive` float DEFAULT NULL,
  `payment_methods_sale` text DEFAULT NULL,
  `register_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=open,2=closed',
  `others_currency` text DEFAULT NULL,
  `total_purchase` float DEFAULT NULL,
  `total_due_payment` float DEFAULT NULL,
  `total_expense` float DEFAULT NULL,
  `user_id` int(15) DEFAULT NULL,
  `outlet_id` int(15) DEFAULT NULL,
  `company_id` int(15) DEFAULT NULL,
  `counter_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_reservations`
--

CREATE TABLE `tbl_reservations` (
  `id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `outlet_id` int(11) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `number_of_guest` int(11) DEFAULT NULL,
  `reservation_date` varchar(50) DEFAULT NULL,
  `reservation_time` varchar(55) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `reservation_type` varchar(50) DEFAULT NULL,
  `special_request` text DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Pending',
  `del_status` varchar(20) NOT NULL DEFAULT 'Live',
  `reservation_order_receiving_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(250) DEFAULT NULL,
  `del_status` varchar(50) NOT NULL DEFAULT 'Live',
  `company_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_role_access`
--

CREATE TABLE `tbl_role_access` (
  `id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `access_parent_id` int(11) DEFAULT NULL,
  `access_child_id` int(11) DEFAULT NULL,
  `del_status` varchar(20) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_running_orders`
--

CREATE TABLE `tbl_running_orders` (
  `id` int(11) NOT NULL,
  `order_content` text NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `del_status` varchar(12) DEFAULT 'Live',
  `sale_no` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_running_order_tables`
--

CREATE TABLE `tbl_running_order_tables` (
  `id` int(11) NOT NULL,
  `table_content` text NOT NULL,
  `del_status` varchar(12) DEFAULT 'Live',
  `sale_no` varchar(20) DEFAULT NULL,
  `table_id` int(11) NOT NULL DEFAULT 0,
  `outlet_id` int(11) NOT NULL DEFAULT 0,
  `persons` int(11) DEFAULT 0,
  `company_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_sales`
--

CREATE TABLE `tbl_sales` (
  `id` int(10) NOT NULL,
  `customer_id` varchar(50) DEFAULT NULL,
  `sale_no` varchar(500) NOT NULL DEFAULT '000000',
  `total_items` int(10) DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `due_amount` float DEFAULT NULL,
  `disc` varchar(50) DEFAULT NULL,
  `disc_actual` float DEFAULT NULL,
  `vat` float DEFAULT NULL,
  `total_payable` float DEFAULT NULL,
  `payment_method_id` int(10) DEFAULT NULL,
  `close_time` time NOT NULL,
  `table_id` int(10) DEFAULT NULL,
  `total_item_discount_amount` float NOT NULL,
  `sub_total_with_discount` float NOT NULL,
  `sub_total_discount_amount` float NOT NULL,
  `total_discount_amount` float NOT NULL,
  `charge_type` varchar(30) DEFAULT NULL,
  `delivery_charge` varchar(100) DEFAULT NULL,
  `tips_amount` varchar(100) DEFAULT NULL,
  `tips_amount_actual_charge` float DEFAULT NULL,
  `delivery_charge_actual_charge` float DEFAULT NULL,
  `sub_total_discount_value` varchar(10) NOT NULL,
  `sub_total_discount_type` varchar(20) NOT NULL,
  `sale_date` varchar(20) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_time` time NOT NULL,
  `cooking_start_time` varchar(50) DEFAULT NULL,
  `cooking_done_time` varchar(50) DEFAULT NULL,
  `modified` enum('Yes','No') NOT NULL DEFAULT 'No',
  `user_id` int(10) DEFAULT NULL,
  `waiter_id` int(10) NOT NULL DEFAULT 0,
  `outlet_id` int(10) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order, 2=invoiced order, 3=closed order',
  `order_type` tinyint(1) NOT NULL COMMENT '1=dine in, 2 = take away, 3 = delivery',
  `del_status` varchar(50) DEFAULT 'Live',
  `zatca_value` text DEFAULT NULL,
  `counter_id` int(11) NOT NULL DEFAULT 0,
  `given_amount` float DEFAULT NULL,
  `change_amount` float DEFAULT NULL,
  `sale_vat_objects` text DEFAULT NULL,
  `future_sale_status` int(11) NOT NULL DEFAULT 1,
  `random_code` varchar(50) DEFAULT NULL,
  `is_kitchen_bell` int(11) DEFAULT 1,
  `is_self_order` int(11) NOT NULL DEFAULT 0,
  `self_order_ran_code` varchar(20) DEFAULT NULL,
  `self_order_status` varchar(20) NOT NULL DEFAULT 'Pending',
  `del_address` varchar(250) DEFAULT NULL,
  `delivery_partner_id` int(11) DEFAULT NULL,
  `rounding_amount_hidden` float DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'Pending',
  `previous_due_tmp` float DEFAULT NULL,
  `used_loyalty_point` int(11) DEFAULT NULL,
  `split_sale_id` int(11) DEFAULT NULL,
  `orders_table_text` varchar(250) DEFAULT NULL,
  `refund_date_time` varchar(50) DEFAULT NULL,
  `refund_payment_id` int(11) NOT NULL DEFAULT 0,
  `total_refund` float DEFAULT NULL,
  `refund_content` text DEFAULT NULL,
  `token_number` varchar(50) DEFAULT NULL,
  `self_order_content` text DEFAULT NULL,
  `paid_date_time` varchar(20) DEFAULT NULL,
  `is_invoice` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_sales_details`
--

CREATE TABLE `tbl_sales_details` (
  `id` bigint(50) NOT NULL,
  `food_menu_id` int(10) DEFAULT NULL,
  `menu_name` varchar(250) DEFAULT NULL,
  `qty` int(10) DEFAULT NULL,
  `tmp_qty` int(11) DEFAULT NULL,
  `menu_price_without_discount` float NOT NULL,
  `menu_price_with_discount` float NOT NULL,
  `menu_unit_price` float NOT NULL,
  `menu_vat_percentage` float NOT NULL,
  `menu_taxes` text DEFAULT NULL,
  `menu_discount_value` varchar(20) DEFAULT NULL,
  `discount_type` varchar(20) NOT NULL,
  `menu_note` varchar(150) DEFAULT NULL,
  `menu_combo_items` text DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `item_type` varchar(50) DEFAULT NULL,
  `cooking_status` varchar(30) DEFAULT NULL,
  `cooking_start_time` varchar(30) DEFAULT '',
  `cooking_done_time` varchar(30) DEFAULT '',
  `previous_id` bigint(50) NOT NULL,
  `loyalty_point_earn` float DEFAULT 0,
  `sales_id` int(10) DEFAULT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order,2=invoiced order, 3=closed order',
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `is_free_item` int(11) NOT NULL DEFAULT 0,
  `del_status` varchar(50) DEFAULT 'Live',
  `discount_reason` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_sales_details_modifiers`
--

CREATE TABLE `tbl_sales_details_modifiers` (
  `id` bigint(50) NOT NULL,
  `modifier_id` int(15) NOT NULL,
  `modifier_price` float NOT NULL,
  `food_menu_id` int(10) NOT NULL,
  `sales_id` int(15) NOT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order,2=invoiced order, 3=closed order',
  `sales_details_id` int(15) NOT NULL,
  `menu_vat_percentage` float DEFAULT NULL,
  `menu_taxes` text DEFAULT NULL,
  `user_id` int(15) NOT NULL,
  `outlet_id` int(15) NOT NULL,
  `customer_id` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_sale_consumptions`
--

CREATE TABLE `tbl_sale_consumptions` (
  `id` bigint(50) NOT NULL,
  `sale_id` int(10) DEFAULT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order,2=invoiced order, 3=closed order',
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_sale_consumptions_of_menus`
--

CREATE TABLE `tbl_sale_consumptions_of_menus` (
  `id` bigint(50) NOT NULL,
  `ingredient_id` int(10) DEFAULT NULL,
  `consumption` float DEFAULT NULL,
  `sale_consumption_id` int(10) DEFAULT NULL,
  `sales_id` int(10) NOT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order,2=invoiced order, 3=closed order',
  `food_menu_id` int(10) NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live',
  `cost` float DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `production_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_sale_consumptions_of_modifiers_of_menus`
--

CREATE TABLE `tbl_sale_consumptions_of_modifiers_of_menus` (
  `id` bigint(50) NOT NULL,
  `ingredient_id` int(10) DEFAULT NULL,
  `consumption` float DEFAULT NULL,
  `sale_consumption_id` int(10) DEFAULT NULL,
  `sales_id` int(10) NOT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '1=new order,2=invoiced order, 3=closed order',
  `food_menu_id` int(10) NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live',
  `cost` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_sale_payments`
--

CREATE TABLE `tbl_sale_payments` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `currency_type` int(11) DEFAULT NULL,
  `loyalty_rate` float DEFAULT NULL,
  `multi_currency` varchar(10) DEFAULT NULL,
  `multi_currency_rate` float DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `usage_point` float DEFAULT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `date_time` timestamp NULL DEFAULT NULL,
  `del_status` varchar(20) NOT NULL DEFAULT 'Live',
  `counter_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) DEFAULT NULL,
  `outlet_id` int(11) DEFAULT NULL,
  `payment_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_sessions`
--

CREATE TABLE `tbl_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_sessions`
--

INSERT INTO `tbl_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('sdvaljh40skj46a3ve97hlbvp76mdpef', '::1', 1759672429, 0x5f5f63695f6c6173745f726567656e65726174657c693a313735393637323432363b73797374656d5f76657273696f6e5f6e756d6265727c733a333a22372e36223b776c627c693a313b6f6e6c696e655f73656c65637465645f6f75746c65747c733a313a2231223b);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_settings`
--

CREATE TABLE `tbl_settings` (
  `id` int(11) NOT NULL,
  `site_name` varchar(300) DEFAULT NULL,
  `footer` varchar(300) DEFAULT NULL,
  `system_logo` text DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(10) NOT NULL DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_settings`
--

INSERT INTO `tbl_settings` (`id`, `site_name`, `footer`, `system_logo`, `company_id`, `del_status`) VALUES
(4, 'iRestora PLUS - Next Gen Restaurant POS', 'iRestora PLUS - Next Gen Restaurant POS', '93ddd1cfd25f29986c3815608532212f.png', 1, 'Live');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_suppliers`
--

CREATE TABLE `tbl_suppliers` (
  `id` int(10) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `contact_person` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(300) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live',
  `added_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_supplier_payments`
--

CREATE TABLE `tbl_supplier_payments` (
  `id` int(10) NOT NULL,
  `date` date DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live',
  `counter_id` int(11) NOT NULL DEFAULT 0,
  `payment_id` int(11) NOT NULL DEFAULT 0,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_tables`
--

CREATE TABLE `tbl_tables` (
  `id` int(10) NOT NULL,
  `area` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sit_capacity` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live',
  `is_setting` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_time_zone`
--

CREATE TABLE `tbl_time_zone` (
  `id` int(10) NOT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `zone_name` varchar(35) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_time_zone`
--

INSERT INTO `tbl_time_zone` (`id`, `country_code`, `zone_name`, `del_status`) VALUES
(1, 'AD', 'Europe/Andorra', 'Live'),
(2, 'AE', 'Asia/Dubai', 'Live'),
(3, 'AF', 'Asia/Kabul', 'Live'),
(4, 'AG', 'America/Antigua', 'Live'),
(5, 'AI', 'America/Anguilla', 'Live'),
(6, 'AL', 'Europe/Tirane', 'Live'),
(7, 'AM', 'Asia/Yerevan', 'Live'),
(8, 'AO', 'Africa/Luanda', 'Live'),
(9, 'AQ', 'Antarctica/McMurdo', 'Live'),
(10, 'AQ', 'Antarctica/Casey', 'Live'),
(11, 'AQ', 'Antarctica/Davis', 'Live'),
(12, 'AQ', 'Antarctica/DumontDUrville', 'Live'),
(13, 'AQ', 'Antarctica/Mawson', 'Live'),
(14, 'AQ', 'Antarctica/Palmer', 'Live'),
(15, 'AQ', 'Antarctica/Rothera', 'Live'),
(16, 'AQ', 'Antarctica/Syowa', 'Live'),
(17, 'AQ', 'Antarctica/Troll', 'Live'),
(18, 'AQ', 'Antarctica/Vostok', 'Live'),
(19, 'AR', 'America/Argentina/Buenos_Aires', 'Live'),
(20, 'AR', 'America/Argentina/Cordoba', 'Live'),
(21, 'AR', 'America/Argentina/Salta', 'Live'),
(22, 'AR', 'America/Argentina/Jujuy', 'Live'),
(23, 'AR', 'America/Argentina/Tucuman', 'Live'),
(24, 'AR', 'America/Argentina/Catamarca', 'Live'),
(25, 'AR', 'America/Argentina/La_Rioja', 'Live'),
(26, 'AR', 'America/Argentina/San_Juan', 'Live'),
(27, 'AR', 'America/Argentina/Mendoza', 'Live'),
(28, 'AR', 'America/Argentina/San_Luis', 'Live'),
(29, 'AR', 'America/Argentina/Rio_Gallegos', 'Live'),
(30, 'AR', 'America/Argentina/Ushuaia', 'Live'),
(31, 'AS', 'Pacific/Pago_Pago', 'Live'),
(32, 'AT', 'Europe/Vienna', 'Live'),
(33, 'AU', 'Australia/Lord_Howe', 'Live'),
(34, 'AU', 'Antarctica/Macquarie', 'Live'),
(35, 'AU', 'Australia/Hobart', 'Live'),
(36, 'AU', 'Australia/Currie', 'Live'),
(37, 'AU', 'Australia/Melbourne', 'Live'),
(38, 'AU', 'Australia/Sydney', 'Live'),
(39, 'AU', 'Australia/Broken_Hill', 'Live'),
(40, 'AU', 'Australia/Brisbane', 'Live'),
(41, 'AU', 'Australia/Lindeman', 'Live'),
(42, 'AU', 'Australia/Adelaide', 'Live'),
(43, 'AU', 'Australia/Darwin', 'Live'),
(44, 'AU', 'Australia/Perth', 'Live'),
(45, 'AU', 'Australia/Eucla', 'Live'),
(46, 'AW', 'America/Aruba', 'Live'),
(47, 'AX', 'Europe/Mariehamn', 'Live'),
(48, 'AZ', 'Asia/Baku', 'Live'),
(49, 'BA', 'Europe/Sarajevo', 'Live'),
(50, 'BB', 'America/Barbados', 'Live'),
(51, 'BD', 'Asia/Dhaka', 'Live'),
(52, 'BE', 'Europe/Brussels', 'Live'),
(53, 'BF', 'Africa/Ouagadougou', 'Live'),
(54, 'BG', 'Europe/Sofia', 'Live'),
(55, 'BH', 'Asia/Bahrain', 'Live'),
(56, 'BI', 'Africa/Bujumbura', 'Live'),
(57, 'BJ', 'Africa/Porto-Novo', 'Live'),
(58, 'BL', 'America/St_Barthelemy', 'Live'),
(59, 'BM', 'Atlantic/Bermuda', 'Live'),
(60, 'BN', 'Asia/Brunei', 'Live'),
(61, 'BO', 'America/La_Paz', 'Live'),
(62, 'BQ', 'America/Kralendijk', 'Live'),
(63, 'BR', 'America/Noronha', 'Live'),
(64, 'BR', 'America/Belem', 'Live'),
(65, 'BR', 'America/Fortaleza', 'Live'),
(66, 'BR', 'America/Recife', 'Live'),
(67, 'BR', 'America/Araguaina', 'Live'),
(68, 'BR', 'America/Maceio', 'Live'),
(69, 'BR', 'America/Bahia', 'Live'),
(70, 'BR', 'America/Sao_Paulo', 'Live'),
(71, 'BR', 'America/Campo_Grande', 'Live'),
(72, 'BR', 'America/Cuiaba', 'Live'),
(73, 'BR', 'America/Santarem', 'Live'),
(74, 'BR', 'America/Porto_Velho', 'Live'),
(75, 'BR', 'America/Boa_Vista', 'Live'),
(76, 'BR', 'America/Manaus', 'Live'),
(77, 'BR', 'America/Eirunepe', 'Live'),
(78, 'BR', 'America/Rio_Branco', 'Live'),
(79, 'BS', 'America/Nassau', 'Live'),
(80, 'BT', 'Asia/Thimphu', 'Live'),
(81, 'BW', 'Africa/Gaborone', 'Live'),
(82, 'BY', 'Europe/Minsk', 'Live'),
(83, 'BZ', 'America/Belize', 'Live'),
(84, 'CA', 'America/St_Johns', 'Live'),
(85, 'CA', 'America/Halifax', 'Live'),
(86, 'CA', 'America/Glace_Bay', 'Live'),
(87, 'CA', 'America/Moncton', 'Live'),
(88, 'CA', 'America/Goose_Bay', 'Live'),
(89, 'CA', 'America/Blanc-Sablon', 'Live'),
(90, 'CA', 'America/Toronto', 'Live'),
(91, 'CA', 'America/Nipigon', 'Live'),
(92, 'CA', 'America/Thunder_Bay', 'Live'),
(93, 'CA', 'America/Iqaluit', 'Live'),
(94, 'CA', 'America/Pangnirtung', 'Live'),
(95, 'CA', 'America/Atikokan', 'Live'),
(96, 'CA', 'America/Winnipeg', 'Live'),
(97, 'CA', 'America/Rainy_River', 'Live'),
(98, 'CA', 'America/Resolute', 'Live'),
(99, 'CA', 'America/Rankin_Inlet', 'Live'),
(100, 'CA', 'America/Regina', 'Live'),
(101, 'CA', 'America/Swift_Current', 'Live'),
(102, 'CA', 'America/Edmonton', 'Live'),
(103, 'CA', 'America/Cambridge_Bay', 'Live'),
(104, 'CA', 'America/Yellowknife', 'Live'),
(105, 'CA', 'America/Inuvik', 'Live'),
(106, 'CA', 'America/Creston', 'Live'),
(107, 'CA', 'America/Dawson_Creek', 'Live'),
(108, 'CA', 'America/Fort_Nelson', 'Live'),
(109, 'CA', 'America/Vancouver', 'Live'),
(110, 'CA', 'America/Whitehorse', 'Live'),
(111, 'CA', 'America/Dawson', 'Live'),
(112, 'CC', 'Indian/Cocos', 'Live'),
(113, 'CD', 'Africa/Kinshasa', 'Live'),
(114, 'CD', 'Africa/Lubumbashi', 'Live'),
(115, 'CF', 'Africa/Bangui', 'Live'),
(116, 'CG', 'Africa/Brazzaville', 'Live'),
(117, 'CH', 'Europe/Zurich', 'Live'),
(118, 'CI', 'Africa/Abidjan', 'Live'),
(119, 'CK', 'Pacific/Rarotonga', 'Live'),
(120, 'CL', 'America/Santiago', 'Live'),
(121, 'CL', 'America/Punta_Arenas', 'Live'),
(122, 'CL', 'Pacific/Easter', 'Live'),
(123, 'CM', 'Africa/Douala', 'Live'),
(124, 'CN', 'Asia/Shanghai', 'Live'),
(125, 'CN', 'Asia/Urumqi', 'Live'),
(126, 'CO', 'America/Bogota', 'Live'),
(127, 'CR', 'America/Costa_Rica', 'Live'),
(128, 'CU', 'America/Havana', 'Live'),
(129, 'CV', 'Atlantic/Cape_Verde', 'Live'),
(130, 'CW', 'America/Curacao', 'Live'),
(131, 'CX', 'Indian/Christmas', 'Live'),
(132, 'CY', 'Asia/Nicosia', 'Live'),
(133, 'CY', 'Asia/Famagusta', 'Live'),
(134, 'CZ', 'Europe/Prague', 'Live'),
(135, 'DE', 'Europe/Berlin', 'Live'),
(136, 'DE', 'Europe/Busingen', 'Live'),
(137, 'DJ', 'Africa/Djibouti', 'Live'),
(138, 'DK', 'Europe/Copenhagen', 'Live'),
(139, 'DM', 'America/Dominica', 'Live'),
(140, 'DO', 'America/Santo_Domingo', 'Live'),
(141, 'DZ', 'Africa/Algiers', 'Live'),
(142, 'EC', 'America/Guayaquil', 'Live'),
(143, 'EC', 'Pacific/Galapagos', 'Live'),
(144, 'EE', 'Europe/Tallinn', 'Live'),
(145, 'EG', 'Africa/Cairo', 'Live'),
(146, 'EH', 'Africa/El_Aaiun', 'Live'),
(147, 'ER', 'Africa/Asmara', 'Live'),
(148, 'ES', 'Europe/Madrid', 'Live'),
(149, 'ES', 'Africa/Ceuta', 'Live'),
(150, 'ES', 'Atlantic/Canary', 'Live'),
(151, 'ET', 'Africa/Addis_Ababa', 'Live'),
(152, 'FI', 'Europe/Helsinki', 'Live'),
(153, 'FJ', 'Pacific/Fiji', 'Live'),
(154, 'FK', 'Atlantic/Stanley', 'Live'),
(155, 'FM', 'Pacific/Chuuk', 'Live'),
(156, 'FM', 'Pacific/Pohnpei', 'Live'),
(157, 'FM', 'Pacific/Kosrae', 'Live'),
(158, 'FO', 'Atlantic/Faroe', 'Live'),
(159, 'FR', 'Europe/Paris', 'Live'),
(160, 'GA', 'Africa/Libreville', 'Live'),
(161, 'GB', 'Europe/London', 'Live'),
(162, 'GD', 'America/Grenada', 'Live'),
(163, 'GE', 'Asia/Tbilisi', 'Live'),
(164, 'GF', 'America/Cayenne', 'Live'),
(165, 'GG', 'Europe/Guernsey', 'Live'),
(166, 'GH', 'Africa/Accra', 'Live'),
(167, 'GI', 'Europe/Gibraltar', 'Live'),
(168, 'GL', 'America/Godthab', 'Live'),
(169, 'GL', 'America/Danmarkshavn', 'Live'),
(170, 'GL', 'America/Scoresbysund', 'Live'),
(171, 'GL', 'America/Thule', 'Live'),
(172, 'GM', 'Africa/Banjul', 'Live'),
(173, 'GN', 'Africa/Conakry', 'Live'),
(174, 'GP', 'America/Guadeloupe', 'Live'),
(175, 'GQ', 'Africa/Malabo', 'Live'),
(176, 'GR', 'Europe/Athens', 'Live'),
(177, 'GS', 'Atlantic/South_Georgia', 'Live'),
(178, 'GT', 'America/Guatemala', 'Live'),
(179, 'GU', 'Pacific/Guam', 'Live'),
(180, 'GW', 'Africa/Bissau', 'Live'),
(181, 'GY', 'America/Guyana', 'Live'),
(182, 'HK', 'Asia/Hong_Kong', 'Live'),
(183, 'HN', 'America/Tegucigalpa', 'Live'),
(184, 'HR', 'Europe/Zagreb', 'Live'),
(185, 'HT', 'America/Port-au-Prince', 'Live'),
(186, 'HU', 'Europe/Budapest', 'Live'),
(187, 'ID', 'Asia/Jakarta', 'Live'),
(188, 'ID', 'Asia/Pontianak', 'Live'),
(189, 'ID', 'Asia/Makassar', 'Live'),
(190, 'ID', 'Asia/Jayapura', 'Live'),
(191, 'IE', 'Europe/Dublin', 'Live'),
(192, 'IL', 'Asia/Jerusalem', 'Live'),
(193, 'IM', 'Europe/Isle_of_Man', 'Live'),
(194, 'IN', 'Asia/Kolkata', 'Live'),
(195, 'IO', 'Indian/Chagos', 'Live'),
(196, 'IQ', 'Asia/Baghdad', 'Live'),
(197, 'IR', 'Asia/Tehran', 'Live'),
(198, 'IS', 'Atlantic/Reykjavik', 'Live'),
(199, 'IT', 'Europe/Rome', 'Live'),
(200, 'JE', 'Europe/Jersey', 'Live'),
(201, 'JM', 'America/Jamaica', 'Live'),
(202, 'JO', 'Asia/Amman', 'Live'),
(203, 'JP', 'Asia/Tokyo', 'Live'),
(204, 'KE', 'Africa/Nairobi', 'Live'),
(205, 'KG', 'Asia/Bishkek', 'Live'),
(206, 'KH', 'Asia/Phnom_Penh', 'Live'),
(207, 'KI', 'Pacific/Tarawa', 'Live'),
(208, 'KI', 'Pacific/Enderbury', 'Live'),
(209, 'KI', 'Pacific/Kiritimati', 'Live'),
(210, 'KM', 'Indian/Comoro', 'Live'),
(211, 'KN', 'America/St_Kitts', 'Live'),
(212, 'KP', 'Asia/Pyongyang', 'Live'),
(213, 'KR', 'Asia/Seoul', 'Live'),
(214, 'KW', 'Asia/Kuwait', 'Live'),
(215, 'KY', 'America/Cayman', 'Live'),
(216, 'KZ', 'Asia/Almaty', 'Live'),
(217, 'KZ', 'Asia/Qyzylorda', 'Live'),
(218, 'KZ', 'Asia/Aqtobe', 'Live'),
(219, 'KZ', 'Asia/Aqtau', 'Live'),
(220, 'KZ', 'Asia/Atyrau', 'Live'),
(221, 'KZ', 'Asia/Oral', 'Live'),
(222, 'LA', 'Asia/Vientiane', 'Live'),
(223, 'LB', 'Asia/Beirut', 'Live'),
(224, 'LC', 'America/St_Lucia', 'Live'),
(225, 'LI', 'Europe/Vaduz', 'Live'),
(226, 'LK', 'Asia/Colombo', 'Live'),
(227, 'LR', 'Africa/Monrovia', 'Live'),
(228, 'LS', 'Africa/Maseru', 'Live'),
(229, 'LT', 'Europe/Vilnius', 'Live'),
(230, 'LU', 'Europe/Luxembourg', 'Live'),
(231, 'LV', 'Europe/Riga', 'Live'),
(232, 'LY', 'Africa/Tripoli', 'Live'),
(233, 'MA', 'Africa/Casablanca', 'Live'),
(234, 'MC', 'Europe/Monaco', 'Live'),
(235, 'MD', 'Europe/Chisinau', 'Live'),
(236, 'ME', 'Europe/Podgorica', 'Live'),
(237, 'MF', 'America/Marigot', 'Live'),
(238, 'MG', 'Indian/Antananarivo', 'Live'),
(239, 'MH', 'Pacific/Majuro', 'Live'),
(240, 'MH', 'Pacific/Kwajalein', 'Live'),
(241, 'MK', 'Europe/Skopje', 'Live'),
(242, 'ML', 'Africa/Bamako', 'Live'),
(243, 'MM', 'Asia/Yangon', 'Live'),
(244, 'MN', 'Asia/Ulaanbaatar', 'Live'),
(245, 'MN', 'Asia/Hovd', 'Live'),
(246, 'MN', 'Asia/Choibalsan', 'Live'),
(247, 'MO', 'Asia/Macau', 'Live'),
(248, 'MP', 'Pacific/Saipan', 'Live'),
(249, 'MQ', 'America/Martinique', 'Live'),
(250, 'MR', 'Africa/Nouakchott', 'Live'),
(251, 'MS', 'America/Montserrat', 'Live'),
(252, 'MT', 'Europe/Malta', 'Live'),
(253, 'MU', 'Indian/Mauritius', 'Live'),
(254, 'MV', 'Indian/Maldives', 'Live'),
(255, 'MW', 'Africa/Blantyre', 'Live'),
(256, 'MX', 'America/Mexico_City', 'Live'),
(257, 'MX', 'America/Cancun', 'Live'),
(258, 'MX', 'America/Merida', 'Live'),
(259, 'MX', 'America/Monterrey', 'Live'),
(260, 'MX', 'America/Matamoros', 'Live'),
(261, 'MX', 'America/Mazatlan', 'Live'),
(262, 'MX', 'America/Chihuahua', 'Live'),
(263, 'MX', 'America/Ojinaga', 'Live'),
(264, 'MX', 'America/Hermosillo', 'Live'),
(265, 'MX', 'America/Tijuana', 'Live'),
(266, 'MX', 'America/Bahia_Banderas', 'Live'),
(267, 'MY', 'Asia/Kuala_Lumpur', 'Live'),
(268, 'MY', 'Asia/Kuching', 'Live'),
(269, 'MZ', 'Africa/Maputo', 'Live'),
(270, 'NA', 'Africa/Windhoek', 'Live'),
(271, 'NC', 'Pacific/Noumea', 'Live'),
(272, 'NE', 'Africa/Niamey', 'Live'),
(273, 'NF', 'Pacific/Norfolk', 'Live'),
(274, 'NG', 'Africa/Lagos', 'Live'),
(275, 'NI', 'America/Managua', 'Live'),
(276, 'NL', 'Europe/Amsterdam', 'Live'),
(277, 'NO', 'Europe/Oslo', 'Live'),
(278, 'NP', 'Asia/Kathmandu', 'Live'),
(279, 'NR', 'Pacific/Nauru', 'Live'),
(280, 'NU', 'Pacific/Niue', 'Live'),
(281, 'NZ', 'Pacific/Auckland', 'Live'),
(282, 'NZ', 'Pacific/Chatham', 'Live'),
(283, 'OM', 'Asia/Muscat', 'Live'),
(284, 'PA', 'America/Panama', 'Live'),
(285, 'PE', 'America/Lima', 'Live'),
(286, 'PF', 'Pacific/Tahiti', 'Live'),
(287, 'PF', 'Pacific/Marquesas', 'Live'),
(288, 'PF', 'Pacific/Gambier', 'Live'),
(289, 'PG', 'Pacific/Port_Moresby', 'Live'),
(290, 'PG', 'Pacific/Bougainville', 'Live'),
(291, 'PH', 'Asia/Manila', 'Live'),
(292, 'PK', 'Asia/Karachi', 'Live'),
(293, 'PL', 'Europe/Warsaw', 'Live'),
(294, 'PM', 'America/Miquelon', 'Live'),
(295, 'PN', 'Pacific/Pitcairn', 'Live'),
(296, 'PR', 'America/Puerto_Rico', 'Live'),
(297, 'PS', 'Asia/Gaza', 'Live'),
(298, 'PS', 'Asia/Hebron', 'Live'),
(299, 'PT', 'Europe/Lisbon', 'Live'),
(300, 'PT', 'Atlantic/Madeira', 'Live'),
(301, 'PT', 'Atlantic/Azores', 'Live'),
(302, 'PW', 'Pacific/Palau', 'Live'),
(303, 'PY', 'America/Asuncion', 'Live'),
(304, 'QA', 'Asia/Qatar', 'Live'),
(305, 'RE', 'Indian/Reunion', 'Live'),
(306, 'RO', 'Europe/Bucharest', 'Live'),
(307, 'RS', 'Europe/Belgrade', 'Live'),
(308, 'RU', 'Europe/Kaliningrad', 'Live'),
(309, 'RU', 'Europe/Moscow', 'Live'),
(310, 'RU', 'Europe/Simferopol', 'Live'),
(311, 'RU', 'Europe/Volgograd', 'Live'),
(312, 'RU', 'Europe/Kirov', 'Live'),
(313, 'RU', 'Europe/Astrakhan', 'Live'),
(314, 'RU', 'Europe/Saratov', 'Live'),
(315, 'RU', 'Europe/Ulyanovsk', 'Live'),
(316, 'RU', 'Europe/Samara', 'Live'),
(317, 'RU', 'Asia/Yekaterinburg', 'Live'),
(318, 'RU', 'Asia/Omsk', 'Live'),
(319, 'RU', 'Asia/Novosibirsk', 'Live'),
(320, 'RU', 'Asia/Barnaul', 'Live'),
(321, 'RU', 'Asia/Tomsk', 'Live'),
(322, 'RU', 'Asia/Novokuznetsk', 'Live'),
(323, 'RU', 'Asia/Krasnoyarsk', 'Live'),
(324, 'RU', 'Asia/Irkutsk', 'Live'),
(325, 'RU', 'Asia/Chita', 'Live'),
(326, 'RU', 'Asia/Yakutsk', 'Live'),
(327, 'RU', 'Asia/Khandyga', 'Live'),
(328, 'RU', 'Asia/Vladivostok', 'Live'),
(329, 'RU', 'Asia/Ust-Nera', 'Live'),
(330, 'RU', 'Asia/Magadan', 'Live'),
(331, 'RU', 'Asia/Sakhalin', 'Live'),
(332, 'RU', 'Asia/Srednekolymsk', 'Live'),
(333, 'RU', 'Asia/Kamchatka', 'Live'),
(334, 'RU', 'Asia/Anadyr', 'Live'),
(335, 'RW', 'Africa/Kigali', 'Live'),
(336, 'SA', 'Asia/Riyadh', 'Live'),
(337, 'SB', 'Pacific/Guadalcanal', 'Live'),
(338, 'SC', 'Indian/Mahe', 'Live'),
(339, 'SD', 'Africa/Khartoum', 'Live'),
(340, 'SE', 'Europe/Stockholm', 'Live'),
(341, 'SG', 'Asia/Singapore', 'Live'),
(342, 'SH', 'Atlantic/St_Helena', 'Live'),
(343, 'SI', 'Europe/Ljubljana', 'Live'),
(344, 'SJ', 'Arctic/Longyearbyen', 'Live'),
(345, 'SK', 'Europe/Bratislava', 'Live'),
(346, 'SL', 'Africa/Freetown', 'Live'),
(347, 'SM', 'Europe/San_Marino', 'Live'),
(348, 'SN', 'Africa/Dakar', 'Live'),
(349, 'SO', 'Africa/Mogadishu', 'Live'),
(350, 'SR', 'America/Paramaribo', 'Live'),
(351, 'SS', 'Africa/Juba', 'Live'),
(352, 'ST', 'Africa/Sao_Tome', 'Live'),
(353, 'SV', 'America/El_Salvador', 'Live'),
(354, 'SX', 'America/Lower_Princes', 'Live'),
(355, 'SY', 'Asia/Damascus', 'Live'),
(356, 'SZ', 'Africa/Mbabane', 'Live'),
(357, 'TC', 'America/Grand_Turk', 'Live'),
(358, 'TD', 'Africa/Ndjamena', 'Live'),
(359, 'TF', 'Indian/Kerguelen', 'Live'),
(360, 'TG', 'Africa/Lome', 'Live'),
(361, 'TH', 'Asia/Bangkok', 'Live'),
(362, 'TJ', 'Asia/Dushanbe', 'Live'),
(363, 'TK', 'Pacific/Fakaofo', 'Live'),
(364, 'TL', 'Asia/Dili', 'Live'),
(365, 'TM', 'Asia/Ashgabat', 'Live'),
(366, 'TN', 'Africa/Tunis', 'Live'),
(367, 'TO', 'Pacific/Tongatapu', 'Live'),
(368, 'TR', 'Europe/Istanbul', 'Live'),
(369, 'TT', 'America/Port_of_Spain', 'Live'),
(370, 'TV', 'Pacific/Funafuti', 'Live'),
(371, 'TW', 'Asia/Taipei', 'Live'),
(372, 'TZ', 'Africa/Dar_es_Salaam', 'Live'),
(373, 'UA', 'Europe/Kiev', 'Live'),
(374, 'UA', 'Europe/Uzhgorod', 'Live'),
(375, 'UA', 'Europe/Zaporozhye', 'Live'),
(376, 'UG', 'Africa/Kampala', 'Live'),
(377, 'UM', 'Pacific/Midway', 'Live'),
(378, 'UM', 'Pacific/Wake', 'Live'),
(379, 'US', 'America/New_York', 'Live'),
(380, 'US', 'America/Detroit', 'Live'),
(381, 'US', 'America/Kentucky/Louisville', 'Live'),
(382, 'US', 'America/Kentucky/Monticello', 'Live'),
(383, 'US', 'America/Indiana/Indianapolis', 'Live'),
(384, 'US', 'America/Indiana/Vincennes', 'Live'),
(385, 'US', 'America/Indiana/Winamac', 'Live'),
(386, 'US', 'America/Indiana/Marengo', 'Live'),
(387, 'US', 'America/Indiana/Petersburg', 'Live'),
(388, 'US', 'America/Indiana/Vevay', 'Live'),
(389, 'US', 'America/Chicago', 'Live'),
(390, 'US', 'America/Indiana/Tell_City', 'Live'),
(391, 'US', 'America/Indiana/Knox', 'Live'),
(392, 'US', 'America/Menominee', 'Live'),
(393, 'US', 'America/North_Dakota/Center', 'Live'),
(394, 'US', 'America/North_Dakota/New_Salem', 'Live'),
(395, 'US', 'America/North_Dakota/Beulah', 'Live'),
(396, 'US', 'America/Denver', 'Live'),
(397, 'US', 'America/Boise', 'Live'),
(398, 'US', 'America/Phoenix', 'Live'),
(399, 'US', 'America/Los_Angeles', 'Live'),
(400, 'US', 'America/Anchorage', 'Live'),
(401, 'US', 'America/Juneau', 'Live'),
(402, 'US', 'America/Sitka', 'Live'),
(403, 'US', 'America/Metlakatla', 'Live'),
(404, 'US', 'America/Yakutat', 'Live'),
(405, 'US', 'America/Nome', 'Live'),
(406, 'US', 'America/Adak', 'Live'),
(407, 'US', 'Pacific/Honolulu', 'Live'),
(408, 'UY', 'America/Montevideo', 'Live'),
(409, 'UZ', 'Asia/Samarkand', 'Live'),
(410, 'UZ', 'Asia/Tashkent', 'Live'),
(411, 'VA', 'Europe/Vatican', 'Live'),
(412, 'VC', 'America/St_Vincent', 'Live'),
(413, 'VE', 'America/Caracas', 'Live'),
(414, 'VG', 'America/Tortola', 'Live'),
(415, 'VI', 'America/St_Thomas', 'Live'),
(416, 'VN', 'Asia/Ho_Chi_Minh', 'Live'),
(417, 'VU', 'Pacific/Efate', 'Live'),
(418, 'WF', 'Pacific/Wallis', 'Live'),
(419, 'WS', 'Pacific/Apia', 'Live'),
(420, 'YE', 'Asia/Aden', 'Live'),
(421, 'YT', 'Indian/Mayotte', 'Live'),
(422, 'ZA', 'Africa/Johannesburg', 'Live'),
(423, 'ZM', 'Africa/Lusaka', 'Live'),
(424, 'ZW', 'Africa/Harare', 'Live');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_transfer`
--

CREATE TABLE `tbl_transfer` (
  `id` int(10) NOT NULL,
  `transfer_type` int(11) NOT NULL DEFAULT 1,
  `reference_no` varchar(50) DEFAULT NULL,
  `date` varchar(15) NOT NULL,
  `received_date` date DEFAULT NULL,
  `note_for_sender` varchar(300) DEFAULT NULL,
  `note_for_receiver` varchar(300) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `from_outlet_id` int(11) DEFAULT NULL,
  `to_outlet_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_transfer_ingredients`
--

CREATE TABLE `tbl_transfer_ingredients` (
  `id` int(10) NOT NULL,
  `transfer_type` int(11) NOT NULL DEFAULT 1,
  `status` int(11) DEFAULT NULL,
  `ingredient_id` int(10) DEFAULT NULL,
  `quantity_amount` float DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  `transfer_id` int(10) DEFAULT NULL,
  `from_outlet_id` int(10) DEFAULT NULL,
  `to_outlet_id` int(11) DEFAULT NULL,
  `total_cost` float DEFAULT NULL,
  `single_cost_total` float DEFAULT NULL,
  `single_total_tax` float DEFAULT NULL,
  `single_total_sale_amount` float DEFAULT NULL,
  `total_tax` float DEFAULT NULL,
  `total_sale_amount` float DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_transfer_received_ingredients`
--

CREATE TABLE `tbl_transfer_received_ingredients` (
  `id` int(10) NOT NULL,
  `transfer_type` int(11) NOT NULL DEFAULT 1,
  `status` int(11) DEFAULT NULL,
  `ingredient_id` int(10) DEFAULT NULL,
  `quantity_amount` float DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  `transfer_id` int(10) DEFAULT NULL,
  `from_outlet_id` int(10) DEFAULT NULL,
  `to_outlet_id` int(11) DEFAULT NULL,
  `total_cost` float DEFAULT NULL,
  `single_cost_total` float DEFAULT NULL,
  `single_total_tax` float DEFAULT NULL,
  `single_total_sale_amount` float DEFAULT NULL,
  `total_tax` float DEFAULT NULL,
  `total_sale_amount` float DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_units`
--

CREATE TABLE `tbl_units` (
  `id` int(10) NOT NULL,
  `unit_name` varchar(10) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `company_id` int(1) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` int(10) NOT NULL,
  `full_name` varchar(25) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email_address` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `will_login` varchar(20) DEFAULT 'No',
  `role` varchar(25) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `outlets` varchar(100) DEFAULT NULL,
  `kitchens` varchar(250) DEFAULT NULL,
  `company_id` int(10) DEFAULT NULL,
  `account_creation_date` varchar(50) DEFAULT NULL,
  `language` varchar(100) DEFAULT 'english',
  `last_login` varchar(50) DEFAULT NULL,
  `created_id` int(11) DEFAULT NULL,
  `active_status` varchar(25) DEFAULT 'Active',
  `del_status` varchar(10) DEFAULT 'Live',
  `created_date` varchar(20) DEFAULT NULL,
  `question` varchar(250) DEFAULT NULL,
  `answer` varchar(250) DEFAULT NULL,
  `login_pin` varchar(4) DEFAULT NULL,
  `order_receiving_id` int(11) NOT NULL DEFAULT 0,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `full_name`, `phone`, `email_address`, `password`, `designation`, `will_login`, `role`, `outlet_id`, `outlets`, `kitchens`, `company_id`, `account_creation_date`, `language`, `last_login`, `created_id`, `active_status`, `del_status`, `created_date`, `question`, `answer`, `login_pin`, `order_receiving_id`, `role_id`) VALUES
(1, 'Admin User', '+923065305216', 'adikhanofficial@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'Super Admin', 'Yes', 'Admin', 1, '2', NULL, 1, '2018-02-17 07:28:32', 'english', '', NULL, 'Active', 'Live', NULL, 'What is your favorite food?', 'Burger', '1234', 0, NULL),
(2, 'Self Order', '-', '', '', NULL, 'No', NULL, NULL, NULL, NULL, NULL, NULL, 'english', NULL, NULL, 'Active', 'Deleted', NULL, NULL, NULL, NULL, 0, NULL),
(3, 'Ds Waiter', '123456789', 'waiter1@doorsoft.co', 'e10adc3949ba59abbe56e057f20f883e', 'Waiter', 'Yes', 'User', 1, '1', '1,2,', 1, NULL, 'french', NULL, 1, 'Active', 'Live', NULL, NULL, NULL, '3333', 4, 1),
(4, 'Alice Cecil', '4569854', 'alice@doam.com', 'e10adc3949ba59abbe56e057f20f883e', 'Cashier', 'Yes', 'User', 1, '1', '', 1, NULL, 'english', NULL, 1, 'Active', 'Live', NULL, NULL, NULL, '9988', 0, 3),
(5, 'GM Martil', '1558744', 'martil@resto.com', '6b17920a59f8e2061aaaf3eb1d50c2cc', 'Manager', 'Yes', 'User', 1, '1', '', 1, NULL, 'english', NULL, 1, 'Active', 'Live', NULL, NULL, NULL, '4321', 0, 10),
(38, 'cashier', '12312312312', '', '4297f44b13955235245b2497399d7a93', 'Cashier', 'Yes', 'User', 1, '1', '', 1, NULL, 'english', NULL, 1, 'Active', 'Live', NULL, NULL, NULL, '2222', 4, 3),
(39, 'Chef User', '12354789', 'chef@doorsoft.co', 'e10adc3949ba59abbe56e057f20f883e', 'Chef', 'Yes', NULL, 1, '1', '', 1, NULL, 'english', NULL, 1, 'Active', 'Live', NULL, NULL, NULL, '4444', 4, 8),
(46, 'kpc@doorsoft.co', '123546789', 'kpc@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'Admin User', 'Yes', 'Admin', NULL, '4', NULL, 4, NULL, 'english', NULL, NULL, 'Active', 'Live', NULL, NULL, NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_user_menu_access`
--

CREATE TABLE `tbl_user_menu_access` (
  `id` int(10) NOT NULL,
  `menu_id` int(10) DEFAULT 0,
  `user_id` int(10) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_wastes`
--

CREATE TABLE `tbl_wastes` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(50) DEFAULT NULL,
  `date` date NOT NULL,
  `total_loss` float(10,2) DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  `employee_id` int(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `del_status` varchar(50) DEFAULT 'Live',
  `food_menu_id` int(11) DEFAULT NULL,
  `food_menu_waste_qty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_waste_ingredients`
--

CREATE TABLE `tbl_waste_ingredients` (
  `id` int(10) NOT NULL,
  `ingredient_id` int(10) DEFAULT NULL,
  `waste_amount` float(10,2) DEFAULT NULL,
  `last_purchase_price` float(10,2) DEFAULT NULL,
  `loss_amount` float(10,2) DEFAULT NULL,
  `waste_id` int(10) DEFAULT NULL,
  `outlet_id` int(10) DEFAULT NULL,
  `del_status` varchar(10) DEFAULT 'Live'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`access_token`);

--
-- Chỉ mục cho bảng `oauth_authorization_codes`
--
ALTER TABLE `oauth_authorization_codes`
  ADD PRIMARY KEY (`authorization_code`);

--
-- Chỉ mục cho bảng `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`client_id`);

--
-- Chỉ mục cho bảng `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`refresh_token`);

--
-- Chỉ mục cho bảng `oauth_scopes`
--
ALTER TABLE `oauth_scopes`
  ADD PRIMARY KEY (`scope`);

--
-- Chỉ mục cho bảng `oauth_users`
--
ALTER TABLE `oauth_users`
  ADD PRIMARY KEY (`username`);

--
-- Chỉ mục cho bảng `tbl_access`
--
ALTER TABLE `tbl_access`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_areas`
--
ALTER TABLE `tbl_areas`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_attendance`
--
ALTER TABLE `tbl_attendance`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_audit_logs`
--
ALTER TABLE `tbl_audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_carts`
--
ALTER TABLE `tbl_carts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_combo_food_menus`
--
ALTER TABLE `tbl_combo_food_menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `food_menu_del` (`food_menu_id`,`del_status`);

--
-- Chỉ mục cho bảng `tbl_companies`
--
ALTER TABLE `tbl_companies`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_contacts`
--
ALTER TABLE `tbl_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_counters`
--
ALTER TABLE `tbl_counters`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_customers`
--
ALTER TABLE `tbl_customers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_customer_address`
--
ALTER TABLE `tbl_customer_address`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_customer_due_receives`
--
ALTER TABLE `tbl_customer_due_receives`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_delivery_partners`
--
ALTER TABLE `tbl_delivery_partners`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_denominations`
--
ALTER TABLE `tbl_denominations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_expenses`
--
ALTER TABLE `tbl_expenses`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_expense_items`
--
ALTER TABLE `tbl_expense_items`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_explores`
--
ALTER TABLE `tbl_explores`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_food_menus`
--
ALTER TABLE `tbl_food_menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_del` (`company_id`,`del_status`),
  ADD KEY `id_del` (`id`,`del_status`);

--
-- Chỉ mục cho bảng `tbl_food_menus_ingredients`
--
ALTER TABLE `tbl_food_menus_ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_food_menus_modifiers`
--
ALTER TABLE `tbl_food_menus_modifiers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_food_menu_categories`
--
ALTER TABLE `tbl_food_menu_categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_food_menu_ratings`
--
ALTER TABLE `tbl_food_menu_ratings`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_galleries`
--
ALTER TABLE `tbl_galleries`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_holds`
--
ALTER TABLE `tbl_holds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `os_del_out` (`order_status`,`del_status`,`outlet_id`),
  ADD KEY `id_del_outlet` (`id`,`del_status`,`outlet_id`),
  ADD KEY `outlet_order_status` (`outlet_id`,`order_status`),
  ADD KEY `id_del` (`id`,`del_status`),
  ADD KEY `user_date_time_del_order` (`user_id`,`date_time`,`del_status`,`order_status`),
  ADD KEY `table_id_status` (`table_id`,`order_status`),
  ADD KEY `outlet_id_waiter_id_order_status` (`outlet_id`,`waiter_id`,`order_status`);

--
-- Chỉ mục cho bảng `tbl_holds_details`
--
ALTER TABLE `tbl_holds_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `food_menu_and_sale_id` (`food_menu_id`,`sales_id`);

--
-- Chỉ mục cho bảng `tbl_holds_details_modifiers`
--
ALTER TABLE `tbl_holds_details_modifiers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_id_details_id` (`sales_id`,`sales_details_id`);

--
-- Chỉ mục cho bảng `tbl_holds_table`
--
ALTER TABLE `tbl_holds_table`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_ingredients`
--
ALTER TABLE `tbl_ingredients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `del` (`del_status`);

--
-- Chỉ mục cho bảng `tbl_ingredient_categories`
--
ALTER TABLE `tbl_ingredient_categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_inventory_adjustment`
--
ALTER TABLE `tbl_inventory_adjustment`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_inventory_adjustment_ingredients`
--
ALTER TABLE `tbl_inventory_adjustment_ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_kitchens`
--
ALTER TABLE `tbl_kitchens`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_kitchen_categories`
--
ALTER TABLE `tbl_kitchen_categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_kitchen_sales`
--
ALTER TABLE `tbl_kitchen_sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `os_del_out` (`order_status`,`del_status`,`outlet_id`),
  ADD KEY `id_del_outlet` (`id`,`del_status`,`outlet_id`),
  ADD KEY `outlet_order_status` (`outlet_id`,`order_status`),
  ADD KEY `id_del` (`id`,`del_status`),
  ADD KEY `user_date_time_del_order` (`user_id`,`date_time`,`del_status`,`order_status`),
  ADD KEY `table_id_status` (`table_id`,`order_status`),
  ADD KEY `outlet_id_waiter_id_order_status` (`outlet_id`,`waiter_id`,`order_status`);

--
-- Chỉ mục cho bảng `tbl_kitchen_sales_details`
--
ALTER TABLE `tbl_kitchen_sales_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `food_menu_and_sale_id` (`food_menu_id`,`sales_id`);

--
-- Chỉ mục cho bảng `tbl_kitchen_sales_details_modifiers`
--
ALTER TABLE `tbl_kitchen_sales_details_modifiers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_id_details_id` (`sales_id`,`sales_details_id`);

--
-- Chỉ mục cho bảng `tbl_main_modules`
--
ALTER TABLE `tbl_main_modules`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_modifiers`
--
ALTER TABLE `tbl_modifiers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_modifier_ingredients`
--
ALTER TABLE `tbl_modifier_ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_multiple_currencies`
--
ALTER TABLE `tbl_multiple_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_notifications`
--
ALTER TABLE `tbl_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_notification_bar_kitchen_panel`
--
ALTER TABLE `tbl_notification_bar_kitchen_panel`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_orders_table`
--
ALTER TABLE `tbl_orders_table`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_outlets`
--
ALTER TABLE `tbl_outlets`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_payment_histories`
--
ALTER TABLE `tbl_payment_histories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_payment_methods`
--
ALTER TABLE `tbl_payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_plugins`
--
ALTER TABLE `tbl_plugins`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_premade_ingredients`
--
ALTER TABLE `tbl_premade_ingredients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `food_menu_del` (`pre_made_id`,`del_status`);

--
-- Chỉ mục cho bảng `tbl_pricing_plans`
--
ALTER TABLE `tbl_pricing_plans`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_printers`
--
ALTER TABLE `tbl_printers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_production`
--
ALTER TABLE `tbl_production`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_production_ingredients`
--
ALTER TABLE `tbl_production_ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_promotions`
--
ALTER TABLE `tbl_promotions`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_purchase`
--
ALTER TABLE `tbl_purchase`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_purchase_ingredients`
--
ALTER TABLE `tbl_purchase_ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_register`
--
ALTER TABLE `tbl_register`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_reservations`
--
ALTER TABLE `tbl_reservations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_role_access`
--
ALTER TABLE `tbl_role_access`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_running_orders`
--
ALTER TABLE `tbl_running_orders`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_running_order_tables`
--
ALTER TABLE `tbl_running_order_tables`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_sales`
--
ALTER TABLE `tbl_sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `os_del_out` (`order_status`,`del_status`,`outlet_id`),
  ADD KEY `id_del_outlet` (`id`,`del_status`,`outlet_id`),
  ADD KEY `outlet_order_status` (`outlet_id`,`order_status`),
  ADD KEY `id_del` (`id`,`del_status`),
  ADD KEY `user_date_time_del_order` (`user_id`,`date_time`,`del_status`,`order_status`),
  ADD KEY `table_id_status` (`table_id`,`order_status`),
  ADD KEY `outlet_id_waiter_id_order_status` (`outlet_id`,`waiter_id`,`order_status`),
  ADD KEY `get_orders_for_delete_runnig_orders` (`sale_no`,`del_status`);

--
-- Chỉ mục cho bảng `tbl_sales_details`
--
ALTER TABLE `tbl_sales_details`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_sales_details_modifiers`
--
ALTER TABLE `tbl_sales_details_modifiers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_id_details_id` (`sales_id`,`sales_details_id`);

--
-- Chỉ mục cho bảng `tbl_sale_consumptions`
--
ALTER TABLE `tbl_sale_consumptions`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_sale_consumptions_of_menus`
--
ALTER TABLE `tbl_sale_consumptions_of_menus`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_sale_consumptions_of_modifiers_of_menus`
--
ALTER TABLE `tbl_sale_consumptions_of_modifiers_of_menus`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_sale_payments`
--
ALTER TABLE `tbl_sale_payments`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_sessions`
--
ALTER TABLE `tbl_sessions`
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Chỉ mục cho bảng `tbl_settings`
--
ALTER TABLE `tbl_settings`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_suppliers`
--
ALTER TABLE `tbl_suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_supplier_payments`
--
ALTER TABLE `tbl_supplier_payments`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_tables`
--
ALTER TABLE `tbl_tables`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_time_zone`
--
ALTER TABLE `tbl_time_zone`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_transfer`
--
ALTER TABLE `tbl_transfer`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Chỉ mục cho bảng `tbl_transfer_ingredients`
--
ALTER TABLE `tbl_transfer_ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_transfer_received_ingredients`
--
ALTER TABLE `tbl_transfer_received_ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_units`
--
ALTER TABLE `tbl_units`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_user_menu_access`
--
ALTER TABLE `tbl_user_menu_access`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_wastes`
--
ALTER TABLE `tbl_wastes`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_waste_ingredients`
--
ALTER TABLE `tbl_waste_ingredients`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `tbl_access`
--
ALTER TABLE `tbl_access`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=372;

--
-- AUTO_INCREMENT cho bảng `tbl_areas`
--
ALTER TABLE `tbl_areas`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_attendance`
--
ALTER TABLE `tbl_attendance`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_audit_logs`
--
ALTER TABLE `tbl_audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_carts`
--
ALTER TABLE `tbl_carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_combo_food_menus`
--
ALTER TABLE `tbl_combo_food_menus`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_companies`
--
ALTER TABLE `tbl_companies`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `tbl_contacts`
--
ALTER TABLE `tbl_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `tbl_counters`
--
ALTER TABLE `tbl_counters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_customers`
--
ALTER TABLE `tbl_customers`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT cho bảng `tbl_customer_address`
--
ALTER TABLE `tbl_customer_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_customer_due_receives`
--
ALTER TABLE `tbl_customer_due_receives`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_delivery_partners`
--
ALTER TABLE `tbl_delivery_partners`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_denominations`
--
ALTER TABLE `tbl_denominations`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `tbl_expenses`
--
ALTER TABLE `tbl_expenses`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_expense_items`
--
ALTER TABLE `tbl_expense_items`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_explores`
--
ALTER TABLE `tbl_explores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_food_menus`
--
ALTER TABLE `tbl_food_menus`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_food_menus_ingredients`
--
ALTER TABLE `tbl_food_menus_ingredients`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_food_menus_modifiers`
--
ALTER TABLE `tbl_food_menus_modifiers`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_food_menu_categories`
--
ALTER TABLE `tbl_food_menu_categories`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_food_menu_ratings`
--
ALTER TABLE `tbl_food_menu_ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_galleries`
--
ALTER TABLE `tbl_galleries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_holds`
--
ALTER TABLE `tbl_holds`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_holds_details`
--
ALTER TABLE `tbl_holds_details`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_holds_details_modifiers`
--
ALTER TABLE `tbl_holds_details_modifiers`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_holds_table`
--
ALTER TABLE `tbl_holds_table`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_ingredients`
--
ALTER TABLE `tbl_ingredients`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_ingredient_categories`
--
ALTER TABLE `tbl_ingredient_categories`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_inventory_adjustment`
--
ALTER TABLE `tbl_inventory_adjustment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_inventory_adjustment_ingredients`
--
ALTER TABLE `tbl_inventory_adjustment_ingredients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_kitchens`
--
ALTER TABLE `tbl_kitchens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_kitchen_categories`
--
ALTER TABLE `tbl_kitchen_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_kitchen_sales`
--
ALTER TABLE `tbl_kitchen_sales`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_kitchen_sales_details`
--
ALTER TABLE `tbl_kitchen_sales_details`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_kitchen_sales_details_modifiers`
--
ALTER TABLE `tbl_kitchen_sales_details_modifiers`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_main_modules`
--
ALTER TABLE `tbl_main_modules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `tbl_modifiers`
--
ALTER TABLE `tbl_modifiers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_modifier_ingredients`
--
ALTER TABLE `tbl_modifier_ingredients`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_multiple_currencies`
--
ALTER TABLE `tbl_multiple_currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_notifications`
--
ALTER TABLE `tbl_notifications`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_notification_bar_kitchen_panel`
--
ALTER TABLE `tbl_notification_bar_kitchen_panel`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_orders_table`
--
ALTER TABLE `tbl_orders_table`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_outlets`
--
ALTER TABLE `tbl_outlets`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `tbl_payment_histories`
--
ALTER TABLE `tbl_payment_histories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_payment_methods`
--
ALTER TABLE `tbl_payment_methods`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT cho bảng `tbl_plugins`
--
ALTER TABLE `tbl_plugins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `tbl_premade_ingredients`
--
ALTER TABLE `tbl_premade_ingredients`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_pricing_plans`
--
ALTER TABLE `tbl_pricing_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tbl_printers`
--
ALTER TABLE `tbl_printers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_production`
--
ALTER TABLE `tbl_production`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_production_ingredients`
--
ALTER TABLE `tbl_production_ingredients`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_promotions`
--
ALTER TABLE `tbl_promotions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_purchase`
--
ALTER TABLE `tbl_purchase`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_purchase_ingredients`
--
ALTER TABLE `tbl_purchase_ingredients`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_register`
--
ALTER TABLE `tbl_register`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_reservations`
--
ALTER TABLE `tbl_reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_role_access`
--
ALTER TABLE `tbl_role_access`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_running_orders`
--
ALTER TABLE `tbl_running_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_running_order_tables`
--
ALTER TABLE `tbl_running_order_tables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_sales`
--
ALTER TABLE `tbl_sales`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_sales_details`
--
ALTER TABLE `tbl_sales_details`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_sales_details_modifiers`
--
ALTER TABLE `tbl_sales_details_modifiers`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_sale_consumptions`
--
ALTER TABLE `tbl_sale_consumptions`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_sale_consumptions_of_menus`
--
ALTER TABLE `tbl_sale_consumptions_of_menus`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_sale_consumptions_of_modifiers_of_menus`
--
ALTER TABLE `tbl_sale_consumptions_of_modifiers_of_menus`
  MODIFY `id` bigint(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_sale_payments`
--
ALTER TABLE `tbl_sale_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_settings`
--
ALTER TABLE `tbl_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `tbl_suppliers`
--
ALTER TABLE `tbl_suppliers`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_supplier_payments`
--
ALTER TABLE `tbl_supplier_payments`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_tables`
--
ALTER TABLE `tbl_tables`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_time_zone`
--
ALTER TABLE `tbl_time_zone`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=425;

--
-- AUTO_INCREMENT cho bảng `tbl_transfer`
--
ALTER TABLE `tbl_transfer`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_transfer_ingredients`
--
ALTER TABLE `tbl_transfer_ingredients`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_transfer_received_ingredients`
--
ALTER TABLE `tbl_transfer_received_ingredients`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_units`
--
ALTER TABLE `tbl_units`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT cho bảng `tbl_user_menu_access`
--
ALTER TABLE `tbl_user_menu_access`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_wastes`
--
ALTER TABLE `tbl_wastes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_waste_ingredients`
--
ALTER TABLE `tbl_waste_ingredients`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

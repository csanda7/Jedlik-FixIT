-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Nov 28. 12:18
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `jedlikfixit_teszt`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `hibabejelentesek`
--

CREATE TABLE `hibabejelentesek` (
  `ID` int(11) NOT NULL,
  `Title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Reported_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Reported_at` timestamp NULL DEFAULT NULL,
  `Updated_at` timestamp NULL DEFAULT NULL,
  `Priority` int(11) DEFAULT NULL,
  `Status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `assignedTo` varchar(50) DEFAULT NULL,
  `deadLine` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `hibabejelentesek`
--

INSERT INTO `hibabejelentesek` (`ID`, `Title`, `Description`, `Reported_by`, `Location`, `Reported_at`, `Updated_at`, `Priority`, `Status`, `Label`, `assignedTo`, `deadLine`) VALUES
(76, 'cxvbxcvbx', 'dfasfa', 'kiss.janos', 'Másik terem 2', '2024-10-29 14:23:49', '2024-11-13 13:15:51', 4, 'Folyamatban', 'Szoftver', NULL, NULL),
(77, 'fsadfasdfcxvy', 'yxcvcycx', 'kiss.janos', 'Első terem', '2024-10-29 14:23:57', '2024-10-29 14:44:23', 5, 'Meghiúsult', 'Szoftver', 'kovacs.bela', NULL),
(80, 'nbv nv', 'xvcbcxbx', 'kovacs.bela', 'Első terem', '2024-10-29 14:44:19', '2024-10-30 17:05:36', 2, 'Meghiúsult', 'Szoftver', 'kovacs.bela', NULL),
(81, 'DSFDS', 'CXY', 'kovacs.bela', 'Első terem', '2024-10-30 17:08:54', '2024-10-30 18:25:25', 4, 'Kész', 'Hardver', 'kovacs.bela', NULL),
(82, 'xcvycv', 'xcvyxcv', 'kovacs.bela', 'Másik terem 2', '2024-10-30 17:09:00', '2024-11-13 13:16:03', 4, 'Folyamatban', 'Hardver', NULL, '2024-11-30 13:16:00'),
(84, 'fadD', 'das', 'kovacs.bela', 'asd', '2024-10-30 17:09:19', '2024-11-14 07:52:18', 2, 'Beszerzésre vár', 'Egyéb', 'kovacs.bela', NULL),
(85, 'sadafvdv', 'xycvvyc', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:20', '2024-11-07 08:51:31', 3, 'Kész', 'Egyéb', 'kovacs.bela', NULL),
(86, '  vcv', 'cx', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:25', '2024-11-07 09:50:03', 1, 'Beszerzésre vár', 'Szoftver', 'kiss.janos', NULL),
(87, 'sdafsd', 'asdf', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:30', '2024-11-07 13:10:37', 3, 'Folyamatban', 'Hardver', 'kovacs.bela', '2024-11-09 16:13:00'),
(88, 'ícxvy', 'cyv', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:36', '2024-10-31 08:25:43', 5, 'Újból kiosztva', 'Hardver', '', NULL),
(89, 'jlk', 'ghd', 'kovacs.bela', 'yxc', '2024-10-30 18:26:42', '2024-11-06 19:57:03', 5, 'Újból kiosztva', 'Hardver', '', '2024-11-14 18:09:00'),
(90, 'fdyv', 'yxcv', 'kovacs.bela', 'Másik terem 2', '2024-10-31 08:44:50', '2024-10-31 10:05:34', 2, 'Kész', 'Szoftver', 'kovacs.bela', NULL),
(91, 'sda', 'Írok két mondatot. Kettő mondat, a Gergő egy buzi.', 'kovacs.bela', 'Másik terem 2', '2024-10-31 08:54:54', '2024-11-01 09:55:09', 2, 'Beszerzésre vár', 'Hardver', 'kovacs.bela', NULL),
(93, 'ydsfy', 'fdsvd', 'kovacs.bela', 'Másik terem 2', '2024-10-31 09:27:15', '2024-11-06 19:58:53', 2, 'Kész', 'Szoftver', 'kovacs.bela', NULL),
(94, 'gj', 'gfhfghf', 'kovacs.bela', 'Első terem', '2024-10-31 10:12:04', '2024-11-06 19:57:59', 3, 'Beszerzésre vár', 'Szoftver', 'kovacs.bela', NULL),
(95, 'fdxvc', 'xcv', 'kovacs.bela', 'Másik terem 2', '2024-10-31 10:21:10', '2024-11-06 20:41:08', 0, 'Kész', 'Hardver', 'kovacs.bela', NULL),
(96, 'adasd', 'sdfasdf', 'kovacs.bela', 'Másik terem 2', '2024-11-05 16:02:10', '2024-11-07 08:49:43', 4, 'Újból kiosztva', 'Szoftver', '', NULL),
(97, 'asd', 'asd', 'kovacs.bela', 'Másik terem 3', '2024-11-06 18:49:08', '2024-11-06 19:58:46', 3, 'Meghiúsult', 'Egyéb', 'kovacs.bela', NULL),
(98, 'asdfas', 'asdfasdf', 'kovacs.bela', 'Másik terem 2', '2024-11-06 19:59:14', '2024-11-06 20:37:41', 3, 'Kész', 'Szoftver', 'kovacs.bela', NULL),
(99, 'asdfasdf', 'fgsdg', 'kovacs.bela', 'Másik terem 2', '2024-11-06 19:59:24', '2024-11-06 20:40:24', 5, 'Kész', 'Hardver', 'kovacs.bela', NULL),
(100, 'asd', 'asd', 'kovacs.bela', 'Első terem', '2024-11-06 20:18:09', '2024-11-06 20:37:55', 2, 'Kész', 'Egyéb', 'kovacs.bela', NULL),
(101, 'sada', 'asdsa', 'kovacs.bela', 'Másik terem 3', '2024-11-07 08:32:11', '2024-11-07 09:24:23', 3, 'Folyamatban', 'Egyéb', 'kovacs.bela', NULL),
(102, 'sada', 'asdsa', 'kovacs.bela', 'Másik terem 3', '2024-11-07 08:32:50', '2024-11-07 13:09:27', 3, 'Folyamatban', 'Egyéb', 'kovacs.bela', NULL),
(103, 'dfs', 'sdaf', 'kovacs.bela', 'Első terem', '2024-11-07 08:33:31', '2024-11-14 10:05:05', 2, 'Kész', 'Hardver', 'kovacs.bela', NULL),
(104, 'sgg', 'fdgsd', 'kovacs.bela', 'Másik terem 2', '2024-11-07 09:35:09', '2024-11-13 20:08:01', NULL, 'Folyamatban', 'Hardver', 'kovacs.bela', '2024-11-30 20:07:00'),
(105, 'sgg', 'fdgsd', 'kovacs.bela', 'Másik terem 2', '2024-11-07 09:40:16', '2024-11-14 07:52:56', 0, 'Folyamatban', 'Hardver', 'kovacs.bela', NULL),
(106, 'bvxcbx', 'bxvbxvc', 'kovacs.bela', 'Másik terem 2', '2024-11-07 12:28:00', '2024-11-07 12:28:16', 4, 'Folyamatban', 'Szoftver', 'kovacs.bela', '2024-11-08 15:28:00'),
(107, 'thgf', 'fhggdf', 'kovacs.bela', 'Másik terem 3', '2024-11-07 12:30:34', '2024-11-07 12:31:02', 4, 'Folyamatban', 'Szoftver', 'kovacs.bela', NULL),
(108, 'fbfdfbd', 'fgdbdgbdgf', 'kovacs.bela', 'Másik terem 2', '2024-11-07 12:47:21', '2024-11-14 10:47:59', 3, 'Folyamatban', 'Szoftver', 'kovacs.bela', NULL),
(109, 'asdfasdf', 'adfgfdsg', 'kovacs.bela', 'Másik terem 3', '2024-11-13 13:17:47', '2024-11-13 13:19:33', 4, 'Folyamatban', 'Szoftver', NULL, NULL),
(110, 'gsdfg', 'gsdfgsdvxcvxbfgsdfgsdvxcvxbfgsdfgsdvxcvxbfgsdfgsdvxcvxbfgsdfgsdvxcvxbfgsdfgsdvxcvxbfgsdfgsdvxcvxbf', 'kovacs.bela', 'Másik terem 2', '2024-11-13 20:10:22', '2024-11-14 10:07:43', NULL, 'Meghiúsult', 'Szoftver', 'kovacs.bela', NULL),
(111, 'sdaf', 'dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd', 'kovacs.bela', 'Másik terem 2', '2024-11-14 08:30:43', '2024-11-14 10:07:21', 3, 'Meghiúsult', 'Szoftver', 'kovacs.bela', '2024-11-22 09:01:00'),
(112, 'asdfa', 'asdfasdf', 'kovacs.bela', 'Első terem', '2024-11-14 10:18:27', '2024-11-14 10:59:27', 2, 'Beszerzésre vár', 'Szoftver', 'kovacs.bela', NULL),
(113, 'dgfwegsef', 'gdfgsdfghsd', 'kovacs.bela', 'Másik terem 2', '2024-11-14 10:28:05', '2024-11-14 10:51:46', 3, 'Folyamatban', 'Hardver', 'kovacs.bela', NULL),
(114, 'fgsdfgsdf', 'gsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycfsygsdfgsdfgsdfgycf', 'kovacs.bela', 'Másik terem 3', '2024-11-14 10:29:24', '2024-11-14 10:29:24', 2, 'Bejelentve', 'Hardver', NULL, NULL),
(115, 'asdf', 'asdfasd', 'kovacs.bela', 'Másik terem 2', '2024-11-14 10:30:15', '2024-11-14 10:30:15', 3, 'Bejelentve', 'Szoftver', NULL, NULL),
(116, 'sdafasd', 'asdfasd', 'kovacs.bela', 'Másik terem 2', '2024-11-14 10:31:07', '2024-11-14 10:55:41', 3, 'Folyamatban', 'Szoftver', 'kovacs.bela', NULL),
(117, 'asdfasfa', 'sdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfasdfasdsdfadasfas', 'kovacs.bela', 'Másik terem 2', '2024-11-14 10:31:38', '2024-11-14 10:31:38', 2, 'Bejelentve', 'Hardver', NULL, NULL),
(118, 'dfasdf', 'asdfs', 'kovacs.bela', 'Másik terem 2', '2024-11-14 10:34:56', '2024-11-14 10:34:56', 2, 'Bejelentve', 'Szoftver', NULL, NULL),
(119, 'dafsdf', 'dascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvycdascvcyvyc', 'kovacs.bela', 'Másik terem 2', '2024-11-14 11:27:06', '2024-11-14 11:27:06', 3, 'Bejelentve', 'Szoftver', NULL, NULL),
(120, 'sdf', 'sdfs', 'kovacs.bela', '21 - Anyagvizsgáló és hidraulika labor', '2024-11-28 11:13:56', '2024-11-28 11:13:56', 0, 'Bejelentve', 'Szoftver', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kepek`
--

CREATE TABLE `kepek` (
  `ID` int(11) NOT NULL,
  `kep` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `kep_id` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `kepek`
--

INSERT INTO `kepek` (`ID`, `kep`, `kep_id`) VALUES
(90, '1730364290854-b21c276a4c14e05ccfb36c11cf9134dd.jpg', 1),
(90, '1730364290870-47b5e3bc757813f4f571e610d5660694.jpg', 2),
(90, '1730364290870-7fdc1a630c238af0815181f9faa190f5.jpg', 3),
(90, '1730364290870-f0d850983ac95b3f483c7233bc0fb73f.jpg', 4),
(108, '1730983641877-b21c276a4c14e05ccfb36c11cf9134dd.jpg', 1),
(108, '1730983641892-47b5e3bc757813f4f571e610d5660694.jpg', 2),
(110, '1731528622220-b21c276a4c14e05ccfb36c11cf9134dd.jpg', 1),
(110, '1731528622252-47b5e3bc757813f4f571e610d5660694.jpg', 2),
(110, '1731528622253-7fdc1a630c238af0815181f9faa190f5.jpg', 3),
(110, '1731528622253-f0d850983ac95b3f483c7233bc0fb73f.jpg', 4),
(114, '1731580164629-depositphotos_94561276-stock-photo-s', 1),
(114, '1731580164630-16732cc5cb9d7fedf85d115ab22d7029.jpg', 2),
(114, '1731580164630-images mÃ¡solata.jpg', 3),
(114, '1731580164630-0f64f755dd8e976067e0a919d2c4b666.jpg', 4),
(115, '1731580215379-depositphotos_94561276-stock-photo-s', 1),
(115, '1731580215379-16732cc5cb9d7fedf85d115ab22d7029.jpg', 2),
(115, '1731580215379-depositphotos_94561276-stock-photo-s', 3),
(115, '1731580215380-47b5e3bc757813f4f571e610d5660694.jpg', 4),
(116, '1731580267723-b21c276a4c14e05ccfb36c11cf9134dd.jpg', 1),
(116, '1731580267735-47b5e3bc757813f4f571e610d5660694.jpg', 2),
(116, '1731580267736-7fdc1a630c238af0815181f9faa190f5.jpg', 3),
(116, '1731580267736-f0d850983ac95b3f483c7233bc0fb73f.jpg', 4),
(117, '1731580298063-b21c276a4c14e05ccfb36c11cf9134dd.jpg', 1),
(117, '1731580298070-47b5e3bc757813f4f571e610d5660694.jpg', 2),
(117, '1731580298070-7fdc1a630c238af0815181f9faa190f5.jpg', 3),
(117, '1731580298070-f0d850983ac95b3f483c7233bc0fb73f.jpg', 4),
(118, '1731580496401-b21c276a4c14e05ccfb36c11cf9134dd.jpg', 1),
(118, '1731580496414-47b5e3bc757813f4f571e610d5660694.jpg', 2),
(118, '1731580496415-7fdc1a630c238af0815181f9faa190f5.jpg', 3),
(118, '1731580496415-f0d850983ac95b3f483c7233bc0fb73f.jpg', 4),
(119, '1731583626547-b21c276a4c14e05ccfb36c11cf9134dd.jpg', 1),
(119, '1731583626560-47b5e3bc757813f4f571e610d5660694.jpg', 2),
(119, '1731583626560-7fdc1a630c238af0815181f9faa190f5.jpg', 3),
(119, '1731583626560-f0d850983ac95b3f483c7233bc0fb73f.jpg', 4);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `log`
--

CREATE TABLE `log` (
  `ID` int(11) NOT NULL,
  `Status` varchar(50) CHARACTER SET utf16 COLLATE utf16_hungarian_ci NOT NULL,
  `Komment` varchar(300) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modosito` varchar(50) DEFAULT NULL,
  `assignedTo` varchar(50) DEFAULT NULL,
  `deadLine` timestamp NULL DEFAULT NULL,
  `priority` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `log`
--

INSERT INTO `log` (`ID`, `Status`, `Komment`, `updated_at`, `modosito`, `assignedTo`, `deadLine`, `priority`) VALUES
(90, 'Beszerzésre vár', '', '2024-10-31 12:45:15', NULL, NULL, NULL, NULL),
(94, 'Bejelentve', '', '2024-10-31 12:45:15', NULL, NULL, NULL, NULL),
(95, 'Bejelentve', '', '2024-10-31 12:45:15', NULL, NULL, NULL, NULL),
(88, 'Kész', '', '2024-10-31 12:45:15', NULL, NULL, NULL, NULL),
(81, 'Kész', '', '2024-10-31 12:45:15', NULL, NULL, NULL, NULL),
(90, 'Folyamatban', '', '2024-10-31 12:45:15', NULL, NULL, NULL, NULL),
(90, 'Kész', '', '2024-10-31 12:45:15', NULL, NULL, NULL, NULL),
(86, 'Folyamatban', '', '2024-10-31 12:45:15', NULL, NULL, NULL, NULL),
(87, 'Folyamatban', '', '2024-10-31 12:45:15', NULL, NULL, NULL, NULL),
(87, 'Beszerzésre vár', '', '2024-10-31 12:45:15', NULL, NULL, NULL, NULL),
(87, 'Kész', '', '2024-10-31 12:45:15', NULL, NULL, NULL, NULL),
(86, '', 'asd', '2024-11-01 09:27:25', 'kovacs.bela', NULL, NULL, NULL),
(86, 'Beszerzésre vár', 'asd', '2024-11-01 09:44:04', 'kovacs.bela', NULL, NULL, NULL),
(86, '', 'gdfsg', '2024-11-01 09:44:30', 'kovacs.bela', NULL, NULL, NULL),
(91, 'Folyamatban', 'asd', '2024-11-01 09:55:09', 'kovacs.bela', NULL, NULL, NULL),
(95, 'Folyamatban', '', '2024-11-01 09:55:48', 'kovacs.bela', NULL, NULL, NULL),
(95, '', '', '2024-11-01 09:56:51', 'kovacs.bela', NULL, NULL, NULL),
(95, 'Beszerzésre vár', '', '2024-11-01 09:59:28', 'kovacs.bela', NULL, NULL, NULL),
(95, 'Folyamatban', '', '2024-11-01 10:55:29', 'kovacs.bela', NULL, NULL, NULL),
(96, 'Bejelentve', '', '2024-11-05 16:02:10', NULL, NULL, NULL, NULL),
(96, 'Folyamatban', 'sda', '2024-11-05 16:46:17', 'kovacs.bela', NULL, NULL, NULL),
(96, 'Kész', '', '2024-11-05 16:46:31', 'kovacs.bela', NULL, NULL, NULL),
(96, 'Újból kiosztva', '', '2024-11-05 17:03:54', 'kovacs.bela', NULL, NULL, NULL),
(96, 'Folyamatban', '', '2024-11-05 17:05:45', 'kiss.janos', NULL, NULL, NULL),
(91, 'Beszerzésre vár', '', '2024-11-06 18:11:59', 'kovacs.bela', NULL, NULL, NULL),
(97, 'Bejelentve', '', '2024-11-06 18:49:08', NULL, NULL, NULL, NULL),
(89, 'Folyamatban', '', '2024-11-06 19:57:03', 'kovacs.bela', NULL, NULL, NULL),
(94, 'Folyamatban', '', '2024-11-06 19:57:59', 'kovacs.bela', NULL, NULL, NULL),
(97, 'Folyamatban', '', '2024-11-06 19:58:46', 'kovacs.bela', NULL, NULL, NULL),
(93, 'Folyamatban', '', '2024-11-06 19:58:53', 'kovacs.bela', NULL, NULL, NULL),
(98, 'Bejelentve', '', '2024-11-06 19:59:14', NULL, NULL, NULL, NULL),
(99, 'Bejelentve', '', '2024-11-06 19:59:24', NULL, NULL, NULL, NULL),
(95, 'Kész', '', '2024-11-06 19:59:29', 'kovacs.bela', NULL, NULL, NULL),
(93, 'Kész', '', '2024-11-06 19:59:50', 'kovacs.bela', NULL, NULL, NULL),
(97, 'Beszerzésre vár', '', '2024-11-06 20:04:04', 'kovacs.bela', NULL, NULL, NULL),
(97, 'Folyamatban', '', '2024-11-06 20:05:16', 'kovacs.bela', NULL, NULL, NULL),
(87, 'Újból kiosztva', '', '2024-11-06 20:08:53', 'kovacs.bela', NULL, NULL, NULL),
(100, 'Bejelentve', '', '2024-11-06 20:18:09', NULL, NULL, NULL, NULL),
(84, 'Újból kiosztva', '', '2024-11-06 20:29:30', 'kovacs.bela', NULL, NULL, NULL),
(84, 'Folyamatban', '', '2024-11-06 20:30:04', 'kovacs.bela', NULL, NULL, NULL),
(87, 'Folyamatban', '', '2024-11-06 20:37:18', 'kovacs.bela', NULL, NULL, NULL),
(98, 'Folyamatban', '', '2024-11-06 20:37:41', 'kovacs.bela', NULL, NULL, NULL),
(100, 'Folyamatban', '', '2024-11-06 20:37:55', 'kovacs.bela', NULL, NULL, NULL),
(85, 'Újból kiosztva', '', '2024-11-06 20:38:15', 'kovacs.bela', NULL, NULL, NULL),
(82, 'Újból kiosztva', '', '2024-11-06 20:38:21', 'kovacs.bela', NULL, NULL, NULL),
(85, 'Folyamatban', '', '2024-11-06 20:38:28', 'kovacs.bela', NULL, NULL, NULL),
(82, 'Folyamatban', '', '2024-11-06 20:40:00', 'kovacs.bela', NULL, NULL, NULL),
(84, 'Beszerzésre vár', '', '2024-11-06 20:40:06', 'kovacs.bela', NULL, NULL, NULL),
(99, 'Folyamatban', '', '2024-11-06 20:40:24', 'kovacs.bela', NULL, NULL, NULL),
(95, 'Újból kiosztva', '', '2024-11-06 20:40:37', 'kovacs.bela', NULL, NULL, NULL),
(95, 'Folyamatban', '', '2024-11-06 20:41:08', 'kovacs.bela', NULL, NULL, NULL),
(102, 'Bejelentve', '', '2024-11-07 08:32:50', NULL, NULL, NULL, NULL),
(103, 'Bejelentve', '', '2024-11-07 08:33:31', NULL, NULL, NULL, NULL),
(95, 'Kész', '', '2024-11-07 08:33:39', 'kovacs.bela', NULL, NULL, NULL),
(89, 'Kész', '', '2024-11-07 08:34:34', 'kovacs.bela', NULL, NULL, NULL),
(98, 'Kész', '', '2024-11-07 08:41:34', 'kovacs.bela', NULL, NULL, NULL),
(100, 'Kész', '', '2024-11-07 08:42:07', 'kovacs.bela', NULL, NULL, NULL),
(97, 'Meghiúsult', '', '2024-11-07 08:43:00', 'kovacs.bela', NULL, NULL, NULL),
(94, 'Beszerzésre vár', '', '2024-11-07 08:43:08', 'kovacs.bela', NULL, NULL, NULL),
(99, 'Kész', '', '2024-11-07 08:43:40', 'kovacs.bela', NULL, NULL, NULL),
(99, 'Kész', '', '2024-11-07 08:45:23', 'kovacs.bela', NULL, NULL, NULL),
(87, 'Kész', '', '2024-11-07 08:46:19', 'kovacs.bela', NULL, NULL, NULL),
(96, 'Kész', '', '2024-11-07 08:49:50', 'kovacs.bela', NULL, NULL, NULL),
(85, 'Kész', '', '2024-11-07 08:50:15', 'kovacs.bela', NULL, NULL, NULL),
(96, 'Újból kiosztva', '', '2024-11-07 08:50:23', 'kovacs.bela', NULL, NULL, NULL),
(89, 'Újból kiosztva', '', '2024-11-07 08:50:32', 'kovacs.bela', NULL, NULL, NULL),
(85, 'Újból kiosztva', '', '2024-11-07 08:50:44', 'kovacs.bela', NULL, NULL, NULL),
(88, 'Újból kiosztva', '', '2024-11-07 08:50:47', 'kovacs.bela', NULL, NULL, NULL),
(85, 'Folyamatban', '', '2024-11-07 08:51:31', 'kovacs.bela', NULL, NULL, NULL),
(87, 'Újból kiosztva', '', '2024-11-07 08:51:49', 'kovacs.bela', NULL, NULL, NULL),
(85, 'Kész', '', '2024-11-07 09:07:02', 'kovacs.bela', NULL, NULL, NULL),
(101, 'Folyamatban', '', '2024-11-07 09:24:23', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(102, 'Folyamatban', 'kovacs.bela', '2024-11-07 09:27:00', 'kovacs.bela', '', NULL, NULL),
(103, 'Folyamatban', '', '2024-11-07 09:28:00', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(76, '', '', '2024-11-07 09:44:57', 'kovacs.bela', 'kovacs.bela', '2024-11-07 05:47:00', 5),
(76, '', '', '2024-11-07 09:45:06', 'kovacs.bela', 'kiss.janos', '2024-11-08 09:45:00', 5),
(86, '', 'dfdasf', '2024-11-07 09:50:03', 'kovacs.bela', NULL, NULL, NULL),
(84, 'Folyamatban', '', '2024-11-07 09:51:30', 'kovacs.bela', NULL, NULL, NULL),
(106, 'Folyamatban', 'dfsdffbcv', '2024-11-07 12:28:06', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(106, '', '', '2024-11-07 12:28:16', 'kovacs.bela', 'kovacs.bela', '2024-11-08 15:28:00', 4),
(107, 'Folyamatban', 'gkmn', '2024-11-07 12:31:02', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(102, '', 'hdfghdfghdf', '2024-11-07 13:09:27', 'kovacs.bela', NULL, NULL, NULL),
(87, 'Folyamatban', 'cvbnfgn', '2024-11-07 13:10:01', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(87, '', '', '2024-11-07 13:10:13', 'kovacs.bela', 'kovacs.bela', '2024-11-09 16:10:00', 1),
(87, '', '', '2024-11-07 13:10:26', 'kovacs.bela', 'kovacs.bela', '2024-11-09 16:10:00', 3),
(87, '', '', '2024-11-07 13:10:37', 'kovacs.bela', 'kovacs.bela', '2024-11-09 16:13:00', 3),
(108, '', '', '2024-11-07 13:15:32', 'kovacs.bela', NULL, NULL, 5),
(108, '', '', '2024-11-07 13:15:39', 'kovacs.bela', NULL, '2024-11-07 13:19:00', NULL),
(108, '', '', '2024-11-07 13:16:17', 'kovacs.bela', NULL, '2024-11-09 16:19:00', NULL),
(105, '', '', '2024-11-07 13:17:20', 'kovacs.bela', NULL, '2024-11-07 18:17:00', NULL),
(84, '', '', '2024-11-13 12:55:00', 'kovacs.bela', NULL, NULL, 2),
(76, '', '', '2024-11-13 13:11:27', 'kovacs.bela', NULL, '2024-11-14 16:11:00', 1),
(82, '', '', '2024-11-13 13:14:36', 'kovacs.bela', NULL, '2024-11-15 13:17:00', NULL),
(76, '', '', '2024-11-13 13:15:04', 'kovacs.bela', NULL, '2024-11-15 13:15:00', NULL),
(76, '', '', '2024-11-13 13:15:51', 'kovacs.bela', NULL, NULL, 4),
(82, '', '', '2024-11-13 13:16:03', 'kovacs.bela', NULL, '2024-11-30 13:16:00', 4),
(109, '', '', '2024-11-13 13:18:01', 'kovacs.bela', NULL, '2024-11-16 13:17:00', 1),
(109, 'Folyamatban', 'sadfasdf', '2024-11-13 13:18:16', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(109, 'Beszerzésre vár', '', '2024-11-13 13:18:30', 'kovacs.bela', NULL, NULL, NULL),
(109, 'Folyamatban', '', '2024-11-13 13:18:53', 'kovacs.bela', NULL, NULL, NULL),
(109, '', '', '2024-11-13 13:19:08', 'kovacs.bela', 'kiss.janos', NULL, NULL),
(109, '', '', '2024-11-13 13:19:33', 'kovacs.bela', NULL, NULL, 4),
(105, '', '', '2024-11-13 20:01:31', 'kovacs.bela', NULL, NULL, 0),
(108, 'Folyamatban', '', '2024-11-13 20:07:33', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(104, '', '', '2024-11-13 20:07:51', 'kovacs.bela', NULL, '2024-11-30 20:07:00', NULL),
(104, 'Folyamatban', '', '2024-11-13 20:08:01', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(84, 'Folyamatban', '', '2024-11-14 07:51:52', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(84, 'Beszerzésre vár', '', '2024-11-14 07:52:18', 'kovacs.bela', NULL, NULL, NULL),
(105, 'Folyamatban', '', '2024-11-14 07:52:56', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(111, '', '', '2024-11-14 08:41:17', 'kovacs.bela', NULL, NULL, NULL),
(111, '', '', '2024-11-14 08:41:29', 'kovacs.bela', NULL, NULL, 1),
(111, '', '', '2024-11-14 08:41:35', 'kovacs.bela', NULL, NULL, NULL),
(111, 'Folyamatban', '', '2024-11-14 08:46:00', 'kiss.janos', 'kiss.janos', NULL, NULL),
(110, 'Folyamatban', '', '2024-11-14 08:56:35', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(110, '', '', '2024-11-14 08:56:36', 'kovacs.bela', NULL, NULL, NULL),
(110, 'Folyamatban', '', '2024-11-14 08:56:45', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(110, '', '', '2024-11-14 08:56:47', 'kovacs.bela', NULL, NULL, NULL),
(110, 'Folyamatban', '', '2024-11-14 08:57:36', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(110, '', '', '2024-11-14 08:57:40', 'kovacs.bela', NULL, NULL, NULL),
(110, '', '', '2024-11-14 08:57:55', 'kovacs.bela', NULL, NULL, NULL),
(111, '', '', '2024-11-14 09:01:48', 'kovacs.bela', 'kovacs.bela', '2024-11-22 09:01:00', 3),
(111, '', '', '2024-11-14 09:01:54', 'kovacs.bela', NULL, NULL, NULL),
(111, '', '', '2024-11-14 09:02:52', 'kovacs.bela', NULL, NULL, NULL),
(111, '', '', '2024-11-14 09:04:54', 'kovacs.bela', NULL, NULL, NULL),
(111, '', '', '2024-11-14 09:06:42', 'kovacs.bela', NULL, NULL, NULL),
(111, '', '', '2024-11-14 09:06:50', 'kovacs.bela', NULL, NULL, 4),
(111, '', '', '2024-11-14 09:06:52', 'kovacs.bela', NULL, NULL, NULL),
(111, '', '', '2024-11-14 09:08:15', 'kovacs.bela', NULL, NULL, NULL),
(111, '', '', '2024-11-14 09:10:52', 'kovacs.bela', NULL, NULL, 3),
(103, '', 'asdfasd', '2024-11-14 10:05:01', 'kovacs.bela', NULL, NULL, NULL),
(103, 'Kész', 'asdfasdfa', '2024-11-14 10:05:05', 'kovacs.bela', NULL, NULL, NULL),
(110, 'Folyamatban', 'sdgfsdfg', '2024-11-14 10:07:07', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(111, 'Meghiúsult', '', '2024-11-14 10:07:21', 'kovacs.bela', NULL, NULL, NULL),
(110, 'Meghiúsult', '', '2024-11-14 10:07:43', 'kovacs.bela', NULL, NULL, NULL),
(108, '', 'asdfasdfa', '2024-11-14 10:08:10', 'kovacs.bela', NULL, NULL, NULL),
(108, '', '', '2024-11-14 10:32:20', 'kovacs.bela', NULL, NULL, 3),
(108, 'Folyamatban', '', '2024-11-14 10:47:59', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(113, 'Folyamatban', '', '2024-11-14 10:51:46', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(116, 'Folyamatban', 'asd', '2024-11-14 10:55:41', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(112, 'Folyamatban', '', '2024-11-14 10:57:03', 'kovacs.bela', 'kovacs.bela', NULL, NULL),
(112, 'Beszerzésre vár', '', '2024-11-14 10:59:27', 'kovacs.bela', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `termek`
--

CREATE TABLE `termek` (
  `terem` varchar(38) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- A tábla adatainak kiíratása `termek`
--

INSERT INTO `termek` (`terem`) VALUES
('\"B\" épület 1. emeleti tanári'),
('\"B\" épület 2. emeleti tanári'),
('002 - Klub 1'),
('004 - Klub 2'),
('011 - Étkező'),
('22'),
('23'),
('24'),
('25'),
('026 - III. tárgyaló'),
('1/2 - Igazgatóhelyettesi iroda'),
('1/3 - Igazgatóhelyettesi iroda'),
('1/4 - Igazgatóhelyettesi iroda'),
('10 - humán tanári'),
('101 - informatika tanári'),
('102'),
('103'),
('104'),
('105 - matematika tanári'),
('106'),
('107 - fizika tanári'),
('108'),
('11 - humán tanári'),
('110'),
('112'),
('113 - tanári szoba'),
('114'),
('115'),
('116'),
('117'),
('118 - Könyvtár'),
('119-1 Lakatos műhely 1'),
('119-2 Lakatos műhely 2'),
('12'),
('121'),
('13 - humán tanári'),
('14'),
('15'),
('18 - Gyakorlati oktatásvezető'),
('2 - Igazgatói iroda'),
('20 - műhely tanári'),
('201 - szerver szoba'),
('202'),
('203'),
('204'),
('205'),
('206 - műszaki tanári'),
('207'),
('208'),
('209'),
('21 - Anyagvizsgáló labor'),
('210'),
('211 - humán tanári'),
('212'),
('213 - orvosi szoba'),
('24 - CÍM'),
('25 - CNC programozó'),
('28 - Esztergályos műhely'),
('29-es kisterem'),
('3 - Tárgyaló'),
('30 - PLC labor'),
('302'),
('303'),
('304 - informatika tanári'),
('31 - Pneumatika labor'),
('32 - Mérőszoba'),
('36 - Hegesztő labor'),
('4 - GINOP projektiroda'),
('401 - vendégszoba'),
('402 - tehetségszoba'),
('41'),
('42 - CAD-CAM'),
('43 - Vegyes forgácsoló'),
('5 - Gazdasági iroda'),
('Aqua sportközpont'),
('B1'),
('B2'),
('B4'),
('B5'),
('B6'),
('B7'),
('B8'),
('K101'),
('K102'),
('K103'),
('K104'),
('K105'),
('K106'),
('K107'),
('K108'),
('K109'),
('K110'),
('K111'),
('K112'),
('K201'),
('K202'),
('K203'),
('K204'),
('K205'),
('K206'),
('K207'),
('K208'),
('K209'),
('K210'),
('K211'),
('Kollégiumi beteg szoba'),
('Kollégiumi étkező'),
('Kollégiumi foglalkoztató'),
('Kollégiumi gépterem'),
('Kollégiumi konditerem'),
('Kollégiumi nevelői szoba 1'),
('Kollégiumi nevelői szoba 2'),
('Kollégiumi tanulószoba 1'),
('Kollégiumi tanulószoba 2'),
('Kollégiumi teakonyha'),
('Kollégiumi vezetői iroda'),
('Külső helyszín'),
('Online'),
('Stúdió'),
('T1'),
('T2'),
('T3'),
('T4'),
('T5'),
('T6'),
('Testnevelő tanári'),
('Tömegsport'),
('tornacsarnok'),
('tornacsarnok2'),
('Egyéb');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `hibabejelentesek`
--
ALTER TABLE `hibabejelentesek`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `kepek`
--
ALTER TABLE `kepek`
  ADD KEY `hiba_kep` (`ID`);

--
-- A tábla indexei `log`
--
ALTER TABLE `log`
  ADD KEY `hiba_log` (`ID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `hibabejelentesek`
--
ALTER TABLE `hibabejelentesek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `kepek`
--
ALTER TABLE `kepek`
  ADD CONSTRAINT `hiba_kep` FOREIGN KEY (`ID`) REFERENCES `hibabejelentesek` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `hiba_log` FOREIGN KEY (`ID`) REFERENCES `hibabejelentesek` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

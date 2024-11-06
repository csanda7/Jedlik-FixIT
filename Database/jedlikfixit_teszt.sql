-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Nov 06. 21:16
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
  `Title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Reported_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Reported_at` timestamp NULL DEFAULT NULL,
  `Updated_at` timestamp NULL DEFAULT NULL,
  `Priority` int(11) DEFAULT NULL,
  `Status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `assignedTo` varchar(255) DEFAULT NULL,
  `hiba_idopont` timestamp NOT NULL DEFAULT current_timestamp(),
  `deadLine` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `hibabejelentesek`
--

INSERT INTO `hibabejelentesek` (`ID`, `Title`, `Description`, `Reported_by`, `Location`, `Reported_at`, `Updated_at`, `Priority`, `Status`, `Label`, `assignedTo`, `hiba_idopont`, `deadLine`) VALUES
(76, 'cxvbxcvbx', 'dfasfa', 'kiss.janos', 'Másik terem 2', '2024-10-29 14:23:49', '2024-11-06 19:55:23', 4, 'Folyamatban', 'Szoftver', 'nagy.gabor', '2024-10-31 08:08:46', '2024-11-07 06:47:00'),
(77, 'fsadfasdfcxvy', 'yxcvcycx', 'kiss.janos', 'Első terem', '2024-10-29 14:23:57', '2024-10-29 14:44:23', 5, 'Meghiúsult', 'Szoftver', 'kovacs.bela', '2024-10-31 08:08:46', NULL),
(80, 'nbv nv', 'xvcbcxbx', 'kovacs.bela', 'Első terem', '2024-10-29 14:44:19', '2024-10-30 17:05:36', 2, 'Meghiúsult', 'Szoftver', 'kovacs.bela', '2024-10-31 08:08:46', NULL),
(81, 'DSFDS', 'CXY', 'kovacs.bela', 'Első terem', '2024-10-30 17:08:54', '2024-10-30 18:25:25', 4, 'Kész', 'Hardver', 'kovacs.bela', '2024-10-31 08:08:46', NULL),
(82, 'xcvycv', 'xcvyxcv', 'kovacs.bela', 'Másik terem 2', '2024-10-30 17:09:00', '2024-10-30 18:24:01', 2, 'Meghiúsult', 'Hardver', 'kovacs.bela', '2024-10-31 08:08:46', NULL),
(84, 'fadD', 'das', 'kovacs.bela', 'asd', '2024-10-30 17:09:19', '2024-10-30 18:25:32', 5, 'Kész', 'Egyéb', 'kovacs.bela', '2024-10-31 08:08:46', NULL),
(85, 'sadafvdv', 'xycvvyc', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:20', '2024-10-30 19:16:15', 3, 'Kész', 'Egyéb', 'kovacs.bela', '2024-10-31 08:08:46', NULL),
(86, '  vcv', 'cx', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:25', '2024-11-06 19:46:15', 1, 'Beszerzésre vár', 'Szoftver', 'kiss.janos', '2024-10-31 08:08:46', NULL),
(87, 'sdafsd', 'asdf', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:30', '2024-10-31 12:40:40', 1, 'Újból kiosztva', 'Hardver', '', '2024-10-31 08:08:46', NULL),
(88, 'ícxvy', 'cyv', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:36', '2024-10-31 08:25:43', 5, 'Kész', 'Hardver', 'kovacs.bela', '2024-10-31 08:08:46', NULL),
(89, 'jlk', 'ghd', 'kovacs.bela', 'yxc', '2024-10-30 18:26:42', '2024-11-06 19:57:03', 5, 'Folyamatban', 'Hardver', 'kovacs.bela', '2024-10-31 08:08:46', '2024-11-14 18:09:00'),
(90, 'fdyv', 'yxcv', 'kovacs.bela', 'Másik terem 2', '2024-10-31 08:44:50', '2024-10-31 10:05:34', 2, 'Kész', 'Szoftver', 'kovacs.bela', '2024-10-31 08:44:50', NULL),
(91, 'sda', 'Írok két mondatot. Kettő mondat, a Gergő egy buzi.', 'kovacs.bela', 'Másik terem 2', '2024-10-31 08:54:54', '2024-11-01 09:55:09', 2, 'Beszerzésre vár', 'Hardver', 'kovacs.bela', '2024-10-31 08:54:54', NULL),
(93, 'ydsfy', 'fdsvd', 'kovacs.bela', 'Másik terem 2', '2024-10-31 09:27:15', '2024-11-06 19:58:53', 2, 'Kész', 'Szoftver', 'kovacs.bela', '2024-10-31 08:26:00', NULL),
(94, 'gj', 'gfhfghf', 'kovacs.bela', 'Első terem', '2024-10-31 10:12:04', '2024-11-06 19:57:59', 3, 'Folyamatban', 'Szoftver', 'kovacs.bela', '2024-10-31 10:11:00', NULL),
(95, 'fdxvc', 'xcv', 'kovacs.bela', 'Másik terem 2', '2024-10-31 10:21:10', '2024-11-01 09:56:51', 0, 'Kész', 'Hardver', 'kovacs.bela', '2024-10-31 10:21:00', NULL),
(96, 'adasd', 'sdfasdf', 'kovacs.bela', 'Másik terem 2', '2024-11-05 16:02:10', '2024-11-05 17:05:45', 4, 'Folyamatban', 'Szoftver', 'kiss.janos', '2024-11-05 16:02:00', NULL),
(97, 'asd', 'asd', 'kovacs.bela', 'Másik terem 3', '2024-11-06 18:49:08', '2024-11-06 19:58:46', 3, 'Folyamatban', 'Egyéb', 'kovacs.bela', '2024-11-06 18:49:00', NULL),
(98, 'asdfas', 'asdfasdf', 'kovacs.bela', 'Másik terem 2', '2024-11-06 19:59:14', '2024-11-06 19:59:14', 3, 'Bejelentve', 'Szoftver', NULL, '2024-11-06 19:59:00', NULL),
(99, 'asdfasdf', 'fgsdg', 'kovacs.bela', 'Másik terem 2', '2024-11-06 19:59:24', '2024-11-06 19:59:24', 5, 'Bejelentve', 'Hardver', NULL, '2024-11-06 19:59:00', NULL);

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
(90, '1730364290870-f0d850983ac95b3f483c7233bc0fb73f.jpg', 4);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `log`
--

CREATE TABLE `log` (
  `ID` int(11) NOT NULL,
  `LStatus` varchar(255) CHARACTER SET utf16 COLLATE utf16_hungarian_ci NOT NULL,
  `Komment` varchar(300) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modosito` varchar(50) DEFAULT NULL,
  `assignedTo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `log`
--

INSERT INTO `log` (`ID`, `LStatus`, `Komment`, `updated_at`, `modosito`, `assignedTo`) VALUES
(90, 'Beszerzésre vár', '', '2024-10-31 12:45:15', NULL, NULL),
(94, 'Bejelentve', '', '2024-10-31 12:45:15', NULL, NULL),
(95, 'Bejelentve', '', '2024-10-31 12:45:15', NULL, NULL),
(88, 'Kész', '', '2024-10-31 12:45:15', NULL, NULL),
(81, 'Kész', '', '2024-10-31 12:45:15', NULL, NULL),
(90, 'Folyamatban', '', '2024-10-31 12:45:15', NULL, NULL),
(90, 'Kész', '', '2024-10-31 12:45:15', NULL, NULL),
(86, 'Folyamatban', '', '2024-10-31 12:45:15', NULL, NULL),
(87, 'Folyamatban', '', '2024-10-31 12:45:15', NULL, NULL),
(87, 'Beszerzésre vár', '', '2024-10-31 12:45:15', NULL, NULL),
(87, 'Kész', '', '2024-10-31 12:45:15', NULL, NULL),
(86, '', 'asd', '2024-11-01 09:27:25', 'kovacs.bela', NULL),
(86, 'Beszerzésre vár', 'asd', '2024-11-01 09:44:04', 'kovacs.bela', NULL),
(86, '', 'gdfsg', '2024-11-01 09:44:30', 'kovacs.bela', NULL),
(91, 'Folyamatban', 'asd', '2024-11-01 09:55:09', 'kovacs.bela', NULL),
(95, 'Folyamatban', '', '2024-11-01 09:55:48', 'kovacs.bela', NULL),
(95, '', '', '2024-11-01 09:56:51', 'kovacs.bela', NULL),
(95, 'Beszerzésre vár', '', '2024-11-01 09:59:28', 'kovacs.bela', NULL),
(95, 'Folyamatban', '', '2024-11-01 10:55:29', 'kovacs.bela', NULL),
(96, 'Bejelentve', '', '2024-11-05 16:02:10', NULL, NULL),
(96, 'Folyamatban', 'sda', '2024-11-05 16:46:17', 'kovacs.bela', NULL),
(96, 'Kész', '', '2024-11-05 16:46:31', 'kovacs.bela', NULL),
(96, 'Újból kiosztva', '', '2024-11-05 17:03:54', 'kovacs.bela', NULL),
(96, 'Folyamatban', '', '2024-11-05 17:05:45', 'kiss.janos', NULL),
(91, 'Beszerzésre vár', '', '2024-11-06 18:11:59', 'kovacs.bela', NULL),
(97, 'Bejelentve', '', '2024-11-06 18:49:08', NULL, NULL),
(89, 'Folyamatban', '', '2024-11-06 19:57:03', 'kovacs.bela', NULL),
(94, 'Folyamatban', '', '2024-11-06 19:57:59', 'kovacs.bela', NULL),
(97, 'Folyamatban', '', '2024-11-06 19:58:46', 'kovacs.bela', NULL),
(93, 'Folyamatban', '', '2024-11-06 19:58:53', 'kovacs.bela', NULL),
(98, 'Bejelentve', '', '2024-11-06 19:59:14', NULL, NULL),
(99, 'Bejelentve', '', '2024-11-06 19:59:24', NULL, NULL),
(95, 'Kész', '', '2024-11-06 19:59:29', 'kovacs.bela', NULL),
(93, 'Kész', '', '2024-11-06 19:59:50', 'kovacs.bela', NULL),
(97, 'Beszerzésre vár', '', '2024-11-06 20:04:04', 'kovacs.bela', NULL),
(97, 'Folyamatban', '', '2024-11-06 20:05:16', 'kovacs.bela', NULL),
(87, 'Újból kiosztva', '', '2024-11-06 20:08:53', 'kovacs.bela', NULL);

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

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

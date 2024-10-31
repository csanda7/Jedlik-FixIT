-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Okt 31. 09:14
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
  `hiba_idopont` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `hibabejelentesek`
--

INSERT INTO `hibabejelentesek` (`ID`, `Title`, `Description`, `Reported_by`, `Location`, `Reported_at`, `Updated_at`, `Priority`, `Status`, `Label`, `assignedTo`, `hiba_idopont`) VALUES
(61, 'asd', 'asd', 'kovacs.bela', 'Első terem', '2024-10-17 09:13:46', '2024-10-29 14:23:16', 3, 'Beszerzésre vár', NULL, 'kiss.janos', '2024-10-31 08:08:46'),
(76, 'cxvbxcvbx', 'dfasfa', 'kiss.janos', 'Másik terem 2', '2024-10-29 14:23:49', '2024-10-29 14:30:24', 3, 'Folyamatban', 'Szoftver', 'kiss.janos', '2024-10-31 08:08:46'),
(77, 'fsadfasdfcxvy', 'yxcvcycx', 'kiss.janos', 'Első terem', '2024-10-29 14:23:57', '2024-10-29 14:44:23', 5, 'Meghiúsult', 'Szoftver', 'kovacs.bela', '2024-10-31 08:08:46'),
(80, 'nbv nv', 'xvcbcxbx', 'kovacs.bela', 'Első terem', '2024-10-29 14:44:19', '2024-10-30 17:05:36', 2, 'Meghiúsult', 'Szoftver', 'kovacs.bela', '2024-10-31 08:08:46'),
(81, 'DSFDS', 'CXY', 'kovacs.bela', 'Első terem', '2024-10-30 17:08:54', '2024-10-30 18:25:25', 4, 'Folyamatban', 'Hardver', 'kovacs.bela', '2024-10-31 08:08:46'),
(82, 'xcvycv', 'xcvyxcv', 'kovacs.bela', 'Másik terem 2', '2024-10-30 17:09:00', '2024-10-30 18:24:01', 2, 'Meghiúsult', 'Hardver', 'kovacs.bela', '2024-10-31 08:08:46'),
(84, 'fadD', 'das', 'kovacs.bela', 'asd', '2024-10-30 17:09:19', '2024-10-30 18:25:32', 5, 'Kész', 'Egyéb', 'kovacs.bela', '2024-10-31 08:08:46'),
(85, 'sadafvdv', 'xycvvyc', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:20', '2024-10-30 19:16:15', 3, 'Kész', 'Egyéb', 'kovacs.bela', '2024-10-31 08:08:46'),
(86, '  vcv', 'cx', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:25', '2024-10-30 18:26:25', 3, 'Bejelentve', 'Szoftver', NULL, '2024-10-31 08:08:46'),
(87, 'sdafsd', 'asdf', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:30', '2024-10-30 18:26:30', 1, 'Bejelentve', 'Hardver', NULL, '2024-10-31 08:08:46'),
(88, 'ícxvy', 'cyv', 'kovacs.bela', 'Másik terem 2', '2024-10-30 18:26:36', '2024-10-30 18:26:36', 5, 'Bejelentve', 'Hardver', NULL, '2024-10-31 08:08:46'),
(89, 'jlk', 'ghd', 'kovacs.bela', 'yxc', '2024-10-30 18:26:42', '2024-10-30 18:26:42', 3, 'Bejelentve', 'Hardver', NULL, '2024-10-31 08:08:46');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kepek`
--

CREATE TABLE `kepek` (
  `ID` int(11) NOT NULL,
  `kep` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `kep_id` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `log`
--

CREATE TABLE `log` (
  `ID` int(11) NOT NULL,
  `LStatus` varchar(255) CHARACTER SET utf16 COLLATE utf16_hungarian_ci NOT NULL,
  `Komment` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

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

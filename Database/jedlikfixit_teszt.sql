-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Okt 10. 11:39
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
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `ID` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Login_name` varchar(255) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `AD_ID` int(11) DEFAULT NULL,
  `Role` enum('f','r','m','a') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`ID`, `Name`, `Login_name`, `Email`, `Password`, `AD_ID`, `Role`) VALUES
(1, 'Kovács Béla', 'kovacs.bela', 'kovacs.bela@jedlik.eu', 'abc', 1, 'f'),
(2, 'Kiss Sándor', 'kiss.sandor', 'kiss.sandor@jedlik.eu', 'abc123456', 2, 'r'),
(3, 'Kottra Richárd', 'kottra.richard', 'kottra.richard@jedlik.eu', 'abc123456', 3, 'm'),
(4, 'Módos Gábor', 'modos.gabor', 'modos.gabor@jedlik.eu', 'abc123456', 4, 'a');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `hibabejelentesek`
--

CREATE TABLE `hibabejelentesek` (
  `ID` int(11) NOT NULL,
  `Title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Reported_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Reported_at` timestamp NULL DEFAULT NULL,
  `Updated_at` timestamp NULL DEFAULT NULL,
  `Priority` int(11) DEFAULT NULL,
  `Status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `Label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `hibabejelentesek`
--

INSERT INTO `hibabejelentesek` (`ID`, `Title`, `Description`, `Photo`, `Reported_by`, `Location`, `Reported_at`, `Updated_at`, `Priority`, `Status`, `Label`) VALUES
(34, 'asd', 'asd', 'MÃ¡sik terem 2.png', 'undefined', 'Másik terem 2', '2024-10-10 08:54:56', '2024-10-10 08:54:56', 4, 'fasz', 'Szoftver'),
(35, 'dffd', 'gdfgd', 'MÃ¡sik terem 2.png', 'kovacs.bela', 'Másik terem 3', '2024-10-10 09:18:16', '2024-10-10 09:18:16', 2, 'fasz', 'Szoftver'),
(36, 'dffd', 'gdfgd', 'MÃ¡sik terem 2.png', 'kovacs.bela', 'Másik terem 3', '2024-10-10 09:20:06', '2024-10-10 09:20:06', 2, 'fasz', 'Szoftver'),
(37, 'dsfg', 'dfg', 'MÃ¡sik terem 2.png', 'kovacs.bela', 'Másik terem 2', '2024-10-10 09:20:47', '2024-10-10 09:20:47', 4, 'fasz', 'Szoftver'),
(38, 'fsdg', 'fdgdfg', NULL, 'kovacs.bela', 'Másik terem 2', '2024-10-10 09:25:17', '2024-10-10 09:25:17', 4, 'fasz', 'Hardver'),
(39, 'fdg', 'dfg', 'MÃ¡sik terem 2.png', 'kovacs.bela', 'Másik terem 2', '2024-10-10 09:32:29', '2024-10-10 09:32:29', 4, 'fasz', 'Hardver');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `hibabejelentesek`
--
ALTER TABLE `hibabejelentesek`
  ADD PRIMARY KEY (`ID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `hibabejelentesek`
--
ALTER TABLE `hibabejelentesek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

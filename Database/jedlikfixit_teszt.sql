-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Okt 17. 11:25
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

INSERT INTO `hibabejelentesek` (`ID`, `Title`, `Description`, `Reported_by`, `Location`, `Reported_at`, `Updated_at`, `Priority`, `Status`, `Label`) VALUES
(60, 'fasfsd', 'sdfs', 'kovacs.bela', 'Első terem', '2024-10-17 09:11:49', '2024-10-17 09:11:49', 3, 'Bejelentve', NULL),
(61, 'asd', 'asd', 'kovacs.bela', 'Első terem', '2024-10-17 09:13:46', '2024-10-17 09:13:46', 3, 'Bejelentve', NULL),
(62, 'asd', 'asd', 'kovacs.bela', 'Másik terem 2', '2024-10-17 09:23:46', '2024-10-17 09:23:46', 3, 'Bejelentve', 'Hardver'),
(63, 'gfhdgh', 'dfghdfgh', 'kovacs.bela', 'Másik terem 2', '2024-10-17 09:24:19', '2024-10-17 09:24:19', 4, 'Bejelentve', 'Szoftver');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kepek`
--

CREATE TABLE `kepek` (
  `ID` int(11) NOT NULL,
  `kep` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `kepek`
--

INSERT INTO `kepek` (`ID`, `kep`) VALUES
(63, '1729157058998-kÃ©p2.png'),
(63, '1729157059000-kÃ©p3.png'),
(63, '1729157059003-kÃ©pe1.png');

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
-- A tábla indexei `kepek`
--
ALTER TABLE `kepek`
  ADD KEY `hiba_kep` (`ID`);

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `kepek`
--
ALTER TABLE `kepek`
  ADD CONSTRAINT `hiba_kep` FOREIGN KEY (`ID`) REFERENCES `hibabejelentesek` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

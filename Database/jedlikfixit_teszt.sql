-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Dec 03. 15:56
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
  `Status` varchar(50) CHARACTER SET utf16 COLLATE utf16_hungarian_ci NOT NULL,
  `Komment` varchar(300) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modosito` varchar(50) DEFAULT NULL,
  `assignedTo` varchar(50) DEFAULT NULL,
  `deadLine` timestamp NULL DEFAULT NULL,
  `priority` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

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

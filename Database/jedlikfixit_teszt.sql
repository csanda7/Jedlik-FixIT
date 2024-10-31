-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Okt 31. 13:45
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
-- Tábla szerkezet ehhez a táblához `log`
--

CREATE TABLE `log` (
  `ID` int(11) NOT NULL,
  `LStatus` varchar(255) CHARACTER SET utf16 COLLATE utf16_hungarian_ci NOT NULL,
  `Komment` varchar(300) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `log`
--

INSERT INTO `log` (`ID`, `LStatus`, `Komment`, `updated_at`) VALUES
(90, 'Beszerzésre vár', '', '2024-10-31 12:45:15'),
(92, 'Folyamatban', '', '2024-10-31 12:45:15'),
(94, 'Bejelentve', '', '2024-10-31 12:45:15'),
(95, 'Bejelentve', '', '2024-10-31 12:45:15'),
(92, 'Kész', '', '2024-10-31 12:45:15'),
(88, 'Kész', '', '2024-10-31 12:45:15'),
(81, 'Kész', '', '2024-10-31 12:45:15'),
(90, 'Folyamatban', '', '2024-10-31 12:45:15'),
(90, 'Kész', '', '2024-10-31 12:45:15'),
(86, 'Folyamatban', '', '2024-10-31 12:45:15'),
(87, 'Folyamatban', '', '2024-10-31 12:45:15'),
(87, 'Beszerzésre vár', '', '2024-10-31 12:45:15'),
(87, 'Kész', '', '2024-10-31 12:45:15');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `log`
--
ALTER TABLE `log`
  ADD KEY `hiba_log` (`ID`);

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `hiba_log` FOREIGN KEY (`ID`) REFERENCES `hibabejelentesek` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-07-2021 a las 20:59:11
-- Versión del servidor: 10.4.17-MariaDB
-- Versión de PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `controldeestados1`
--
CREATE DATABASE IF NOT EXISTS `controldeestados1` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `controldeestados1`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dispositivosiot`
--

CREATE TABLE IF NOT EXISTS `dispositivosiot` (
  `iddispositivoIoT` int(11) NOT NULL AUTO_INCREMENT,
  `modulo` int(11) NOT NULL,
  `tipodispositivoIoT` int(11) NOT NULL,
  `firmware` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`iddispositivoIoT`),
  KEY `idmodulo` (`modulo`),
  KEY `tipodispositivoIoT` (`tipodispositivoIoT`),
  KEY `fk_dispositivosiot_usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `dispositivosiot`
--

INSERT INTO `dispositivosiot` (`iddispositivoIoT`, `modulo`, `tipodispositivoIoT`, `firmware`, `created_at`, `updated_at`, `deleted_at`, `status`, `idusuario`) VALUES
(1, 1, 1, 'B', '2020-11-27 09:31:07', NULL, NULL, 1, 1),
(2, 2, 1, 'A', '2020-11-27 09:31:52', NULL, NULL, 1, 1),
(3, 3, 1, 'B', '2020-11-27 09:32:15', NULL, NULL, 1, 1),
(4, 4, 1, 'B', '2020-11-27 09:32:32', NULL, '2021-07-14 20:55:43', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE IF NOT EXISTS `estados` (
  `idestado` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idestado`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `estados`
--

INSERT INTO `estados` (`idestado`, `estado`) VALUES
(1, 'En programación'),
(2, 'En validación'),
(3, 'En proceso'),
(4, 'Pausado Supervisor'),
(5, 'Parado Línea'),
(6, 'Terminado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadosordenproduccion`
--

CREATE TABLE IF NOT EXISTS `estadosordenproduccion` (
  `idestadoordenproduccion` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idestadoordenproduccion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `estadosordenproduccion`
--

INSERT INTO `estadosordenproduccion` (`idestadoordenproduccion`, `estado`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Inscrita', 1, '2020-05-25 17:22:06', NULL, NULL),
(2, 'En Proceso', 1, '2020-05-25 17:22:06', NULL, NULL),
(3, 'Pausada', 1, '2020-05-25 17:22:52', NULL, NULL),
(4, 'Cancelada', 1, '2020-05-25 17:22:52', NULL, NULL),
(5, 'Terminada', 1, '2020-05-25 17:23:08', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE IF NOT EXISTS `modulos` (
  `idmodulo` int(11) NOT NULL AUTO_INCREMENT,
  `nombremodulo` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `ordendeprod` int(11) NOT NULL DEFAULT 0,
  `itemaproducir` int(11) NOT NULL DEFAULT 0,
  `unidadesesperadas` int(11) NOT NULL,
  `tiempocicloesperado` float NOT NULL,
  `minutosprogramados` float NOT NULL,
  `productoshechos` int(11) NOT NULL DEFAULT 0,
  `momentodeinicio` int(11) NOT NULL,
  `momentodepausa` int(11) NOT NULL,
  `momentoinidespausa` int(11) NOT NULL,
  `tiemporegistro` int(11) NOT NULL,
  `tiemporegistroanterior` int(11) NOT NULL,
  `ultimotiempodeproduccion` float NOT NULL,
  `tiempoacumulado` int(11) NOT NULL DEFAULT 0,
  `tiempopausado` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `voltage` float NOT NULL,
  `prodhechosdespausaini` int(11) NOT NULL,
  `eficienciaacumulada` float NOT NULL,
  `pausashechas` int(11) NOT NULL,
  `tiempoacumtrabajo` int(11) NOT NULL,
  PRIMARY KEY (`idmodulo`),
  KEY `idestado` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `modulos`
--

INSERT INTO `modulos` (`idmodulo`, `nombremodulo`, `descripcion`, `estado`, `ordendeprod`, `itemaproducir`, `unidadesesperadas`, `tiempocicloesperado`, `minutosprogramados`, `productoshechos`, `momentodeinicio`, `momentodepausa`, `momentoinidespausa`, `tiemporegistro`, `tiemporegistroanterior`, `ultimotiempodeproduccion`, `tiempoacumulado`, `tiempopausado`, `created_at`, `updated_at`, `deleted_at`, `status`, `voltage`, `prodhechosdespausaini`, `eficienciaacumulada`, `pausashechas`, `tiempoacumtrabajo`) VALUES
(1, 'Módulo 1', 'Ropa deportiva', 3, 1, 1, 10, 1, 10, 0, 1606966175, 1607012543, 1607012546, 0, 0, 0, 46368, 3, '2020-09-04 17:55:23', '2020-11-27 20:21:42', NULL, 1, 0, 0, 0, 1, 0),
(2, 'Módulo 2', 'Faldas', 1, 14, 1, 10, 1, 10, 0, 1606975260, 1606975270, 1606975260, 0, 0, 0, 10, 0, '2020-09-04 17:55:23', '2020-11-27 20:22:00', '2020-11-26 15:21:41', 1, 0, 0, 0, 0, 0),
(3, 'Módulo 3', 'Pijamas', 3, 1, 1, 100, 1, 100, 0, 1626314408, 1606502926, 1626314408, 1626314408, 0, 0, 0, 0, '2020-09-04 17:55:23', '2020-11-27 20:21:32', NULL, 1, 0, 0, 0, 0, 0),
(4, 'Módulo 4', 'Camisas', 1, 15, 0, 12, 1, 12, 2, 1605671549, 0, 1605671549, 1605671627, 1605671568, 0.983333, 0, 0, '2020-09-04 17:55:23', '2020-11-27 20:22:37', NULL, 1, 0, 2, 0, 0, 0),
(12, 'Módulo 5', 'Medias', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2021-07-14 11:02:20', NULL, NULL, 1, 0, 0, 0, 0, 0),
(13, 'Módulo 6', 'Corbatas', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2021-07-14 11:06:38', NULL, NULL, 1, 0, 0, 0, 0, 0),
(14, 'Módulo 7', 'Guantes', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2021-07-14 11:34:44', NULL, NULL, 1, 0, 0, 0, 0, 0),
(15, 'Módulo 8', 'Mochilas', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2021-07-14 15:55:53', '2021-07-14 22:56:27', '2021-07-14 15:56:39', 1, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenesproduccion`
--

CREATE TABLE IF NOT EXISTS `ordenesproduccion` (
  `idordenproduccion` int(11) NOT NULL AUTO_INCREMENT,
  `numeroordenproduccion` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `fechaprogramacion` date DEFAULT NULL,
  `fechapausa` date DEFAULT NULL,
  `fechacontinuacion` date DEFAULT NULL,
  `fechacierre` date DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `descripcion` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `idestadoordenproduccion` int(11) NOT NULL DEFAULT 1,
  `status` int(11) NOT NULL DEFAULT 1,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`idordenproduccion`),
  KEY `idestadoordenproduccion` (`idestadoordenproduccion`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ordenesproduccion`
--

INSERT INTO `ordenesproduccion` (`idordenproduccion`, `numeroordenproduccion`, `fechaprogramacion`, `fechapausa`, `fechacontinuacion`, `fechacierre`, `created_at`, `updated_at`, `deleted_at`, `descripcion`, `idestadoordenproduccion`, `status`, `usuario_id`) VALUES
(0, 'No Asignada', NULL, NULL, NULL, NULL, '2021-07-14 11:31:28', NULL, NULL, '', 1, 1, 0),
(1, '10001', '2020-07-20', NULL, NULL, NULL, '2020-07-20 23:05:38', NULL, NULL, 'Casa', 1, 1, 15),
(14, '10002', '2020-07-25', NULL, NULL, NULL, '2020-07-25 11:23:35', NULL, NULL, 'camisas', 1, 1, 1),
(15, '10003', '2020-11-25', NULL, NULL, NULL, '2020-11-27 10:41:54', '2020-12-02 18:26:27', NULL, 'zapatos rojizos', 1, 1, 1),
(16, '10004', '2020-12-13', NULL, NULL, NULL, '2020-12-01 10:10:59', NULL, NULL, 'Camisas pra linea directa', 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE IF NOT EXISTS `producto` (
  `idproducto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `referencia` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `usuario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`idproducto`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idproducto`, `nombre`, `referencia`, `descripcion`, `created_at`, `updated_at`, `deleted_at`, `status`, `usuario_id`) VALUES
(0, 'No Asignado', 'No Asignado', '', '2021-07-14 15:29:36', NULL, NULL, 1, NULL),
(1, 'Pijama', 'Coleccion Primavera', 'rojo', '2020-12-02 15:38:40', '2020-12-02 18:42:23', '0000-00-00 00:00:00', 1, 1),
(2, 'Sabana', 'primavera', 'morada', '2020-12-02 18:29:11', '2020-12-02 18:42:35', '2020-12-02 18:50:53', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registroeficiencias`
--

CREATE TABLE IF NOT EXISTS `registroeficiencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ordendeprod` int(11) NOT NULL,
  `itemaproducir` int(11) NOT NULL,
  `cantidadesperada` int(11) NOT NULL,
  `cantidadhecha` int(11) NOT NULL,
  `eficiencia` float NOT NULL,
  `fechahora` datetime NOT NULL DEFAULT current_timestamp(),
  `modulo` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_registroeficiencias_ordenesproduccion` (`ordendeprod`),
  KEY `fk_registroeficiencias_producto` (`itemaproducir`),
  KEY `fk_registroeficiencias_modulos` (`modulo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `registroeficiencias`
--

INSERT INTO `registroeficiencias` (`id`, `ordendeprod`, `itemaproducir`, `cantidadesperada`, `cantidadhecha`, `eficiencia`, `fechahora`, `modulo`) VALUES
(1, 1, 1, 50, 10, 70, '2020-12-03 21:29:14', 1),
(2, 1, 1, 50, 20, 80, '2020-12-03 01:30:18', 1),
(3, 1, 1, 50, 30, 85, '2020-12-03 01:30:27', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registrotiempos`
--

CREATE TABLE IF NOT EXISTS `registrotiempos` (
  `idregistro` int(11) NOT NULL AUTO_INCREMENT,
  `ordendeprod` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `itemaproducir` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `horaderegistro` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idregistro`)
) ENGINE=InnoDB AUTO_INCREMENT=351 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `registrotiempos`
--

INSERT INTO `registrotiempos` (`idregistro`, `ordendeprod`, `itemaproducir`, `horaderegistro`) VALUES
(1, 'casa', 'polo', '2020-09-07 17:02:28'),
(2, '121212', 'camisas pancho', '2020-09-07 18:33:32'),
(3, '121212', 'camisas pancho', '2020-09-07 18:34:06'),
(4, '121212', 'camisas pancho', '2020-09-07 18:34:23'),
(5, '121212', 'camisas pancho', '2020-09-07 18:34:27'),
(6, '121212', 'camisas pancho', '2020-09-07 18:34:41'),
(7, '121212', 'camisas pancho', '2020-09-07 18:34:42'),
(8, '121212', 'camisas pancho', '2020-09-07 18:34:42'),
(9, '121212', 'camisas pancho', '2020-09-07 18:34:43'),
(10, '121212', 'camisas pancho', '2020-09-07 18:34:43'),
(11, '121212', 'camisas pancho', '2020-09-07 18:34:43'),
(12, '121212', 'camisas pancho', '2020-09-07 18:35:58'),
(13, '121212', 'camisas pancho', '2020-09-07 18:36:04'),
(14, '121212', 'camisas pancho', '2020-09-07 18:36:30'),
(15, '121212', 'camisas pancho', '2020-09-07 18:39:29'),
(16, '121212', 'camisas pancho', '2020-09-07 18:41:44'),
(17, '121212', 'camisas pancho', '2020-09-07 18:41:45'),
(18, '121212', 'camisas pancho', '2020-09-07 18:41:46'),
(19, '121212', 'camisas pancho', '2020-09-07 18:41:47'),
(20, '121212', 'camisas pancho', '2020-09-07 18:41:47'),
(21, '121212', 'camisas pancho', '2020-09-07 18:41:47'),
(22, '121212', 'camisas pancho', '2020-09-07 18:41:47'),
(23, '121212', 'camisas pancho', '2020-09-07 18:41:48'),
(24, '121212', 'camisas pancho', '2020-09-07 18:42:23'),
(25, '121212', 'camisas pancho', '2020-09-07 18:42:30'),
(26, '121212', 'camisas pancho', '2020-09-07 18:42:34'),
(27, '121212', 'camisas pancho', '2020-09-07 18:42:35'),
(28, '121212', 'camisas pancho', '2020-09-07 18:42:45'),
(29, '10', 'asas', '2020-09-07 19:00:43'),
(30, '10', 'asas', '2020-09-07 19:03:10'),
(31, '10', 'asas', '2020-09-07 20:33:25'),
(32, '1234', 'baberos', '2020-09-07 21:12:29'),
(33, '1234', 'baberos', '2020-09-07 21:13:39'),
(34, '1234', 'baberos', '2020-09-07 21:14:51'),
(35, '1234', 'baberos', '2020-09-07 21:16:46'),
(36, '1234', 'baberos', '2020-09-07 21:18:31'),
(37, '1234', 'baberos', '2020-09-07 21:19:07'),
(38, '1234', 'baberos', '2020-09-07 21:20:32'),
(39, '1234', 'baberos', '2020-09-07 21:21:06'),
(40, '1234', 'baberos', '2020-09-07 21:21:35'),
(41, '1234', 'baberos', '2020-09-07 21:22:07'),
(42, '1234', 'baberos', '2020-09-07 21:22:13'),
(43, '1234', 'baberos', '2020-09-07 21:22:39'),
(44, '20', '212121', '2020-09-07 21:24:18'),
(45, '20', '212121', '2020-09-07 21:24:31'),
(46, '20', '212121', '2020-09-07 21:25:23'),
(47, '20', '212121', '2020-09-07 21:25:44'),
(48, '20', '212121', '2020-09-07 21:25:48'),
(49, '20', '212121', '2020-09-07 21:25:50'),
(50, '20', '212121', '2020-09-07 21:25:54'),
(51, '20', '212121', '2020-09-07 21:26:01'),
(52, '20', '212121', '2020-09-07 21:26:12'),
(53, '20', '212121', '2020-09-07 21:26:18'),
(54, '20', '212121', '2020-09-07 21:26:24'),
(55, '20', '212121', '2020-09-07 21:26:32'),
(56, '20', '212121', '2020-09-07 21:26:39'),
(57, '20', '212121', '2020-09-07 21:26:47'),
(58, '20', '212121', '2020-09-07 21:26:56'),
(59, '20', '212121', '2020-09-07 21:27:04'),
(60, '20', '212121', '2020-09-07 21:27:13'),
(61, '20', '212121', '2020-09-07 21:27:32'),
(62, '20', '212121', '2020-09-07 21:27:50'),
(63, '20', '212121', '2020-09-07 21:28:09'),
(64, 'reret', 'ewweew', '2020-09-07 21:44:27'),
(65, 'reret', 'ewweew', '2020-09-07 21:45:31'),
(66, 'reret', 'ewweew', '2020-09-07 21:47:15'),
(67, 'reret', 'ewweew', '2020-09-07 21:47:38'),
(68, 'reret', 'ewweew', '2020-09-07 21:47:49'),
(69, 'reret', 'ewweew', '2020-09-07 21:47:59'),
(70, 'reret', 'ewweew', '2020-09-07 21:48:14'),
(71, 'reret', 'ewweew', '2020-09-07 21:48:56'),
(72, 'reret', 'ewweew', '2020-09-07 21:49:33'),
(73, 'fdjhgdk', 'sdfsfs', '2020-09-07 21:51:28'),
(74, 'fdjhgdk', 'sdfsfs', '2020-09-07 21:52:45'),
(75, 'fdjhgdk', 'sdfsfs', '2020-09-07 21:52:59'),
(76, '5', '5', '2020-09-07 22:03:15'),
(77, '5', '5', '2020-09-07 22:03:33'),
(78, '5', '5', '2020-09-07 22:03:44'),
(79, '5', '5', '2020-09-07 22:11:06'),
(80, '5', '5', '2020-09-07 22:11:22'),
(81, 'gfghhf', 'fghfgh', '2020-09-07 22:12:16'),
(82, 'gfghhf', 'fghfgh', '2020-09-07 22:12:24'),
(83, 'gfghhf', 'fghfgh', '2020-09-07 22:12:40'),
(84, 'gfghhf', 'fghfgh', '2020-09-07 22:13:08'),
(85, 'gfghhf', 'fghfgh', '2020-09-07 22:13:50'),
(86, 'gfghhf', 'fghfgh', '2020-09-07 22:15:00'),
(87, 'gfghhf', 'fghfgh', '2020-09-07 22:16:32'),
(88, 'gfghhf', 'fghfgh', '2020-09-07 22:19:50'),
(89, 'gfghhf', 'fghfgh', '2020-09-07 22:28:35'),
(90, '2', '33', '2020-09-07 22:40:41'),
(91, '2', '33', '2020-09-07 22:40:54'),
(92, 'Casas', '254', '2020-09-08 10:07:10'),
(93, 'Casas', '254', '2020-09-08 10:29:26'),
(94, 'Casas', '254', '2020-09-08 10:29:34'),
(95, 'Casas', '254', '2020-09-08 10:29:40'),
(96, '3456', 'ratones', '2020-09-08 10:48:45'),
(97, '3456', 'ratones', '2020-09-08 10:48:53'),
(98, '2222', '21212', '2020-09-08 11:00:58'),
(99, '2', '2', '2020-09-08 11:02:37'),
(100, '2', '2', '2020-09-08 11:02:45'),
(101, '1234', '1', '2020-09-08 20:07:25'),
(102, '1234', '1', '2020-09-08 20:07:37'),
(103, '1234', '1', '2020-09-08 20:07:43'),
(104, '1234', '1', '2020-09-08 20:07:51'),
(105, '1234', '1', '2020-09-08 20:07:59'),
(106, '1234', '1', '2020-09-08 20:08:31'),
(107, '1234', '1', '2020-09-08 20:16:57'),
(108, '1234', '1', '2020-09-08 20:17:08'),
(109, '1234', '1', '2020-09-08 20:17:23'),
(110, '1234', '1', '2020-09-08 20:21:59'),
(111, '1234', '1', '2020-09-08 20:22:06'),
(112, '1234', '1', '2020-09-08 20:22:13'),
(113, '12345', 'Camisas Polo', '2020-09-08 20:30:31'),
(114, '12345', 'Camisas Polo', '2020-09-08 20:30:52'),
(115, '12345', 'Camisas Polo', '2020-09-08 20:32:17'),
(116, '12345', 'Camisas Polo', '2020-09-08 20:32:49'),
(117, '12345', 'Camisas Polo', '2020-09-08 20:32:51'),
(118, '12345', 'Camisas Polo', '2020-09-08 20:32:58'),
(119, '12345', 'Camisas Polo', '2020-09-08 20:33:03'),
(120, '12345', 'Camisas Polo', '2020-09-08 20:33:08'),
(121, '12345', 'Camisas Polo', '2020-09-08 20:33:14'),
(122, '12345', 'Camisas Polo', '2020-09-08 20:33:19'),
(123, '29999', 'Camisas davi', '2020-09-09 10:17:58'),
(124, '29999', 'Camisas davi', '2020-09-09 10:26:24'),
(125, '1234', 'Polo', '2020-09-09 10:54:38'),
(126, '1234', 'Polo', '2020-09-09 10:54:55'),
(127, '1234', 'Polo', '2020-09-09 10:55:23'),
(128, '1234', 'Polo', '2020-09-09 10:56:06'),
(129, '12345g', 'apatos', '2020-11-02 19:29:28'),
(130, '12345g', 'apatos', '2020-11-02 19:29:36'),
(131, '12345g', 'apatos', '2020-11-02 19:30:36'),
(132, '12345g', 'apatos', '2020-11-02 23:20:27'),
(133, '12345g', 'apatos', '2020-11-02 23:22:35'),
(134, '12345g', 'apatos', '2020-11-02 23:22:50'),
(135, '12345g', 'apatos', '2020-11-02 23:22:59'),
(136, '12345g', 'apatos', '2020-11-02 23:23:15'),
(137, 'aaa', 'aaaaaa', '2020-11-02 23:36:44'),
(138, 'aaa', 'aaaaaa', '2020-11-02 23:37:14'),
(139, 'aaa', 'aaaaaa', '2020-11-02 23:37:41'),
(140, 'aaa', 'aaaaaa', '2020-11-02 23:38:15'),
(141, 'aaa', 'aaaaaa', '2020-11-02 23:38:42'),
(142, 'aaa', 'aaaaaa', '2020-11-02 23:39:18'),
(143, 'aaa', 'aaaaaa', '2020-11-02 23:40:12'),
(144, 'aaa', 'aaaaaa', '2020-11-02 23:42:11'),
(145, 'aaa', 'aaaaaa', '2020-11-02 23:43:12'),
(146, 'aaa', 'aaaaaa', '2020-11-03 00:08:52'),
(147, 'aaa', 'aaaaaa', '2020-11-03 00:09:26'),
(148, '1234', 'Camisas Polo', '2020-11-03 00:18:29'),
(149, '1234', 'Camisas Polo', '2020-11-03 00:19:01'),
(150, '1234', 'Camisas Polo', '2020-11-03 00:19:07'),
(151, '1234', 'Camisas Polo', '2020-11-03 00:19:26'),
(152, '1234', 'Camisas Polo', '2020-11-03 00:19:56'),
(153, '1234', 'Camisas Polo', '2020-11-02 23:24:25'),
(154, '1234', 'Camisas Polo', '2020-11-02 23:26:36'),
(155, '1234', 'Camisas Polo', '2020-11-02 23:26:51'),
(156, '1234', 'Camisas Polo', '2020-11-02 23:30:27'),
(157, '1234', 'Camisas Polo', '2020-11-02 23:30:47'),
(158, '1234', 'Camisas Polo', '2020-11-02 23:31:17'),
(159, '1234', 'Camisas Polo', '2020-11-02 23:31:47'),
(160, '1234', 'Camisas Polo', '2020-11-02 23:32:12'),
(161, '1234', 'Camisas Polo', '2020-11-02 23:32:32'),
(162, '1234', 'Camisas Polo', '2020-11-02 23:32:51'),
(163, '1234', 'Camisas Polo', '2020-11-02 23:33:26'),
(164, '1234', 'Camisas Polo', '2020-11-03 00:39:44'),
(165, '1234', 'Camisas Polo', '2020-11-03 00:41:41'),
(166, '1234', 'Camisas Polo', '2020-11-03 01:00:51'),
(167, '1234', 'Camisas Polo', '2020-11-03 01:01:30'),
(168, '1234', 'Camisas Polo', '2020-11-03 01:04:07'),
(169, '1234', 'Camisas Polo', '2020-11-03 01:04:14'),
(170, '1234', 'Camisas Polo', '2020-11-03 01:13:49'),
(171, '1234', 'Camisas Polo', '2020-11-03 01:13:56'),
(172, '1234', 'Camisas Polo', '2020-11-03 01:14:29'),
(173, '1234', 'Camisas Polo', '2020-11-03 01:14:38'),
(174, '1234', 'Camisas Polo', '2020-11-03 01:15:07'),
(175, '1234', 'Camisas Polo', '2020-11-03 01:15:15'),
(176, '1234', 'Camisas Polo', '2020-11-03 01:15:22'),
(177, '1234', 'Camisas Polo', '2020-11-03 01:22:32'),
(178, '1234', 'Camisas Polo', '2020-11-03 01:22:41'),
(179, '1234', 'Camisas Polo', '2020-11-03 01:22:53'),
(180, '1234', 'Camisas Polo', '2020-11-03 00:43:30'),
(181, '1234', 'Camisas Polo', '2020-11-03 00:43:54'),
(182, '1234', 'Camisas Polo', '2020-11-03 00:45:46'),
(183, '1234', 'Camisas Polo', '2020-11-03 00:46:02'),
(184, '1234', 'Camisas Polo', '2020-11-03 00:46:14'),
(185, '1234', 'Camisas Polo', '2020-11-03 00:48:14'),
(186, '1234', 'Camisas Polo', '2020-11-03 00:48:46'),
(187, '1234', 'Camisas Polo', '2020-11-03 00:48:51'),
(188, '1234', 'Camisas Polo', '2020-11-03 00:49:18'),
(189, '1234', 'Camisas Polo', '2020-11-03 00:49:27'),
(190, '1234', 'Camisas Polo', '2020-11-03 00:49:32'),
(191, '1234', 'Camisas Polo', '2020-11-03 00:49:55'),
(192, '1234', '20', '2020-11-03 00:59:31'),
(193, '1234', '20', '2020-11-03 00:59:56'),
(194, '1234', '20', '2020-11-03 01:04:22'),
(195, '1234', '20', '2020-11-03 01:10:48'),
(196, '1234', '20', '2020-11-03 01:10:58'),
(197, '2345', '1123', '2020-11-06 10:55:22'),
(198, '2345', '1123', '2020-11-06 10:55:42'),
(199, '2345', '1123', '2020-11-06 10:55:58'),
(200, '2345', '1123', '2020-11-06 10:56:04'),
(201, '2345', '1123', '2020-11-06 10:56:18'),
(202, '2345', '1123', '2020-11-06 10:56:33'),
(203, '2345', '1123', '2020-11-06 10:56:52'),
(204, '2345', '1123', '2020-11-06 10:57:18'),
(205, '2345', '1123', '2020-11-06 11:03:57'),
(206, '123454321', 'Camisas Polo', '2020-11-06 10:41:45'),
(207, '123454321', 'Camisas Polo', '2020-11-06 10:42:13'),
(208, '123454321', 'Camisas Polo', '2020-11-06 10:42:28'),
(209, '123454321', 'Camisas Polo', '2020-11-06 10:31:56'),
(210, '123454321', 'Camisas Polo', '2020-11-06 10:32:16'),
(211, '123454321', 'Camisas Polo', '2020-11-06 10:34:14'),
(212, '12345432', 'Camisas Polo', '2020-11-07 11:07:04'),
(213, '12345432', 'Camisas Polo', '2020-11-07 11:07:21'),
(214, '12345432', 'Camisas Polo', '2020-11-07 11:08:46'),
(215, '12345432', 'Camisas Polo', '2020-11-08 16:34:41'),
(216, '12345432', 'Camisas Polo', '2020-11-08 16:41:42'),
(217, '12345432', 'Camisas Polo', '2020-11-08 16:41:54'),
(218, '12345432', 'Camisas Polo', '2020-11-08 16:44:01'),
(219, '12345432', 'Camisas Polo', '2020-11-08 16:44:19'),
(220, '12345432', 'Camisas Polo', '2020-11-08 16:44:29'),
(221, '12345432', 'Camisas Polo', '2020-11-08 16:44:37'),
(222, '1234', 'Camisas Polo', '2020-11-08 20:25:12'),
(223, '1234', 'Camisas Polo', '2020-11-08 20:25:23'),
(224, '1234', 'Camisas Polo', '2020-11-08 20:25:32'),
(225, '1234', 'Camisas Polo', '2020-11-08 20:34:50'),
(226, '1234', 'Camisas Polo', '2020-11-08 21:06:52'),
(227, '1234', 'Camisas Polo', '2020-11-08 21:08:53'),
(228, '1234', 'Camisas Polo', '2020-11-08 21:09:21'),
(229, '1234', 'Camisas Polo', '2020-11-08 22:15:37'),
(230, '1234', 'Camisas Polo', '2020-11-08 22:16:09'),
(231, '1234', 'Camisas Polo', '2020-11-08 22:16:31'),
(232, '1234', 'Camisas Polo', '2020-11-08 22:20:15'),
(233, '1234', 'Camisas Polo', '2020-11-08 22:20:45'),
(234, '1234', 'Camisas Polo', '2020-11-08 22:21:11'),
(235, '1234', 'Camisas Polo', '2020-11-08 22:21:46'),
(236, '1234', 'Camisas Polo', '2020-11-08 22:22:15'),
(237, '1234', 'Camisas Polo', '2020-11-08 22:22:47'),
(238, '1234', 'Camisas Polo', '2020-11-08 22:23:23'),
(239, '1234', 'Camisas Polo', '2020-11-08 22:23:45'),
(240, '1234', 'Camisas Polo', '2020-11-08 22:24:20'),
(241, '1234', 'Camisas Polo', '2020-11-08 22:24:29'),
(242, '1234', 'Camisas Polo', '2020-11-08 23:38:10'),
(243, '1234', 'Camisas Polo', '2020-11-08 23:38:47'),
(244, '1234', 'Camisas Polo', '2020-11-08 23:38:57'),
(245, '1234', 'Camisas Polo', '2020-11-08 23:39:06'),
(246, '1234', 'Camisas Polo', '2020-11-08 23:55:53'),
(247, '1234', 'Camisas Polo', '2020-11-08 23:56:05'),
(248, '1234', 'Camisas Polo', '2020-11-09 00:01:15'),
(249, '1234', 'Camisas Polo', '2020-11-09 00:01:24'),
(250, '1234', 'Camisas Polo', '2020-11-09 00:01:28'),
(251, '1234', 'Camisas Polo', '2020-11-09 00:01:33'),
(252, '1234', 'Camisas Polo', '2020-11-09 00:01:39'),
(253, '1234', 'Camisas Polo', '2020-11-09 00:01:50'),
(254, '1234', 'Camisas Polo', '2020-11-09 00:02:00'),
(255, '1234', 'Camisas Polo', '2020-11-09 00:02:06'),
(256, '1234', 'Camisas Polo', '2020-11-09 00:07:14'),
(257, '1234', 'Camisas Polo', '2020-11-09 00:07:32'),
(258, '1234', 'Camisas Polo', '2020-11-09 00:08:16'),
(259, '1234', 'Camisas Polo', '2020-11-09 00:08:37'),
(260, '1234', 'Camisas Polo', '2020-11-09 00:08:42'),
(261, '1234', 'Camisas Polo', '2020-11-09 00:08:48'),
(262, '1234', 'Camisas Polo', '2020-11-09 00:08:54'),
(263, '1234', 'Camisas Polo', '2020-11-09 00:09:06'),
(264, '1234', 'Camisas Polo', '2020-11-09 00:09:12'),
(265, '1234', 'Camisas Polo', '2020-11-09 00:09:17'),
(266, '1234', 'Camisas Polo', '2020-11-09 00:09:23'),
(267, '1234', 'Camisas Polo', '2020-11-09 00:09:28'),
(268, '1234', 'Camisas Polo', '2020-11-09 00:09:37'),
(269, '1234', 'Camisas Polo', '2020-11-09 00:09:43'),
(270, '1234', 'Camisas Polo', '2020-11-09 00:09:49'),
(271, '1234', 'Camisas Polo', '2020-11-09 00:09:57'),
(272, '1234', 'Camisas Polo', '2020-11-09 00:10:08'),
(273, '1234', 'Camisas Polo', '2020-11-09 00:10:15'),
(274, '1234', 'Camisas Polo', '2020-11-09 00:10:20'),
(275, '1234', 'Camisas Polo', '2020-11-09 00:10:34'),
(276, '1234', 'Camisas Polo', '2020-11-09 00:29:43'),
(277, '1234', 'Camisas Polo', '2020-11-09 00:29:50'),
(278, '1234', 'Camisas Polo', '2020-11-09 00:32:41'),
(279, '1234', 'Camisas Polo', '2020-11-09 01:57:45'),
(280, '1234', 'Camisas Polo', '2020-11-09 01:58:12'),
(281, '1234', 'Camisas Polo', '2020-11-09 02:05:52'),
(282, '1234', 'Camisas Polo', '2020-11-09 02:05:59'),
(283, '1234', 'Camisas Polo', '2020-11-09 02:06:07'),
(284, '1234', 'Camisas Polo', '2020-11-09 02:06:26'),
(285, '1234', 'Camisas Polo', '2020-11-09 02:26:30'),
(286, '1234', 'Camisas Polo', '2020-11-09 02:26:38'),
(287, '1234', 'Camisas Polo', '2020-11-09 02:28:10'),
(288, '1234', 'Camisas Polo', '2020-11-09 02:28:21'),
(289, '1234', 'Camisas Polo', '2020-11-09 02:29:40'),
(290, '1234', 'Camisas Polo', '2020-11-09 02:35:15'),
(291, '1234', 'Camisas Polo', '2020-11-09 02:35:20'),
(292, '1234', 'Camisas Polo', '2020-11-09 02:35:31'),
(293, '1234', 'Camisas Polo', '2020-11-09 02:35:38'),
(294, '1234', 'Camisas Polo', '2020-11-09 02:35:45'),
(295, '1234', 'Camisas Polo', '2020-11-09 02:35:54'),
(296, '1234', 'Camisas Polo', '2020-11-09 02:36:04'),
(297, '1234', 'Camisas Polo', '2020-11-09 02:36:14'),
(298, '1234', 'Camisas Polo', '2020-11-09 02:36:22'),
(299, '1234', '1111', '2020-11-09 03:00:36'),
(300, '1234', 'Camisas Polo', '2020-11-09 03:15:37'),
(301, '1234', 'Camisas Polo', '2020-11-09 03:15:48'),
(302, '1234', 'Camisas Polo', '2020-11-09 03:16:06'),
(303, '1234', 'Camisas Polo', '2020-11-09 03:17:22'),
(304, '1234', 'Camisas Polo', '2020-11-09 03:18:59'),
(305, '1234', 'Camisas Polo', '2020-11-09 03:33:30'),
(306, '1234', 'Camisas Polo', '2020-11-09 03:33:53'),
(307, '1234', 'Camisas Polo', '2020-11-09 03:34:01'),
(308, '1234', 'Camisas Polo', '2020-11-09 03:34:07'),
(309, '1234', 'Camisas Polo', '2020-11-09 03:34:14'),
(310, '10', '10', '2020-11-17 01:31:50'),
(311, '10', '10', '2020-11-17 01:32:00'),
(312, '10', '10', '2020-11-17 01:32:06'),
(313, '10', '10', '2020-11-17 01:32:21'),
(314, '10', '10', '2020-11-17 01:32:30'),
(315, '10', '10', '2020-11-17 01:32:41'),
(316, '10', '10', '2020-11-17 01:32:47'),
(317, '10', '10', '2020-11-17 01:32:53'),
(318, '10', '10', '2020-11-17 01:33:11'),
(319, '10', '10', '2020-11-17 01:33:18'),
(320, '10', '10', '2020-11-17 01:33:28'),
(321, '10', '10', '2020-11-17 01:33:39'),
(322, '1234', 'Camisas Polo', '2020-11-17 13:22:34'),
(323, '1234', 'Camisas Polo', '2020-11-17 13:22:39'),
(324, '1234', 'Camisas Polo', '2020-11-17 13:22:44'),
(325, '1234', 'Camisas Polo', '2020-11-17 13:22:50'),
(326, '1234', 'Camisas Polo', '2020-11-17 13:22:58'),
(327, '1234', 'Camisas Polo', '2020-11-17 13:23:19'),
(328, '1234', 'Camisas Polo', '2020-11-17 13:23:30'),
(329, '1234', 'Camisas Polo', '2020-11-17 13:23:37'),
(330, '1234', 'Camisas Polo', '2020-11-17 22:37:50'),
(331, '4', '4', '2020-11-17 22:52:48'),
(332, '1', '1', '2020-11-17 22:53:32'),
(333, '4', '4', '2020-11-17 22:53:47'),
(334, '3', '3', '2020-11-17 22:54:18'),
(335, '2', '2', '2020-11-17 22:55:20'),
(336, '2', '2', '2020-11-17 22:55:29'),
(337, '2', '2', '2020-11-17 22:57:14'),
(338, '1234', 'polo', '2020-11-26 09:23:43'),
(339, '1234', 'polo', '2020-11-26 09:23:55'),
(340, '1234', 'polo', '2020-11-26 09:24:05'),
(341, '1234', 'polo', '2020-11-26 09:24:21'),
(342, '1234', 'polo', '2020-11-26 09:24:36'),
(343, '1234', 'polo', '2020-11-26 09:24:58'),
(344, '16', 'camisas', '2020-12-01 12:52:06'),
(345, '16', 'camisas', '2020-12-01 12:55:39'),
(346, '16', 'camisas', '2020-12-01 12:55:53'),
(347, '16', 'camisas', '2020-12-01 12:57:01'),
(348, '16', 'camisas', '2020-12-01 12:58:21'),
(349, '16', 'camisas', '2020-12-01 13:29:37'),
(350, '16', 'camisas', '2020-12-01 13:29:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE IF NOT EXISTS `rol` (
  `idrol` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idrol`, `rol`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Admin', 1, NULL, NULL, NULL),
(2, 'Supervisor', 1, NULL, NULL, NULL),
(3, 'Operario', 1, NULL, NULL, NULL),
(4, 'Gerente', 1, NULL, NULL, NULL),
(5, 'Administrador', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposdispositivosiot`
--

CREATE TABLE IF NOT EXISTS `tiposdispositivosiot` (
  `idtipodispositivoiot` int(11) NOT NULL AUTO_INCREMENT,
  `tipodispositivoIoT` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idtipodispositivoiot`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tiposdispositivosiot`
--

INSERT INTO `tiposdispositivosiot` (`idtipodispositivoiot`, `tipodispositivoIoT`, `descripcion`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
(1, '1A', 'Caja Wifi con botones: verde de aceptar y rojo de paro, con opción de medir corriente', '2020-09-04 19:16:59', '2020-11-27 15:37:13', NULL, 1),
(2, '2A', 'Caja Wifi con  monitoreo de corriente y opción de apagar máquinas', '2020-09-04 19:19:45', '2020-11-27 15:37:05', '2021-07-16 10:23:44', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `correo` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usuario` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `clave` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `rol` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  KEY `rol` (`rol`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `correo`, `usuario`, `clave`, `rol`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Jorge Andrés Cock Ramírez', 'jcock@sena.edu.co', 'admin', '21232f297a57a5a743894a0e4a801fc3', 1, 1, '2020-11-27 09:52:55', NULL, NULL),
(2, 'Gustavo Carvajal Ramírez', 'gcarvajal@sena.edu.co.com', 'gcarvajal', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2020-11-27 09:53:03', '2020-11-27 16:01:10', NULL),
(3, 'Karolina Paniagua Gómez', 'kpaniagua@sena.edu.co', 'kpaniagua', '827ccb0eea8a706c4c34a16891f84e7b', 3, 1, '2020-11-27 09:53:14', NULL, NULL),
(4, 'Marisol Osorio Beltran', 'marosorio@sena.edu.co', 'marosorio', '827ccb0eea8a706c4c34a16891f84e7b', 2, 1, '2020-11-27 09:53:18', NULL, NULL),
(5, 'Fabio Andrés Gaviria', 'fgaviria@sena.edu.co', 'fgaviria', '827ccb0eea8a706c4c34a16891f84e7b', 3, 0, '2020-11-27 10:05:30', '2020-11-27 16:06:59', '2020-11-27 10:07:13');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `dispositivosiot`
--
ALTER TABLE `dispositivosiot`
  ADD CONSTRAINT `dispositivosiot_ibfk_2` FOREIGN KEY (`tipodispositivoIoT`) REFERENCES `tiposdispositivosiot` (`idtipodispositivoiot`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `dispositivosiot_ibfk_3` FOREIGN KEY (`modulo`) REFERENCES `modulos` (`idmodulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `dispositivosiot_ibfk_4` FOREIGN KEY (`tipodispositivoIoT`) REFERENCES `tiposdispositivosiot` (`idtipodispositivoiot`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_dispositivosiot_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD CONSTRAINT `modulos_ibfk_1` FOREIGN KEY (`estado`) REFERENCES `estados` (`idestado`);

--
-- Filtros para la tabla `ordenesproduccion`
--
ALTER TABLE `ordenesproduccion`
  ADD CONSTRAINT `fk_ordenesproduccion_estadosordenproduccion` FOREIGN KEY (`idestadoordenproduccion`) REFERENCES `estadosordenproduccion` (`idestadoordenproduccion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `registroeficiencias`
--
ALTER TABLE `registroeficiencias`
  ADD CONSTRAINT `fk_registroeficiencias_modulos` FOREIGN KEY (`modulo`) REFERENCES `modulos` (`idmodulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_registroeficiencias_ordenesproduccion` FOREIGN KEY (`ordendeprod`) REFERENCES `ordenesproduccion` (`idordenproduccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_registroeficiencias_producto` FOREIGN KEY (`itemaproducir`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol`) REFERENCES `rol` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

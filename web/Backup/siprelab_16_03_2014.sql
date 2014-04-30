-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.5.31 - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             8.0.0.4409
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura de base de datos para siprelab
DROP DATABASE IF EXISTS `siprelab`;
CREATE DATABASE IF NOT EXISTS `siprelab` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `siprelab`;


-- Volcando estructura para tabla siprelab.danho
DROP TABLE IF EXISTS `danho`;
CREATE TABLE IF NOT EXISTS `danho` (
  `codigo` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion_d` varchar(150) DEFAULT NULL,
  `codigo_mat` int(10) NOT NULL,
  `codigo_usu` varchar(20) DEFAULT NULL,
  `fecha_d` datetime NOT NULL,
  `cod_usu_rd` varchar(20) NOT NULL,
  `estado` int(1) NOT NULL DEFAULT '0' COMMENT '0=Dañado, 1=Reparado, 2=Dado de baja',
  PRIMARY KEY (`codigo`),
  KEY `FK_danho_material` (`codigo_mat`),
  KEY `FK_danho_usuario` (`codigo_usu`),
  KEY `FK_danho_usuario_2` (`cod_usu_rd`),
  CONSTRAINT `FK_danho_material` FOREIGN KEY (`codigo_mat`) REFERENCES `material` (`codigo`),
  CONSTRAINT `FK_danho_usuario` FOREIGN KEY (`codigo_usu`) REFERENCES `usuario` (`codigo`),
  CONSTRAINT `FK_danho_usuario_2` FOREIGN KEY (`cod_usu_rd`) REFERENCES `usuario` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.danho: ~5 rows (aproximadamente)
DELETE FROM `danho`;
/*!40000 ALTER TABLE `danho` DISABLE KEYS */;
INSERT INTO `danho` (`codigo`, `descripcion_d`, `codigo_mat`, `codigo_usu`, `fecha_d`, `cod_usu_rd`, `estado`) VALUES
	(1, 'partida por la mitad', 1, 'U00061264', '2014-02-16 18:35:09', 'U00057132', 0),
	(2, 'partida en una esquina', 1, 'U00057132', '2014-02-13 10:14:00', '123', 1),
	(3, 'Tiene humedad internamente', 1, 'U00061264', '2014-02-11 10:16:00', '123', 2),
	(4, 'manchada de pintura', 1, 'U00061264', '2014-02-05 05:13:00', '123', 1),
	(5, 'Partido a la mitad', 142, '123', '2014-03-01 06:00:00', '123', 0);
/*!40000 ALTER TABLE `danho` ENABLE KEYS */;


-- Volcando estructura para tabla siprelab.error
DROP TABLE IF EXISTS `error`;
CREATE TABLE IF NOT EXISTS `error` (
  `codigo` varchar(50) NOT NULL,
  `mensaje` varchar(150) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.error: ~24 rows (aproximadamente)
DELETE FROM `error`;
/*!40000 ALTER TABLE `error` DISABLE KEYS */;
INSERT INTO `error` (`codigo`, `mensaje`) VALUES
	('backup_insuficiente', 'No hay suficientes Backup para poder ser eliminados'),
	('error', 'Ha ocurrido un error'),
	('error_accion', 'Ha ocurrido un error'),
	('faltan_Datos', 'Debe completar todos los datos'),
	('fecha_error', 'Hubo un error al intentar procesar la fecha'),
	('login_Incorrecto', 'Los datos son incorrectos'),
	('materiales_Ndisp', 'Uno o más materiales no se encuentran disponibles'),
	('material_inexistente', 'El material no existe'),
	('no_agrego', 'Un error no permitió realizar la última acción'),
	('no_directorio', 'Ha ocurrido un error interno del sistema, se recomienda contactar con el Administrador'),
	('no_existe', 'El usuario no existe'),
	('no_orden', 'Los datos no han sido procesados de manera correcta'),
	('NO_prestamo', 'No hay préstamos'),
	('No_usuario', 'No se ha detectado ninguna sesión activa'),
	('prestamo_null', 'No se encontró ningún préstamo'),
	('QR_error', 'Debido a un error no se generó el código QR'),
	('sin_ID', 'Hubo un error al procesar el id'),
	('sin_permisos', 'Usted no posee los privilegios sufientes para esta acción'),
	('sin_reserva', 'El usuario no tiene ninguna reserva activa'),
	('telefono_incorrecto', 'El telefono suministrado es incorrecto'),
	('usuario_inactivo', 'Este usuario no se encuentra activo'),
	('usuario_multa', 'El usuario tiene una multa activa que no le permite realizar esa acción'),
	('usuario_prestamo', 'El usuario tiene un préstamo activo que no le permite realizar esa acción'),
	('usuario_reserva', 'El usuario tiene una reserva activa que no le permite realizar esa acción');
/*!40000 ALTER TABLE `error` ENABLE KEYS */;


-- Volcando estructura para tabla siprelab.laboratorio
DROP TABLE IF EXISTS `laboratorio`;
CREATE TABLE IF NOT EXISTS `laboratorio` (
  `codigo` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `ubicacion` varchar(50) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.laboratorio: ~1 rows (aproximadamente)
DELETE FROM `laboratorio`;
/*!40000 ALTER TABLE `laboratorio` DISABLE KEYS */;
INSERT INTO `laboratorio` (`codigo`, `nombre`, `descripcion`, `ubicacion`) VALUES
	(1, 'Electronica', 'Laboratorio con elementos para estudiantes de quinto y sexto semestre de la carrera ingenieria mecatronica.', 'Edificio de ingenierias cuarto piso');
/*!40000 ALTER TABLE `laboratorio` ENABLE KEYS */;


-- Volcando estructura para tabla siprelab.material
DROP TABLE IF EXISTS `material`;
CREATE TABLE IF NOT EXISTS `material` (
  `codigo` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(150) DEFAULT NULL,
  `tipo_mat` int(10) NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `serial` varchar(50) DEFAULT NULL,
  `foto_mat` varchar(150) DEFAULT NULL,
  `num_inventario` varchar(50) DEFAULT NULL,
  `estado` int(1) NOT NULL DEFAULT '0' COMMENT '0 activo, 1 dado de baja, 2 dañado',
  `ult_fecha_mante` datetime DEFAULT NULL,
  `disponibilidad` int(1) NOT NULL DEFAULT '0' COMMENT '0 libre, 1 prestado, 2 reserva',
  `codigo_lab` int(10) NOT NULL DEFAULT '0',
  `imagenqr` varchar(150) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_material_laboratorio` (`codigo_lab`),
  KEY `FK_material_tipo_material` (`tipo_mat`),
  CONSTRAINT `FK_material_laboratorio` FOREIGN KEY (`codigo_lab`) REFERENCES `laboratorio` (`codigo`),
  CONSTRAINT `FK_material_tipo_material` FOREIGN KEY (`tipo_mat`) REFERENCES `tipo_material` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.material: ~171 rows (aproximadamente)
DELETE FROM `material`;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` (`codigo`, `descripcion`, `tipo_mat`, `marca`, `serial`, `foto_mat`, `num_inventario`, `estado`, `ult_fecha_mante`, `disponibilidad`, `codigo_lab`, `imagenqr`) VALUES
	(1, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'ninguna', 'ninguna', '', '00008731', 0, '2014-02-16 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/1'),
	(2, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'ninguna', 'ninguna', '', '00008732', 0, '2014-02-11 10:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/2'),
	(3, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'ninguna', 'ninguna', '', '00008733', 0, '2014-02-12 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/3'),
	(4, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'ninguna', 'ninguna', '', '00008734', 0, '2014-02-12 10:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/4'),
	(5, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB) ', 3, 'ninguna', 'ninguna', '', '00008735', 0, '2014-02-10 09:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/5'),
	(6, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'ninguna', 'ninguna', '', '00008736', 0, '2014-02-17 10:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/6'),
	(7, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'ninguna', 'ninguna', '', '00008737', 0, '2014-02-10 13:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/7'),
	(8, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-17 11:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/8'),
	(9, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 13:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/9'),
	(10, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/10'),
	(11, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/11'),
	(12, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-17 02:00:00', 1, 1, 'C:/Users/WM/Desktop/QR/12'),
	(13, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/13'),
	(14, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/14'),
	(15, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 13:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/15'),
	(16, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 10:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/16'),
	(17, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 11:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/17'),
	(18, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 16:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/18'),
	(19, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 13:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/19'),
	(20, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 13:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/20'),
	(21, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 10:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/21'),
	(22, 'CONTROLADOR OMRON E5CNH', 4, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 08:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/22'),
	(23, 'CONTROLADOR OMRON E5CNH', 4, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 09:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/23'),
	(24, 'CONTROLADOR OMRON E5CNH', 4, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/24'),
	(25, 'CONTROLADOR OMRON E5CNH', 4, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-06 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/25'),
	(26, 'CONTROLADOR OMRON E5CNH', 4, 'ninguna', 'ninguna', '', '000012265', 0, '2014-02-13 09:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/26'),
	(27, 'CONTROLADOR OMRON E5CNH', 4, 'ninguna', 'ninguna', '', '000012264', 0, '2014-02-04 11:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/27'),
	(28, 'CONTROLADOR OMRON E5CNH', 4, 'ninguna', 'ninguna', '', '000012264', 0, '2014-02-11 11:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/28'),
	(29, 'CONTROLADOR OMRON E5CNH', 4, 'ninguna', 'ninguna', '', '000012266', 0, '2014-02-04 13:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/29'),
	(30, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/30'),
	(31, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/31'),
	(32, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/32'),
	(33, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/33'),
	(34, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/34'),
	(35, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 09:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/35'),
	(36, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-02 15:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/36'),
	(37, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 15:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/37'),
	(38, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 14:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/38'),
	(39, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-09 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/39'),
	(40, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/40'),
	(41, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/41'),
	(42, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/42'),
	(43, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/43'),
	(44, 'MODEM SIMENS SITRANS TH200 INTERFASE USB', 4, 'ninguna', 'ninguna', '', '00020550', 0, '2014-02-11 02:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/44'),
	(45, 'TRANSMISOR DE TEMPERATURA SIMENS SITRANS TH200', 4, 'ninguna', 'ninguna', '', '00020549', 0, '2014-02-12 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/45'),
	(46, 'SENSORES ULTRASONIDO DISTANCIA 0-6 MTS MAXBOTIX', 7, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-18 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/46'),
	(47, 'SENSORES ULTRASONIDO DISTANCIA 0-6 MTS MAXBOTIX', 7, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-09 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/47'),
	(48, 'SENSORES ULTRASONIDO DISTANCIA 0-6 MTS MAXBOTIX', 7, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/48'),
	(49, 'SENSORES ULTRASONIDO DISTANCIA 0-6 MTS MAXBOTIX', 7, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/49'),
	(50, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/50'),
	(51, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/51'),
	(52, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/52'),
	(53, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/53'),
	(54, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-17 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/54'),
	(55, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-17 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/55'),
	(56, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-17 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/56'),
	(57, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-17 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/57'),
	(58, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/58'),
	(59, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/59'),
	(60, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/60'),
	(61, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/61'),
	(62, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/62'),
	(63, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/63'),
	(64, 'CABLES USB TIPO B', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/64'),
	(65, 'CABLES USB TIPO B', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/65'),
	(66, 'CABLES USB TIPO B', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-17 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/66'),
	(67, 'CABLES USB TIPO B', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/67'),
	(68, 'CABLE USB MINI USB', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/68'),
	(69, 'CABLE USB MINI USB', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-09 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/69'),
	(70, 'CABLE USB MINI USB', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/70'),
	(71, 'CABLES USB', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/71'),
	(72, 'CABLE CONVERSOR USB-SERIAL', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/72'),
	(73, 'CABLE CONVERSOR USB-SERIAL', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/73'),
	(74, 'CABLE CONVERSOR USB-SERIAL', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/74'),
	(75, 'CABLE CONVERSOR USB-SERIAL', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/75'),
	(76, 'SENSOR INDUCTIVO PNP/N.O', 7, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-05 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/76'),
	(77, 'SENSOR INDUCTIVO PNP/N.O', 7, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/77'),
	(78, 'SENSOR INDUCTIVO PNP/N.O', 7, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/78'),
	(79, 'SENSOR INDUCTIVO PNP/N.O', 7, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/79'),
	(80, 'ARDUINO MEGA ADK + CABLE ARDUINO USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/80'),
	(81, 'ARDUINO MEGA ADK + CABLE ARDUINO USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/81'),
	(82, 'ARDUINO MEGA ADK + CABLE ARDUINO USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/82'),
	(83, 'ARDUINO MEGA ADK + CABLE ARDUINO USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/83'),
	(84, 'ARDUINO MEGA ADK + CABLE ARDUINO USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/84'),
	(85, 'ARDUINO UNO R3 + CABLE USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/85'),
	(86, 'ARDUINO MEGA 2560 R2 + CABLE USB TIPO B', 3, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/86'),
	(87, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/87'),
	(88, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/88'),
	(89, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/89'),
	(90, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/90'),
	(91, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/91'),
	(92, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/92'),
	(93, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/93'),
	(94, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/94'),
	(95, 'KIT MINIPA(VOM-CAUTIN+BASE-ESTRACTOR-OHMIOS', 9, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/95'),
	(96, 'KIT MINIPA(VOM-CAUTIN+BASE-ESTRACTOR-OHMIOS', 9, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/96'),
	(97, 'FUENTE FIJA (12-12/5-5)', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/97'),
	(98, 'FUENTE FIJA (12-12/5-5)', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/98'),
	(99, 'FUENTE FIJA (12-12/5-5)', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/99'),
	(100, 'FUENTE FIJA (12-12/5-5)', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/100'),
	(101, 'FUENTE FIJA (12-12/5-5)', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/101'),
	(102, 'FUENTE FIJA (12-12/5-5)', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/102'),
	(103, 'FUENTE FIJA (12-12/5-5)', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/103'),
	(104, 'MULTIMETROS UNIT', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/104'),
	(105, 'MULTIMETROS UNIT', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/105'),
	(106, 'MULTIMETROS UNIT', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/106'),
	(107, 'MULTIMETROS UNIT', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/107'),
	(108, 'MULTIMETROS UNIT', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/108'),
	(109, 'MULTIMETROS UNIT', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/109'),
	(110, 'MULTIMETRO TECH TM-178', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-05 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/110'),
	(111, 'MULTIMETRO TECH TM-178', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/111'),
	(112, 'MULTIMETRO TECH TM-178', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/112'),
	(113, 'MULTIMETRO TECH TM-178', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/113'),
	(114, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/114'),
	(115, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/115'),
	(116, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/116'),
	(117, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/117'),
	(118, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/118'),
	(119, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/119'),
	(120, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/120'),
	(121, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/121'),
	(122, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/122'),
	(123, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/123'),
	(124, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/124'),
	(125, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/125'),
	(126, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/126'),
	(127, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/127'),
	(128, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/128'),
	(129, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/129'),
	(130, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/130'),
	(131, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/131'),
	(132, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/132'),
	(133, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/133'),
	(134, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/134'),
	(135, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/135'),
	(136, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/136'),
	(137, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/137'),
	(138, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/138'),
	(139, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/139'),
	(140, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/140'),
	(141, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', '', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/141'),
	(142, 'pRUEBA', 13, 'ninguna', 'ninguna', '595b1.jpg', ' ', 0, '2014-02-03 02:00:00', 0, 1, 'C:SIPLSIPLwebQR142'),
	(143, 'preuba', 13, 'ninguna', 'ninguna', '595b1.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:SIPLSIPLwebQR143'),
	(144, 'ninguna', 1, 'ninguna', 'ninguna', 'ninguna', ' ', 0, '2014-02-23 00:00:00', 0, 1, 'C:siplSIPLwebQR144'),
	(145, 'ADAPTADOR INTELIGENTE 2500 mA TECH', 5, 'ninguna', 'ninguna', '', ' ', 0, '2014-03-01 05:30:00', 0, 1, 'C:SIPLSIPLwebQR145');
/*!40000 ALTER TABLE `material` ENABLE KEYS */;


-- Volcando estructura para tabla siprelab.multa
DROP TABLE IF EXISTS `multa`;
CREATE TABLE IF NOT EXISTS `multa` (
  `codigo` int(10) NOT NULL AUTO_INCREMENT,
  `cod_usuario` varchar(20) NOT NULL,
  `fecha_multa` datetime NOT NULL,
  `estado_multa` int(11) NOT NULL DEFAULT '0' COMMENT '0 activo, 1 inactivo',
  `tiempo_multa` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`codigo`),
  KEY `FK_multa_usuario` (`cod_usuario`),
  CONSTRAINT `FK_multa_usuario` FOREIGN KEY (`cod_usuario`) REFERENCES `usuario` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.multa: ~3 rows (aproximadamente)
DELETE FROM `multa`;
/*!40000 ALTER TABLE `multa` DISABLE KEYS */;
INSERT INTO `multa` (`codigo`, `cod_usuario`, `fecha_multa`, `estado_multa`, `tiempo_multa`) VALUES
	(2, '456', '2014-03-09 07:34:02', 1, 3),
	(3, 'U00061264', '2014-03-09 07:35:00', 1, 3),
	(4, '000', '2014-03-15 10:18:13', 1, 3);
/*!40000 ALTER TABLE `multa` ENABLE KEYS */;


-- Volcando estructura para tabla siprelab.prestamo
DROP TABLE IF EXISTS `prestamo`;
CREATE TABLE IF NOT EXISTS `prestamo` (
  `codigo` int(10) NOT NULL AUTO_INCREMENT,
  `cod_material` varchar(100) NOT NULL,
  `cod_usuario` varchar(20) NOT NULL,
  `fecha_prestamo` datetime NOT NULL,
  `fecha_devolucion` datetime NOT NULL,
  `estado` int(2) NOT NULL DEFAULT '0' COMMENT '0 activo, 1 inactivo',
  PRIMARY KEY (`codigo`),
  KEY `FK_prestamo_material` (`cod_material`),
  KEY `FK_prestamo_usuario` (`cod_usuario`),
  CONSTRAINT `FK_prestamo_usuario` FOREIGN KEY (`cod_usuario`) REFERENCES `usuario` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.prestamo: ~8 rows (aproximadamente)
DELETE FROM `prestamo`;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
INSERT INTO `prestamo` (`codigo`, `cod_material`, `cod_usuario`, `fecha_prestamo`, `fecha_devolucion`, `estado`) VALUES
	(1, '1', 'U00057132', '2013-02-23 22:21:08', '2013-03-23 22:21:19', 1),
	(2, '2', 'U00057132', '2013-04-20 22:21:41', '2014-04-13 22:21:55', 1),
	(3, '1;2', 'U00057132', '2014-02-23 11:08:23', '2014-02-24 11:08:23', 1),
	(5, '80', '123', '2014-02-01 05:18:05', '2014-03-01 05:18:50', 1),
	(6, '82', '456', '2014-03-01 06:20:47', '2014-03-09 07:34:02', 1),
	(7, '33', 'U00061264', '2014-02-09 07:33:32', '2014-03-09 07:35:00', 1),
	(8, '12', '123', '2014-03-12 12:00:16', '2014-03-15 12:00:16', 0),
	(9, '1;23', '000', '2014-03-12 12:45:15', '2014-03-15 10:18:13', 1);
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;


-- Volcando estructura para tabla siprelab.reserva
DROP TABLE IF EXISTS `reserva`;
CREATE TABLE IF NOT EXISTS `reserva` (
  `codigo` int(10) NOT NULL AUTO_INCREMENT,
  `cod_usuario` varchar(20) NOT NULL,
  `estado` int(1) NOT NULL DEFAULT '0' COMMENT '0 activo, 1 inactivo',
  `fecha_reserva` datetime NOT NULL,
  `cod_material` varchar(50) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_reserva_usuario` (`cod_usuario`),
  CONSTRAINT `FK_reserva_usuario` FOREIGN KEY (`cod_usuario`) REFERENCES `usuario` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.reserva: ~5 rows (aproximadamente)
DELETE FROM `reserva`;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` (`codigo`, `cod_usuario`, `estado`, `fecha_reserva`, `cod_material`) VALUES
	(1, '123', 1, '2014-03-08 23:38:26', '37'),
	(2, '123', 1, '2014-03-09 12:28:40', '28'),
	(4, '000', 1, '2014-03-11 10:59:20', '112;1'),
	(5, '000', 1, '2014-03-12 12:38:08', '1;23'),
	(6, '000', 1, '2014-03-15 10:18:56', '32');
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;


-- Volcando estructura para tabla siprelab.tipo_material
DROP TABLE IF EXISTS `tipo_material`;
CREATE TABLE IF NOT EXISTS `tipo_material` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `cantidad` int(5) NOT NULL,
  `disponibilidad` int(5) NOT NULL DEFAULT '0' COMMENT '0 disponible, 1 no disponible',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.tipo_material: ~13 rows (aproximadamente)
DELETE FROM `tipo_material`;
/*!40000 ALTER TABLE `tipo_material` DISABLE KEYS */;
INSERT INTO `tipo_material` (`id`, `nombre`, `descripcion`, `cantidad`, `disponibilidad`) VALUES
	(1, 'PROTOBOARD', 'Es un tablero con orificios conectados eléctricamente entre sí, habitualmente siguiendo patrones de líneas, en el cual se pueden insertar componentes electrónicos y cables para el armado y prototipado de circuitos electrónicos ', 8, 7),
	(2, 'EQUIPOS DE COMPUTO', 'ninguno', 0, 0),
	(3, 'TARJETAS DE DESARROLLO', 'ninguno', 21, 21),
	(4, 'EQUIPOS DE CONTROL', 'ninguno', 10, 10),
	(5, 'CABLE Y CONECTOR', 'ninguno', 20, 20),
	(6, 'MOTOR', 'ninguno', 7, 7),
	(7, 'SENSORES Y ACTUADORES', 'ninguno', 8, 8),
	(8, 'ELECTRICO', 'ninguno', 14, 14),
	(9, 'HERRAMIENTA SOLDAR', 'ninguno', 10, 10),
	(10, 'EQUIPO DE MEDICION Y GENERACION DE SEÑALES', 'ninguno', 45, 44),
	(11, 'ACCESORIOS', 'ninguno', 0, 0),
	(12, 'HERRAMIENTA MANUAL', 'ninguno', 0, 0),
	(13, 'BATERIAS', 'ninguno', 2, 2);
/*!40000 ALTER TABLE `tipo_material` ENABLE KEYS */;


-- Volcando estructura para tabla siprelab.usuario
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(30) NOT NULL,
  `telefono` bigint(15) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `estado` int(1) NOT NULL DEFAULT '0' COMMENT '0 activo, 1 inactivo, 2 con prestamo, 3 con  reserva, 4 con multa',
  `tipo_usuario` int(1) NOT NULL DEFAULT '0' COMMENT '0 estudiante, 1 admin local, 2 admin global',
  `observaciones` varchar(200) DEFAULT NULL,
  `clave` varchar(100) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.usuario: ~35 rows (aproximadamente)
DELETE FROM `usuario`;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`codigo`, `nombre`, `apellido`, `telefono`, `correo`, `estado`, `tipo_usuario`, `observaciones`, `clave`) VALUES
	('000', 'Estudiante', 'Prueba', 156324, 'prueba@unab.gol.co', 0, 0, 'Testeando el aplicativo web 123', 'c6f057b86584942e415435ffb1fa93d4'),
	('123', 'Juan Carlos', 'Garcia Ojeda', 0, 'jgarciao@unab.edu.co', 2, 2, 'Docente facultad ingenieria de sistemas', '202cb962ac59075b964b07152d234b70'),
	('456', 'Freddy', 'Mendez Ortiz', 0, 'fmendez@unab.edu.co', 0, 1, 'Docente facultad ingenieria de sistemas', '250cf8b51c773f3f8dc8b4be867a9a02'),
	('789', 'Daniel', 'Arenas Seleey', 0, 'darenass@unab.edu.co', 0, 2, 'Docente facultad ingenieria de sistemas', '68053af2923e00204c3ca7c6a3150cf7'),
	('U00016473', 'MANUEL ALONSO', 'ENCISO CALA', 3167591901, 'menciso@unab.edu.co', 0, 0, '', '788f16884459ee90ba76a424be8fe7fd'),
	('U00021306', 'EDUARDO AMADOR', 'CORONADO CARDONA', 3016065164, 'ecoronado@unab.edu.co', 0, 0, '', '36356943e906691708569486bba8f351'),
	('U00057132', 'Sandra Milena', 'Vera Gomez', 12345, 'svera5@unab.edu.co', 0, 2, '', 'b8a125c27f91a0dbb77a2df5fc40baa9'),
	('U00057571', 'JORGE ELIECER', 'RANGEL VERA', 3134946885, 'jrangel22@unab.edu.co', 0, 0, '', '47f336713f3c33b71750bdb4bce39110'),
	('U00058297', 'JONATAN FERNANDO', 'CASTELLANOS HERNANDEZ', 3118627202, 'jcastellanos10@unab.edu.co', 0, 0, '', '0edb510144b1bbefa8f3dd4ba2fe5c44'),
	('U00058584', 'ANDERSON JAIR', 'BAUTISTA DELGADO', 3138991667, 'abautista7@unab.edu.co', 0, 0, '', '068691e81fe1938e00de3e46a841d051'),
	('U00060829', 'DALYA JULIETH', 'GALVIS PARADA', 3165382178, 'dgalvis34@unab.edu.co', 0, 0, '', 'bd6487b88a03cfb6c2b23ae3cc842327'),
	('U00061149', 'FRANCISCO JAVIER', 'ANGARITA DIAZ', 3143553395, 'fangarita2@unab.edu.co', 0, 0, '', 'f4b49b6b03884a82993ab6918c5f8f63'),
	('U00061264', 'Wilmar', 'González Franco', 0, 'wgonzalez@unab.edu.co', 0, 2, 'ninguna', '827ccb0eea8a706c4c34a16891f84e7b'),
	('U00061338', 'ANDRES YESID', 'MARTINEZ ARDILA', 0, 'amartinez2@unab.edu.co', 0, 0, '', 'f6cfa4d28e5ca0a5bfb4afda731ccccc'),
	('U00061575', 'JULIAN DAVID', 'MANTILLA BLANCO', 3115027213, 'jmantilla26@unab.edu.co', 0, 0, '', '7c786952840f1e69869da4e40b831d18'),
	('U00062050', 'JESUS ERNESTO', 'MONSALVE CARABALLO', 3005521416, 'jmonsalve11@unab.edu.co', 0, 0, '', '04a6f11189028b6f1d8244cb8a0803d0'),
	('U00062808', 'JOSE IGNACIO', 'TRAPERO VILLARREAL', 0, 'jtrapero@unab.edu.co', 0, 0, '', 'c06c4acbd66e816e863a70c09cdce138'),
	('U00062871', 'JESSICA PAOLA', 'AZA MANTILLA', 3002334854, 'jaza@unab.edu.co', 0, 0, '', '170c35e5562a88c744642f76f63bd866'),
	('U00067421', 'JULIANA DE LOS ANGELES', 'CASTELLANOS CASTILLA', 3015308859, 'jcastellanos88@unab.edu.co', 0, 0, '', 'a6d78565f60b01727bf2cb0adfde55d5'),
	('U00069009', 'OLMER GIOVANNY', 'VILLAMIZAR GALVIS', 3153445938, 'ovillamizar10@unab.edu.co', 0, 0, '', 'a67bf731250430b9a8bc582d1ace5d93'),
	('U00069634', 'DANIEL FELIPE', 'LEON CARDONA', 3123621158, 'dleon41@unab.edu.co', 0, 0, '', '32232fa61e6ec4831155ea030d5493b6'),
	('U00071262', 'LUISA FERNANDA', 'PINTO VASQUEZ', 3143326139, 'lpinto12@unab.edu.co', 0, 0, '', '41337c91ae3186a9eb9a676fbedf1385'),
	('U00071341', 'RAUL ROQUE', 'DI MARCO D SILVA', 3153554782, 'rdi@unab.edu.co', 0, 0, '', '33fe684815d1d9d32b70d4c756a5841c'),
	('U00071373', 'JEFERSSON SNEIDER', 'PULIDO CONDIA', 3115274969, 'jpulido23@unab.edu.co', 0, 0, '', '63dcfd61a61b90cce1cc4d4479774ecd'),
	('U00071626', 'JHON CESAR OSWALDO', 'RODRIGUEZ REINEMER', 3106329992, 'jrodriguez86@unab.edu.co', 0, 0, '', '10490a2b6a81fe450a2153c04b223fa5'),
	('U00072372', 'VERONICA ANDREA', 'GALEANO BLANCO', 3102012965, 'vgaleano@unab.edu.co', 0, 0, '', '4e4b572b61aef94b587f8b42ed789577'),
	('U00072423', 'JULIAN ANDRES', 'SERRANO PABON', 3188013212, 'jserrano155@unab.edu.co', 0, 0, '', 'c85aedb7c7dca3f8dab0d1accd443cb3'),
	('U00072596', 'ALVARO JULIAN', 'GONZALEZ CARDENAS', 0, 'agonzalez79@unab.edu.co', 0, 0, '', 'b6c93cdaea76b15efce9898ec9c3941f'),
	('U00073093', 'JUAN SEBASTIAN', 'RIVERA CABEZAS', 3203709388, 'jrivera36@unab.edu.co', 0, 0, '', '88154a762d3064197a782b377fe1f6b7'),
	('U00073102', 'CRISTIAN LEONARDO', 'HERRERA ACOSTA', 3103306816, 'cherrera57@unab.edu.co', 0, 0, '', '9fe1cf5bfa7c1d97f378e7789be18585'),
	('U00075541', 'SAID YAMIL', 'GANDUR ADARME', 0, 'sgandur@unab.edu.co', 0, 0, '', '909e42511e582214b45381cad8c356f7'),
	('U00079226', 'GILMAR HERNANDO', 'TUTA NAVAJAS', 3212542924, 'gtuta@unab.edu.co', 0, 0, '', 'c981b35e1e1899faaf452ae59ab46249'),
	('U00079789', 'MARTHA PATRICIA', 'FORERO CARRILLO', 3044093525, 'mforero261@unab.edu.co', 0, 0, '', '6fe520c5c908183f4441847d42e1ddf2'),
	('U00084229', 'JAIRO IVAN', 'SERRANO GOMEZ', 3162871945, 'jserrano51@unab.edu.co', 0, 0, '', '73989d9fa1582abdc4ebc23bb85c76e8'),
	('U00086281', 'CRISTIAN FABIAN', 'JAIMES SAAVEDRA', 3185214627, 'cjaimes64@unab.edu.co', 0, 0, '', 'e5305399d16a7f3d58b2e830f17ff691');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;


-- Volcando estructura para tabla siprelab.variable_sistema
DROP TABLE IF EXISTS `variable_sistema`;
CREATE TABLE IF NOT EXISTS `variable_sistema` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `datos` varchar(300) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.variable_sistema: ~4 rows (aproximadamente)
DELETE FROM `variable_sistema`;
/*!40000 ALTER TABLE `variable_sistema` DISABLE KEYS */;
INSERT INTO `variable_sistema` (`id`, `datos`, `descripcion`) VALUES
	(1, 'C:\\\\sipl\\\\SIPL\\\\web\\\\', 'Ubicación del sistema'),
	(2, 'C:\\\\Program Files (x86)\\\\MySQL\\\\MySQL Server 5.5\\\\bin\\\\mysqldump', 'Ubicación de Mysql en el disco duro'),
	(3, 'root', 'usuario Mysql'),
	(4, '12345', 'clave Mysql');
/*!40000 ALTER TABLE `variable_sistema` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

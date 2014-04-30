-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.5.37 - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             8.3.0.4694
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.danho: ~6 rows (aproximadamente)
DELETE FROM `danho`;
/*!40000 ALTER TABLE `danho` DISABLE KEYS */;
INSERT INTO `danho` (`codigo`, `descripcion_d`, `codigo_mat`, `codigo_usu`, `fecha_d`, `cod_usu_rd`, `estado`) VALUES
	(1, 'partida por la mitad', 1, 'U00061264', '2014-02-16 18:35:09', 'U00057132', 1),
	(2, 'partida en una esquina', 1, 'U00057132', '2014-02-13 10:14:00', '123', 1),
	(3, 'Tiene humedad internamente', 1, 'U00061264', '2014-02-11 10:16:00', '123', 1),
	(4, 'manchada de pintura', 1, 'U00061264', '2014-02-05 05:13:00', '123', 1),
	(5, 'Partido a la mitad', 142, '123', '2014-03-01 06:00:00', '123', 1),
	(6, 'Perdida toal, incidente causado por estudiantes\r\nFabio Correa\r\nDaniel Daza', 154, 'U00075541', '2014-03-25 06:30:00', '1098652414', 2);
/*!40000 ALTER TABLE `danho` ENABLE KEYS */;


-- Volcando estructura para tabla siprelab.error
DROP TABLE IF EXISTS `error`;
CREATE TABLE IF NOT EXISTS `error` (
  `codigo` varchar(50) NOT NULL,
  `mensaje` varchar(150) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.error: ~25 rows (aproximadamente)
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
	('sin_multa', 'El usuario no tiene ninguna multa activa'),
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
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.material: ~227 rows (aproximadamente)
DELETE FROM `material`;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` (`codigo`, `descripcion`, `tipo_mat`, `marca`, `serial`, `foto_mat`, `num_inventario`, `estado`, `ult_fecha_mante`, `disponibilidad`, `codigo_lab`, `imagenqr`) VALUES
	(1, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'NEXYS2', 'D218365', 'noimage.jpg', '00008731', 0, '2009-12-17 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(2, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'NEXYS2', 'D217752', 'noimage.jpg', '00008732', 0, '2009-12-17 10:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(3, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'NEXYS2', 'D218205', 'noimage.jpg', '00008733', 0, '2009-12-17 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(4, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'NEXYS2', 'D217504', 'noimage.jpg', '00008734', 0, '2009-12-17 10:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(5, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB) ', 3, 'NEXYS2', 'D217909', 'noimage.jpg', '00008735', 0, '2009-12-17 09:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(6, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'NEXYS2', 'D218153', 'noimage.jpg', '00008736', 0, '2009-12-17 10:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(7, 'FPGA  DIGILENT NEXYS 2 + CABLE (USB-MINIUSB)', 3, 'NEXYS2', 'D218483', 'noimage.jpg', '00008737', 0, '2009-12-17 01:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(8, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-17 11:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(9, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 13:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/9'),
	(10, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-11 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/10'),
	(11, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/11'),
	(12, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-17 02:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/12'),
	(13, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/13'),
	(14, 'PROTOBOARD FX2-BB DIGILENT', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/14'),
	(15, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'NATIONAL INSTRUMENT', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 01:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(16, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 10:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/16'),
	(17, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 11:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/17'),
	(18, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 04:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/18'),
	(19, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-11 01:00:00', 1, 1, 'C:/Users/WM/Desktop/QR/19'),
	(20, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 13:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/20'),
	(21, 'DAQ-DATA ACQUISITION NATIONAL INSTRUMENT+ CABLE USB TIPO B', 3, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 10:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/21'),
	(22, 'CONTROLADOR DIGITAL DE SENALES', 4, 'MOTOROLA', 'DSP56F805EVM', 'noimage.jpg', ' N00003285', 0, '2014-02-03 08:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(23, 'CONTROLADOR E5CN-H', 4, 'OMRON', 'V2M500AC100', 'noimage.jpg', ' N00012268', 0, '2011-05-20 09:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(24, 'CONTROLADOR E5CN-H', 4, 'OMRON', 'V2M500AC100', 'noimage.jpg', ' N00012262', 0, '2011-05-20 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(25, 'CONTROLADOR E5CN-H', 4, 'OMRON', 'V2M500AC100', 'noimage.jpg', ' N00012263', 0, '2009-05-20 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(26, 'CONTROLADOR E5CN-H', 4, 'OMRON', 'V2M500AC100', 'noimage.jpg', '000012265', 0, '2011-05-20 09:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(27, 'CONTROLADOR E5CN-H', 4, 'OMRON', 'V2M500AC100', 'noimage.jpg', '000012264', 0, '2011-05-20 11:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(28, 'CONTROLADOR E5CN-H', 4, 'OMRON', 'V2M500AC100', 'noimage.jpg', '000012266', 0, '2011-05-20 11:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(29, 'CONTROLADOR E5CN-H', 4, 'OMRON', 'V2M500AC100', 'noimage.jpg', '000012267', 0, '2009-05-20 01:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(30, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-11 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/30'),
	(31, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/31'),
	(32, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/32'),
	(33, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/33'),
	(34, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/34'),
	(35, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 09:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/35'),
	(36, 'CABLE PARA CONTROLADOR', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-02 15:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/36'),
	(37, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'DYNAMO', 'ninguna', 'noimage.jpg', ' 1', 0, '2014-02-10 03:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(38, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 02:00:00', 1, 1, 'C:/Users/WM/Desktop/QR/38'),
	(39, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-09 12:00:00', 1, 1, 'C:/Users/WM/Desktop/QR/39'),
	(40, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-04 12:00:00', 1, 1, 'C:/Users/WM/Desktop/QR/40'),
	(41, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 12:00:00', 1, 1, 'C:/Users/WM/Desktop/QR/41'),
	(42, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 1, 1, 'C:/Users/WM/Desktop/QR/42'),
	(43, 'MOTOREDUCTOR 12VDC TORQUE 18KG VEL 80 RPM DYNAMO', 6, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/43'),
	(44, 'MODEM SIMENS SITRANS TH200 INTERFASE USB', 4, 'SIEMENS', '100018948', 'noimage.jpg', 'N00020550', 0, '2013-11-21 02:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(45, 'TRANSMISOR DE TEMPERATURA SIMENS SITRANS TH200', 4, 'SIEMENS', '100018945', 'noimage.jpg', 'N00020549', 0, '2013-11-21 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(46, 'SENSORES ULTRASONIDO DISTANCIA 0-6 MTS MAXBOTIX', 7, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-18 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/46'),
	(47, 'SENSORES ULTRASONIDO DISTANCIA 0-6 MTS MAXBOTIX', 7, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-09 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/47'),
	(48, 'SENSORES ULTRASONIDO DISTANCIA 0-6 MTS MAXBOTIX', 7, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/48'),
	(49, 'SENSORES ULTRASONIDO DISTANCIA 0-6 MTS MAXBOTIX', 7, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/49'),
	(50, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/50'),
	(51, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/51'),
	(52, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/52'),
	(53, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/53'),
	(54, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-17 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/54'),
	(55, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-17 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/55'),
	(56, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-17 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/56'),
	(57, 'BREAKER SCHNEIDER IC60N C 20A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-17 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/57'),
	(58, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/58'),
	(59, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/59'),
	(60, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/60'),
	(61, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/61'),
	(62, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/62'),
	(63, 'BREAKER SCHENIDER IC60N  C 40A', 8, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/63'),
	(64, 'CABLES USB TIPO B', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/64'),
	(65, 'CABLES USB TIPO B', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/65'),
	(66, 'CABLES USB TIPO B', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-17 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/66'),
	(67, 'CABLES USB TIPO B', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/67'),
	(68, 'CABLE USB MINI USB', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/68'),
	(69, 'CABLE USB MINI USB', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-09 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/69'),
	(70, 'CABLE USB MINI USB', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/70'),
	(71, 'CABLES USB', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/71'),
	(72, 'CABLE CONVERSOR USB-SERIAL', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/72'),
	(73, 'CABLE CONVERSOR USB-SERIAL', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/73'),
	(74, 'CABLE CONVERSOR USB-SERIAL', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/74'),
	(75, 'CABLE CONVERSOR USB-SERIAL', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/75'),
	(76, 'SENSOR INDUCTIVO PNP/N.O', 7, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-05 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/76'),
	(77, 'SENSOR INDUCTIVO PNP/N.O', 7, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/77'),
	(78, 'SENSOR INDUCTIVO PNP/N.O', 7, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/78'),
	(79, 'SENSOR INDUCTIVO PNP/N.O', 7, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/79'),
	(80, 'ARDUINO MEGA ADK + CABLE ARDUINO USB TIPO B', 3, 'ARDUINO', '1', 'noimage.jpg', 'MK0012519', 0, '2013-12-10 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(81, 'ARDUINO MEGA ADK + CABLE ARDUINO USB TIPO B', 3, 'ARDUINO', '2', 'Invierno.jpg', ' MK0012514', 0, '2013-12-10 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(82, 'ARDUINO MEGA ADK + CABLE ARDUINO USB TIPO B', 3, 'ARDUINO', '3', 'Invierno.jpg', ' MK0012511', 0, '2013-12-10 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(83, 'ARDUINO MEGA ADK + CABLE ARDUINO USB TIPO B', 3, 'ARDUINO', '4', 'noimage.jpg', ' MK0012515', 0, '2013-12-10 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(84, 'ARDUINO MEGA ADK + CABLE ARDUINO USB TIPO B', 3, 'ARDUINO', '5', 'noimage.jpg', ' MK0012517', 0, '2013-12-10 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(85, 'ARDUINO UNO R3 + CABLE USB TIPO B', 3, 'ARDUINO', '6', 'noimage.jpg', ' ', 0, '2013-02-04 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(86, 'ARDUINO MEGA 2560 R2 + CABLE USB TIPO B', 3, 'ARDUINO', '7', 'noimage.jpg', ' ', 0, '2013-02-04 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(87, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/87'),
	(88, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/88'),
	(89, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/89'),
	(90, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/90'),
	(91, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/91'),
	(92, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/92'),
	(93, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/93'),
	(94, 'CAUTIN + BASE', 9, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-11 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/94'),
	(95, 'KIT MINIPA(VOM-CAUTIN+BASE-ESTRACTOR-OHMIOS', 9, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/95'),
	(96, 'KIT MINIPA(VOM-CAUTIN+BASE-ESTRACTOR-OHMIOS', 9, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/96'),
	(97, 'FUENTE FIJA (12-12/5-5)', 10, 'ELECTRONICS', 'ninguna', 'noimage.jpg', ' 1', 0, '2014-02-04 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(98, 'FUENTE FIJA (12-12/5-5)', 10, 'ELECTRONICS', 'ninguna', 'noimage.jpg', ' 2', 0, '2014-02-03 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(99, 'FUENTE FIJA (12-12/5-5)', 10, 'ELECTRONICS', 'ninguna', 'noimage.jpg', ' 3', 0, '2014-02-04 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(100, 'FUENTE FIJA (12-12/5-5)', 10, 'ELECTRONICS', 'ninguna', 'noimage.jpg', '4', 0, '2014-02-11 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(101, 'FUENTE FIJA (12-12/5-5)', 10, 'ELECTRONICS', 'ninguna', 'noimage.jpg', ' 5', 0, '2014-02-04 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(102, 'FUENTE FIJA (12-12/5-5)', 10, 'ELECTRONICS', 'ninguna', 'noimage.jpg', '6', 0, '2014-02-11 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(103, 'FUENTE FIJA (12-12/5-5)', 10, 'ELECTRONICS', 'ninguna', 'noimage.jpg', '7', 0, '2014-02-11 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(104, 'MULTIMETROS DIGITAL UT58D', 10, 'UNIT-T', '1080424816', 'noimage.jpg', ' N00006833', 0, '2008-09-01 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(105, 'MULTIMETROS DIGITAL UT58D', 10, 'UNIT-T', '1070860914', 'noimage.jpg', ' N00007978', 0, '2009-09-04 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(106, 'MULTIMETROS DIGITAL UT58D', 10, 'UNIT-T', '1080801034', 'noimage.jpg', ' N00007984', 0, '2009-09-04 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(107, 'MULTIMETROS UNIT', 10, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/107'),
	(108, 'MULTIMETROS UNIT', 10, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/108'),
	(109, 'MULTIMETROS UNIT', 10, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/109'),
	(110, 'MULTIMETRO TECH TM-178', 10, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-05 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/110'),
	(111, 'MULTIMETRO TECH TM-178', 10, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-04 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/111'),
	(112, 'MULTIMETRO TECH TM-178', 10, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-04 12:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/112'),
	(113, 'MULTIMETRO TECH TM-178', 10, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 00:00:00', 0, 1, 'C:/Users/WM/Desktop/QR/113'),
	(114, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '11038408', 'noimage.jpg', ' N00014519', 0, '2011-11-04 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(115, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '11038401', 'noimage.jpg', 'N00014520 ', 0, '2011-11-01 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(116, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '11038361', 'noimage.jpg', ' N00014521', 0, '2011-11-01 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(117, 'MULTIMETROS ISDUSTRIAL AUTORANGO', 10, 'EXTECH', '12047847', 'noimage.jpg', ' N00018300', 0, '2013-04-15 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(118, 'MULTIMETROS INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12018534', 'noimage.jpg', ' N00018301', 0, '2013-04-15 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(119, 'MULTIMETROS INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12018539', 'noimage.jpg', ' N00018302', 0, '2013-04-15 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(120, 'MULTIMETROS INDUSRIAL AUTORANGO', 10, 'EXTECH', '12018530', 'noimage.jpg', ' N00018303', 0, '2013-04-15 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(121, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12018518', 'noimage.jpg', ' N00018304', 0, '2013-04-15 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(122, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12057504', 'noimage.jpg', ' N00018305', 0, '2014-02-03 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(123, 'MULTIMETROS INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12057486', 'noimage.jpg', ' N00018306', 0, '2014-02-11 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(124, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12057520', 'noimage.jpg', ' N00018307', 0, '2013-04-15 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(125, 'MULTIMETRO INDUSTRIAL AUTORANGO ', 10, 'EXTECH', '12057510', 'noimage.jpg', ' N00018308', 0, '2014-02-04 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(126, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12057479', 'noimage.jpg', ' N00018309', 0, '2014-02-10 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(127, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12057485', 'noimage.jpg', ' N00018310', 0, '2013-04-15 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(128, 'MULTIMETRO INDUSTRIAL AUTORANGO ', 10, 'EXTECH', '12057511', 'noimage.jpg', ' N00018312', 0, '2014-02-04 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(129, 'MULTIMETRO INSDUSTRIAL AUTORANGO', 10, 'EXTECH', '12079445', 'noimage.jpg', ' N00018891', 0, '2013-07-03 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(130, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12057475', 'noimage.jpg', ' N00018313', 0, '2014-02-04 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(131, 'MULTIMETRO INDUSTRIAL AUTORANGO ', 10, 'EXTECH', '12057508', 'noimage.jpg', ' N00018314', 0, '2013-04-15 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(132, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 10, 'ninguna', 'ninguna', 'noimage.jpg', ' N00018314', 0, '2014-02-10 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(133, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12079403', 'noimage.jpg', 'N00018882', 0, '2013-07-03 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(134, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12079400', 'noimage.jpg', ' N00018883', 0, '2013-07-03 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(135, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12079386', 'noimage.jpg', ' N00018884', 0, '2013-07-03 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(136, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12079443', 'noimage.jpg', ' N00018885', 0, '2014-02-03 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(137, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12079423', 'noimage.jpg', ' N00018886', 0, '2013-07-03 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(138, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12079384', 'noimage.jpg', ' N00018887', 0, '2013-07-03 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(139, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12079372', 'noimage.jpg', ' N00018888', 0, '2013-07-03 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(140, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12079360', 'noimage.jpg', ' N00018889', 0, '2013-07-03 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(141, 'MULTIMETRO INDUSTRIAL AUTORANGO', 10, 'EXTECH', '12079432', 'noimage.jpg', ' N00018890', 0, '2013-07-03 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(142, 'pRUEBA', 13, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-03 02:00:00', 0, 1, 'C:SIPLSIPLwebQR142'),
	(143, 'preuba', 13, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-10 12:00:00', 0, 1, 'C:SIPLSIPLwebQR143'),
	(144, 'ninguna', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-02-23 00:00:00', 0, 1, 'C:siplSIPLwebQR144'),
	(145, 'ADAPTADOR INTELIGENTE 2500 mA TECH', 5, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-03-01 05:30:00', 0, 1, 'C:SIPLSIPLwebQR145'),
	(146, 'ninguna', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-03-25 15:35:00', 0, 1, 'C:siplSIPLweb/QR/'),
	(147, 'ninguna', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-03-25 15:36:00', 0, 1, 'C:siplSIPLweb/QR/'),
	(148, 'ninguna', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-03-25 15:39:00', 0, 1, 'C:siplSIPLwebQR/'),
	(149, 'ninguna', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-03-25 15:41:00', 0, 1, 'C:siplSIPLwebQR/'),
	(150, 'ninguna', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-03-25 15:42:00', 0, 1, 'C:siplSIPLwebQR/'),
	(151, 'ninguna', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-03-25 15:44:00', 0, 1, 'C:siplSIPLwebQR/151'),
	(152, 'ninguna', 1, 'ninguna', 'ninguna', 'noimage.jpg', ' ', 0, '2014-03-25 15:46:00', 0, 1, 'C:siplSIPLwebQR/152'),
	(153, 'Epecializacion /  Nanotecnologia', 3, 'Con3Lab LEYBOL', 'NO:UP30431', 'Invierno.jpg', '16897', 0, '2014-04-04 02:16:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/153'),
	(154, 'COMPUTADOR DELL OPTIPLEX 390CORE i5', 2, 'Dell', '9L74VV1/871NRL', 'noimage.jpg', 'N00016525', 1, '2012-05-04 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/154'),
	(155, 'ninguna', 10, 'MULTIMETROS DIGITALES EXTECH INSTRUMENTS', 'ninguna', 'noimage.jpg', 'N00018891', 0, '2014-04-11 18:40:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/155'),
	(156, 'PINZA AMPERIMETRICA AC /DC 54NAV', 10, 'AMPROBE', 'ninguna', 'noimage.jpg', 'N00018355', 0, '2013-05-02 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(157, 'PINZA AMPERIMETRICA AC /DC 54NAV', 10, 'AMPROBE', 'ninguna', 'noimage.jpg', 'N00018356', 0, '2013-05-02 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(158, 'PINZA AMPERIMETRICA AC /DC 54NAV', 10, 'AMPROBE', 'ninguna', 'noimage.jpg', 'N00018357', 0, '2013-05-02 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(159, 'PINZA AMPERIMERICA AC /DC 54NAV', 10, 'AMPROBE', 'ninguna', 'noimage.jpg', 'N00018358', 0, '2013-05-02 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(160, 'PINZA AMPERIMETRICA AC /DC 54NAV', 10, 'AMPROBE', 'ninguna', 'noimage.jpg', 'N00018359', 0, '2014-04-21 14:44:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/160'),
	(161, 'PINZA AMPERIMETRICA AC /DC 54NAV', 10, 'AMPROBE', 'ninguna', 'noimage.jpg', 'N00018360', 0, '2013-05-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/161'),
	(162, 'MULTIMETRO 187 - IV', 10, 'FLUKE', '317B870', 'noimage.jpg', '00016884', 0, '2014-04-21 15:12:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/162'),
	(163, 'MULTIMETRO 187 - IV', 10, 'FLUKE', '317B870', 'noimage.jpg', '00016886', 0, '2001-03-01 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/163'),
	(164, 'MULTIMETRO 187 - IV', 10, 'FLUKE', '317B870', 'noimage.jpg', '00016887', 0, '2001-03-01 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/164'),
	(165, 'MULTIMETRO 187 - IV', 10, 'FLUKE', '317B870', 'noimage.jpg', '00016888', 0, '2001-03-01 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/165'),
	(166, 'MULTIMETRO 187 - IV', 10, 'FLUKE', '317B870', 'noimage.jpg', '00016889', 0, '2001-03-01 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/166'),
	(167, 'MULTIMETRO 187 - IV', 10, 'FLUKE', '317B870', 'noimage.jpg', '00016890', 0, '2001-03-01 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/167'),
	(168, 'FUENTE PODER CPS 250', 10, 'TEKTRONIX', '310B658', 'noimage.jpg', '00016952', 0, '2001-03-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/168'),
	(169, 'FUENTE PODER CPS 250', 10, 'TEKTRONIX', '310B658', 'noimage.jpg', '00016953', 0, '2001-03-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/169'),
	(170, 'FUENTE PODER CPS 250', 10, 'TEKTRONIX', '310B658', 'noimage.jpg', '00016954', 0, '2001-03-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/170'),
	(171, 'FUENTE PODER CPS 250', 10, 'TEKTRONIX', '310B658', 'noimage.jpg', '00016955', 0, '2001-03-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/171'),
	(172, 'FUENTE PODER CPS 250', 10, 'TEKTRONIX', '310B658', 'noimage.jpg', '00016956', 0, '2001-03-23 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/172'),
	(173, 'FUENTE PODER CPS 250', 10, 'TEKTRONIX', '310B658', 'noimage.jpg', '00016957', 0, '2001-03-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/173'),
	(174, 'FUENTE PODER CPS 250', 10, 'TEKTRONIX', '310B658', 'noimage.jpg', '00016958', 0, '2001-03-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/174'),
	(175, 'GENERADOR DE SENALES AFG 310', 10, 'TEKTRONIX', 'J313149', 'noimage.jpg', '00016960', 0, '2001-04-02 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(176, 'GENERADOR DE SENALES AFG310', 10, 'TEKTRONIX', 'J313147', 'noimage.jpg', '00016961', 0, '2001-04-02 12:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(177, 'GENERADOR DE SENALES AFG310', 10, 'TEKTRONIX', 'J313148', 'noimage.jpg', '00016962', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/177'),
	(178, 'GENERADOR DE SENALES AFG310', 10, 'TEKTRONIX', 'J313151', 'noimage.jpg', '000166963', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/178'),
	(179, 'GENERADOR DE SENALES AFG310', 10, 'TEKTRONIX', 'J313146', 'noimage.jpg', '00016964', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/179'),
	(180, 'GENERADOR DE SENALES AFG310', 10, 'TEKTRONIX', 'J313150', 'noimage.jpg', '00016965', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/180'),
	(181, 'GENERADOR DE SENALES AFG310', 10, 'TEKTRONIX', 'J313145', 'noimage.jpg', '00016966', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/181'),
	(182, 'GENERADOR DE SANALES AFG3021 B', 10, 'TEKTRONIX', 'C038292', 'noimage.jpg', 'N00015535', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/182'),
	(183, 'GENERADOR DE SENALES AFG3021B', 10, 'TEKTRONIX', 'CO38295', 'noimage.jpg', 'N000015536', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/183'),
	(184, 'GENERADOR DE SENALES AFG3021B', 10, 'TEKTRONIX', 'C038296', 'noimage.jpg', 'N00015537', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/184'),
	(185, 'GENERADOR DE SENALES AFG3021B', 10, 'TEKTRONIX', 'C038297', 'noimage.jpg', 'N00015538', 0, '2012-04-23 08:18:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/'),
	(186, 'GENERADOR DE SENALES AFG3021B', 10, 'TEKTRONIX', 'C038298', 'noimage.jpg', 'N00015539', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/186'),
	(187, 'GENERADOR DE SENALES AFG3021B', 10, 'TEKTRONIX', 'C038299', 'noimage.jpg', 'N00015540', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/187'),
	(188, 'GENERADOR DE SENALES AFG3021B', 10, 'TEKTRONIX', 'C038300', 'noimage.jpg', 'N00015541', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/188'),
	(189, 'GENERADOR DE SENALES AFG30', 10, 'TEKTRONIX', 'C010415', 'noimage.jpg', 'N00018361', 0, '2013-05-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/189'),
	(190, 'GENRADOR DE SENALES AFG30', 10, 'TEKTRONIX', 'C010436', 'noimage.jpg', 'N00018362', 0, '2013-05-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/190'),
	(191, 'OSCILOSCOPIO TDS 3012', 10, 'TEKTRONIX', 'B022237', 'noimage.jpg', '00016877', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/191'),
	(192, 'OSCILOSCOPIO TDS 3012', 10, 'TEKTRONIX', 'B022238', 'noimage.jpg', '00016878', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/192'),
	(193, 'OSCILOSCOPIO TDS 3012', 10, 'TEKTRONIX', 'B021853', 'noimage.jpg', '00016879', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/193'),
	(194, 'OSCILOSCOPIO TDS 3012', 10, 'TEKTRONIX', 'B022148', 'noimage.jpg', '00016880', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/194'),
	(195, 'OSCILOSCOPIO TDS 3012', 10, 'TEKTRONIX', 'B022157', 'noimage.jpg', '00016881', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/195'),
	(196, 'OSCILOSCOPIO TDS 3012', 10, 'TEKTRONIX', 'B021854', 'noimage.jpg', '00016882', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/196'),
	(197, 'OSCILOSCOPIO TDS 3012', 10, 'TEKTRONIX', 'B021736', 'noimage.jpg', '00016883', 0, '2001-04-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/197'),
	(198, 'OSCILOSCOPIO DIGITAL UT81B', 10, 'UNI-T', '1080347110', 'noimage.jpg', 'N00006838', 0, '2008-09-01 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/198'),
	(199, 'OSCILOSCOPIOS DIGITAL TDS2012C', 10, 'TEKTRONIX', 'C020214', 'noimage.jpg', 'N00015528', 0, '2012-04-24 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/199'),
	(200, 'OSCILOSCOPIO DIGITAL TDS 2012C', 10, 'TEKTRONIX', 'C00218', 'noimage.jpg', 'N00015529', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/200'),
	(201, 'OSCILOSCOPIO DIGITAL TDS2012C', 10, 'TEKTRONIX', 'C020224', 'noimage.jpg', 'N00015530', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/201'),
	(202, 'OSCILOSCOPIO DIGITAL TDS2012C', 10, 'TEKTRONIX', 'C020232', 'noimage.jpg', 'N000015531', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/202'),
	(203, 'OSCILOSCOPIO DIGITAL TDS2012C', 10, 'TEKTRONIX', 'C020238', 'noimage.jpg', 'N00015532', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/203'),
	(204, 'OSCILOSCOPIO DIGITAL TDS2012C', 10, 'TEKTRONIX', 'C020249', 'noimage.jpg', 'N00015533', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/204'),
	(205, 'OSCILOSCOPIO DIGITAL TDS2012C', 10, 'TEKTRONIX', 'C020254', 'noimage.jpg', 'N00015534', 0, '2012-04-23 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/205'),
	(206, 'OSCILOSCOPIO DIGITAL TDS2012C', 10, 'TEKTRONIX', 'C030272', 'noimage.jpg', 'N00018363', 0, '2013-05-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/206'),
	(207, 'OSCILOSCOPIO DIGITAL TDS2012C', 10, 'TEKTRONIX', 'C030404', 'noimage.jpg', 'N00018364', 0, '2013-05-02 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/207'),
	(208, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'TEKTRONIX', 'ninguna', 'noimage.jpg', '1', 0, '2013-11-20 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/208'),
	(209, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'TEKTRONIX', 'ninguna', 'noimage.jpg', '2', 0, '2013-11-20 12:00:00', 1, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/209'),
	(210, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'TEKTRONIX', 'ninguna', 'noimage.jpg', '3', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/210'),
	(211, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'TEKTRONIX', 'ninguna', 'noimage.jpg', '4', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/211'),
	(212, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'TEKTRONIX', 'ninguna', 'noimage.jpg', '5', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/212'),
	(213, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'TEKTRONIX', 'ninguna', 'noimage.jpg', '6', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/213'),
	(214, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'TEKTRONIX', 'ninguna', 'noimage.jpg', '7', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/214'),
	(215, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'TEKTRONIX', 'ninguna', 'noimage.jpg', '8', 0, '2014-04-28 15:16:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/215'),
	(216, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'TEKTRONIX', 'ninguna', 'noimage.jpg', '9', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/216'),
	(217, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'TEKTRONIX', 'ninguna', 'noimage.jpg', '10', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/217'),
	(218, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'POMONA', 'ninguna', 'noimage.jpg', '1', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/218'),
	(219, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'POMONA', 'ninguna', 'noimage.jpg', '2', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/219'),
	(220, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'POMONA', 'ninguna', 'noimage.jpg', '3', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/220'),
	(221, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'POMONA', 'ninguna', 'noimage.jpg', '4', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/221'),
	(222, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'POMONA', 'ninguna', 'noimage.jpg', '5', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/222'),
	(223, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'POMONA', 'ninguna', 'noimage.jpg', '6', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/223'),
	(224, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'POMONA', 'ninguna', 'noimage.jpg', '7', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/224'),
	(225, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'POMONA', 'ninguna', 'noimage.jpg', '8', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/225'),
	(226, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'POMONA', 'ninguna', 'noimage.jpg', '9', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/226'),
	(227, 'PUNTA DE OSCILOSCOPIO CON CAPERUZA', 10, 'POMONA', 'ninguna', 'noimage.jpg', '10', 0, '2013-11-20 00:00:00', 0, 1, 'C:Archivos de programaApache Software FoundationTomcat 7.0webappsSIPLQR/227');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.multa: ~10 rows (aproximadamente)
DELETE FROM `multa`;
/*!40000 ALTER TABLE `multa` DISABLE KEYS */;
INSERT INTO `multa` (`codigo`, `cod_usuario`, `fecha_multa`, `estado_multa`, `tiempo_multa`) VALUES
	(2, '456', '2014-03-09 07:34:02', 1, 3),
	(3, 'U00061264', '2014-03-09 07:35:00', 1, 3),
	(4, '000', '2014-03-15 10:18:13', 1, 3),
	(5, '000', '2014-04-04 14:59:49', 1, 3),
	(6, '000', '2014-04-04 15:04:46', 1, 3),
	(7, 'U00062808', '2014-04-08 12:12:05', 1, 3),
	(8, 'u00061264', '2014-04-11 15:49:09', 1, 3),
	(9, 'U00057571', '2014-04-28 11:02:01', 0, 3),
	(10, 'U00060829', '2014-04-28 11:43:19', 0, 3),
	(11, 'U00071626', '2014-04-28 14:08:27', 1, 3);
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.prestamo: ~39 rows (aproximadamente)
DELETE FROM `prestamo`;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
INSERT INTO `prestamo` (`codigo`, `cod_material`, `cod_usuario`, `fecha_prestamo`, `fecha_devolucion`, `estado`) VALUES
	(1, '1', 'U00057132', '2013-02-23 22:21:08', '2013-03-23 22:21:19', 1),
	(2, '2', 'U00057132', '2013-04-20 22:21:41', '2014-04-13 22:21:55', 1),
	(3, '1;2', 'U00057132', '2014-02-23 11:08:23', '2014-02-24 11:08:23', 1),
	(5, '80', '123', '2014-02-01 05:18:05', '2014-03-01 05:18:50', 1),
	(6, '82', '456', '2014-03-01 06:20:47', '2014-03-09 07:34:02', 1),
	(7, '33', 'U00061264', '2014-02-09 07:33:32', '2014-03-09 07:35:00', 1),
	(8, '12', '123', '2014-03-12 12:00:16', '2014-03-15 12:00:16', 1),
	(9, '1;23', '000', '2014-03-12 12:45:15', '2014-03-15 10:18:13', 1),
	(10, '123', '000', '2014-03-24 09:17:56', '2014-03-24 09:18:49', 1),
	(11, '77;64;88;106;13;105;99;', '000', '2014-03-31 15:53:07', '2014-03-31 16:02:07', 1),
	(12, '17;', '000', '2014-03-31 16:03:26', '2014-03-31 16:04:07', 1),
	(13, '67;82;', '000', '2014-03-31 16:05:01', '2014-04-03 11:20:35', 1),
	(14, '87;', 'U00062808', '2014-04-04 14:29:21', '2014-04-08 12:12:05', 1),
	(15, '50', '000', '2014-04-04 14:59:20', '2014-04-04 14:59:49', 1),
	(16, '50', '000', '2014-04-04 15:02:46', '2014-04-04 15:04:46', 1),
	(17, '14;', '000', '2014-04-04 15:09:39', '2014-04-04 15:13:41', 1),
	(18, '50;', '000', '2014-04-04 15:13:56', '2014-04-04 15:14:03', 1),
	(19, '15;', 'U00072372', '2014-04-04 16:07:59', '2014-04-08 16:07:59', 1),
	(20, '18;', 'u00061264', '2014-04-09 15:44:46', '2014-04-11 15:49:09', 1),
	(21, '87;', 'U00071626', '2014-04-21 11:52:14', '2014-04-21 11:55:29', 1),
	(22, '37;', 'U00071626', '2014-04-21 11:57:09', '2014-04-21 12:00:33', 1),
	(23, '37;', 'U00071626', '2014-04-21 12:00:59', '2014-04-28 14:08:27', 1),
	(24, '86;', 'U00061338', '2014-04-21 12:05:43', '2014-04-23 12:05:43', 0),
	(25, '38;39;', 'U00061487', '2014-04-21 12:08:47', '2014-04-23 12:08:47', 0),
	(26, '40;', 'U00057006', '2014-04-21 14:27:08', '2014-04-26 14:27:08', 0),
	(27, '131;', 'U00016473', '2014-04-21 14:55:54', '2014-04-21 16:42:18', 1),
	(28, '128;', 'U00058297', '2014-04-21 15:06:14', '2014-04-22 15:06:14', 0),
	(29, '41;42;', 'U00061709', '2014-04-21 16:10:40', '2014-04-22 16:10:40', 0),
	(30, '172;', 'U00072423', '2014-04-21 16:11:15', '2014-04-22 10:55:43', 1),
	(31, '43;', 'U00057571', '2014-04-21 16:15:42', '2014-04-28 11:02:01', 1),
	(32, '80;', 'U00071373', '2014-04-22 12:13:58', '2014-04-24 12:13:58', 0),
	(33, '130;', 'U00060829', '2014-04-23 10:42:10', '2014-04-28 11:43:19', 1),
	(34, '126;', 'U00078994', '2014-04-23 12:07:47', '2014-04-23 15:56:55', 1),
	(35, '122;', 'U00078994', '2014-04-24 15:05:51', '2014-04-25 15:05:51', 0),
	(36, '121;126;', 'U00072107', '2014-04-24 15:22:08', '2014-04-24 15:29:47', 1),
	(37, '121;118;', 'U00072107', '2014-04-24 17:39:15', '2014-04-25 17:39:15', 0),
	(38, '124;', 'U00071626', '2014-04-25 11:41:21', '2014-04-28 11:41:21', 0),
	(39, '126;', 'U00072372', '2014-04-28 16:54:37', '2014-04-30 16:54:37', 0),
	(40, '117;120;19;37;208;209;', 'U00071626', '2014-04-28 17:06:15', '2014-05-02 17:06:15', 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.reserva: ~10 rows (aproximadamente)
DELETE FROM `reserva`;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` (`codigo`, `cod_usuario`, `estado`, `fecha_reserva`, `cod_material`) VALUES
	(1, '123', 1, '2014-03-08 23:38:26', '37'),
	(2, '123', 1, '2014-03-09 12:28:40', '28'),
	(4, '000', 1, '2014-03-11 10:59:20', '112;1'),
	(5, '000', 1, '2014-03-12 12:38:08', '1;23'),
	(6, '000', 1, '2014-03-15 10:18:56', '32'),
	(7, '000', 1, '2014-03-24 09:15:43', '123'),
	(8, '000', 1, '2014-03-24 09:16:39', '123'),
	(9, '000', 1, '2014-03-25 11:50:52', '1;145'),
	(10, '000', 1, '2014-04-04 14:58:28', '50'),
	(11, '000', 1, '2014-04-04 15:02:03', '50');
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
	(1, 'PROTOBOARD', 'Es un tablero con orificios conectados eléctricamente entre sí, habitualmente siguiendo patrones de líneas, en el cual se pueden insertar componentes electrónicos y cables para el armado y prototipado de circuitos electrónicos ', 15, 15),
	(2, 'EQUIPOS DE COMPUTO', 'ninguno', 1, 1),
	(3, 'TARJETAS DE DESARROLLO', 'ninguno', 22, 18),
	(4, 'EQUIPOS DE CONTROL', 'ninguno', 10, 10),
	(5, 'CABLE Y CONECTOR', 'ninguno', 20, 20),
	(6, 'MOTOR', 'ninguno', 7, 1),
	(7, 'SENSORES Y ACTUADORES', 'ninguno', 8, 8),
	(8, 'ELECTRICO', 'ninguno', 14, 14),
	(9, 'HERRAMIENTA SOLDAR', 'ninguno', 10, 10),
	(10, 'EQUIPO DE MEDICION Y GENERACION DE SEÑALES', 'ninguno', 118, 108),
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

-- Volcando datos para la tabla siprelab.usuario: ~47 rows (aproximadamente)
DELETE FROM `usuario`;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`codigo`, `nombre`, `apellido`, `telefono`, `correo`, `estado`, `tipo_usuario`, `observaciones`, `clave`) VALUES
	('000', 'Estudiante', 'Prueba', 156324, 'prueba@unab.gol.co', 0, 0, 'Testeando el aplicativo web 123', 'c6f057b86584942e415435ffb1fa93d4'),
	('1098652414', 'Rocio', 'Pabon', 0, 'jpabon281@unab.edu.co', 0, 2, '', '7b1ce3d73b70f1a7246e7b76a35fb552'),
	('123', 'Juan Carlos', 'Garcia Ojeda', 0, 'jgarciao@unab.edu.co', 0, 2, 'Docente facultad ingenieria de sistemas', '202cb962ac59075b964b07152d234b70'),
	('456', 'Freddy', 'Mendez Ortiz', 0, 'fmendez@unab.edu.co', 0, 2, 'Docente facultad ingenieria de sistemas', '250cf8b51c773f3f8dc8b4be867a9a02'),
	('789', 'Daniel', 'Arenas Seleey', 0, 'darenass@unab.edu.co', 0, 2, 'Docente facultad ingenieria de sistemas', '68053af2923e00204c3ca7c6a3150cf7'),
	('local', 'administrador local', 'prueba', 0, '159', 0, 1, 'Testeando como administrador local el programa', 'f5ddaf0ca7929578b408c909429f68f2'),
	('U00016473', 'MANUEL ALONSO', 'ENCISO CALA', 0, 'menciso@unab.edu.co', 0, 0, '', '788f16884459ee90ba76a424be8fe7fd'),
	('U00021306', 'EDUARDO AMADOR', 'CORONADO CARDONA', 0, 'ecoronado@unab.edu.co', 0, 0, '', '36356943e906691708569486bba8f351'),
	('U00038997', 'JHON ALEXANDER ', 'GUALDRON', 0, 'jgualdron4@unab.edu.co', 0, 0, '', '6075cc5a7d32fec498ffd5729494dc69'),
	('U00051158', 'ANDRES FELIPE', 'MAYORGA GAHONA', 3168784100, 'amoyorga2@unab.edu.co', 0, 0, '', '35d57a27512e60f2a62aba83e2ed607b'),
	('U00057006', 'RUBEN DARIO', 'MORALES BAUTISTA', 3157272636, 'rmorales4@unab.edu.co', 2, 0, '', 'efadc04bd1417ef1ab2a46537bfb2579'),
	('U00057132', 'Sandra Milena', 'Vera Gomez', 12345, 'svera5@unab.edu.co', 0, 2, '', 'b8a125c27f91a0dbb77a2df5fc40baa9'),
	('U00057571', 'JORGE ELIECER', 'RANGEL VERA', 0, 'jrangel22@unab.edu.co', 4, 0, '', '47f336713f3c33b71750bdb4bce39110'),
	('U00058297', 'JONATAN FERNANDO', 'CASTELLANOS HERNANDEZ', 0, 'jcastellanos10@unab.edu.co', 2, 0, '', '0edb510144b1bbefa8f3dd4ba2fe5c44'),
	('U00058584', 'ANDERSON JAIR', 'BAUTISTA DELGADO', 3213717659, 'abautista7@unab.edu.co', 0, 0, '', '068691e81fe1938e00de3e46a841d051'),
	('U00060829', 'DALYA JULIETH', 'GALVIS PARADA', 3168025281, 'dgalvis34@unab.edu.co', 4, 0, '', 'bd6487b88a03cfb6c2b23ae3cc842327'),
	('U00061149', 'FRANCISCO JAVIER', 'ANGARITA DIAZ', 0, 'fangarita2@unab.edu.co', 0, 0, '', 'f4b49b6b03884a82993ab6918c5f8f63'),
	('U00061264', 'Wilmar', 'González Franco', 0, 'wgonzalez@unab.edu.co', 0, 2, 'ninguna', '827ccb0eea8a706c4c34a16891f84e7b'),
	('U00061338', 'ANDRES YESID', 'MARTINEZ ARDILA', 3166357658, 'amartinez2@unab.edu.co', 2, 0, '', 'f6cfa4d28e5ca0a5bfb4afda731ccccc'),
	('U00061487', 'AIDER', 'PLATA QUINTERO', 3114385106, 'aplata75@unab.edu.co', 2, 0, '', 'f77365f19d0ee30b6e4bd628faf11681'),
	('U00061575', 'JULIAN DAVID', 'MANTILLA BLANCO', 0, 'jmantilla26@unab.edu.co', 0, 0, '', '7c786952840f1e69869da4e40b831d18'),
	('U00061709', 'JAVIER MARIO', 'QUINTERO', 3144861536, 'jquintero20@unab.edu.co', 2, 0, '', 'e30a8fb75a81bdb53c1b68bef5dceb26'),
	('U00061926', 'DAVID RICARDO', 'SUAREZ ALZA', 0, 'dsuarez9@unab.edu.co', 0, 0, '', 'a9741684c21bd3f143fdac3267e9a077'),
	('U00062050', 'JESUS ERNESTO', 'MONSALVE CARABALLO', 3013569884, 'jmonsalve11@unab.edu.co', 0, 0, '', '04a6f11189028b6f1d8244cb8a0803d0'),
	('U00062808', 'JOSE IGNACIO', 'TRAPERO VILLARREAL', 0, 'jtrapero@unab.edu.co', 0, 0, '', 'c06c4acbd66e816e863a70c09cdce138'),
	('U00062871', 'JESSICA PAOLA', 'AZA MANTILLA', 0, 'jaza@unab.edu.co', 0, 0, '', '170c35e5562a88c744642f76f63bd866'),
	('U00062890', 'PAOLA MARCELA', 'CACERES', 0, 'pcaceres13@unab.edu.co', 0, 0, '', '53fe95ea27065dd04535f3c88611041d'),
	('U00067421', 'JULIANA DE LOS ANGELES', 'CASTELLANOS CASTILLA', 0, 'jcastellanos88@unab.edu.co', 0, 0, '', 'a6d78565f60b01727bf2cb0adfde55d5'),
	('U00069009', 'OLMER GIOVANNY', 'VILLAMIZAR GALVIS', 0, 'ovillamizar10@unab.edu.co', 0, 0, '', 'a67bf731250430b9a8bc582d1ace5d93'),
	('U00069634', 'DANIEL FELIPE', 'LEON CARDONA', 3123621158, 'dleon41@unab.edu.co', 0, 0, '', '32232fa61e6ec4831155ea030d5493b6'),
	('U00071262', 'LUISA FERNANDA', 'PINTO VASQUEZ', 3213442814, 'lpinto12@unab.edu.co', 0, 0, '', '41337c91ae3186a9eb9a676fbedf1385'),
	('U00071341', 'RAUL ROQUE', 'DI MARCO D SILVA', 3186954664, 'rdi@unab.edu.co', 0, 0, '', '33fe684815d1d9d32b70d4c756a5841c'),
	('U00071373', 'JEFERSSON SNEIDER', 'PULIDO CONDIA', 0, 'jpulido23@unab.edu.co', 2, 0, '', '63dcfd61a61b90cce1cc4d4479774ecd'),
	('U00071626', 'JHON CESAR OSWALDO', 'RODRIGUEZ REINEMER', 3106329992, 'jrodriguez86@unab.edu.co', 2, 0, '', '10490a2b6a81fe450a2153c04b223fa5'),
	('U00072107', 'ORLANDO FABIO', 'CORREA VECINO', 3102520858, 'ocorrea55@unab.edu.co', 2, 0, '', '9568ea1f4b1057f317d4d76c45e94725'),
	('U00072372', 'VERONICA ANDREA', 'GALEANO BLANCO', 3213813060, 'vgaleano@unab.edu.co', 2, 0, '', '4e4b572b61aef94b587f8b42ed789577'),
	('U00072423', 'JULIAN ANDRES', 'SERRANO PABON', 3188013212, 'jserrano155@unab.edu.co', 0, 0, '', 'c85aedb7c7dca3f8dab0d1accd443cb3'),
	('U00072596', 'ALVARO JULIAN', 'GONZALEZ CARDENAS', 0, 'agonzalez79@unab.edu.co', 0, 0, '', 'b6c93cdaea76b15efce9898ec9c3941f'),
	('U00073093', 'JUAN SEBASTIAN', 'RIVERA CABEZAS', 0, 'jrivera36@unab.edu.co', 0, 0, '', '88154a762d3064197a782b377fe1f6b7'),
	('U00073102', 'CRISTIAN LEONARDO', 'HERRERA ACOSTA', 0, 'cherrera57@unab.edu.co', 0, 0, '', '9fe1cf5bfa7c1d97f378e7789be18585'),
	('U00075541', 'SAID YAMIL', 'GANDUR ADARME', 3164329419, 'sgandur@unab.edu.co', 0, 0, '', '909e42511e582214b45381cad8c356f7'),
	('U00078994', 'JUAN SEBASTIAN', 'CASTANEDA DIAZ', 0, 'jcastaneda710@unab.edu.co', 2, 0, '', 'd7a56a309e9ffdf6d54560c630371d30'),
	('U00079226', 'GILMAR HERNANDO', 'TUTA NAVAJAS', 3212542924, 'gtuta@unab.edu.co', 0, 0, '', 'c981b35e1e1899faaf452ae59ab46249'),
	('U00079789', 'MARTHA PATRICIA', 'FORERO CARRILLO', 0, 'mforero261@unab.edu.co', 0, 0, '', '6fe520c5c908183f4441847d42e1ddf2'),
	('U00080493', 'LEMNEC ', 'TILLER AVELLANEDA', 0, 'ltiller@unab.edu.co', 0, 0, '', '97cd069575fb3a33fc92ed756de0046d'),
	('U00084229', 'JAIRO IVAN', 'SERRANO GOMEZ', 0, 'jserrano51@unab.edu.co', 0, 0, '', '73989d9fa1582abdc4ebc23bb85c76e8'),
	('U00086281', 'CRISTIAN FABIAN', 'JAIMES SAAVEDRA', 0, 'cjaimes64@unab.edu.co', 0, 0, '', 'e5305399d16a7f3d58b2e830f17ff691');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;


-- Volcando estructura para tabla siprelab.variable_sistema
DROP TABLE IF EXISTS `variable_sistema`;
CREATE TABLE IF NOT EXISTS `variable_sistema` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `datos` varchar(300) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla siprelab.variable_sistema: ~5 rows (aproximadamente)
DELETE FROM `variable_sistema`;
/*!40000 ALTER TABLE `variable_sistema` DISABLE KEYS */;
INSERT INTO `variable_sistema` (`id`, `datos`, `descripcion`) VALUES
	(1, 'C:\\Archivos de programa\\Apache Software Foundation\\Tomcat 7.0\\webapps\\SIPL\\', 'Ubicación del sistema'),
	(2, 'C:\\Archivos de programa\\MySQL\\MySQL Server 5.5\\bin\\', 'Ubicación de Mysql en el disco duro'),
	(3, 'root', 'usuario Mysql'),
	(4, 'q-j8$mr5.L', 'clave Mysql'),
	(5, '12345', 'ApiKey para comunicacion con el WebService');
/*!40000 ALTER TABLE `variable_sistema` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

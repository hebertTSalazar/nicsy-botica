CREATE DATABASE  IF NOT EXISTS `nicsy_botica` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `nicsy_botica`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: nicsy_botica
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `boletas`
--

DROP TABLE IF EXISTS `boletas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boletas` (
  `id_boleta` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `numero_incremental` int NOT NULL,
  `pdf` longblob,
  PRIMARY KEY (`id_boleta`),
  UNIQUE KEY `numero_incremental` (`numero_incremental`),
  KEY `id_venta` (`id_venta`),
  CONSTRAINT `boletas_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletas`
--

LOCK TABLES `boletas` WRITE;
/*!40000 ALTER TABLE `boletas` DISABLE KEYS */;
INSERT INTO `boletas` VALUES (1,1,1,NULL),(2,2,2,NULL),(3,3,3,NULL),(4,4,4,NULL),(5,5,5,NULL),(6,6,6,NULL),(7,7,7,NULL),(8,8,8,NULL),(9,9,9,NULL),(10,10,10,NULL),(11,11,11,NULL),(12,12,12,NULL),(13,13,13,NULL),(14,14,14,NULL),(15,15,15,NULL),(16,16,16,NULL),(17,17,17,NULL),(18,18,18,NULL);
/*!40000 ALTER TABLE `boletas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `dni` char(8) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `dni` (`dni`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (6,11,'76854178','985346712','Joel@hotmail.com'),(7,17,'79841635','908246812','rios@hotmail.com'),(8,18,'76491872','907843517','mabel@hotmail.com'),(9,19,'49758172','907548711','Anel@hotmail.com'),(10,21,'16784397','947841578','rosa@hotmail.com'),(11,22,'78417584','908528476','manuel@hotmail.com'),(12,23,'79482678','976384196','jhon@hotmail.com'),(13,4,'73541542','981090000','anel@hotmail.com');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalleventa`
--

DROP TABLE IF EXISTS `detalleventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalleventa` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_venta` (`id_venta`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `detalleventa_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`),
  CONSTRAINT `detalleventa_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalleventa`
--

LOCK TABLES `detalleventa` WRITE;
/*!40000 ALTER TABLE `detalleventa` DISABLE KEYS */;
INSERT INTO `detalleventa` VALUES (1,1,11,1,18.00),(2,2,11,2,36.00),(3,3,11,3,54.00),(4,3,15,2,206.00),(5,3,9,1,2.50),(6,3,8,1,3.00),(10,4,6,1,1.50),(11,4,15,2,206.00),(13,5,28,7,3.50),(14,6,13,1,15.00),(15,6,12,1,49.00),(17,7,16,2,127.00),(18,8,14,3,26.10),(19,9,11,1,18.00),(20,10,28,9,4.50),(21,11,8,1,3.00),(22,12,16,1,63.50),(23,13,28,3,1.50),(24,14,25,1,10.00),(25,15,9,1,2.50),(26,16,25,4,40.00),(27,16,9,1,2.50),(29,17,11,1,18.00),(30,17,9,1,2.50),(31,17,8,1,3.00),(32,17,28,1,0.50),(36,18,9,1,2.50);
/*!40000 ALTER TABLE `detalleventa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direccionescliente`
--

DROP TABLE IF EXISTS `direccionescliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direccionescliente` (
  `id_direccion` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `referencia` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_direccion`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `direccionescliente_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccionescliente`
--

LOCK TABLES `direccionescliente` WRITE;
/*!40000 ALTER TABLE `direccionescliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `direccionescliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listaconteo`
--

DROP TABLE IF EXISTS `listaconteo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `listaconteo` (
  `id_conteo` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `fecha` date NOT NULL,
  `cantidad_real` int NOT NULL,
  `observacion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_conteo`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `listaconteo_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listaconteo`
--

LOCK TABLES `listaconteo` WRITE;
/*!40000 ALTER TABLE `listaconteo` DISABLE KEYS */;
/*!40000 ALTER TABLE `listaconteo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lotes`
--

DROP TABLE IF EXISTS `lotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lotes` (
  `id_lote` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id_lote`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `lotes_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lotes`
--

LOCK TABLES `lotes` WRITE;
/*!40000 ALTER TABLE `lotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `lotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientosstock`
--

DROP TABLE IF EXISTS `movimientosstock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientosstock` (
  `id_movimiento` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `id_lote` int DEFAULT NULL,
  `tipo` enum('Entrada','Salida') NOT NULL,
  `cantidad` int NOT NULL,
  `fecha` datetime NOT NULL,
  `referencia` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_movimiento`),
  KEY `id_producto` (`id_producto`),
  KEY `id_lote` (`id_lote`),
  CONSTRAINT `movimientosstock_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `movimientosstock_ibfk_2` FOREIGN KEY (`id_lote`) REFERENCES `lotes` (`id_lote`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientosstock`
--

LOCK TABLES `movimientosstock` WRITE;
/*!40000 ALTER TABLE `movimientosstock` DISABLE KEYS */;
INSERT INTO `movimientosstock` VALUES (1,11,NULL,'Salida',1,'2025-11-28 20:36:23','Venta 1'),(2,11,NULL,'Salida',2,'2025-11-28 21:25:02','Venta 2'),(3,11,NULL,'Salida',3,'2025-11-28 21:35:20','Venta 3'),(4,15,NULL,'Salida',2,'2025-11-28 21:35:20','Venta 3'),(5,9,NULL,'Salida',1,'2025-11-28 21:35:20','Venta 3'),(6,8,NULL,'Salida',1,'2025-11-28 21:35:20','Venta 3'),(10,6,NULL,'Salida',1,'2025-12-01 22:10:42','Venta 4'),(11,15,NULL,'Salida',2,'2025-12-01 22:10:42','Venta 4'),(13,28,NULL,'Salida',7,'2025-12-01 22:44:55','Venta 5'),(14,13,NULL,'Salida',1,'2025-12-01 23:20:09','Venta 6'),(15,12,NULL,'Salida',1,'2025-12-01 23:20:09','Venta 6'),(17,16,NULL,'Salida',2,'2025-12-01 23:51:54','Venta 7'),(18,14,NULL,'Salida',3,'2025-12-02 00:00:00','Venta 8'),(19,11,NULL,'Salida',1,'2025-12-02 00:00:50','Venta 9'),(20,28,NULL,'Salida',9,'2025-12-02 00:17:29','Venta 10'),(21,8,NULL,'Salida',1,'2025-12-02 00:30:30','Venta 11'),(22,16,NULL,'Salida',1,'2025-12-02 00:54:17','Venta 12'),(23,28,NULL,'Salida',3,'2025-12-02 01:15:12','Venta 13'),(24,25,NULL,'Salida',1,'2025-12-02 01:31:02','Venta 14'),(25,9,NULL,'Salida',1,'2025-12-02 02:08:29','Venta 15'),(26,25,NULL,'Salida',4,'2025-12-02 02:10:42','Venta 16'),(27,9,NULL,'Salida',1,'2025-12-02 02:10:42','Venta 16'),(29,11,NULL,'Salida',1,'2025-12-02 19:41:05','Venta 17'),(30,9,NULL,'Salida',1,'2025-12-02 19:41:05','Venta 17'),(31,8,NULL,'Salida',1,'2025-12-02 19:41:05','Venta 17'),(32,28,NULL,'Salida',1,'2025-12-02 19:41:05','Venta 17'),(36,9,NULL,'Salida',1,'2025-12-02 19:51:27','Venta 18');
/*!40000 ALTER TABLE `movimientosstock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `id_pago` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `metodo` enum('Efectivo','Tarjeta','Yape/Plin') NOT NULL,
  `estado` enum('Pendiente','Pagado','Anulado') DEFAULT 'Pendiente',
  PRIMARY KEY (`id_pago`),
  KEY `id_venta` (`id_venta`),
  CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (1,1,'Yape/Plin','Pagado'),(2,2,'Yape/Plin','Pagado'),(3,3,'Yape/Plin','Pagado'),(4,4,'Yape/Plin','Pagado'),(5,5,'Yape/Plin','Pagado'),(6,6,'Yape/Plin','Pagado'),(7,7,'Yape/Plin','Pagado'),(8,8,'Yape/Plin','Pagado'),(9,9,'Yape/Plin','Pagado'),(10,10,'Yape/Plin','Pagado'),(11,11,'Yape/Plin','Pagado'),(12,12,'Yape/Plin','Pagado'),(13,13,'Yape/Plin','Pagado'),(14,14,'Yape/Plin','Pagado'),(15,15,'Yape/Plin','Pagado'),(16,16,'Yape/Plin','Pagado'),(17,17,'Yape/Plin','Pagado'),(18,18,'Yape/Plin','Pagado');
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `fecha` datetime NOT NULL,
  `estado` enum('Pendiente','Confirmado','Cancelado') DEFAULT 'Pendiente',
  `total` decimal(8,2) NOT NULL,
  `metodo_entrega` enum('Delivery','Recojo') NOT NULL DEFAULT 'Recojo',
  `costo_delivery` decimal(6,2) NOT NULL DEFAULT '0.00',
  `direccion_entrega` varchar(200) DEFAULT NULL,
  `referencia_entrega` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,6,'2025-11-28 20:36:23','Confirmado',18.00,'Recojo',0.00,'',''),(2,7,'2025-11-28 21:25:02','Confirmado',36.00,'Recojo',0.00,'',''),(3,7,'2025-11-28 21:35:19','Confirmado',265.50,'Recojo',0.00,'',''),(4,8,'2025-12-01 22:10:42','Confirmado',207.50,'Delivery',0.00,'calle los jardines','Frente a iglesia adventista'),(5,9,'2025-12-01 22:44:55','Confirmado',3.50,'Recojo',0.00,'',''),(6,10,'2025-12-01 23:20:09','Confirmado',64.00,'Recojo',0.00,'',''),(7,10,'2025-12-01 23:51:54','Confirmado',127.00,'Recojo',0.00,'',''),(8,10,'2025-12-01 23:59:59','Confirmado',26.10,'Recojo',0.00,'',''),(9,11,'2025-12-02 00:00:50','Confirmado',18.00,'Recojo',0.00,'',''),(10,12,'2025-12-02 00:17:29','Confirmado',4.50,'Recojo',0.00,'',''),(11,12,'2025-12-02 00:30:29','Confirmado',3.00,'Recojo',0.00,'',''),(12,12,'2025-12-02 00:54:17','Confirmado',63.50,'Recojo',0.00,'',''),(13,12,'2025-12-02 01:15:12','Confirmado',1.50,'Recojo',0.00,'',''),(14,12,'2025-12-02 01:31:02','Confirmado',10.00,'Recojo',0.00,'',''),(15,13,'2025-12-02 02:08:29','Confirmado',7.50,'Delivery',5.00,'Los Dormilones 123','frente al estadio Garces'),(16,13,'2025-12-02 02:10:42','Confirmado',42.50,'Recojo',0.00,'',''),(17,13,'2025-12-02 19:41:05','Confirmado',24.00,'Recojo',0.00,'',''),(18,13,'2025-12-02 19:51:27','Confirmado',7.50,'Delivery',5.00,'los sauces','Frente al estadio Miguel Grau');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_detalle`
--

DROP TABLE IF EXISTS `pedidos_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_detalle` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `pedidos_detalle_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `pedidos_detalle_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_detalle`
--

LOCK TABLES `pedidos_detalle` WRITE;
/*!40000 ALTER TABLE `pedidos_detalle` DISABLE KEYS */;
INSERT INTO `pedidos_detalle` VALUES (1,1,11,1,18.00),(2,2,11,2,36.00),(3,3,11,3,54.00),(4,3,15,2,206.00),(5,3,9,1,2.50),(6,3,8,1,3.00),(7,4,6,1,1.50),(8,4,15,2,206.00),(9,5,28,7,3.50),(10,6,13,1,15.00),(11,6,12,1,49.00),(12,7,16,2,127.00),(13,8,14,3,26.10),(14,9,11,1,18.00),(15,10,28,9,4.50),(16,11,8,1,3.00),(17,12,16,1,63.50),(18,13,28,3,1.50),(19,14,25,1,10.00),(20,15,9,1,2.50),(21,16,25,4,40.00),(22,16,9,1,2.50),(23,17,11,1,18.00),(24,17,9,1,2.50),(25,17,8,1,3.00),(26,17,28,1,0.50),(27,18,9,1,2.50);
/*!40000 ALTER TABLE `pedidos_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `categoria` enum('Nutrición','Cuidado personal','Salud') NOT NULL,
  `precio` decimal(6,2) NOT NULL,
  `descripcion` text,
  `stock` int NOT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (6,'Paracetamol 500mg','Salud',1.50,'Analgesico y antipirético',99,'img/paracetamol generico.jpg'),(8,'Amoxicilina 500mg/5 ml','Salud',3.00,'Antibiótico de amplio espectro',97,'img/amoxicilina.jpg'),(9,'Clorfenamina Maleato 2mg/5ml','Salud',2.50,'Antihistamínico para alergias',95,'img/clorfenamina.jpeg'),(11,'Dermocane Crema 100ml','Cuidado personal',18.00,'Crema hidratante para piel sensible',92,'img/Dermoacne.jpg'),(12,'Huggies Natural Care','Cuidado personal',49.00,'Pañales XG',99,'img/huggies.jpg'),(13,'Jabón Rejuvenece','Cuidado personal',15.00,'Jabón a base de arroz y acido hialuronico',99,'img/jabonRejuvenece.jpeg'),(14,'Mascarilla 3 pliegues','Cuidado personal',8.70,'Mascarilla médica',97,'img/mascarillas.jpg'),(15,'Ensure Plus Vainilla850g','Nutrición',103.00,'Suplemento nutricional completo para adultos',96,'img/ensure.webp'),(16,'Glucosamina 900mg','Nutrición',63.50,'Ayuda a fortalecer las articulaciones',97,'img/glucosamina.jpg'),(18,'Nutriamec Adulto','Nutrición',100.00,'Bebida nutricional balanceada para adultos mayores',100,'img/nutriamec-adulto.jpg'),(19,'Nutriamec Kids','Nutrición',85.00,'Suplemento infantil multivitamínico',100,'img/nutriamec-kids.jpg'),(21,'Panadol Niños 160mg/5ml','Salud',14.50,'Jarabe',50,'img/panadol niños.jpg'),(23,'Redoxon 1g','Nutrición',13.00,'Tabletas efervescentes',120,'img/redoxon.webp'),(24,'Pedialyte Solución 500ml','Nutrición',6.00,'Solución hidratante oral con electrolitos',40,'img/pedialyte.jpeg'),(25,'Magnesol C','Salud',10.00,'Vitamina C',95,'img/magnesol.jpg'),(26,'Lactulosa 3,3g/5ml','Salud',7.50,'Solución vía oral',80,'img/lactulosa.jpg'),(27,'Tapsin Migraña','Salud',2.50,'Migraña',50,'img/tapsin.jpeg'),(28,'Alkhofar / Jeringas esteriles','Salud',0.50,'Jeringas descartables',30,'img/jeringas.jpg');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `rol` enum('Administrador','Cajero','Cliente') NOT NULL,
  `estado` enum('Pendiente','Verificado','Bloqueado') NOT NULL DEFAULT 'Verificado',
  `nombre_usuario` varchar(50) NOT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `dni` char(8) DEFAULT NULL,
  `edad` int DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `otp_codigo` varchar(10) DEFAULT NULL,
  `otp_expiracion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  UNIQUE KEY `uk_usuarios_correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (3,'Administrador General','Administrador','Verificado','admin','frankpool2711@hotmail.com','968320516','46104175',35,'12345','368560','2025-12-01 22:21:07'),(4,'Cajero Principal','Cajero','Verificado','frankpool.2711@gmail.com','frankpool.2711@gmail.com','968320516','73541542',32,'12345','701670','2025-11-24 19:56:50'),(5,'Jose Perez Mitma','Cliente','Verificado','u23231016@utp.edu.pe','u23231016@utp.edu.pe','981090000','73541542',25,'202020',NULL,NULL),(6,'Ayar Vásquez Lozada','Cliente','Verificado','u23234130@utp.edu.pe','u23234130@utp.edu.pe','96847517','48579618',40,'454545',NULL,NULL),(7,'Heber Tirado Salazar','Cliente','Verificado','u23235408@utp.edu.pe','u23235408@utp.edu.pe','958472178','48390535',37,'707070',NULL,NULL),(9,'Theo Morante','Cliente','Verificado','theo@hotmail.com','theo@hotmail.com','968320516','46107584',20,'969696',NULL,NULL),(10,'Martin Vizcarra','Cliente','Verificado','hola@barbadillo.com','hola@barbadillo.com','987415749','76847941',40,'1414',NULL,NULL),(11,'Joel Diaz Nima','Cliente','Verificado','Joel@hotmail.com','Joel@hotmail.com','985346712','76854178',19,'707070',NULL,NULL),(17,'Juan Rios Nima','Cliente','Verificado','rios@hotmail.com','rios@hotmail.com','908246812','79841635',0,'123456',NULL,NULL),(18,'Mabel Mitma Gomez','Cliente','Verificado','mabel@hotmail.com','mabel@hotmail.com','907843517','76491872',0,'123456',NULL,NULL),(19,'Ayar Frank Vásquez Tirado','Cliente','Verificado','Anel@hotmail.com','Anel@hotmail.com','907548711','49758172',0,'123456',NULL,NULL),(20,'Anel Tirado Salazar','Cliente','Verificado','Tirado@hotmail.com','Tirado@hotmail.com','123456789','12345678',20,'123456',NULL,NULL),(21,'Rosa Juárez Diaz','Cliente','Verificado','rosa@hotmail.com','rosa@hotmail.com','947841578','16784397',0,'123456',NULL,NULL),(22,'Manuel Nima Nima','Cliente','Verificado','manuel@hotmail.com','manuel@hotmail.com','908528476','78417584',0,'123456',NULL,NULL),(23,'Jhon Regalado Chavez','Cliente','Verificado','jhon@hotmail.com','jhon@hotmail.com','976384196','79482678',0,'123456',NULL,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int DEFAULT NULL,
  `id_usuario` int NOT NULL,
  `fecha` datetime NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `tipo` enum('Presencial','Online') NOT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,1,3,'2025-11-28 20:36:23',18.00,'Online'),(2,2,3,'2025-11-28 21:25:02',36.00,'Online'),(3,3,3,'2025-11-28 21:35:20',265.50,'Online'),(4,4,3,'2025-12-01 22:10:42',207.50,'Online'),(5,5,3,'2025-12-01 22:44:55',3.50,'Online'),(6,6,3,'2025-12-01 23:20:09',64.00,'Online'),(7,7,3,'2025-12-01 23:51:54',127.00,'Online'),(8,8,3,'2025-12-02 00:00:00',26.10,'Online'),(9,9,3,'2025-12-02 00:00:50',18.00,'Online'),(10,10,3,'2025-12-02 00:17:29',4.50,'Online'),(11,11,3,'2025-12-02 00:30:30',3.00,'Online'),(12,12,3,'2025-12-02 00:54:17',63.50,'Online'),(13,13,3,'2025-12-02 01:15:12',1.50,'Online'),(14,14,3,'2025-12-02 01:31:02',10.00,'Online'),(15,15,3,'2025-12-02 02:08:29',7.50,'Online'),(16,16,3,'2025-12-02 02:10:42',42.50,'Online'),(17,17,3,'2025-12-02 19:41:05',24.00,'Online'),(18,18,3,'2025-12-02 19:51:27',7.50,'Online');
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'nicsy_botica'
--
/*!50003 DROP PROCEDURE IF EXISTS `BuscarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarCliente`(IN p_id_cliente INT)
BEGIN
SELECT c.id_cliente, u.nombre, u.nombre_usuario, c.dni, c.telefono, c.correo,
         d.direccion, d.referencia
  FROM Clientes c
  JOIN Usuarios u           ON u.id_usuario = c.id_usuario
  LEFT JOIN DireccionesCliente d ON d.id_cliente = c.id_cliente
  WHERE c.id_cliente = p_id_cliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BuscarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarProducto`(
    IN p_q VARCHAR(100),
    IN p_categoria VARCHAR(30)
)
BEGIN
    SELECT id_producto, nombre, categoria, precio, descripcion, stock, imagen_url
    FROM Productos
    WHERE (p_q IS NULL OR nombre LIKE CONCAT('%', p_q, '%'))
      AND (p_categoria IS NULL OR p_categoria = '' OR categoria = p_categoria)
    ORDER BY nombre ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BuscarProductoPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarProductoPorId`(
    IN p_id_producto INT
)
BEGIN
    SELECT 
        id_producto,
        nombre,
        categoria,
        precio,
        descripcion,
        stock,
        imagen_url
    FROM Productos
    WHERE id_producto = p_id_producto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CrearVentaDesdePedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearVentaDesdePedido`(
    IN p_id_pedido  INT,
    IN p_id_usuario INT,
    IN p_tipo       VARCHAR(20)   -- 'Presencial' o 'Online'
)
BEGIN
    DECLARE v_total   DECIMAL(8,2);
    DECLARE v_estado  VARCHAR(20);
    DECLARE v_id_venta INT;

    -- Validar tipo de venta
    IF p_tipo NOT IN ('Presencial','Online') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Tipo de venta inválido. Use Presencial u Online.';
    END IF;

    -- Verificar que el pedido exista y esté Pendiente
    SELECT total, estado
    INTO v_total, v_estado
    FROM pedidos
    WHERE id_pedido = p_id_pedido
    LIMIT 1;

    IF v_total IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El pedido no existe.';
    END IF;

    IF v_estado <> 'Pendiente' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El pedido ya fue procesado o cancelado.';
    END IF;

    -- Validar stock suficiente para todos los productos del pedido
    IF EXISTS (
        SELECT 1
        FROM pedidos_detalle d
        JOIN productos p ON p.id_producto = d.id_producto
        WHERE d.id_pedido = p_id_pedido
          AND p.stock < d.cantidad
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Stock insuficiente para uno o más productos del pedido.';
    END IF;

    START TRANSACTION;

    -- Crear la venta
    INSERT INTO ventas (id_pedido, id_usuario, fecha, total, tipo)
    VALUES (p_id_pedido, p_id_usuario, NOW(), v_total, p_tipo);

    SET v_id_venta = LAST_INSERT_ID();

    -- Copiar detalle del pedido a detalleventa
    INSERT INTO detalleventa (id_venta, id_producto, cantidad, subtotal)
    SELECT v_id_venta, id_producto, cantidad, subtotal
    FROM pedidos_detalle
    WHERE id_pedido = p_id_pedido;

    -- Registrar movimientos de stock (Salida)
    INSERT INTO movimientosstock (id_producto, id_lote, tipo, cantidad, fecha, referencia)
    SELECT d.id_producto,
           NULL,                    -- sin lote específico (puedes ajustar luego si usas FEFO)
           'Salida',
           d.cantidad,
           NOW(),
           CONCAT('Venta ', v_id_venta)
    FROM pedidos_detalle d
    WHERE d.id_pedido = p_id_pedido;

    -- Descontar stock de productos
    UPDATE productos p
    JOIN pedidos_detalle d ON p.id_producto = d.id_producto
    SET p.stock = p.stock - d.cantidad
    WHERE d.id_pedido = p_id_pedido;

    -- Marcar pedido como Confirmado
    UPDATE pedidos
    SET estado = 'Confirmado'
    WHERE id_pedido = p_id_pedido;

    COMMIT;

    -- Devolver datos clave al backend
    SELECT v_id_venta AS id_venta, v_total AS total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCliente`(IN p_id_cliente INT)
BEGIN
DECLARE v_id_usuario INT;
  SELECT id_usuario INTO v_id_usuario FROM Clientes WHERE id_cliente=p_id_cliente;

  DELETE FROM DireccionesCliente WHERE id_cliente=p_id_cliente;
  DELETE FROM Clientes          WHERE id_cliente=p_id_cliente;
  DELETE FROM Usuarios          WHERE id_usuario=v_id_usuario;

  SELECT 1 AS ok;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarProducto`(IN p_id_producto INT)
BEGIN
IF EXISTS (SELECT 1 FROM Pedidos_Detalle WHERE id_producto=p_id_producto)
     OR EXISTS (SELECT 1 FROM DetalleVenta   WHERE id_producto=p_id_producto)
  THEN
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No se puede eliminar: producto con historial.';
  ELSE
     DELETE FROM Lotes WHERE id_producto=p_id_producto;
     DELETE FROM Productos WHERE id_producto=p_id_producto;
     SELECT 1 AS ok;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GenerarBoletaVenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerarBoletaVenta`(
    IN p_id_venta INT
)
BEGIN
    DECLARE v_nuevo_numero INT;
    DECLARE v_existe_venta INT;

    -- Verificar que la venta exista
    SELECT COUNT(*) INTO v_existe_venta
    FROM ventas
    WHERE id_venta = p_id_venta;

    IF v_existe_venta = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No existe la venta para generar boleta.';
    END IF;

    -- Calcular siguiente número incremental
    SELECT IFNULL(MAX(numero_incremental), 0) + 1
    INTO v_nuevo_numero
    FROM boletas;

    -- Insertar boleta (pdf NULL por ahora)
    INSERT INTO boletas (id_venta, numero_incremental, pdf)
    VALUES (p_id_venta, v_nuevo_numero, NULL);

    SELECT LAST_INSERT_ID() AS id_boleta,
           v_nuevo_numero AS numero_incremental;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCliente`(
IN p_nombre      VARCHAR(100),
  IN p_dni         CHAR(8),
  IN p_telefono    VARCHAR(15),
  IN p_correo      VARCHAR(100),
  IN p_direccion   VARCHAR(200),
  IN p_referencia  VARCHAR(200)
)
BEGIN
DECLARE v_id_usuario INT;
  DECLARE v_id_cliente INT;
  INSERT INTO Usuarios(nombre, rol, nombre_usuario, password)
  VALUES (p_nombre, 'Cliente', p_dni, CONCAT('*', p_dni));
  SET v_id_usuario = LAST_INSERT_ID();

  INSERT INTO Clientes(id_usuario, dni, telefono, correo)
  VALUES (v_id_usuario, p_dni, p_telefono, p_correo);
  SET v_id_cliente = LAST_INSERT_ID();

  INSERT INTO DireccionesCliente(id_cliente, direccion, referencia)
  VALUES (v_id_cliente, p_direccion, p_referencia);

  SELECT v_id_cliente AS id_cliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarLote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarLote`(
    IN p_id_producto INT,
    IN p_fecha_vencimiento DATE,
    IN p_cantidad INT
)
BEGIN
   
    IF NOT EXISTS(SELECT 1 FROM productos WHERE id_producto = p_id_producto) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto no existe';
    END IF;

    
    IF p_fecha_vencimiento <= CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de vencimiento debe ser posterior a hoy';
    END IF;

   
    IF p_cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad debe ser mayor que cero';
    END IF;

   
    INSERT INTO lotes (id_producto, fecha_vencimiento, cantidad)
    VALUES (p_id_producto, p_fecha_vencimiento, p_cantidad);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarPedidoCabecera` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarPedidoCabecera`(IN p_id_cliente INT)
BEGIN
INSERT INTO Pedidos(id_cliente, fecha, estado, total)
  VALUES (p_id_cliente, NOW(), 'Pendiente', 0.00);
  SELECT LAST_INSERT_ID() AS id_pedido;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarPedidoDetalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarPedidoDetalle`(
IN p_id_pedido INT,
  IN p_id_producto INT,
  IN p_cantidad INT,
  IN p_precio DECIMAL(6,2)
)
BEGIN
DECLARE v_sub DECIMAL(8,2);
  SET v_sub = ROUND(p_cantidad * p_precio, 2);

  INSERT INTO Pedidos_Detalle(id_pedido, id_producto, cantidad, subtotal)
  VALUES (p_id_pedido, p_id_producto, p_cantidad, v_sub);

  UPDATE Pedidos
     SET total = total + v_sub
   WHERE id_pedido = p_id_pedido;

  SELECT v_sub AS subtotal_linea;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarProducto`(
    IN p_nombre VARCHAR(100),
    IN p_categoria VARCHAR(50),
    IN p_precio DECIMAL(10,2),
    IN p_descripcion TEXT,
    IN p_stock INT,
    IN p_imagenUrl VARCHAR(255)
)
BEGIN
    DECLARE nuevo_id INT;

    
    IF EXISTS (SELECT 1 FROM productos WHERE nombre = p_nombre) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto ya existe en la base de datos.';
    END IF;

   
    INSERT INTO productos(nombre, categoria, precio, descripcion, stock, imagen_url)
    VALUES (p_nombre, p_categoria, p_precio, p_descripcion, p_stock, p_imagenUrl);

   
    SET nuevo_id = LAST_INSERT_ID();

    SELECT nuevo_id AS id_producto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListarClientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarClientes`(IN p_q VARCHAR(100))
BEGIN
SELECT c.id_cliente, u.nombre, u.nombre_usuario, c.dni, c.telefono, c.correo,
         d.direccion, d.referencia
  FROM Clientes c
  JOIN Usuarios u           ON u.id_usuario = c.id_usuario
  LEFT JOIN DireccionesCliente d ON d.id_cliente = c.id_cliente
  WHERE p_q IS NULL
     OR u.nombre LIKE CONCAT('%',p_q,'%')
     OR c.dni    LIKE CONCAT('%',p_q,'%')
  ORDER BY u.nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListarLotesPorProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarLotesPorProducto`(IN p_id_producto INT)
BEGIN
SELECT id_lote, fecha_vencimiento, cantidad
  FROM Lotes
  WHERE id_producto = p_id_producto
  ORDER BY fecha_vencimiento ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListarLotesPorVencer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarLotesPorVencer`()
BEGIN
SELECT p.nombre AS producto, l.fecha_vencimiento, l.cantidad
  FROM Lotes l
  JOIN Productos p ON p.id_producto = l.id_producto
  WHERE l.cantidad > 0 AND l.fecha_vencimiento >= CURDATE()
  ORDER BY l.fecha_vencimiento ASC
  LIMIT 5;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListarProductos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarProductos`(
    IN p_q VARCHAR(100),
    IN p_categoria VARCHAR(30)
)
BEGIN
    SELECT id_producto, nombre, categoria, precio, descripcion, stock, imagen_url
    FROM Productos
    WHERE (p_q IS NULL OR nombre LIKE CONCAT('%', p_q, '%'))
      AND (p_categoria IS NULL OR p_categoria = '' OR categoria = p_categoria)
    ORDER BY nombre ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListarProductosStockBajo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarProductosStockBajo`()
BEGIN
    SELECT 
        id_producto,
        nombre,
        categoria,
        precio,
        stock,
        imagen_url
    FROM productos
    WHERE stock <= 10
    ORDER BY stock ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ModificarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarCliente`(
IN p_id_cliente  INT,
  IN p_nombre      VARCHAR(100),
  IN p_telefono    VARCHAR(15),
  IN p_correo      VARCHAR(100),
  IN p_direccion   VARCHAR(200),
  IN p_referencia  VARCHAR(200)
)
BEGIN
DECLARE v_id_usuario INT;
  SELECT id_usuario INTO v_id_usuario FROM Clientes WHERE id_cliente=p_id_cliente;

  UPDATE Usuarios SET nombre = COALESCE(p_nombre, nombre)
  WHERE id_usuario = v_id_usuario;

  UPDATE Clientes
     SET telefono   = COALESCE(p_telefono, telefono),
         correo     = COALESCE(p_correo,   correo)
   WHERE id_cliente = p_id_cliente;

  UPDATE DireccionesCliente
     SET direccion  = COALESCE(p_direccion,  direccion),
         referencia = COALESCE(p_referencia, referencia)
   WHERE id_cliente = p_id_cliente;

  SELECT ROW_COUNT() AS filas_afectadas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ModificarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarProducto`(
    IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_categoria VARCHAR(50),
    IN p_precio DECIMAL(10,2),
    IN p_descripcion TEXT,
    IN p_stock INT,
    IN p_imagenUrl VARCHAR(255)
)
BEGIN
   
    IF EXISTS (SELECT 1 FROM productos WHERE nombre = p_nombre AND id_producto <> p_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ya existe otro producto con ese nombre.';
    END IF;

   
    UPDATE productos
    SET nombre = p_nombre,
        categoria = p_categoria,
        precio = p_precio,
        descripcion = p_descripcion,
        stock = p_stock,
        imagen_url = p_imagenUrl
    WHERE id_producto = p_id;

   
    SELECT ROW_COUNT() AS filas_afectadas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarCliente`(
    IN  p_nombre     VARCHAR(100),
    IN  p_dni        CHAR(8),
    IN  p_correo     VARCHAR(100),
    IN  p_telefono   VARCHAR(15),
    OUT p_id_cliente INT
)
BEGIN
    DECLARE v_id_cliente INT;
    DECLARE v_id_usuario INT;

    -- 1) ¿Ya existe cliente con ese DNI?
    SELECT c.id_cliente, c.id_usuario
    INTO   v_id_cliente, v_id_usuario
    FROM   clientes c
    WHERE  c.dni = p_dni
    LIMIT  1;

    -- 2) Si NO hay cliente, buscamos si ya existe un USUARIO con ese DNI o correo
    IF v_id_cliente IS NULL THEN
        SELECT u.id_usuario
        INTO   v_id_usuario
        FROM   usuarios u
        WHERE  (u.dni = p_dni OR u.correo = p_correo)
        LIMIT  1;
    END IF;

    -- 3) Si tampoco hay usuario, lo creamos
    IF v_id_usuario IS NULL THEN
        INSERT INTO usuarios
            (nombre,    rol,      estado,      nombre_usuario,
             correo,    telefono, dni,         edad, password)
        VALUES
            (p_nombre, 'Cliente', 'Verificado', p_correo,
             p_correo, p_telefono, p_dni, 0,   '123456');
        SET v_id_usuario = LAST_INSERT_ID();
    END IF;

    -- 4) Si aún no hay cliente, lo creamos enlazado al usuario
    IF v_id_cliente IS NULL THEN
        INSERT INTO clientes (id_usuario, dni, telefono, correo)
        VALUES (v_id_usuario, p_dni, p_telefono, p_correo);
        SET v_id_cliente = LAST_INSERT_ID();
    END IF;

    -- 5) Devolvemos id_cliente
    SET p_id_cliente = v_id_cliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarPagoVenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarPagoVenta`(
    IN p_id_venta INT,
    IN p_metodo   VARCHAR(20)   -- 'Efectivo','Tarjeta','Yape/Plin'
)
BEGIN
    DECLARE v_total DECIMAL(8,2);

    IF p_metodo NOT IN ('Efectivo','Tarjeta','Yape/Plin') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Método de pago inválido.';
    END IF;

    SELECT total
    INTO v_total
    FROM ventas
    WHERE id_venta = p_id_venta
    LIMIT 1;

    IF v_total IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La venta no existe.';
    END IF;

    INSERT INTO pagos (id_venta, metodo, estado)
    VALUES (p_id_venta, p_metodo, 'Pagado');

    SELECT LAST_INSERT_ID() AS id_pago, v_total AS total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_validarLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validarLogin`(
    IN p_usuario VARCHAR(100),   -- puede ser correo o nombre_usuario
    IN p_clave   VARCHAR(255)
)
BEGIN
    DECLARE v_id       INT;
    DECLARE v_nombre   VARCHAR(100);
    DECLARE v_rol      VARCHAR(20);
    DECLARE v_password VARCHAR(255);
    DECLARE v_estado   ENUM('Pendiente','Verificado','Bloqueado');
    DECLARE v_correo   VARCHAR(100);

    -- Buscar usuario por correo O por nombre_usuario
    SELECT id_usuario, nombre, rol, password, estado, correo
      INTO v_id, v_nombre, v_rol, v_password, v_estado, v_correo
    FROM usuarios
    WHERE (nombre_usuario = p_usuario OR correo = p_usuario)
    LIMIT 1;

    IF v_id IS NULL THEN
        SELECT 0 AS estado, 'Usuario no existe' AS mensaje;
    ELSEIF v_estado = 'Bloqueado' THEN
        SELECT 3 AS estado, 'Usuario bloqueado' AS mensaje;
    ELSEIF v_password <> p_clave THEN
        SELECT 1 AS estado, 'Contraseña incorrecta' AS mensaje;
    ELSEIF v_estado = 'Pendiente' THEN
        SELECT 4 AS estado, 'Cuenta pendiente de verificación' AS mensaje;
    ELSE
        SELECT 2 AS estado,
               'Acceso correcto' AS mensaje,
               v_rol       AS rol,
               v_id        AS id_usuario,
               v_nombre    AS nombre,
               v_correo    AS correo;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-02 21:12:06

-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 01-Jul-2017 às 15:16
-- Versão do servidor: 10.1.21-MariaDB
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simonejoias`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `PREENCHE` (IN `quant` INT)  NO SQL
BEGIN

SET @x = 1;
REPEAT

INSERT INTO lojas VALUES (
    DEFAULT,
    concat('nome', @x),
    concat("Endereço" , @x),
    concat("tel ", @x));
INSERT INTO funcionarios VALUES(
    DEFAULT,
    CONCAT("Nome ",@x),
    CONCAT("Usuario ",@x),
    CONCAT("Senha ",@x),
	ceil(rand()* 1),
    DEFAULT);    
INSERT INTO lojas_has_funcionarios VALUES(
    @x,
    @x);
    
INSERT INTO clientes VALUES(
    DEFAULT,
    CONCAT("Nome ",@x),
    CURRENT_DATE,
    concat("Endereço" , @x),
    concat("CPF " + @x),
    concat("Celular " , @x),
    concat("categoria " , @x),
    concat("email" , @x,"@hotmail.com"),
    concat("origem " , @x),
    concat("funcionario " , @x),
    @x,
    DEFAULT,
    concat("comentario ", @x)
    );
  
SET @val = ceil(rand() * @x); 
    
INSERT into tarefas VALUES(
    DEFAULT,
    @x,
    ceil(rand() * @val),
    DEFAULT,
    concat("tipo " , @x),
    CURRENT_DATE,
    concat("comentario " , @x));

 INSERT INTO negocios VALUES(
     DEFAULT,
     concat("funcionario " , @x),
     @x,
     concat("cliente " , @x),
     @x,
     DEFAULT,
     concat("tipo " , @x),
     concat("comentario " , @x),
     rand() * 5000);
    
    
SET @x = @x +1;
UNTIL @x = quant 
END REPEAT;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `alteraçoes`
--

CREATE TABLE `alteraçoes` (
  `id` int(11) NOT NULL,
  `tabela` varchar(45) NOT NULL,
  `valores` varchar(5000) NOT NULL,
  `DATA_ALTERAÇAO` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `idCliente` int(10) UNSIGNED NOT NULL,
  `Nome` varchar(250) NOT NULL,
  `data_de_nascimento` date DEFAULT NULL,
  `Endereço` varchar(250) DEFAULT NULL,
  `CPF` varchar(15) NOT NULL,
  `Celular` varchar(15) NOT NULL,
  `Categoria` varchar(45) NOT NULL,
  `Email` varchar(250) DEFAULT NULL,
  `Origem` varchar(45) DEFAULT NULL,
  `Funcionario_que_cadastrou` varchar(100) DEFAULT NULL,
  `Funcionario_idFuncionario` int(10) UNSIGNED DEFAULT NULL,
  `Data_de_cadastro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Comentario` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `clientes`
--

INSERT INTO `clientes` (`idCliente`, `Nome`, `data_de_nascimento`, `Endereço`, `CPF`, `Celular`, `Categoria`, `Email`, `Origem`, `Funcionario_que_cadastrou`, `Funcionario_idFuncionario`, `Data_de_cadastro`, `Comentario`) VALUES
(1, 'Nome 1', '2017-07-01', 'Endereço1', '1', 'Celular 1', 'categoria 1', 'email1@hotmail.com', 'origem 1', 'funcionario 1', 1, '2017-07-01 10:10:10', 'comentario 1'),
(2, 'Nome 2', '2017-07-01', 'Endereço2', '2', 'Celular 2', 'categoria 2', 'email2@hotmail.com', 'origem 2', 'funcionario 2', 2, '2017-07-01 10:10:10', 'comentario 2'),
(3, 'Nome 3', '2017-07-01', 'Endereço3', '3', 'Celular 3', 'categoria 3', 'email3@hotmail.com', 'origem 3', 'funcionario 3', 3, '2017-07-01 10:10:11', 'comentario 3'),
(4, 'Nome 4', '2017-07-01', 'Endereço4', '4', 'Celular 4', 'categoria 4', 'email4@hotmail.com', 'origem 4', 'funcionario 4', 4, '2017-07-01 10:10:11', 'comentario 4'),
(5, 'Nome 5', '2017-07-01', 'Endereço5', '5', 'Celular 5', 'categoria 5', 'email5@hotmail.com', 'origem 5', 'funcionario 5', 5, '2017-07-01 10:10:12', 'comentario 5'),
(6, 'Nome 6', '2017-07-01', 'Endereço6', '6', 'Celular 6', 'categoria 6', 'email6@hotmail.com', 'origem 6', 'funcionario 6', 6, '2017-07-01 10:10:12', 'comentario 6'),
(7, 'Nome 7', '2017-07-01', 'Endereço7', '7', 'Celular 7', 'categoria 7', 'email7@hotmail.com', 'origem 7', 'funcionario 7', 7, '2017-07-01 10:10:12', 'comentario 7'),
(8, 'Nome 8', '2017-07-01', 'Endereço8', '8', 'Celular 8', 'categoria 8', 'email8@hotmail.com', 'origem 8', 'funcionario 8', 8, '2017-07-01 10:10:12', 'comentario 8'),
(9, 'Nome 9', '2017-07-01', 'Endereço9', '9', 'Celular 9', 'categoria 9', 'email9@hotmail.com', 'origem 9', 'funcionario 9', 9, '2017-07-01 10:10:12', 'comentario 9');

--
-- Acionadores `clientes`
--
DELIMITER $$
CREATE TRIGGER `Clientes_BEFORE_UPDATE` BEFORE UPDATE ON `clientes` FOR EACH ROW BEGIN
	
set @v = CONCAT(
    COALESCE(OLD.idCliente,''),"|",
    COALESCE(OLD.Nome,''),"|",
    COALESCE(OLD.data_de_nascimento,''),"|",
    COALESCE(OLD.Endereço,''),"|",
    COALESCE(OLD.CPF,''),"|",
    COALESCE(OLD.Celular,''),"|",
    COALESCE(OLD.Categoria,''),"|",
    COALESCE(OLD.Email,''),"|",
    COALESCE(OLD.Origem,''),"|",
    COALESCE(OLD.Funcionario_que_cadastrou,''),"|",
    COALESCE(OLD.Funcionario_idFuncionario,''),"|",
    COALESCE(OLD.Data_de_cadastro,''),"|",
    COALESCE(OLD.Comentario,''));
INSERT INTO `Alteraçoes` values (default,"Clientes",@v,
default);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
  `idFuncionario` int(10) UNSIGNED NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `Usuario` varchar(250) NOT NULL,
  `Senha` varchar(250) NOT NULL,
  `isAdm` tinyint(4) NOT NULL,
  `Data_de_cadastro` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `funcionarios`
--

INSERT INTO `funcionarios` (`idFuncionario`, `Nome`, `Usuario`, `Senha`, `isAdm`, `Data_de_cadastro`) VALUES
(1, 'Nome 1', 'Usuario 1', 'Senha 1', 1, '2017-07-01 10:10:10'),
(2, 'Nome 2', 'Usuario 2', 'Senha 2', 1, '2017-07-01 10:10:10'),
(3, 'Nome 3', 'Usuario 3', 'Senha 3', 1, '2017-07-01 10:10:11'),
(4, 'Nome 4', 'Usuario 4', 'Senha 4', 1, '2017-07-01 10:10:11'),
(5, 'Nome 5', 'Usuario 5', 'Senha 5', 1, '2017-07-01 10:10:11'),
(6, 'Nome 6', 'Usuario 6', 'Senha 6', 1, '2017-07-01 10:10:12'),
(7, 'Nome 7', 'Usuario 7', 'Senha 7', 1, '2017-07-01 10:10:12'),
(8, 'Nome 8', 'Usuario 8', 'Senha 8', 1, '2017-07-01 10:10:12'),
(9, 'Nome 9', 'Usuario 9', 'Senha 9', 1, '2017-07-01 10:10:12');

--
-- Acionadores `funcionarios`
--
DELIMITER $$
CREATE TRIGGER `Funcionarios_BEFORE_UPDATE` BEFORE UPDATE ON `funcionarios` FOR EACH ROW BEGIN 
INSERT INTO `Alteraçoes` values (
default,
"Funcionarios",
concat(
OLD.idFuncionario,"|",
OLD.Nome,"|",
OLD.Usuario,"|",
OLD.Senha,"|",
OLD.isAdm),
DEFAULT);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `lojas`
--

CREATE TABLE `lojas` (
  `idLoja` int(10) UNSIGNED NOT NULL,
  `Nome` varchar(45) DEFAULT NULL,
  `Endereço` varchar(250) DEFAULT NULL,
  `Telefone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `lojas`
--

INSERT INTO `lojas` (`idLoja`, `Nome`, `Endereço`, `Telefone`) VALUES
(1, 'nome1', 'Endereço1', 'tel 1'),
(2, 'nome2', 'Endereço2', 'tel 2'),
(3, 'nome3', 'Endereço3', 'tel 3'),
(4, 'nome4', 'Endereço4', 'tel 4'),
(5, 'nome5', 'Endereço5', 'tel 5'),
(6, 'nome6', 'Endereço6', 'tel 6'),
(7, 'nome7', 'Endereço7', 'tel 7'),
(8, 'nome8', 'Endereço8', 'tel 8'),
(9, 'nome9', 'Endereço9', 'tel 9');

-- --------------------------------------------------------

--
-- Estrutura da tabela `lojas_has_funcionarios`
--

CREATE TABLE `lojas_has_funcionarios` (
  `Lojas_idLoja` int(10) UNSIGNED NOT NULL,
  `Funcionarios_idFuncionario` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `lojas_has_funcionarios`
--

INSERT INTO `lojas_has_funcionarios` (`Lojas_idLoja`, `Funcionarios_idFuncionario`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9);

--
-- Acionadores `lojas_has_funcionarios`
--
DELIMITER $$
CREATE TRIGGER `Lojas_has_Funcionarios_AFTER_UPDATE` AFTER UPDATE ON `lojas_has_funcionarios` FOR EACH ROW BEGIN
insert into `Alteraçoes` values(default,'Loja_has_Funionarios',CONCAT(OLD.Lojas_idLoja," ",OLD.Funcionarios_idFuncionario),default);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `negocios`
--

CREATE TABLE `negocios` (
  `idNegocio` int(10) UNSIGNED NOT NULL,
  `Funcionario` varchar(100) DEFAULT NULL,
  `idFuncionario` int(10) UNSIGNED DEFAULT NULL,
  `Cliente` varchar(100) DEFAULT NULL,
  `idCliente` int(10) UNSIGNED DEFAULT NULL,
  `Data_do_Negocio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Tipo_de_negocio` varchar(50) NOT NULL,
  `Comentario` varchar(250) DEFAULT NULL,
  `Valor_do_negocio` decimal(19,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `negocios`
--

INSERT INTO `negocios` (`idNegocio`, `Funcionario`, `idFuncionario`, `Cliente`, `idCliente`, `Data_do_Negocio`, `Tipo_de_negocio`, `Comentario`, `Valor_do_negocio`) VALUES
(1, 'funcionario 1', 1, 'cliente 1', 1, '2017-07-01 10:10:10', 'tipo 1', 'comentario 1', '1820.7492'),
(2, 'funcionario 2', 2, 'cliente 2', 2, '2017-07-01 10:10:10', 'tipo 2', 'comentario 2', '1760.1506'),
(3, 'funcionario 3', 3, 'cliente 3', 3, '2017-07-01 10:10:11', 'tipo 3', 'comentario 3', '1251.0238'),
(4, 'funcionario 4', 4, 'cliente 4', 4, '2017-07-01 10:10:11', 'tipo 4', 'comentario 4', '1529.0096'),
(5, 'funcionario 5', 5, 'cliente 5', 5, '2017-07-01 10:10:12', 'tipo 5', 'comentario 5', '3117.4032'),
(6, 'funcionario 6', 6, 'cliente 6', 6, '2017-07-01 10:10:12', 'tipo 6', 'comentario 6', '419.5521'),
(7, 'funcionario 7', 7, 'cliente 7', 7, '2017-07-01 10:10:12', 'tipo 7', 'comentario 7', '1396.7685'),
(8, 'funcionario 8', 8, 'cliente 8', 8, '2017-07-01 10:10:12', 'tipo 8', 'comentario 8', '107.9197'),
(9, 'funcionario 9', 9, 'cliente 9', 9, '2017-07-01 10:10:12', 'tipo 9', 'comentario 9', '3878.2435');

--
-- Acionadores `negocios`
--
DELIMITER $$
CREATE TRIGGER `Negocios_BEFORE_UPDATE` BEFORE UPDATE ON `negocios` FOR EACH ROW BEGIN
INSERT INTO `Alteraçoes` values (
default,
"Negocios",
concat(
 COALESCE(OLD.idNegocio,''),"|",
 COALESCE(OLD.Funcionario,''),"|",
 COALESCE(OLD.idFuncionario,''),"|",
 COALESCE(OLD.Cliente,''),"|",
 COALESCE(OLD.idCliente,''),"|",
 COALESCE(OLD.Data_do_Negocio,''),"|",
 COALESCE(OLD.Tipo_de_negocio,''),"|",
 COALESCE(OLD.Comentario,''),"|",
 COALESCE(OLD.Valor_do_negocio,'')),
default);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tarefas`
--

CREATE TABLE `tarefas` (
  `idTarefas` int(10) UNSIGNED NOT NULL,
  `idFuncionario_Criador` int(10) UNSIGNED NOT NULL,
  `idFuncionario_Delegado` int(10) UNSIGNED NOT NULL,
  `Data_Criaçao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Tipo_de_tarefa` varchar(250) NOT NULL,
  `Data_Limite` date NOT NULL,
  `Comentario` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tarefas`
--

INSERT INTO `tarefas` (`idTarefas`, `idFuncionario_Criador`, `idFuncionario_Delegado`, `Data_Criaçao`, `Tipo_de_tarefa`, `Data_Limite`, `Comentario`) VALUES
(1, 1, 1, '2017-07-01 10:10:10', 'tipo 1', '2017-07-01', 'comentario 1'),
(2, 2, 1, '2017-07-01 10:10:10', 'tipo 2', '2017-07-01', 'comentario 2'),
(3, 3, 3, '2017-07-01 10:10:11', 'tipo 3', '2017-07-01', 'comentario 3'),
(4, 4, 1, '2017-07-01 10:10:11', 'tipo 4', '2017-07-01', 'comentario 4'),
(5, 5, 3, '2017-07-01 10:10:12', 'tipo 5', '2017-07-01', 'comentario 5'),
(6, 6, 1, '2017-07-01 10:10:12', 'tipo 6', '2017-07-01', 'comentario 6'),
(7, 7, 1, '2017-07-01 10:10:12', 'tipo 7', '2017-07-01', 'comentario 7'),
(8, 8, 7, '2017-07-01 10:10:12', 'tipo 8', '2017-07-01', 'comentario 8'),
(9, 9, 1, '2017-07-01 10:10:12', 'tipo 9', '2017-07-01', 'comentario 9');

--
-- Acionadores `tarefas`
--
DELIMITER $$
CREATE TRIGGER `Tarefas_BEFORE_UPDATE` BEFORE UPDATE ON `tarefas` FOR EACH ROW BEGIN
INSERT INTO `Alteraçoes` values (
default,
"Tarefas",
concat(
OLD.idTarefas,"|",
OLD.idFuncionario_Criador,"|",
OLD.idFuncionario_Delegado,"|",
OLD.Data_Criaçao,"|",
COALESCE(OLD.Tipo_de_tarefa,''),"|",
COALESCE(OLD.Data_Limite,''),"|",
COALESCE(OLD.Comentario,'')
),
DEFAULT);
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alteraçoes`
--
ALTER TABLE `alteraçoes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idCliente`),
  ADD UNIQUE KEY `CPF_UNIQUE` (`CPF`),
  ADD KEY `fk_Cliente_Funcionario1_idx` (`Funcionario_idFuncionario`);

--
-- Indexes for table `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`idFuncionario`),
  ADD UNIQUE KEY `Usuario_UNIQUE` (`Usuario`);

--
-- Indexes for table `lojas`
--
ALTER TABLE `lojas`
  ADD PRIMARY KEY (`idLoja`);

--
-- Indexes for table `lojas_has_funcionarios`
--
ALTER TABLE `lojas_has_funcionarios`
  ADD PRIMARY KEY (`Lojas_idLoja`,`Funcionarios_idFuncionario`),
  ADD KEY `fk_Lojas_has_Funcionarios_Funcionarios1_idx` (`Funcionarios_idFuncionario`),
  ADD KEY `fk_Lojas_has_Funcionarios_Lojas1_idx` (`Lojas_idLoja`);

--
-- Indexes for table `negocios`
--
ALTER TABLE `negocios`
  ADD PRIMARY KEY (`idNegocio`),
  ADD KEY `fk_Negocio_Funcionario_idx` (`idFuncionario`),
  ADD KEY `fk_Negocio_Cliente1_idx` (`idCliente`);

--
-- Indexes for table `tarefas`
--
ALTER TABLE `tarefas`
  ADD PRIMARY KEY (`idTarefas`),
  ADD KEY `fk_Tarefas_Funcionarios1_idx` (`idFuncionario_Criador`),
  ADD KEY `fk_Tarefas_Funcionarios2_idx` (`idFuncionario_Delegado`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alteraçoes`
--
ALTER TABLE `alteraçoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `funcionarios`
--
ALTER TABLE `funcionarios`
  MODIFY `idFuncionario` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `lojas`
--
ALTER TABLE `lojas`
  MODIFY `idLoja` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `negocios`
--
ALTER TABLE `negocios`
  MODIFY `idNegocio` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `tarefas`
--
ALTER TABLE `tarefas`
  MODIFY `idTarefas` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `fk_Cliente_Funcionario1` FOREIGN KEY (`Funcionario_idFuncionario`) REFERENCES `funcionarios` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `lojas_has_funcionarios`
--
ALTER TABLE `lojas_has_funcionarios`
  ADD CONSTRAINT `fk_Lojas_has_Funcionarios_Funcionarios1` FOREIGN KEY (`Funcionarios_idFuncionario`) REFERENCES `funcionarios` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Lojas_has_Funcionarios_Lojas1` FOREIGN KEY (`Lojas_idLoja`) REFERENCES `lojas` (`idLoja`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `negocios`
--
ALTER TABLE `negocios`
  ADD CONSTRAINT `fk_Negocio_Cliente1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Negocio_Funcionario` FOREIGN KEY (`idFuncionario`) REFERENCES `funcionarios` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tarefas`
--
ALTER TABLE `tarefas`
  ADD CONSTRAINT `fk_Tarefas_Funcionarios1` FOREIGN KEY (`idFuncionario_Criador`) REFERENCES `funcionarios` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Tarefas_Funcionarios2` FOREIGN KEY (`idFuncionario_Delegado`) REFERENCES `funcionarios` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

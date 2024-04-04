/*PARA CREAR UNA BASE DE DATOS LLAMADA Alke Wallet */
    CREATE SCHEMA `alke_wallet` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;


/*PARA CREAR TABLAS EN LA BASE DE DATOS */
    /*Para crear la tabla usuario */
    CREATE TABLE `alke_wallet`.`usuario` (
    `user_id` INT NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(60) NOT NULL,
    `correo_electronico` VARCHAR(100) NOT NULL,
    `contrasena` VARCHAR(50) NOT NULL,
    `saldo` FLOAT NOT NULL,
    PRIMARY KEY (`user_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8
    COLLATE = utf8_spanish_ci;

    /*Para crear la tabla transacción */
    CREATE TABLE `alke_wallet`.`transaccion` (
    `transaction_id` INT NOT NULL AUTO_INCREMENT,
    `sender_user_id` INT NOT NULL,
    `receiver_user_id` INT NOT NULL,
    `importe` DECIMAL(10,2) NOT NULL,
    `transaction_date` DATE NOT NULL,
    PRIMARY KEY (`transaction_id`),
    INDEX `sender_user_id_idx` (`sender_user_id` ASC) VISIBLE,
    INDEX `receiver_user_id_idx` (`receiver_user_id` ASC) VISIBLE,
    CONSTRAINT `sender_user_id`
        FOREIGN KEY (`sender_user_id`)
        REFERENCES `alke_wallet`.`usuario` (`user_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `receiver_user_id`
        FOREIGN KEY (`receiver_user_id`)
        REFERENCES `alke_wallet`.`usuario` (`user_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8
    COLLATE = utf8_spanish_ci;

    /* Para crear la tabla moneda */
    CREATE TABLE `alke_wallet`.`moneda` (
    `currency_id` INT NOT NULL AUTO_INCREMENT,
    `currency_name` VARCHAR(50) NOT NULL,
    `currency_simbol` VARCHAR(5) NOT NULL,
    PRIMARY KEY (`currency_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8
    COLLATE = utf8_spanish_ci;


/*PARA INSERTAR DATOS EN LAS TABLAS */
    /*insertar datos en tabla usuario */
    INSERT INTO `alke_wallet`.`usuario` (`nombre`, `correo_electronico`, `contrasena`, `saldo`) VALUES ('Daniel Riquelme', 'danielr@mail.com', '1234', '50000');
    INSERT INTO `alke_wallet`.`usuario` (`nombre`, `correo_electronico`, `contrasena`, `saldo`) VALUES ('Miguel Salvador', 'miguels@mail.com', '4567', '10000');
    INSERT INTO `alke_wallet`.`usuario` (`nombre`, `correo_electronico`, `contrasena`, `saldo`) VALUES ('Rita Salas', 'ritas@gmail.com', '7890', '25000');
    INSERT INTO `alke_wallet`.`usuario` (`nombre`, `correo_electronico`, `contrasena`, `saldo`) VALUES ('Gonzalo Saez', 'gonzalos@mail.com', '0147', '80000');
    INSERT INTO `alke_wallet`.`usuario` (`nombre`, `correo_electronico`, `contrasena`, `saldo`) VALUES ('Maria Rojas', 'mariar@mail.com', '0258', '70000');

    /*insertar datos en tabla transacción */
    INSERT INTO `alke_wallet`.`transaccion` (`sender_user_id`, `receiver_user_id`, `importe`, `transaction_date`) VALUES ('1', '2', '250000', '2024-04-01');
    INSERT INTO `alke_wallet`.`transaccion` (`sender_user_id`, `receiver_user_id`, `importe`, `transaction_date`) VALUES ('3', '1', '50000', '2024-04-01');
    INSERT INTO `alke_wallet`.`transaccion` (`sender_user_id`, `receiver_user_id`, `importe`, `transaction_date`) VALUES ('2', '4', '240000', '2024-04-02');
    INSERT INTO `alke_wallet`.`transaccion` (`sender_user_id`, `receiver_user_id`, `importe`, `transaction_date`) VALUES ('5', '3', '100000', '2024-04-03');
    INSERT INTO `alke_wallet`.`transaccion` (`sender_user_id`, `receiver_user_id`, `importe`, `transaction_date`) VALUES ('4', '5', '90000', '2024-04-04');

    /*insertar datos en tabla transacción */
    INSERT INTO `alke_wallet`.`moneda` (`currency_name`, `currency_simbol`) VALUES ('dolar estadounidense', 'USD');
    INSERT INTO `alke_wallet`.`moneda` (`currency_name`, `currency_simbol`) VALUES ('euro', 'EUR');
    INSERT INTO `alke_wallet`.`moneda` (`currency_name`, `currency_simbol`) VALUES ('peso chileno', 'CLP');


/*Alterar tablas usuario y transacción permitiendo conectarlas a la tabla moneda a usuario*/
    /*Alterar tabla usuario*/
    ALTER TABLE Usuario
    ADD COLUMN currency_id INT,
    ADD FOREIGN KEY (currency_id) REFERENCES Moneda(currency_id);
    /*Para agregar tipo de divisa en tabla usuario*/
    UPDATE `alke_wallet`.`usuario` SET `currency_id` = '1' WHERE (`user_id` = '1');
    UPDATE `alke_wallet`.`usuario` SET `currency_id` = '3' WHERE (`user_id` = '3');
    UPDATE `alke_wallet`.`usuario` SET `currency_id` = '2' WHERE (`user_id` = '2');
    UPDATE `alke_wallet`.`usuario` SET `currency_id` = '2' WHERE (`user_id` = '4');
    UPDATE `alke_wallet`.`usuario` SET `currency_id` = '1' WHERE (`user_id` = '5');

    /*Alterar tabla transacción*/
    ALTER TABLE Transaccion
    ADD COLUMN currency_id INT,
    ADD FOREIGN KEY (currency_id) REFERENCES Moneda(currency_id);
    /*Para agregar tipo de divisa en transacciones*/
    UPDATE `alke_wallet`.`transaccion` SET `currency_id` = '1' WHERE (`transaction_id` = '1');
    UPDATE `alke_wallet`.`transaccion` SET `currency_id` = '2' WHERE (`transaction_id` = '2');
    UPDATE `alke_wallet`.`transaccion` SET `currency_id` = '1' WHERE (`transaction_id` = '3');
    UPDATE `alke_wallet`.`transaccion` SET `currency_id` = '3' WHERE (`transaction_id` = '4');
    UPDATE `alke_wallet`.`transaccion` SET `currency_id` = '2' WHERE (`transaction_id` = '5');


/*PARA REALIZAR CONSULTAS*/
    /*Consulta para obtener el nombre de la moneda elegida*/
    SELECT u.nombre AS nombre_usuario, m.currency_name AS nombre_moneda
    FROM Usuario u
    JOIN Moneda m ON u.currency_id = m.currency_id
    WHERE u.user_id = 3;

    /*Consulta para obtener todas las transacciones realizadas*/
    SELECT * FROM Transaccion;

    /*Consulta para obtener todas las transacciones realizadas por un usuario especifico*/
    SELECT * FROM Transaccion
    WHERE sender_user_id = 2; 

    /*Sentencia DMl para modificar un correo electronico*/
    UPDATE Usuario
    SET correo_electronico = 'rita_salas@mail.com'
    WHERE user_id = 3;

    /*Sentencia para eliminar los datos de una transacción (eliminación de tabla completa)*/
    DELETE FROM Transaccion
    WHERE transaction_id = 4 ; 
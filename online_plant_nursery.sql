-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema online_plant_nursery
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema online_plant_nursery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `online_plant_nursery` DEFAULT CHARACTER SET utf8 ;
USE `online_plant_nursery` ;

-- -----------------------------------------------------
-- Table `online_plant_nursery`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_plant_nursery`.`customer` (
  `customer_ID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NULL,
  `address` VARCHAR(200) NULL,
  PRIMARY KEY (`customer_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_plant_nursery`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_plant_nursery`.`category` (
  `category_ID` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`category_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_plant_nursery`.`plant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_plant_nursery`.`plant` (
  `plant_ID` INT NOT NULL AUTO_INCREMENT,
  `plant_name` VARCHAR(100) NOT NULL,
  `scientific_name` VARCHAR(100) NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `size` VARCHAR(20) NULL,
  `stock_quantity` INT NOT NULL,
  `category_ID` INT NOT NULL,
  PRIMARY KEY (`plant_ID`),
  INDEX `fk_plant_category1_idx` (`category_ID` ASC) VISIBLE,
  CONSTRAINT `fk_plant_category1`
    FOREIGN KEY (`category_ID`)
    REFERENCES `online_plant_nursery`.`category` (`category_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_plant_nursery`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_plant_nursery`.`orders` (
  `order_ID` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATE NOT NULL,
  `total_amount` DECIMAL(10,2) NOT NULL,
  `customer_ID` INT NOT NULL,
  PRIMARY KEY (`order_ID`),
  INDEX `fk_orders_customer_idx` (`customer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customer`
    FOREIGN KEY (`customer_ID`)
    REFERENCES `online_plant_nursery`.`customer` (`customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_plant_nursery`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_plant_nursery`.`payment` (
  `payment_ID` INT NOT NULL AUTO_INCREMENT,
  `payment_date` DATE NOT NULL,
  `payment_method` VARCHAR(50) NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `order_ID` INT NOT NULL,
  PRIMARY KEY (`payment_ID`),
  INDEX `fk_payment_orders1_idx` (`order_ID` ASC) VISIBLE,
  CONSTRAINT `fk_payment_orders1`
    FOREIGN KEY (`order_ID`)
    REFERENCES `online_plant_nursery`.`orders` (`order_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_plant_nursery`.`orders_has_plant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_plant_nursery`.`orders_has_plant` (
  `order_ID` INT NOT NULL,
  `plant_ID` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`order_ID`, `plant_ID`),
  INDEX `fk_orders_has_plant_plant1_idx` (`plant_ID` ASC) VISIBLE,
  INDEX `fk_orders_has_plant_orders1_idx` (`order_ID` ASC) VISIBLE,
  CONSTRAINT `fk_orders_has_plant_orders1`
    FOREIGN KEY (`order_ID`)
    REFERENCES `online_plant_nursery`.`orders` (`order_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_plant_plant1`
    FOREIGN KEY (`plant_ID`)
    REFERENCES `online_plant_nursery`.`plant` (`plant_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

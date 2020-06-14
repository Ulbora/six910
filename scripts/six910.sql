-- MySQL Script generated by MySQL Workbench
-- Sun 14 Jun 2020 05:28:04 PM EDT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema six910
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema six910
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `six910` DEFAULT CHARACTER SET utf8 ;
USE `six910` ;

-- -----------------------------------------------------
-- Table `six910`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`store` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(100) NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `local_domain` VARCHAR(150) NULL,
  `remote_domain` VARCHAR(150) NULL,
  `oauth_client_id` BIGINT NULL,
  `oauth_secret` VARCHAR(200) NULL,
  `email` VARCHAR(100) NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(15) NOT NULL,
  `date_entered` DATETIME NOT NULL,
  `store_name` VARCHAR(45) NULL,
  `store_slogan` VARCHAR(45) NULL,
  `logo` VARCHAR(100) NULL,
  `currency` VARCHAR(5) NOT NULL DEFAULT 'USD',
  `date_updated` DATETIME NULL,
  `enabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `oauth_client_id_UNIQUE` (`oauth_client_id` ASC),
  UNIQUE INDEX `store_name_UNIQUE` (`store_name` ASC),
  UNIQUE INDEX `local_domain_UNIQUE` (`local_domain` ASC),
  UNIQUE INDEX `remote_domain_UNIQUE` (`remote_domain` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`customer` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `reset_password` TINYINT(1) NOT NULL DEFAULT 0,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `company` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zip` VARCHAR(15) NOT NULL,
  `phone` VARCHAR(12) NULL,
  `store_id` BIGINT NOT NULL,
  `date_entered` DATETIME NOT NULL,
  `date_updated` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_cart_owner_idx` (`store_id` ASC),
  CONSTRAINT `fk_customer_cart_owner`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`security`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`security` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `oauth_on` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`address` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zip` VARCHAR(15) NOT NULL,
  `county` VARCHAR(45) NOT NULL,
  `country` VARCHAR(5) NOT NULL DEFAULT 'US',
  `customer_id` BIGINT NOT NULL,
  `address_type` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_address_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_address_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `six910`.`customer` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`distributor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`distributor` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(45) NOT NULL,
  `contact_name` VARCHAR(100) NULL,
  `phone` VARCHAR(12) NULL,
  `store_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_distributor_store1_idx` (`store_id` ASC),
  CONSTRAINT `fk_distributor_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`category` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL,
  `store_id` BIGINT NOT NULL,
  `image` VARCHAR(150) NULL,
  `thumbnail` VARCHAR(150) NULL,
  `parent_category_id` BIGINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_category_store1_idx` (`store_id` ASC),
  CONSTRAINT `fk_category_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`product` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `sku` VARCHAR(45) NOT NULL,
  `gtin` VARCHAR(45) NULL,
  `name` VARCHAR(45) NOT NULL,
  `short_description` VARCHAR(150) NULL,
  `description` BLOB(65000) NULL,
  `cost` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `msrp` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `map` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `price` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `sale_price` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `currency` VARCHAR(5) NOT NULL,
  `manufacturer` VARCHAR(45) NULL,
  `stock` INT NOT NULL DEFAULT 0,
  `stock_alert` INT NOT NULL DEFAULT 0,
  `weight` FLOAT NOT NULL DEFAULT 0,
  `width` FLOAT NOT NULL DEFAULT 0,
  `height` FLOAT NOT NULL DEFAULT 0,
  `depth` FLOAT NOT NULL DEFAULT 0,
  `shipping_markup` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `visible` TINYINT(1) NOT NULL DEFAULT 1,
  `searchable` TINYINT(1) NOT NULL DEFAULT 1,
  `multibox` TINYINT(1) NOT NULL DEFAULT 0,
  `ship_separate` TINYINT(1) NOT NULL DEFAULT 0,
  `free_shipping` TINYINT(1) NOT NULL DEFAULT 0,
  `date_entered` DATETIME NOT NULL,
  `distributor_id` BIGINT NOT NULL,
  `promoted` TINYINT(1) NOT NULL DEFAULT 0,
  `dropship` TINYINT(1) NOT NULL DEFAULT 0,
  `size` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  `parient_product_id` BIGINT NOT NULL DEFAULT 0,
  `store_id` BIGINT NOT NULL,
  `thumbnail` VARCHAR(150) NULL,
  `image1` VARCHAR(150) NULL,
  `image2` VARCHAR(150) NULL,
  `image3` VARCHAR(150) NULL,
  `image4` VARCHAR(150) NULL,
  `special_processing` TINYINT(1) NOT NULL DEFAULT 0,
  `special_processing_type` VARCHAR(45) NULL,
  `date_updated` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_distributor1_idx` (`distributor_id` ASC),
  INDEX `fk_product_store1_idx` (`store_id` ASC),
  CONSTRAINT `fk_product_distributor1`
    FOREIGN KEY (`distributor_id`)
    REFERENCES `six910`.`distributor` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`product_category` (
  `category_id` BIGINT NOT NULL,
  `product_id` BIGINT NOT NULL,
  PRIMARY KEY (`category_id`, `product_id`),
  INDEX `fk_product_category_category1_idx` (`category_id` ASC),
  INDEX `fk_product_category_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_product_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `six910`.`category` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_category_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `six910`.`product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`orders` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NOT NULL,
  `updated` DATETIME NULL,
  `status` VARCHAR(45) NOT NULL,
  `subtotal` DECIMAL(15,2) NOT NULL,
  `shipping_handling` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `insurance` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `taxes` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `total` DECIMAL(15,2) NOT NULL,
  `customer_id` BIGINT NOT NULL,
  `billing_address_id` BIGINT NOT NULL,
  `shipping_address_id` BIGINT NOT NULL,
  `customer_name` VARCHAR(80) NOT NULL,
  `billing_address` VARCHAR(150) NOT NULL,
  `shipping_address` VARCHAR(150) NOT NULL,
  `store_id` BIGINT NOT NULL,
  `order_number` VARCHAR(45) NOT NULL,
  `order_type` VARCHAR(45) NOT NULL,
  `pickup` TINYINT(1) NOT NULL DEFAULT 0,
  `username` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_store1_idx` (`store_id` ASC),
  CONSTRAINT `fk_order_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`order_item` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT NOT NULL,
  `product_name` VARCHAR(45) NOT NULL,
  `product_short_desc` VARCHAR(150) NOT NULL,
  `order_id` BIGINT NOT NULL,
  `quantity` INT NOT NULL,
  `backordered` TINYINT(1) NOT NULL DEFAULT 0,
  `dropship` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_order_item_order1_idx` (`order_id` ASC),
  CONSTRAINT `fk_order_item_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `six910`.`orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`shipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`shipment` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT NOT NULL,
  `create_date` DATETIME NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `boxes` INT NOT NULL DEFAULT 0,
  `shipping_handling` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `insurance` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `updated` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_shipment_order1_idx` (`order_id` ASC),
  CONSTRAINT `fk_shipment_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `six910`.`orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`shipment_box`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`shipment_box` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `box_number` INT NOT NULL,
  `dropshipped` TINYINT(1) NOT NULL DEFAULT 0,
  `cost` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `insurance` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `shipping_method_id` BIGINT NOT NULL,
  `weight` FLOAT NOT NULL DEFAULT 0,
  `width` FLOAT NOT NULL DEFAULT 0,
  `height` FLOAT NOT NULL DEFAULT 0,
  `depth` FLOAT NOT NULL DEFAULT 0,
  `ship_date` DATETIME NOT NULL,
  `updated` DATETIME NULL,
  `tracking_number` VARCHAR(100) NULL,
  `shipping_address_id` BIGINT NOT NULL,
  `shipping_address` VARCHAR(150) NOT NULL,
  `shipment_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_shipment_box_shipment1_idx` (`shipment_id` ASC),
  CONSTRAINT `fk_shipment_box_shipment1`
    FOREIGN KEY (`shipment_id`)
    REFERENCES `six910`.`shipment` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`shipment_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`shipment_item` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `order_item_id` BIGINT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  `shipment_id` BIGINT NOT NULL,
  `updated` DATETIME NOT NULL,
  `shipment_box_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_shipment_item_order_item1_idx` (`order_item_id` ASC),
  INDEX `fk_shipment_item_shipment1_idx` (`shipment_id` ASC),
  INDEX `fk_shipment_item_shipment_box1_idx` (`shipment_box_id` ASC),
  CONSTRAINT `fk_shipment_item_order_item1`
    FOREIGN KEY (`order_item_id`)
    REFERENCES `six910`.`order_item` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipment_item_shipment1`
    FOREIGN KEY (`shipment_id`)
    REFERENCES `six910`.`shipment` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipment_item_shipment_box1`
    FOREIGN KEY (`shipment_box_id`)
    REFERENCES `six910`.`shipment_box` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`shipping_carrier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`shipping_carrier` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `carrier` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `store_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_shipping_method_store1_idx` (`store_id` ASC),
  CONSTRAINT `fk_shipping_method_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`region` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `region_code` VARCHAR(5) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `store_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_region_store1_idx` (`store_id` ASC),
  CONSTRAINT `fk_region_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`shipping_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`shipping_method` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `cost` DECIMAL(15,2) NOT NULL,
  `max_weight` INT NOT NULL,
  `handling` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `store_id` BIGINT NOT NULL,
  `minimum_order` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `maximum_order` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `region_id` BIGINT NOT NULL,
  `shipping_carrier_id` BIGINT NOT NULL,
  `insurance_id` BIGINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_shipping_store1_idx` (`store_id` ASC),
  INDEX `fk_shipping_method_region1_idx` (`region_id` ASC),
  INDEX `fk_shipping_method_shipping_carrier1_idx` (`shipping_carrier_id` ASC),
  CONSTRAINT `fk_shipping_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping_method_region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `six910`.`region` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping_method_shipping_carrier1`
    FOREIGN KEY (`shipping_carrier_id`)
    REFERENCES `six910`.`shipping_carrier` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`cart` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `store_id` BIGINT NOT NULL,
  `customer_id` BIGINT NULL DEFAULT 0,
  `date_entered` DATETIME NOT NULL,
  `date_updated` DATETIME NULL,
  `ip_address` VARCHAR(45) NULL,
  `user_info` VARCHAR(150) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cart_store1_idx` (`store_id` ASC),
  CONSTRAINT `fk_cart_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`cart_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`cart_item` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT NOT NULL,
  `cart_id` BIGINT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cart_item_product1_idx` (`product_id` ASC),
  INDEX `fk_cart_item_cart1_idx` (`cart_id` ASC),
  CONSTRAINT `fk_cart_item_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `six910`.`product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_item_cart1`
    FOREIGN KEY (`cart_id`)
    REFERENCES `six910`.`cart` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`local_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`local_account` (
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(1000) NOT NULL,
  `store_id` BIGINT NOT NULL,
  `enabled` TINYINT(1) NOT NULL DEFAULT 1,
  `customer_id` BIGINT NULL DEFAULT 0,
  `role` VARCHAR(45) NOT NULL DEFAULT 'admin',
  `date_entered` DATETIME NOT NULL,
  `date_updated` DATETIME NULL,
  PRIMARY KEY (`username`, `store_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_local_accounts_store1_idx` (`store_id` ASC),
  UNIQUE INDEX `store_id_UNIQUE` (`store_id` ASC),
  CONSTRAINT `fk_local_accounts_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`store_plugins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`store_plugins` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `store_id` BIGINT NOT NULL,
  `plugins_id` BIGINT NOT NULL,
  `plugin_name` VARCHAR(45) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 0,
  `oauth_client_id` BIGINT NULL,
  `oauth_secret` VARCHAR(200) NULL,
  `activate_url` VARCHAR(150) NULL,
  `oauth_redirect_url` VARCHAR(150) NULL,
  `api_key` VARCHAR(200) NULL,
  `rekey_try_count` INT NULL,
  `rekey_date` DATETIME NULL,
  `iframe_url` VARCHAR(150) NULL,
  `menu_title` VARCHAR(45) NULL,
  `menu_icon_url` VARCHAR(150) NULL,
  `is_pgw` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_plugins_store1_idx` (`store_id` ASC),
  CONSTRAINT `fk_plugins_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`plugins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`plugins` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `plugin_name` VARCHAR(45) NOT NULL,
  `developer` VARCHAR(100) NOT NULL,
  `contact_phone` VARCHAR(12) NOT NULL,
  `developer_address` VARCHAR(100) NOT NULL,
  `fee` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `enabled` TINYINT(1) NOT NULL DEFAULT 0,
  `category` VARCHAR(45) NOT NULL,
  `activate_url` VARCHAR(150) NULL,
  `oauth_redirect_url` VARCHAR(150) NULL,
  `is_pgw` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`sub_region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`sub_region` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `sub_region_code` VARCHAR(5) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `region_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sub_region_region1_idx` (`region_id` ASC),
  CONSTRAINT `fk_sub_region_region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `six910`.`region` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`excluded_sub_region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`excluded_sub_region` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `region_id` BIGINT NOT NULL,
  `shipping_method_id` BIGINT NOT NULL,
  `sub_region_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_excluded_sub_region_region1_idx` (`region_id` ASC),
  INDEX `fk_excluded_sub_region_shipping_method1_idx` (`shipping_method_id` ASC),
  INDEX `fk_excluded_sub_region_sub_region1_idx` (`sub_region_id` ASC),
  CONSTRAINT `fk_excluded_sub_region_region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `six910`.`region` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_excluded_sub_region_shipping_method1`
    FOREIGN KEY (`shipping_method_id`)
    REFERENCES `six910`.`shipping_method` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_excluded_sub_region_sub_region1`
    FOREIGN KEY (`sub_region_id`)
    REFERENCES `six910`.`sub_region` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`insurance` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `cost` DECIMAL(15,2) NOT NULL,
  `minimum_order_amount` DECIMAL(15,2) NOT NULL,
  `maximum_order_amount` DECIMAL(15,2) NOT NULL,
  `store_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_insurance_store1_idx` (`store_id` ASC),
  CONSTRAINT `fk_insurance_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`included_sub_region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`included_sub_region` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `region_id` BIGINT NOT NULL,
  `shipping_method_id` BIGINT NOT NULL,
  `sub_region_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_included_sub_region_region1_idx` (`region_id` ASC),
  INDEX `fk_included_sub_region_shipping_method1_idx` (`shipping_method_id` ASC),
  INDEX `fk_included_sub_region_sub_region1_idx` (`sub_region_id` ASC),
  CONSTRAINT `fk_included_sub_region_region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `six910`.`region` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_included_sub_region_shipping_method1`
    FOREIGN KEY (`shipping_method_id`)
    REFERENCES `six910`.`shipping_method` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_included_sub_region_sub_region1`
    FOREIGN KEY (`sub_region_id`)
    REFERENCES `six910`.`sub_region` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`local_data_store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`local_data_store` (
  `store_id` BIGINT NOT NULL,
  `data_store_name` VARCHAR(50) NOT NULL,
  `reload` TINYINT(1) NOT NULL DEFAULT 0,
  `reload_date` DATETIME NOT NULL,
  INDEX `fk_local_data_store_store1_idx` (`store_id` ASC),
  PRIMARY KEY (`store_id`, `data_store_name`),
  CONSTRAINT `fk_local_data_store_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`instances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`instances` (
  `instance_name` VARCHAR(100) NOT NULL,
  `reload_date` DATETIME NOT NULL,
  `store_id` BIGINT NOT NULL,
  `data_store_name` VARCHAR(50) NOT NULL,
  INDEX `fk_instances_local_data_store1_idx` (`store_id` ASC, `data_store_name` ASC),
  PRIMARY KEY (`instance_name`, `store_id`, `data_store_name`),
  CONSTRAINT `fk_instances_local_data_store1`
    FOREIGN KEY (`store_id` , `data_store_name`)
    REFERENCES `six910`.`local_data_store` (`store_id` , `data_store_name`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`datastore_write_lock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`datastore_write_lock` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `datastore_name` VARCHAR(50) NOT NULL,
  `locked` TINYINT(1) NOT NULL DEFAULT 0,
  `locking_instance_name` VARCHAR(100) NOT NULL,
  `store_id` BIGINT NOT NULL,
  `locked_time` DATETIME NOT NULL,
  `locked_by_user` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_datastore_lock_store1_idx` (`store_id` ASC),
  CONSTRAINT `fk_datastore_lock_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `six910`.`store` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`order_transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`order_transaction` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT NOT NULL,
  `transaction_id` VARCHAR(150) NULL,
  `date_entered` DATETIME NOT NULL,
  `type` VARCHAR(45) NULL,
  `method` VARCHAR(50) NULL,
  `amount` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `approval` VARCHAR(150) NULL,
  `ref_number` VARCHAR(200) NULL,
  `avs` VARCHAR(150) NULL,
  `response_message` VARCHAR(150) NULL,
  `response_code` VARCHAR(50) NULL,
  `gwid` INT NOT NULL DEFAULT 0,
  `success` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_order_transaction_order1_idx` (`order_id` ASC),
  CONSTRAINT `fk_order_transaction_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `six910`.`orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`zone_zip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`zone_zip` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `zip_code` VARCHAR(15) NOT NULL,
  `included_sub_region_id` BIGINT NOT NULL DEFAULT 0,
  `excluded_sub_region_id` BIGINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_zone_zip_included_sub_region1_idx` (`included_sub_region_id` ASC),
  INDEX `fk_zone_zip_excluded_sub_region1_idx` (`excluded_sub_region_id` ASC),
  CONSTRAINT `fk_zone_zip_included_sub_region1`
    FOREIGN KEY (`included_sub_region_id`)
    REFERENCES `six910`.`included_sub_region` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_zone_zip_excluded_sub_region1`
    FOREIGN KEY (`excluded_sub_region_id`)
    REFERENCES `six910`.`excluded_sub_region` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`payment_gateway`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`payment_gateway` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `store_plugins_id` BIGINT NOT NULL,
  `checkout_url` VARCHAR(150) NULL,
  `post_order_url` VARCHAR(150) NULL,
  `logo_url` VARCHAR(150) NULL,
  `client_id` VARCHAR(150) NULL,
  `client_key` VARCHAR(150) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_payment_gateway_store_plugins1_idx` (`store_plugins_id` ASC),
  CONSTRAINT `fk_payment_gateway_store_plugins1`
    FOREIGN KEY (`store_plugins_id`)
    REFERENCES `six910`.`store_plugins` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `six910`.`order_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `six910`.`order_comment` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `comment` TEXT(2000) NOT NULL,
  `order_id` BIGINT NOT NULL,
  `username` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_comment_order1_idx` (`order_id` ASC),
  CONSTRAINT `fk_order_comment_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `six910`.`orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

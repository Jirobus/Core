-- MySQL Script generated by MySQL Workbench
-- Thu 21 May 2020 12:12:08 EEST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`projects` ;

CREATE TABLE IF NOT EXISTS `mydb`.`projects` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`roles` ;

CREATE TABLE IF NOT EXISTS `mydb`.`roles` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `projects_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_roles_projects1_idx` (`projects_id` ASC) VISIBLE,
  CONSTRAINT `fk_roles_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `mydb`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`persons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`persons` ;

CREATE TABLE IF NOT EXISTS `mydb`.`persons` (
  `id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `publickey` VARCHAR(1000) NULL,
  `qualities` JSON NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`tasks` ;

CREATE TABLE IF NOT EXISTS `mydb`.`tasks` (
  `id` INT NOT NULL,
  `details` JSON NULL,
  `projects_id` INT NOT NULL,
  `persons_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tasks_projects1_idx` (`projects_id` ASC) VISIBLE,
  INDEX `fk_tasks_persons1_idx` (`persons_id` ASC) VISIBLE,
  CONSTRAINT `fk_tasks_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `mydb`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tasks_persons1`
    FOREIGN KEY (`persons_id`)
    REFERENCES `mydb`.`persons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`signatures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`signatures` ;

CREATE TABLE IF NOT EXISTS `mydb`.`signatures` (
  `data` JSON NULL,
  `roles_id` INT NOT NULL,
  `tasks_id` INT NOT NULL,
  `persons_id` INT NOT NULL,
  INDEX `fk_signatures_roles_idx` (`roles_id` ASC) VISIBLE,
  INDEX `fk_signatures_tasks1_idx` (`tasks_id` ASC) VISIBLE,
  INDEX `fk_signatures_persons1_idx` (`persons_id` ASC) VISIBLE,
  CONSTRAINT `fk_signatures_roles`
    FOREIGN KEY (`roles_id`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_signatures_tasks1`
    FOREIGN KEY (`tasks_id`)
    REFERENCES `mydb`.`tasks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_signatures_persons1`
    FOREIGN KEY (`persons_id`)
    REFERENCES `mydb`.`persons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`artefacts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`artefacts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`artefacts` (
  `id` INT NOT NULL,
  `unique_name` VARCHAR(45) NOT NULL,
  `projects_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique_name_UNIQUE` (`unique_name` ASC) VISIBLE,
  INDEX `fk_artefacts_projects1_idx` (`projects_id` ASC) VISIBLE,
  CONSTRAINT `fk_artefacts_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `mydb`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`artefact_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`artefact_roles` ;

CREATE TABLE IF NOT EXISTS `mydb`.`artefact_roles` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`artefact_links`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`artefact_links` ;

CREATE TABLE IF NOT EXISTS `mydb`.`artefact_links` (
  `artefact_roles_id` INT NOT NULL,
  `artefacts_id` INT NOT NULL,
  `tasks_id` INT NOT NULL,
  INDEX `fk_artefact_links_artefact_roles1_idx` (`artefact_roles_id` ASC) VISIBLE,
  INDEX `fk_artefact_links_artefacts1_idx` (`artefacts_id` ASC) VISIBLE,
  INDEX `fk_artefact_links_tasks1_idx` (`tasks_id` ASC) VISIBLE,
  CONSTRAINT `fk_artefact_links_artefact_roles1`
    FOREIGN KEY (`artefact_roles_id`)
    REFERENCES `mydb`.`artefact_roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artefact_links_artefacts1`
    FOREIGN KEY (`artefacts_id`)
    REFERENCES `mydb`.`artefacts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artefact_links_tasks1`
    FOREIGN KEY (`tasks_id`)
    REFERENCES `mydb`.`tasks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`role_links`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`role_links` ;

CREATE TABLE IF NOT EXISTS `mydb`.`role_links` (
  `roles_id` INT NOT NULL,
  `persons_id` INT NOT NULL,
  INDEX `fk_role_links_roles1_idx` (`roles_id` ASC) VISIBLE,
  INDEX `fk_role_links_persons1_idx` (`persons_id` ASC) VISIBLE,
  CONSTRAINT `fk_role_links_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_links_persons1`
    FOREIGN KEY (`persons_id`)
    REFERENCES `mydb`.`persons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

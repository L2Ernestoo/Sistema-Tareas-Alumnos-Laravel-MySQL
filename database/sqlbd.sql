-- MySQL Script generated by MySQL Workbench
-- Wed Jun  2 19:18:31 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema laravel_redesmynr
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema laravel_redesmynr
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `laravel_redesmynr` DEFAULT CHARACTER SET latin1 ;
USE `laravel_redesmynr` ;

-- -----------------------------------------------------
-- Table `laravel_redesmynr`.`materias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laravel_redesmynr`.`materias` (
  `id_materia` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_materia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `laravel_redesmynr`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laravel_redesmynr`.`roles` (
  `id_rol` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `laravel_redesmynr`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laravel_redesmynr`.`users` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `email_verified_at` TIMESTAMP NULL DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  `remember_token` VARCHAR(100) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `roles_id_rol` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `users_email_unique` (`email` ASC),
  INDEX `fk_users_roles1_idx` (`roles_id_rol` ASC),
  CONSTRAINT `fk_users_roles1`
    FOREIGN KEY (`roles_id_rol`)
    REFERENCES `laravel_redesmynr`.`roles` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `laravel_redesmynr`.`actividades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laravel_redesmynr`.`actividades` (
  `id_actividad` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `url_actividad` VARCHAR(45) NULL DEFAULT NULL,
  `id_docente` BIGINT(20) UNSIGNED NOT NULL,
  `id_materia` INT(11) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id_actividad`),
  INDEX `fk_archivos_users1_idx` (`id_docente` ASC),
  INDEX `fk_archivos_materias1_idx` (`id_materia` ASC),
  CONSTRAINT `fk_archivos_materias1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `laravel_redesmynr`.`materias` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_archivos_users1`
    FOREIGN KEY (`id_docente`)
    REFERENCES `laravel_redesmynr`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `laravel_redesmynr`.`entregas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laravel_redesmynr`.`entregas` (
  `id_entrega` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NULL DEFAULT NULL,
  `url_entrega` VARCHAR(200) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `users_id` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_entrega`),
  INDEX `fk_entregas_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_entregas_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `laravel_redesmynr`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `laravel_redesmynr`.`failed_jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laravel_redesmynr`.`failed_jobs` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `connection` TEXT NOT NULL,
  `queue` TEXT NOT NULL,
  `payload` LONGTEXT NOT NULL,
  `exception` LONGTEXT NOT NULL,
  `failed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `laravel_redesmynr`.`migrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laravel_redesmynr`.`migrations` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` VARCHAR(255) NOT NULL,
  `batch` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `laravel_redesmynr`.`password_resets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laravel_redesmynr`.`password_resets` (
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  INDEX `password_resets_email_index` (`email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `laravel_redesmynr`.`social_logins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laravel_redesmynr`.`social_logins` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `provider` VARCHAR(30) NOT NULL,
  `nick_email` VARCHAR(255) NOT NULL,
  `social_id` VARCHAR(255) NOT NULL,
  `user_id` BIGINT(20) UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `social_logins_user_id_foreign` (`user_id` ASC),
  CONSTRAINT `social_logins_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `laravel_redesmynr`.`users` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
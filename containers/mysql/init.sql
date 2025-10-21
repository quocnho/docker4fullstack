-- Initialize database for Fukoji project
-- This script runs after the main SQL dump

-- Ensure the fukoji database exists
CREATE DATABASE IF NOT EXISTS `fukoji` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Use the fukoji database
USE `fukoji`;

-- Grant all privileges to fukoji user
GRANT ALL PRIVILEGES ON `fukoji`.* TO 'fukoji'@'%';
FLUSH PRIVILEGES;

-- Show databases to confirm
SHOW DATABASES;

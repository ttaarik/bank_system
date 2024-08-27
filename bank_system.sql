-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 27. Aug 2024 um 13:04
-- Server-Version: 10.4.32-MariaDB
-- PHP-Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `bank_system`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `accounts`
--

CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `account_type` enum('Girokonto','Sparbuch','Tagesgeldkonto') NOT NULL,
  `balance` decimal(15,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `accounts`
--

INSERT INTO `accounts` (`account_id`, `customer_id`, `account_type`, `balance`) VALUES
(1, 1, 'Girokonto', 1400.00),
(2, 1, 'Sparbuch', 3100.00),
(3, 3, 'Girokonto', 2500.00),
(4, 4, 'Tagesgeldkonto', 4500.00),
(5, 4, 'Girokonto', 500.00),
(6, 4, 'Tagesgeldkonto', 2000.00),
(7, 2, 'Girokonto', 500.00);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cards`
--

CREATE TABLE `cards` (
  `card_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `card_number` varchar(16) NOT NULL,
  `card_type` varchar(50) NOT NULL,
  `expiry_date` date NOT NULL,
  `cvv` varchar(3) NOT NULL,
  `pin` varchar(4) NOT NULL,
  `monthly_spending` decimal(10,2) DEFAULT 0.00,
  `credit_limit` decimal(10,2) NOT NULL,
  `active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `cards`
--

INSERT INTO `cards` (`card_id`, `customer_id`, `card_number`, `card_type`, `expiry_date`, `cvv`, `pin`, `monthly_spending`, `credit_limit`, `active`) VALUES
(1, 1, '2118 2245 5521', 'Visa', '2025-12-01', '123', '4321', 250.00, 5000.00, 1),
(2, 1, '2118 2245 5521', 'MasterCard', '2024-05-01', '456', '5678', 100.00, 3000.00, 1),
(3, 2, '2118 2245 5521', 'Visa', '2023-09-01', '789', '8765', 50.00, 2000.00, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `street` varchar(100) DEFAULT NULL,
  `plz` varchar(10) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `income` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `customers`
--

INSERT INTO `customers` (`customer_id`, `email`, `password`, `first_name`, `last_name`, `street`, `plz`, `city`, `income`) VALUES
(1, 'john.doe@example.com', 'password123', 'John', 'Doe', 'Musterstraße 1', '10115', 'Berlin', 3500),
(2, 'jane.smith@example.com', 'password456', 'Jane', 'Smith', 'Beispielweg 2', '20095', 'Hamburg', 2400),
(3, 'a', 'a', 'Max', 'Mustermann', 'Demoweg 3', '80331', 'München', 6000),
(4, 'lisa.schmidt@example.com', 'password321', 'Lisa', 'Schmidt', 'Teststraße 4', '70173', 'Stuttgart', 4100),
(5, 'test.s@hotmail.com', 'test123', 'Peter', 'Huber', NULL, NULL, NULL, 2800);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `subscriptions`
--

CREATE TABLE `subscriptions` (
  `subscription_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `service_name` varchar(255) NOT NULL,
  `monthly_fee` decimal(10,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `subscriptions`
--

INSERT INTO `subscriptions` (`subscription_id`, `customer_id`, `service_name`, `monthly_fee`, `start_date`, `end_date`, `active`) VALUES
(1, 1, 'Netflix', 12.99, '2023-01-01', NULL, 1),
(2, 1, 'Spotify', 9.99, '2023-02-15', NULL, 1),
(3, 2, 'Amazon Prime', 7.99, '2023-03-10', '2024-03-10', 0),
(4, 2, 'Disney+', 8.99, '2023-04-01', NULL, 1),
(5, 3, 'Hulu', 5.99, '2023-05-20', NULL, 1),
(6, 1, 'YouTube Premium', 11.99, '2023-06-01', NULL, 1),
(7, 3, 'Apple Music', 9.99, '2023-07-15', NULL, 1),
(8, 4, 'HBO Max', 14.99, '2023-08-05', '2024-08-05', 0),
(9, 5, 'Google Play Music', 10.99, '2023-09-01', NULL, 1),
(10, 5, 'Starz', 8.99, '2023-10-01', NULL, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `support_tickets`
--

CREATE TABLE `support_tickets` (
  `ticket_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` enum('open','in_progress','resolved','closed') DEFAULT 'open',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `support_tickets`
--

INSERT INTO `support_tickets` (`ticket_id`, `customer_id`, `subject`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Login Issue', 'Unable to login with my credentials.', 'open', '2024-08-01 10:15:00', NULL),
(2, 2, 'Card Suspended', 'My card was suspended without any reason. Please help.', 'in_progress', '2024-08-02 11:30:00', NULL),
(3, 1, 'Incorrect Transaction', 'There is an incorrect charge on my account. Please investigate.', 'resolved', '2024-08-03 14:45:00', NULL),
(4, 3, 'Subscription Issue', 'I am being charged twice for my Netflix subscription.', 'open', '2024-08-04 09:20:00', NULL),
(5, 4, 'Change PIN', 'I want to change the PIN of my Visa card, but the system is not allowing it.', 'in_progress', '2024-08-05 16:00:00', NULL),
(6, 5, 'Support Request', 'Need help with setting up my account.', 'closed', '2024-08-06 08:50:00', NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `sender_account_id` int(11) DEFAULT NULL,
  `receiver_account_id` int(11) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `transaction_type` enum('withdrawal','deposit','gehalt','transfer') NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `sender_account_id`, `receiver_account_id`, `amount`, `transaction_type`, `timestamp`, `description`) VALUES
(1, 1, 2, 500.00, 'transfer', '2024-08-20 08:00:00', 'Überweisung auf Girokonto'),
(2, 3, 3, 1500.00, 'withdrawal', '2024-08-21 09:00:00', 'Miete August'),
(3, NULL, 4, 2500.00, 'deposit', '2024-08-22 10:00:00', 'Gehalt August'),
(4, 2, 1, 800.00, 'transfer', '2024-08-23 11:00:00', 'Rückzahlung'),
(5, NULL, 5, 1200.00, 'deposit', '2024-08-24 12:00:00', 'Bonus'),
(6, 3, 2, 3000.00, 'transfer', '2024-08-25 13:00:00', 'Überweisung auf Girokonto'),
(7, 5, 3, 1000.00, 'deposit', '2024-08-25 12:00:00', 'Schulden'),
(8, 4, 2, 2500.00, 'transfer', '2024-08-25 14:00:00', 'Überweisung auf Girokonto'),
(9, 5, 3, 2000.00, 'transfer', '2024-08-25 12:00:00', 'Schulden'),
(10, 2, 4, 750.00, 'withdrawal', '2024-08-26 08:00:00', 'Lebensmittel'),
(11, 3, 1, 300.00, 'transfer', '2024-08-26 09:30:00', 'Überweisung für Stromrechnung'),
(12, NULL, 2, 2200.00, 'deposit', '2024-08-26 10:00:00', 'Steuerrückerstattung'),
(13, 4, 5, 950.00, 'transfer', '2024-08-26 11:15:00', 'Miete Rückzahlung'),
(14, 1, 3, 450.00, 'transfer', '2024-08-26 12:30:00', 'Kaution Rückzahlung'),
(15, NULL, 1, 1500.00, 'deposit', '2024-08-26 13:45:00', 'Urlaubsbonus'),
(16, 5, 4, 1300.00, 'transfer', '2024-08-26 14:15:00', 'Überweisung für Autoreparatur'),
(17, NULL, 3, 2800.00, 'deposit', '2024-08-27 07:00:00', 'Freelance Projekt'),
(18, 2, 5, 1000.00, 'withdrawal', '2024-08-27 08:00:00', 'Rechnung für Internet'),
(19, 4, 2, 2100.00, 'transfer', '2024-08-27 09:00:00', 'Überweisung auf Sparbuch'),
(20, NULL, 4, 5000.00, 'deposit', '2024-08-27 10:00:00', 'Steuererklärung Rückerstattung');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indizes für die Tabelle `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`card_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indizes für die Tabelle `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indizes für die Tabelle `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`subscription_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indizes für die Tabelle `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indizes für die Tabelle `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `sender_account_id` (`sender_account_id`),
  ADD KEY `receiver_account_id` (`receiver_account_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `accounts`
--
ALTER TABLE `accounts`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `cards`
--
ALTER TABLE `cards`
  MODIFY `card_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT für Tabelle `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `subscription_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints der Tabelle `cards`
--
ALTER TABLE `cards`
  ADD CONSTRAINT `cards_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints der Tabelle `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints der Tabelle `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD CONSTRAINT `support_tickets_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints der Tabelle `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`sender_account_id`) REFERENCES `accounts` (`account_id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`receiver_account_id`) REFERENCES `accounts` (`account_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

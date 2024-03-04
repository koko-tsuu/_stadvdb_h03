# Dirty Read
SET SESSION TRANSACTION ISOLATION LEVEL serializable;
SET autocommit=0;

CREATE TABLE Accounts(id INT AUTO_INCREMENT PRIMARY KEY, amount INT);
ALTER TABLE accounts ENGINE = InnoDB;

## 1_Transaction A - Values that have been committed
START TRANSACTION;
INSERT INTO accounts(amount) VALUES (100);
INSERT INTO accounts(amount) VALUES (200);
INSERT INTO accounts(amount) VALUES (300);
INSERT INTO accounts(amount) VALUES (400);
INSERT INTO accounts(amount) VALUES (500);
COMMIT;

## 1_Transaction B - Values haven't been committed
START TRANSACTION;
INSERT INTO accounts (amount) VALUES (350);
DO SLEEP(8);
COMMIT;

## 2_Read while uncommitted
START TRANSACTION;
SELECT * FROM accounts WHERE amount < 400;
COMMIT;

DELETE FROM accounts;


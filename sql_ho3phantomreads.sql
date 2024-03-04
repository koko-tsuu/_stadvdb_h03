# Phantom Reads
SET SESSION TRANSACTION ISOLATION LEVEL serializable;
SET autocommit=0;

CREATE TABLE Accounts(id INT AUTO_INCREMENT PRIMARY KEY, amount INT);
ALTER TABLE accounts ENGINE = InnoDB;

## 0_test values
START TRANSACTION;
INSERT INTO accounts(amount) VALUES (100);
INSERT INTO accounts(amount) VALUES (200);
INSERT INTO accounts(amount) VALUES (300);
INSERT INTO accounts(amount) VALUES (400);
INSERT INTO accounts(amount) VALUES (500);
COMMIT;

## 1_Transaction A - read table twice
START TRANSACTION;
SELECT SUM(amount) FROM accounts;
DO SLEEP(8);
SELECT SUM(amount) FROM accounts;
COMMIT;

# 2_Transaction B - insert a value
START TRANSACTION;
INSERT INTO accounts(amount) VALUES (6969);
COMMIT;

DELETE FROM accounts;

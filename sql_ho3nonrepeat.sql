# Non-repeatable reads
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
SELECT * FROM accounts WHERE amount > 300;
DO SLEEP(8);
SELECT * FROM accounts WHERE amount > 300;
COMMIT;

# 2_Transaction B - update a value
START TRANSACTION;
UPDATE accounts
SET amount = 1000
WHERE amount < 300;
COMMIT;

DELETE FROM accounts;


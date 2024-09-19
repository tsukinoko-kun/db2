DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
  id VARCHAR(255),
  balance INTEGER NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO accounts (id, balance) VALUES ('bob', 100);
INSERT INTO accounts (id, balance) VALUES ('alice', 100);

SELECT * FROM accounts;
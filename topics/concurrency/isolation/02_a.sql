BEGIN;

UPDATE accounts SET balance = balance - 30 WHERE id = 'alice';
UPDATE accounts SET balance = balance + 30 WHERE id = 'bob';

SELECT pg_sleep(30);

COMMIT;
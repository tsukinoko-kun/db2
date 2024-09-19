BEGIN;

/* select for update, don't wait if it is locked */
SELECT * FROM accounts WHERE id = 'alice' FOR UPDATE NOWAIT;

UPDATE accounts SET balance = balance + 50 WHERE id = 'alice';

COMMIT;
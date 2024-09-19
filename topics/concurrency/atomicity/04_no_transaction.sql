/* make postgres stop processing after an error happens */
\set ON_ERROR_STOP on

UPDATE accounts SET balance = balance - 30 WHERE id = 'alice';

/* this statement is not valid - the is no attribute x */
SELECT x FROM accounts;

UPDATE accounts SET balance = balance + 30 WHERE id = 'bob';
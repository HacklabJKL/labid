-- -*- mode: sql; sql-product: sqlite; -*-
BEGIN;

-- Table of users with basic user information
CREATE TABLE user (
	id INTEGER PRIMARY KEY,
	full_name TEXT NOT NULL,
	nick TEXT,
	email TEXT UNIQUE NOT NULL,
	tel TEXT,                   -- E.164
	municipality TEXT,
	birthyear TEXT,             -- YYYY format
	lang TEXT,                  -- ISO 639‑1
	member_type TEXT NOT NULL,  -- 'basic' or 'key'
	discount_end DATE,          -- ISO 8601. Affects the membership fee when in future.
	joined DATE,                -- ISO 8601
	creditor_ref TEXT UNIQUE    -- ISO 11649
);

CREATE INDEX ix_user_joined ON user (joined);
CREATE INDEX ix_user_discount_end ON user (discount_end);
CREATE INDEX ix_user_nick ON user (nick);

-- Table of payments
CREATE TABLE payment (
	user_id INTEGER NOT NULL REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE,
	date DATE NOT NULL,
	amount NUMERIC NOT NULL,
	msg TEXT
);

CREATE INDEX ix_payment_user_date ON payment (user_id, date);
CREATE INDEX ix_payment_date ON payment (date);

-- Table for auxiliary user data such as secondary emails, key credentials or so.
CREATE TABLE user_data (
 	user_id INTEGER NOT NULL REFERENCES user(id) ON UPDATE CASCADE ON DELETE CASCADE,
 	k TEXT NOT NULL,
	v TEXT
);

CREATE INDEX ix_user_data_id ON user_data (user_id);

END;

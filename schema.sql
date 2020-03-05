-- -*- mode: sql; sql-product: sqlite; -*-
BEGIN;

-- Table of users with basic user information
CREATE TABLE user (
	id INTEGER PRIMARY KEY,
	email TEXT UNIQUE NOT NULL,
	joined DATE,
	member_type TEXT NOT NULL,
	discount_end DATE,
	nick TEXT,
	ref TEXT UNIQUE
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

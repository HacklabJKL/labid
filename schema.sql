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
	user_id INTEGER NOT NULL,
	date TEXT NOT NULL,
	amount NUMERIC NOT NULL,
	msg TEXT,
	FOREIGN KEY (user_id) REFERENCES user(id)
)

-- Table for auxiliary user data such as secondary emails, key credentials or so.
CREATE TABLE user_data (
 	user_id INTEGER NOT NULL,
 	k TEXT NOT NULL,
	v TEXT
	FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE INDEX ix_user_data_id ON user_datacredential (user_id);

END;

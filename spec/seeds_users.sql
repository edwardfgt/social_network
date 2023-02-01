TRUNCATE TABLE users, posts RESTART IDENTITY; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO users (email, username) VALUES ('edward@makers.com', 'Edward');
INSERT INTO users (email, username) VALUES ('luke@makers.com', 'Luke');
INSERT INTO users (email, username) VALUES ('cassius@makers.com', 'Cassius');
INSERT INTO posts (content, views, user_id) VALUES ('Hello world', 2000, 2)
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email text,
  username text
);
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  content text,
  views int,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);
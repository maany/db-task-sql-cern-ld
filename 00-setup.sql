-- 7. Modify the database schema in order to improve the performance of all the queries in 02-queries.sql
--     - You can modify the database schema as you wish as long as the queries are executed properly by PostgreSQL 9.3.
--     - For each modification, justify your choice with a comment

-- TODO: Documenting Task 7 as text.
-- 1. Alter table messages and add a new column
--        ancestor_length NUMERIC DEFAULT 0;
-- 2. Add a Trigger on messages table to do the following pseudocode before insert:
--        if quoted_message_id for new_record is not none then
--                set new_record.ancestor_length := quoted_message.ancestor_length + 1;
--        else
--                do_nothing
-- This way finding chain lengths is a single lookup operation as opposed to my current solution for part 5 and 6.



CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(32) NOT NULL,
  email VARCHAR(128) NOT NULL,
  passsword VARCHAR(256) NOT NULL,
  ip VARCHAR(39) NOT NULL
);

CREATE TABLE rooms (
  id SERIAL PRIMARY KEY,
  owner INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL
);

CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  room_id INTEGER NOT NULL,
  quoted_message_id INTEGER NOT NULL DEFAULT '0',
  content VARCHAR NOT NULL,
  ip VARCHAR(39) NOT NULL
);


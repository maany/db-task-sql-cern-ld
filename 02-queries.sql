
-- 1. What user posted the most messages in room 1 (room whose id is 1), and how many did he sent?
--     - Your query should return a table with columns (`user_id`, `count`)
--     - Your query should return at most 1 row.
SELECT user_id
, COUNT(*)
FROM messages
WHERE room_id = 1
GROUP BY user_id
ORDER BY 2 DESC
LIMIT 1;


-- 2. In what room did user 1 (user whose id is 1) send the most messages, and how many messages did he send in this room?
--     - Your query should return a table with columns (`room_id`, `room_name`, `count`)
--     - Your query should return at most 1 row
SELECT m.room_id
, r.name AS room_name
, COUNT(*) AS count
FROM messages AS m
JOIN rooms AS r
ON r.id = m.room_id
WHERE user_id = 1
GROUP BY room_id, room_name
ORDER BY count DESC
LIMIT 1;


-- 3. Is there any message quoting a message which has been posted in a different room?
--     - Your query should return a table with columns (`message_id`, `message_room_name`, `quoted_message_id`, `quoted_message_room_name`)
--     - Results should be sorted by descending message_id
SELECT m1.id AS message_id
, r1.name AS message_room_name
, m1.quoted_message_id
, r2.name AS quoted_message_room_name
-- Need to join messages twice to get room_ids for message and quoted message
FROM messages AS m1
JOIN messages AS m2
ON m1.quoted_message_id = m2.id
-- Need to join rooms twice to get names for message and quoted message
JOIN rooms AS r1
ON r1.id = m1.room_id
JOIN rooms AS r2
ON r2.id = m2.room_id
-- Filter only to rows where message and quoted message are from different rooms
WHERE r1.id != r2.id
ORDER BY message_id DESC;


-- 4. For each user, display the number of different ips he used
--     - Ips should be retrieved from the `users` and `messages` tables
--     - Your query should return a table with columns (`user_id`, `count`)
--     - Results should be sorted by ascending user_id
SELECT user_id
, COUNT(*)
FROM (
  SELECT user_id, ip FROM messages
  UNION -- No ALL as we want unique IP counts per user
  SELECT id AS user_id, ip FROM users
) AS ip_union
GROUP BY user_id
ORDER BY user_id;


-- 5. How long is the quote chain for message 7 (message whose id is 7)?
--     - Example: If message C quotes message B which itself quotes message A, and we consider message C, then there is a quote chain from message A to message B and the length of the quote chain is 2 (= number of embedded quotes).
--     - Your query should return a table with a single column named `count`
--     - Your query should return at most 1 row

-- Using a Recursive Common Table Expression to determine full length of quote chain
WITH RECURSIVE rec AS
(
  -- Non-recursive statement starting the chain at message 7
  SELECT id FROM messages where id = 7
  UNION
  -- Recursive statement unioning all messages in the quote chain
  SELECT messages.id
  FROM rec, messages
  WHERE messages.quoted_message_id = rec.id
)
-- Subtract one from count to follow chain length convention
-- (A --> B --> C == 2)
SELECT COUNT(*) -1 AS count
FROM rec;




-- 6. What is the maximum quote chain length?
--     - Your query should return a table with columns (`message_id`, `count`) where message_id is the id of the message which is quoting all the others
--     - Your query should return at most 1 row

WITH RECURSIVE rec AS
(
  -- Non-recursive statement starting the chain at top/ancestor messages
  SELECT id, NULL AS msg_chain, id AS message_id
  FROM messages
  WHERE quoted_message_id = 0
  UNION
  -- Recursive statement unioning all messages in the quote chain
  SELECT messages.id
  , CASE
    WHEN rec.msg_chain IS NULL THEN messages.quoted_message_id::TEXT
    ELSE rec.msg_chain || ',' || messages.quoted_message_id::TEXT
  END AS msg_chain
  , rec.message_id AS message_id
  FROM rec, messages
  WHERE messages.quoted_message_id = rec.id
)
-- Subtract one from count to follow chain length convention
-- (A --> B --> C == 2)
SELECT * from (SELECT message_id
-- Count the commas to determine chain length
, CHAR_LENGTH(msg_chain)-CHAR_LENGTH(REPLACE(msg_chain, ',', ''))+1 AS count
FROM rec
WHERE msg_chain IS NOT NULL
ORDER BY 2 DESC) as CHAIN_TRACE fetch first row only;

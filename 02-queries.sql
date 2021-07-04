
-- 1. What user posted the most messages in room 1 (room whose id is 1), and how many did he sent?
--     - Your query should return a table with columns (`user_id`, `count`)
--     - Your query should return at most 1 row.


-- 2. In what room the user 1 (user whose id is 1) has sent the most messages, and how many messages did he sent in this room?
--     - Your query should return a table with columns (`room_id`, `room_name`, `count`)
--     - Your query should return at most 1 row


-- 3. Is there any message quoting a message which has been posted in a different room?
--     - Your query should return a table with columns (`message_id`, `message_room_name`, `quoted_message_id`, `quoted_message_room_name`)
--     - Results should be sorted by descending message_id


-- 4. For each user, display the number of different ips he used
--     - Ips should be retrieved from the `users` and `messages` tables
--     - Your query should return a table with columns (`user_id`, `count`)
--     - Results should be sorted by ascending user_id


-- 5. How long is the quote chain for message 7 (message whose id is 7)?
--     - Example: If message C quotes message B which itself quotes message A, and we consider message C, then there is a quote chain from message A to message B and the length of the quote chain is 2 (= number of embedded quotes).
--     - Your query should return a table with a single column named `count`
--     - Your query should return at most 1 row


-- 6. What is the maximum quote chain length?
--     - Your query should return a table with columns (`message_id`, `count`) where message_id is the id of the message which is quoting all the others
--     - Your query should return at most 1 row

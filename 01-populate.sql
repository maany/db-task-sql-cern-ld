-- You should NOT modify this file

INSERT INTO users
(username, email, passsword, ip)
VALUES
('user 1', 'user1@mail.org', 'user1password', 'IP 1B'),
('user 2', 'user2@mail.org', 'user2password', 'IP 2A'),
('user 3', 'user3@mail.org', 'user3password', 'IP 3A');

INSERT INTO rooms
(owner, name)
VALUES
(1, 'room 1'),
(2, 'room 2');

INSERT INTO messages
(id, user_id, room_id, quoted_message_id, content, ip)
VALUES
(1 , 1, 1, 0, 'Message 01', 'IP 1A'),
(2 , 1, 1, 1, 'Message 02', 'IP 1A'),
(3 , 2, 1, 2, 'Message 03', 'IP 2B'),
(4 , 1, 1, 0, 'Message 04', 'IP 1B'),
(5 , 2, 1, 3, 'Message 05', 'IP 2B'),
(6 , 2, 1, 0, 'Message 06', 'IP 2B'),
(7 , 2, 1, 2, 'Message 07', 'IP 2B'),
(8 , 3, 1, 2, 'Message 08', 'IP 3A'),
(9 , 1, 2, 0, 'Message 09', 'IP 1A'),
(10, 3, 2, 1, 'Message 10', 'IP 3A'),
(11, 1, 2, 0, 'Message 11', 'IP 1A')
;

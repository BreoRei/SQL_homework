-- Получите друзей пользователя с id=1 (решение задачи с помощью представления “друзья”)
USE seminar4;
CREATE OR REPLACE VIEW freinds_id_1_view AS
SELECT initiator_user_id "Друзья ID_1"
FROM friend_requests 
WHERE target_user_id=1 
	AND `status`='approved'
UNION
SELECT target_user_id 
FROM friend_requests 
WHERE initiator_user_id=1 
	AND `status`='approved';
        
SELECT * 
FROM freinds_id_1_view;

-- Создайте представление, в котором будут выводится все сообщения, в которых принимал
-- участие пользователь с id = 1.
CREATE OR REPLACE VIEW posts_id_1_view AS
SELECT body "Сообщения ID_1" 
FROM messages 
WHERE from_user_id=1 
	OR to_user_id=1;
        
SELECT * 
FROM posts_id_1_view;

-- Получите список медиафайлов пользователя с количеством лайков(media m, likes l ,users u)    
CREATE OR REPLACE VIEW likes_view 
AS  
SELECT l.media_id, COUNT(l.media_id) AS likes FROM likes l
GROUP BY l.media_id;
  
CREATE OR REPLACE VIEW users_likes_view AS
SELECT CONCAT(u.firstname, " ", u.lastname) username,  m.filename file_, l.likes likes_
FROM media m
LEFT JOIN likes_view l
ON l.media_id = m.id
JOIN users u 
ON u.id = m.user_id
ORDER BY user_id;

SELECT * 
FROM users_likes_view;

-- Получите количество групп у пользователей
CREATE OR REPLACE VIEW group_view 
AS
SELECT u_c.user_id, COUNT(community_id) AS count_
FROM users_communities u_c
GROUP BY u_c.user_id;

SELECT CONCAT(u.firstname, " ", u.lastname) username, g.count_
FROM users u
LEFT JOIN group_view g
ON g.user_id = u.id;

-- Вывести 3 пользователей с наибольшим количеством лайков за медиафайлы
SELECT username, SUM(likes_) AS likes_sum
FROM users_likes_view
GROUP BY username
ORDER BY likes_sum DESC
LIMIT 3;
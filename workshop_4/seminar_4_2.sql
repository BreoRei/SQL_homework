# Задание №1. Вывести на экран сколько машин каждого цвета для машин марок BMW и LADA
SELECT MARK "Марка авто",COLOR "Цвет",COUNT(COLOR) "Кол-во цветов"
	FROM AUTO
    WHERE MARK IN ("BMW","LADA")
    GROUP BY COLOR,MARK;
	    
# Задание №2. Вывести на экран марку авто и количество AUTO не этой марки
SELECT DISTINCT MARK "Марка авто", 
				(SELECT count(MARK) 
					   FROM AUTO  
					   WHERE AUTO.MARK != a.MARK) AS "Кол-во авто других марок" 
FROM AUTO a;    

# Задание №3.
-- Напишите запрос, который вернет строки из таблицы test_a, id которых нет в таблице test_b, НЕ используя ключевого слова NOT.
SELECT a.data
FROM test_a a
LEFT JOIN test_b b
    ON a.id=b.id
WHERE b.id IS NULL;

# Задание №4
-- выбрать всех пользователей, указав их id, имя и фамилию, город и аватарку
-- (используя вложенные запросы)
SELECT u.id, 
	CONCAT(u.firstname," ",u.lastname) "имя,фамилия", 
	(SELECT hometown 
		FROM `profiles` p 
		WHERE u.id=p.user_id) "Город", 
    (SELECT filename
		FROM media m
        WHERE (SELECT photo_id FROM `profiles` p WHERE u.id=p.user_id)=m.id) "Aватар"
FROM users u;

-- выбрать фотографии (filename) пользователя с email: arlo50@example.org . ID типа медиа, соответствующий фотографиям неизвестен.
-- (используя вложенные запросы)
SELECT m.filename "Графические фаилы"
	FROM media m
	WHERE 		
		((SELECT id 
			FROM users
			WHERE email="arlo50@example.org")=m.user_id 
		AND 
        (SELECT id 
			FROM media_types 
            WHERE name_type="Photo")=m.media_type_id);

-- выбрать id друзей пользователя с id = 1
-- (используя UNION)

SELECT initiator_user_id 
	FROM friend_requests 
	WHERE target_user_id=1 
		AND `status`='approved'
UNION
SELECT target_user_id 
	FROM friend_requests 
	WHERE initiator_user_id=1 
		AND `status`='approved';

-- выбрать всех пользователей, указав их id, имя и фамилию, город и аватарку
-- (используя JOIN)

SELECT u.id, 
	CONCAT(u.firstname," ",u.lastname) "имя,фамилия", 
	p.hometown "Город", 
	m.filename "Aватар"
FROM users u
LEFT JOIN `profiles` p
	ON u.id=p.user_id
LEFT JOIN media m
	ON m.id=p.photo_id;   

-- Список медиафайлов пользователей, указав название типа медиа (id, filename, name_type)
-- (используя JOIN)
SELECT m.user_id, m.filename, mt.name_type 
FROM media m
JOIN media_types mt
	ON m.media_type_id = mt.id
ORDER BY user_id;
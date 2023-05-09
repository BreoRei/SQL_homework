USE seminar_6;

-- Выведите только четные числа от 1 до 10.
-- Пример: 2,4,6,8,10

DROP PROCEDURE IF EXISTS even_num;
DELIMITER $$
CREATE PROCEDURE even_num
(	
)
BEGIN
	DECLARE inner_num INT DEFAULT 2; 
    DECLARE str_even VARCHAR(100) DEFAULT "";    
    
    WHILE inner_num < 10 DO
		SET str_even = CONCAT(str_even, inner_num, ",");
		SET inner_num = inner_num + 2;   
    END WHILE;
    
    SET str_even = CONCAT(str_even, inner_num);
    SELECT str_even;
END $$

CALL even_num();



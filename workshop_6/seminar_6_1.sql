CREATE DATABASE IF NOT EXISTS seminar_6;
USE seminar_6;

-- Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.

DROP PROCEDURE IF EXISTS format_seconds;
DELIMITER $$
CREATE PROCEDURE format_seconds
(
	IN value_sec INT,
    OUT format_sec VARCHAR(100)
)
BEGIN
	DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE seconds INT;
		
    SET format_sec = "";     
    
    IF value_sec > 0 THEN    
		SET days =  FLOOR(value_sec / 86400);
        SET seconds = value_sec - (days * 86400);
        SET hours = FLOOR(seconds / 3600);
		SET seconds = seconds - (hours * 3600);
		SET minutes = FLOOR(seconds / 60);
		SET seconds = seconds - (minutes * 60); 
        
		IF value_sec >= 86400 THEN
			SET format_sec = CONCAT(days, ' days, ', hours, ' hours, ', minutes, ' minutes, ', seconds, ' seconds');
		ELSEIF value_sec < 86400 AND value_sec >=3600 THEN
			SET format_sec = CONCAT(hours, ' hours, ', minutes, ' minutes, ', seconds, ' seconds');
		ELSEIF value_sec < 3600 AND value_sec >= 60 THEN
			SET format_sec = CONCAT(minutes, ' minutes, ', seconds, ' seconds');
		ELSE
			SET format_sec = CONCAT(seconds, ' seconds');
		END IF;
	ELSE
		SET format_sec = 'Invalid format';
    END IF;           
END $$

CALL format_seconds(123456, @result);
SELECT @result;
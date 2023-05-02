# 1.	Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов
CREATE OR REPLACE VIEW cars25_view AS
SELECT
	id, name, cost AS "Цена до 25000"
FROM cars
WHERE cost<"25000"
ORDER BY cost;

SELECT * FROM cars25_view;

# 2.	Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 
ALTER VIEW cars25_view AS
SELECT
	id, name, cost AS "Цена до 30000"
FROM cars
WHERE cost<"30000"
ORDER BY cost;

RENAME TABLE cars25_view TO cars30_view;

SELECT * FROM cars30_view;

# 3. 	Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE OR REPLACE VIEW skoda_audi_view AS
SELECT
	id, name, cost
FROM cars 
WHERE name IN("Audi","Skoda")
ORDER BY cost;

SELECT * FROM skoda_audi_view;

# 4. Добавьте новый столбец под названием «время до следующей станции».
-- 1  
SELECT train_id,station,station_time, 
	TIMEDIFF(LEAD(station_time) OVER(PARTITION BY train_id),station_time) AS time_to_next_station
FROM trains;

-- 2
SELECT train_id,station,station_time,
	TIME(LEAD(station_time) OVER(PARTITION BY train_id)) - INTERVAL station_time HOUR_SECOND AS time_to_next_station
FROM trains;

-- 3
SELECT train_id,station,station_time,
	SUBTIME(LEAD(station_time) OVER (PARTITION BY train_id), station_time) AS time_to_next_station
FROM trains;

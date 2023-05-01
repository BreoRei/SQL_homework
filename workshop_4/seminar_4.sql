-- Используя JOIN-ы, выполните следующие операции:
# Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)
SELECT s.shopname, c.name FROM shops s JOIN cats c ON s.id = c.shops_id;

# Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)
# 1 способ
SELECT s.shopname, c.name 
	FROM shops s 
    JOIN cats c 
    ON s.id = c.shops_id WHERE c.name='Murzik';
    
# 2 способ   
SELECT s.shopname, c.name 
	FROM shops s 
	JOIN (SELECT cats.shops_id, cats.name FROM cats WHERE cats.name='Murzik') c 
    ON s.id = c.shops_id;

# Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”
SELECT s.shopname
FROM shops s
LEFT JOIN cats c
ON s.id = c.shops_id
AND (c.name = "Murzik" OR c.name = "Zuza")
WHERE c.shops_id IS NULL;

# Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.
SELECT a.an_name AS 'Название анализа', a.an_price AS 'Цена', o.ord_datetime
FROM Analysis a
JOIN Orders o
ON a.an_id = o.ord_an
AND o.ord_datetime BETWEEN '2020-02-05' AND '2020-02-12';
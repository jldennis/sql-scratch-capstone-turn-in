 SELECT *
 FROM survey
 LIMIT 10;
 
 SELECT COUNT(response)
 FROM survey;
 
 SELECT question, COUNT(response)
 FROM survey
 GROUP BY 1;
 
 SELECT *
 FROM quiz
 LIMIT 5;
  SELECT *
 FROM home_try_on
 LIMIT 5;
 SELECT *
 FROM purchase
 LIMIT 5;
 
 SELECT DISTINCT q.user_id,
 		h.user_id IS NOT NULL AS
 'is home_try_on',
 		h.number_of_pairs,
    p.user_id IS NOT NULL AS 'is_purchase'
  FROM quiz q
  LEFT JOIN home_try_on h
  	ON q.user_id = h.user_id
  LEFT JOIN purchase p
  	ON p.user_id = q.user_id
 LIMIT 10;
 
 WITH funnels AS (
 	 SELECT DISTINCT q.user_id,
 		h.user_id IS NOT NULL AS
 'is_home_try_on',
 		h.number_of_pairs,
    p.user_id IS NOT NULL AS 'is_purchase'
  FROM quiz q
  LEFT JOIN home_try_on h
  	ON q.user_id = h.user_id
  LEFT JOIN purchase p
  	ON p.user_id = q.user_id)
  SELECT COUNT(*) AS 'num_quiz',
  SUM(is_home_try_on) AS 'num_try_on',
  SUM(is_purchase) AS 'num_purchase',
  1.0 * SUM(is_home_try_on) /
  COUNT(user_id) AS 'quiz to try on',
  1.0 * SUM(is_purchase) /
  SUM(is_home_try_on) AS 'checkout to purchase'
  FROM funnels;
 
 WITH funnels AS (
 	 SELECT DISTINCT q.user_id,
 		h.user_id IS NOT NULL AS
 'is_home_try_on',
 		h.number_of_pairs,
    p.user_id IS NOT NULL AS 'is_purchase'
  FROM quiz q
  LEFT JOIN home_try_on h
  	ON q.user_id = h.user_id
  LEFT JOIN purchase p
  	ON p.user_id = q.user_id)
SELECT SUM(is_home_try_on) AS 'num_try_on',
			 number_of_pairs  AS 'num_pairs'
FROM funnels
WHERE num_pairs IS NOT NULL
GROUP BY 2;

SELECT COUNT(user_id) AS 'num_of_users', shape
FROM quiz
GROUP BY 2
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) AS 'num_purchased', model_name
FROM purchase
GROUP BY 2
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) AS 'num_purchased', color
FROM purchase
GROUP by 2
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) AS 'num_purchased', model_name, color
FROM purchase
GROUP BY 3
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) AS 'Num_per_price_point',
			price
FROM purchase
GROUP BY 2
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) AS 'purchased', style
FROM purchase
GROUP BY 2;

SELECT COUNT(*) AS 'num_per_style', style
FROM quiz
GROUP BY 2
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) AS 'num_per_color', color
FROM quiz
GROUP BY 2
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) AS 'num_per_shape', shape
FROM quiz
GROUP BY 2
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) AS 'num_per_fit', fit
FROM quiz
GROUP BY 2
ORDER BY COUNT(*) DESC;
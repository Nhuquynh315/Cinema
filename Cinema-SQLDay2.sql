-- Cau 1
SELECT film.name, count(*) AS total_booking
FROM film
JOIN screening ON film.id = screening.film_id
JOIN booking ON booking.id = booking.screening_id
GROUP BY film.name
ORDER BY total_booking DESC
LIMIT 3;

-- Cau 2
SELECT film.name, length_min FROM film WHERE (length_min) > (SELECT AVG(length_min)
FROM film);

-- Cau 3
SELECT room.name, count(*) AS total_screen 
FROM screening
JOIN room ON screening.room_id = room.id
GROUP BY room.id
HAVING total_screen = 
	(SELECT count(*) total_screen 
	FROM screening
    JOIN room ON screening.room_id = room.id
	GROUP BY room.id
    ORDER BY total_screen DESC
    LIMIT 1)
    
UNION ALL (SELECT room.name, count(*) AS total_screen 
FROM screening
JOIN room ON room.id = screening.room_id
GROUP BY room.id
HAVING total_screen = 
	(SELECT count(*) total_screen
	FROM screening
    JOIN room ON screening.room_id = room.id
	GROUP BY room.id
    ORDER BY total_screen
    LIMIT 1));

-- Cau 4
SELECT room.name, room.id, film.name, count(*) AS total_booking_room
FROM room
JOIN screening ON room.id = screening.room_id
JOIN booking ON booking.screening_id = screening.id
JOIN film ON film.id = screening.film_id
WHERE film.name = 'Tom&Jerry'
GROUP BY room_id;

-- Cau 5
SELECT seat.*, count(*) AS total_booked_seat
FROM seat
JOIN reserved_seat ON seat.id = reserved_seat.seat_id
GROUP BY seat.id
HAVING total_booked_seat = 
	(SELECT count(*) total_booked_seat
	FROM seat
	JOIN reserved_seat ON seat.id = reserved_seat.seat_id
	GROUP BY seat.id
	ORDER BY total_booked_seat DESC
	LIMIT 1);
    
-- Cau 6
SELECT film.name, count(*) AS film_most_screen
FROM screening
JOIN film ON film.id = screening.film_id
GROUP BY film.name
HAVING film_most_screen = 
	(SELECT count(*) film_most_screen
	FROM screening
	JOIN film ON film.id = screening.film_id
	GROUP BY film.name
    ORDER BY film_most_screen DESC
    LIMIT 1);
    
-- Cau 7
SELECT date(start_time), count(*) AS day_most_screen
FROM screening
GROUP BY date(start_time)
HAVING day_most_screen =
	(SELECT count(*) day_most_screen
	FROM screening
	GROUP BY date(start_time)
	ORDER BY day_most_screen DESC
	LIMIT 1);
    
-- Cau 8
SELECT distinct film.name
FROM screening
JOIN film ON film.id = screening.film_id
WHERE year(start_time) = 2022 and month(start_time) = 05;

-- Cau 9
SELECT film.name FROM film
WHERE name like '%n';

-- Cau 10
SELECT UPPER(substr(first_name,1,3)), UPPER (RIGHT(last_name,3))
from customer;

-- Cau 11
SELECT film.name, length_min FROM film WHERE (length_min) > 120
/* Forma 1 */
SELECT r.movieID, n.title, avg(rating) as avgRating, count(userID) as ratingCount
FROM ratings r
JOIN names n ON r.movieID = n.movieID
GROUP BY r.movieID, n.title
HAVING ratingCount > 10
ORDER BY avgRating DESC;

/* Forma 2 */
DROP VIEW IF EXISTS topMovieIDs;
CREATE VIEW IF NOT EXISTS topMovieIDs AS
SELECT movieID, count(movieID) as ratingCount, avg(rating) as avgRating
FROM ratings
GROUP BY movieID
ORDER BY avgRating DESC;

SELECT n.title, t.ratingCount, t.avgRating
FROM topMovieIDs t
JOIN names n ON t.movieID = n.movieID
WHERE ratingCount > 10;
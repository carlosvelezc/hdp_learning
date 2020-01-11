ratings = LOAD '/user/maria_dev/ml-100k/u.data' AS (userID:int, movieID:int, rating:int, ratingTime:int);

metadata = 	LOAD '/user/maria_dev/ml-100k/u.item' USING PigStorage('|')
			AS (movieID:int, movieTitle:chararray, releaseDate:chararray, videoRelease:chararray, imbdLink:chararray);
            
nameLookup = FOREACH metadata GENERATE 	movieID, movieTitle, releaseDate,
										ToUnixTime(ToDate(releaseDate, 'dd-MMM-yyyy')) AS releaseTime;
                                        
ratingsByMovie = GROUP ratings BY movieID;

avgRatings = FOREACH ratingsByMovie GENERATE group AS movieID, AVG(ratings.rating) AS avgRating;

fiveStarMovies = FILTER avgRatings BY avgRating > 4.0;

fiveStarsWithData = JOIN fiveStarMovies BY movieID, nameLookup BY movieID;

oldestFiveStarMovies = ORDER fiveStarsWithData BY nameLookup::releaseTime;

oldiesButGoodies = FOREACH oldestFiveStarMovies GENERATE nameLookup::movieTitle AS movie,
														 fiveStarMovies::avgRating AS avgRating,
                                                         nameLookup::releaseDate AS date;

DUMP oldiesButGoodies;
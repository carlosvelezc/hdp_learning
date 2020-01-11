ratings = LOAD '/user/maria_dev/ml-100k/u.data' AS (userID:int, movieID:int, rating:int, ratingTime:int);

metadata = 	LOAD '/user/maria_dev/ml-100k/u.item' USING PigStorage('|')
			AS (movieID:int, movieTitle:chararray, releaseDate:chararray, videoRelease:chararray, imbdLink:chararray);
            
nameLookup = FOREACH metadata GENERATE 	movieID, movieTitle, releaseDate;
                                        
ratingsByMovie = GROUP ratings BY movieID;

avgRatings = FOREACH ratingsByMovie GENERATE group AS movieID, AVG(ratings.rating) AS avgRating, COUNT(ratings.userID) AS numRatings;

badMovies = FILTER avgRatings BY avgRating < 2.0;

namedBadMovies = JOIN badMovies BY movieID, nameLookup BY movieID;

famousBadMovies = ORDER namedBadMovies BY badMovies::numRatings DESC;

mostFamousBadMovies = FOREACH famousBadMovies GENERATE  nameLookup::movieTitle AS movie,
														badMovies::avgRating AS avgRating,
                                                        nameLookup::releaseDate AS date,
                                                        badMovies::numRatings AS numRatings;

DUMP mostFamousBadMovies;
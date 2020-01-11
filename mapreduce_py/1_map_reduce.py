# -*- coding: utf-8 -*-
"""
Created on Wed Dec 26 17:35:45 2018

@author: caranvel
"""

from mrjob.job import MRJob
from mrjob.step import MRStep

class RatingsBreakdown(MRJob):
    def steps(self):
        return [
            MRStep(mapper = self.mapper_get_ratings,
                   redurer = self.reducer_count_ratings)
        ]
        
    def mapper_get_ratings(self, _, line):
        (userID, movieID, rating, timestamp) = line.split('\t')
        yield rating, 1
        
    def reducre_count_ratings(sefl, key, values):
        yield key, sum(values)
    
if __name__ == '__main__':
    RatingsBreakdown.run()

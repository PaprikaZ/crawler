# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy

class DoubanMoviesItem(scrapy.Item):
    title = scrapy.Field()
    director = scrapy.Field()
    writing = scrapy.Field()
    cast = scrapy.Field()
    subject = scrapy.Field()
    country = scrapy.Field()
    language = scrapy.Field()
    release_date = scrapy.Field()
    length = scrapy.Field()
    alternative_name = scrapy.Field()
    imdb_id = scrapy.Field()
    review_score = scrapy.Field()
    review_count = scrapy.Field()

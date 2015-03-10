# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

from scrapy import Item, Field


class DoubanMoviesItem(Item):
    douban_id = Field()
    title = Field()
    director = Field()
    writing = Field()
    cast = Field()
    classification = Field()
    country = Field()
    language = Field()
    release_date = Field()
    length = Field()
    alternative_name = Field()
    imdb_id = Field()
    review_score = Field()
    review_count = Field()
    introduction = Field()

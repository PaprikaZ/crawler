# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

from scrapy import Item, Field


class DoubanCelebritysItem(Item):
    title = Field()
    gender = Field()
    constellation = Field()
    birth_day = Field()
    birth_place = Field()
    profession = Field()
    imdb_id = Field()
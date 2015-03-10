# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html

from re import search, match
from datetime import datetime
from string import strip
import pymongo
from scrapy import log

empty_regex = r'^\s+$'


def clean_invalid_field(field):
    if not field or match(empty_regex, field[0]):
        return []
    else:
        return field


def passby_empty_field(f):
    def wrapper(field):
        if field:
            return f(field)
        else:
            return []
    return wrapper


class DoubanCelebritysPipeline(object):
    def __init__(self):
        self.db = pymongo.MongoClient().douban_movies
        self.celebrity = self.db.celebrity

    def process_item(self, item, _):
        self.celebrity.insert({
            'douban_id': item['douban_id'],
            'title': item['title'][0],
            'name_cn': self.extract_name_cn(item['title']),
            'name_en': self.extract_name_en(item['title']),
            'gender': self.extract_gender(item['gender']),
            'constellation': self.extract_constellation(item['constellation']),
            'birth_day': self.extract_birth_day(item['birth_day']),
            'birth_place': self.extract_birth_place(item['birth_place']),
            'profession': self.extract_profession(item['profession']),
            'imdb_id': self.extract_imdb_id(item['imdb_id']),
        })
        log.msg('douban movie celebrity id %s crawled' % item['douban_id'])
        return item

    @staticmethod
    @passby_empty_field
    def extract_gender(gender):
        return gender[0]

    @staticmethod
    @passby_empty_field
    def extract_constellation(constellation):
        return constellation[0]

    @staticmethod
    @passby_empty_field
    def extract_birth_day(birth_day):
        full_date_regex = r'^(\d{4})-(\d{2})-(\d{2}).*$'
        part_date_regex = r'^(\d{4}).*$'
        if match(full_date_regex, birth_day[0]):
            (y, m, d) = map(int, search(full_date_regex, birth_day[0]).groups())
            return datetime(y, m, d)
        elif match(part_date_regex, birth_day[0]):
            y = int(search(part_date_regex, birth_day[0]).group(1))
            return datetime(y, 1, 1)
        else:
            return datetime(1900, 1, 1)

    @staticmethod
    @passby_empty_field
    def extract_birth_place(birth_place):
        return birth_place[0]

    @staticmethod
    @passby_empty_field
    def extract_profession(profession):
        return profession[0]

    @staticmethod
    @passby_empty_field
    def extract_imdb_id(imdb_id):
        return imdb_id[0]

    @staticmethod
    @passby_empty_field
    def extract_name_cn(title):
        regex = r'^(\S+)\s+(\w.+)$'
        if match(regex, title[0]):
            return search(regex, title[0]).group(1)
        else:
            return []

    @staticmethod
    @passby_empty_field
    def extract_name_en(title):
        regex = r'^(\S+)\s+(\w.+)$'
        if match(regex, title[0]):
            return search(regex, title[0]).group(1)
        else:
            return []

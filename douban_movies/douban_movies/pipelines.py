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


class DoubanMoviesPipeline(object):
    def __init__(self):
        self.db = pymongo.MongoClient().douban_movies
        self.movie = self.db.movie

    def process_item(self, item, _):
        self.movie.insert({
            'douban_id': item['douban_id'],
            'title': item['title'][0],
            'name_cn': self.extract_name_cn(item['title']),
            'name_en': self.extract_name_en(item['title']),
            'director': self.extract_director(item['director']),
            'writing': self.extract_writing(item['writing']),
            'cast': self.extract_cast(item['cast']),
            'classification': self.extract_classification(item['classification']),
            'country': self.extract_country(item['country']),
            'language': self.extract_language(item['language']),
            'release_date': self.extract_release_date(item['release_date']),
            'length': self.extract_length(item['length']),
            'alternative_name': self.extract_alternative_name(item['alternative_name']),
            'imdb_id': self.extract_imdb_id(item['imdb_id']),
            'review_score': self.extract_review_score(item['review_score']),
            'review_count': self.extract_review_count(item['review_count']),
            'introduction': self.extract_introduction(item['introduction'])
        })
        log.msg('douban movie id %s' % item['douban_id'])
        return item

    @staticmethod
    def extract_name_cn(title):
        regex = r'^(\S+)\s+(\w.+)$'
        if match(regex, title[0]):
            return search(regex, title[0]).group(1)
        else:
            return []

    @staticmethod
    def extract_name_en(title):
        regex = r'^(\S+)\s+(\w.+)$'
        if match(regex, title[0]):
            return search(regex, title[0]).group(2)
        else:
            return []

    extract_director = staticmethod(clean_invalid_field)
    extract_writing = staticmethod(clean_invalid_field)
    extract_cast = staticmethod(clean_invalid_field)
    extract_classification = staticmethod(clean_invalid_field)

    @staticmethod
    @passby_empty_field
    def extract_release_date(release_date):
        full_date_regex = r'^(\d{4})-(\d{2})-(\d{2}).*$'
        part_date_regex = r'^(\d{4}).*$'
        if match(full_date_regex, release_date[0]):
            (y, m, d) = map(int, search(full_date_regex, release_date[0]).groups())
            return datetime(y, m, d)
        elif match(part_date_regex, release_date[0]):
            y = int(search(part_date_regex, release_date[0]).group(1))
            return datetime(y, 1, 1)

    @staticmethod
    @passby_empty_field
    def extract_length(length):
        regex = r'(\d+).+$'
        return search(regex, length[0]).group(1)

    @staticmethod
    @passby_empty_field
    def extract_alternative_name(alternative_name):
        if clean_invalid_field(alternative_name):
            delimiter = '/'
            non_empty_regex = r'^\S+$'
            return filter(lambda x: match(non_empty_regex, x),
                          map(strip, alternative_name[0].split(delimiter)))
        else:
            return []

    @staticmethod
    @passby_empty_field
    def extract_country(country):
        if clean_invalid_field(country):
            delimiter = '/'
            non_empty_regex = r'^\S+$'
            return filter(lambda x: match(non_empty_regex, x),
                          map(strip, country[0].split(delimiter)) )
        else:
            return []

    @staticmethod
    @passby_empty_field
    def extract_language(language):
        if clean_invalid_field(language):
            delimiter = '/'
            non_empty_regex = r'^\S+$'
            return filter(lambda x: match(non_empty_regex, x),
                          map(strip, language[0].split(delimiter)))
        else:
            return []

    @staticmethod
    @passby_empty_field
    def extract_imdb_id(imdb_id):
        return imdb_id[0]

    @staticmethod
    @passby_empty_field
    def extract_review_score(review_score):
        if review_score:
            return float(review_score[0])
        else:
            return 0

    @staticmethod
    def extract_review_count(review_count):
        if review_count:
            return int(review_count[0])
        else:
            return 0

    @staticmethod
    @passby_empty_field
    def extract_introduction(introduction):
        return strip(introduction[0])

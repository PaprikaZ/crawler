# -*- coding: utf-8 -*-

# Scrapy settings for douban_movies project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/en/latest/topics/settings.html
#

BOT_NAME = 'douban_movies'

SPIDER_MODULES = ['douban_movies.spiders']
NEWSPIDER_MODULE = 'douban_movies.spiders'

# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'douban_movies (+http://www.yourdomain.com)'

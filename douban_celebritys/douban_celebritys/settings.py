# -*- coding: utf-8 -*-

# Scrapy settings for douban_celebritys project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/en/latest/topics/settings.html
#

BOT_NAME = 'douban_celebritys'

SPIDER_MODULES = ['douban_celebritys.spiders']
NEWSPIDER_MODULE = 'douban_celebritys.spiders'
ITEM_PIPELINES = {
    'douban_celebritys.pipelines.DoubanCelebritysPipeline': 100,
    }

LOG_LEVEL = 'DEBUG'

# Crawl responsibly by identifying yourself (and your website) on the user-agent
DOWNLOAD_DELAY = 2
RANDOMIZE_DOWNLOAD_DELAY = True
COOKIES_ENABLED = True
USER_AGENT = 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0'

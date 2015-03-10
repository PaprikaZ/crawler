__author__ = 'zhujie'

from re import search
from scrapy.contrib.spiders import CrawlSpider, Rule
from scrapy.contrib.linkextractors import LinkExtractor
from douban_celebritys.items import DoubanCelebritysItem


class CelebritySpider(CrawlSpider):
    name = 'douban_celebritys'
    allowed_domains = ['movie.douban.com']

    url_head = 'http://movie.douban.com/tag/'
    year_iterator = xrange(1900, 2020)
    start_urls = [url_head + str(year) for year in year_iterator]

    rules = (
        Rule(LinkExtractor(allow=('tag/\d{4}\?start=\d{1,4}&type=T$', ))),
        Rule(LinkExtractor(allow=('subject/\d+/$', ))),
        Rule(LinkExtractor(allow=('celebrity/\d+/$', )), callback='parse_item'),
    )

    def parse_item(self, response):
        title_xpath = './/*[@id="content"]/h1/text()'
        gender_xpath = './/*[@id="headline"]/div[2]/ul/li[1]/text()[2]'
        constellation_xpath = './/*[@id="headline"]/div[2]/ul/li[2]/text()[2]'
        birth_day_xpath = './/*[@id="headline"]/div[2]/ul/li[3]/text()[2]'
        birth_place_xpath = './/*[@id="headline"]/div[2]/ul/li[4]/text()[2]'
        profession_xpath = './/*[@id="headline"]/div[2]/ul/li[5]/text()[2]'
        imdb_id_xpath = './/*[@id="headline"]/div[2]/ul/li/a[contains(@href, "imdb")]/text()'

        item = DoubanCelebritysItem()
        item['douban_id'] = search(r'(\d+)/$', response.url).group(1)
        item['title'] = response.xpath(title_xpath).extract()
        item['gender'] = response.xpath(gender_xpath).extract()
        item['constellation'] = response.xpath(constellation_xpath).extract()
        item['birth_day'] = response.xpath(birth_day_xpath).extract()
        item['birth_place'] = response.xpath(birth_place_xpath).extract()
        item['profession'] = response.xpath(profession_xpath).extract()
        item['imdb_id'] = response.xpath(imdb_id_xpath).extract()
        yield item

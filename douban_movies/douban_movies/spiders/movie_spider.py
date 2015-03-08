__author__ = 'zhujie'

from scrapy.contrib.spiders import CrawlSpider, Rule
from scrapy.contrib.linkextractors import LinkExtractor
from douban_movies.items import DoubanMoviesItem

class MovieSpider(CrawlSpider):
    name = 'douban_movies'
    allowed_domains = ['movie.douban.com']

    url_head = 'http://movie.douban.com/tag/'
    page_suffix_iterator = ['?start=' + str(20 * i) for i in xrange(100)]
    year_iterator = xrange(1900, 2020)
    start_urls = [url_head + str(year) + suffix
                  for year in year_iterator
                  for suffix in page_suffix_iterator]

    rules = (
        Rule(LinkExtractor(allow=('tag/\d{4}\?start=\d{1,4}&type=T$', ))),
        Rule(LinkExtractor(allow=('subject/\d+/$', )), callback='parse_item'),
    )

    def parse_item(self, response):
        title_xpath = './/*[@id="content"]/h1/span[1]/text()'
        director_xpath = './/*[@id="info"]/span[1]/span[2]/a[@rel="v:directedBy"]/text()'
        writing_xpath = './/*[@id="info"]/span[2]/span[2]/a/text()'
        cast_xpath = './/*[@id="info"]/span[3]/span[2]/a[@rel="v:starring"]/text()'
        classification_xpath = './/*[@id="info"]/span[@property="v:genre"]/text()'
        country_xpath = './/*[@id="info"]/text()[8]'
        language_xpath = './/*[@id="info"]/text()[10]'
        release_date_xpath = './/*[@id="info"]/span[@property="v:initialReleaseDate"]/text()'
        length_xpath = './/*[@id="info"]/span[@property="v:runtime"]/text()'
        alternative_name_xpath = './/*[@id="info"]/text()[16]'
        imdb_id_xpath = './/*[@id="info"]/a/text()'
        review_score_xpath = './/*[@id="interest_sectl"]/div/p[1]/strong/text()'
        review_count_xpath = './/*[@id="interest_sectl"]/div/p[2]/a/span/text()'
        preface_xpath = './/*[@id="link-report"]/span/text()'

        item = DoubanMoviesItem()
        item['title'] = response.xpath(title_xpath).extract()
        item['director'] = response.xpath(director_xpath).extract()
        item['writing'] = response.xpath(writing_xpath).extract()
        item['cast'] = response.xpath(cast_xpath).extract()
        item['classification'] = response.xpath(classification_xpath).extract()
        item['country'] = response.xpath(country_xpath).extract()
        item['language'] = response.xpath(language_xpath).extract()
        item['release_date'] = response.xpath(release_date_xpath).extract()
        item['length'] = response.xpath(length_xpath).extract()
        item['alternative_name'] = response.xpath(alternative_name_xpath).extract()
        item['imdb_id'] = response.xpath(imdb_id_xpath).extract()
        item['review_score'] = response.xpath(review_score_xpath).extract()
        item['review_count'] = response.xpath(review_count_xpath).extract()
        item['preface'] = response.xpath(preface_xpath).extract()
        yield item

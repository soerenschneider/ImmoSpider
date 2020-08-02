import logging
from jinja2 import Environment, FileSystemLoader
from scrapy import signals


logger = logging.getLogger(__name__)

class Table:
	def __init__(self):
		self.items = list()

	@classmethod
	def from_crawler(cls, crawler):
		ext = cls()

		crawler.signals.connect(ext.spider_closed, signal=signals.spider_closed)
		crawler.signals.connect(ext.item_scraped, signal=signals.item_scraped)

		return ext
	
	def item_scraped(self, item, spider):
		self.items.append(item)

	def spider_closed(self, spider):
		if len(self.items) > 0:
			self.print()

	def print(self):
		file_loader = FileSystemLoader('jinja2')
		env = Environment(loader=file_loader)
		template = env.get_template("table.html")

		# render template with the custom variables in your jinja2 template
		html = template.render(title="Email from scraper", items=self.items)
		with open("/home/soeren/apartments.html", "wb") as f:
			f.write(html.encode(encoding='UTF-8'))
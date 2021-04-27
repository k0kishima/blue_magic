class Crawler
  # NOTE: エンティティのデータが複数のページに散財していて、単一のページからスクレイピングできないケースがあるため可変長引数にしている
  # 例えばボートの整備情報など（チルト ・プロペラ、本体整備情報は「直前情報」で取れるが、ボートやモーターの番号は「出走表」にある）
  def initialize(*source_pages)
    @strategy = if source_pages.many?
                  CrawlManyPageToManyScpaerStrategy.new(source_pages)
                else
                  CrawlSinglePageToManyScpaerStrategy.new(source_pages.first)
                end
  end

  def crawl!
    strategy.crawl!
  end

  private

  attr_reader :strategy
end

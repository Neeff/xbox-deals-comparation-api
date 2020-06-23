class GamePage < Kimurai::Base
  attr_accessor :start_urls
  @name = "game_page"
  @engine = :selenium_chrome
  @start_urls = nil
  @config = {
    before_request: { delay: 4..6 }
  }
    def parse(response, url:, data: {})
    detail = {}
    if url.include? 'microsoft'
      banner              = response.at_css('picture#dynamicImage_backgroundImage_picture')
      clasification_image = response.at_css('div.c-age-rating')
      c_category          =  response.at_css('div.c-age-rating').at_css('div.c-paragraph')
      clasification       = response.at_css('div.c-age-rating')
      description         = response.at_css('div.m-product-detail-information')
      detail[:banner]              = banner.nil? ? 'Image not Found' : banner.at_css('img').attr('src')
      detail[:clasification_image] = clasification_image.nil? ? 'Image not Found' : clasification_image.at_css('img').attr('src')
      detail[:clasification]       = clasification.nil? ? 'Clasification not Available' : clasification.at_css('a.c-hyperlink').text
      detail[:c_category]          = c_category.nil? ? 'Categories Not Available' : c_category.text
      detail[:description]         = description.nil? 'Description Not Available' : description.at_css('div.c-content-toggle').at_css('p#product-description').text
      detail[:sale_id]             = data[:sale_id]
      Detail.create(detail)
      #return detail
    else
      banner = response.at_css('picture.c-image')
      detail[:banner] = banner.nil? ? 'Image not Found' : banner.at_css('img').attr('src')
      detail[:clasification_image] = response.at_css('section.m-additional-information').at_css('div.c-age-rating').at_css('img').attr('src')
      detail[:clasification]       = response.at_css('section.m-additional-information').at_css('div.c-age-rating').at_css('p.c-label').at_css('a.c-hyperlink').text
      detail[:c_category]          = nil
      detail[:description]         = response.at_css('div#gamedetails').at_css('div.m-').at_css('p.c-paragraph-1').text
      detail[:sale_id]             = data[:sale_id]
      Detail.create(detail)
      #return detail
    end
   end
end

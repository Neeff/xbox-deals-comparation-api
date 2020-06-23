class ScraperPageGameJob
 include Sidekiq::Worker
 sidekiq_options retry: false

 def perform(url, id)
   p "init process 🎉"
   GamePage.parse!(:parse, url: url, data:{sale_id: id, data_bi_product: data_bi_product})
   p "ok! 👍"
  end
end

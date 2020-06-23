class CreateClusterJob
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform
    batch_urls = Sale.urls
    batch = Sidekiq::Batch.new
    batch.description = 'create cluster of job, scraping main page for each game'
    batch.on(:success, CreateClusterJob::Created, {"cluster_id"=> 99})
    batch.jobs do
      # poner los trabajos aqui!
      batch_urls.each {|data| ScraperPageGameJob.perform_async(data[0],data[1] ) }
    end
  end
  class Created
    def on_success(status, options)
      puts "-----------------------"
      puts status, options
      puts "Created cluster of jobs"
    end

  end
end

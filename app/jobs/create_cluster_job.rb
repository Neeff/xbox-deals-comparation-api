class CreateClusterJob
  include Sidekiq::Worker
  def perform
    batch = Sidekiq::Batch.new
    batch.description = "Creating Cluster"
    batch.on(:success, CreateClusterJob::Created, { 'cluster_id'=> 999 })
    stores =
    [
      ["https://www.xbox.com/en-us/games/xbox-one?cat=onsale", 'Next','us','USD'],
      ["https://www.xbox.com/es-cl/games/xbox-one?cat=onsale&source=lp#%20c-hyperlink", 'Siguiente','cl','CLP'],
      ["https://www.xbox.com/es-ar/games/xbox-one?cat=onsale&source=lp", 'Siguiente','ar','ARS']
    ]
    batch.jobs do
      stores.each { |store| CreateOffersJob.perform_async(store) }
    end
  end
  class Created
    def on_success(status, options)
      puts "-------"
      puts status, options
      puts "Created cluster"
    end
  end
 end

require "pg"

class DatabasePersistance
  attr_accessor :recipes

  def initialize(logger = nil)
    @db = if Sinatra::Base.production?
            PG.connect(ENV['DATABASE_URL'])
          else
            PG.connect(dbname: "recipe_boss")
          end
   @logger = logger
  end

  def disconnect
   @db.close
  end

  def query(statement, *params)
    @logger.info "#{statement}: #{params}" unless @logger.nil?
    @db.exec_params(statement, params)
  end
end

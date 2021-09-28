require "pg"

class DatabasePersistance
  attr_accessor :db

  def initialize(logger = nil)
    @db = if Sinatra::Base.production?
            PG.connect(ENV['DATABASE_URL'])
          elsif ENV["RACK_ENV"] == "test"
            PG.connect(dbname: "recipe_boss_test")
          else
            PG.connect(dbname: "recipe_boss")
          end
    @logger = logger
  end

  def execute(sql)
    @db.exec(sql)
  end

  def disconnect
   @db.close
  end

  def query(statement, *params)
    @logger.info "#{statement}: #{params}" unless @logger.nil?
    @db.exec_params(statement, params)
  end
end

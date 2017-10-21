require 'sequel'

DB = Sequel.connect(
               adapter: :postgres,
               user: ENV['DB_USER'],
               password: ENV['DB_PASSWORD'],
               host: ENV['DB_HOST'],
               port: ENV['DB_PG_PORT'],
               database: ENV['DB']
)

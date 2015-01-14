# if ENV['MONGOLAB_URI']
#   conn = Mongo::MongoClient.from_uri(ENV['MONGOLAB_URI'])
#   MONGO = conn.db(URI.parse(ENV['MONGOLAB_URI']).path.gsub(/^\//, ''))
# else
#   conn = Mongo::MongoClient.new
#   MONGO = conn["nike_charts"]
# end
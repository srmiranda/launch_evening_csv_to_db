#YOUR CODE GOES HERE
require "pg"

def db_connection
  begin
    connection = PG.connect(dbname: "ingredients")
    yield(connection)
  ensure
    connection.close
  end
end

# db_connection do |conn|
#   conn.exec("COPY ingredients FROM '/Users/Sasquatch/challenges/evening-csv-to-db/ingredients.csv' DELIMITER ',' CSV;")
# end

db_connection do |conn|
  results = conn.exec('SELECT number, ingredient FROM ingredients;')
  results.each do |list|
    puts "#{list['number']}. #{list['ingredient']}"
  end
end

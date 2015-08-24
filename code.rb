#YOUR CODE GOES HERE
require "pg"
require "csv"

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

# # D-Rods Way
CSV.foreach("ingredients.csv", headers: true) do |row|
  db_connection do |conn|
    conn.exec_params("INSERT INTO ingredients (number, ingredient) VALUES ($1, $2)", [row["number"], row["ingredient"]])
  end
end


db_connection do |conn|
  results = conn.exec('SELECT * FROM ingredients;')
  results.each do |list|
    puts "#{list['number']}. #{list['ingredient']}"
  end
end

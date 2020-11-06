require 'pg'
require_relative 'dbcon'

class Peep

  attr_reader :id, :message, :posttime

  def initialize(id, message, posttime)
    @id = id
    @message = message
    @posttime = posttime
  end

  def self.all
    table  = DatabaseConnection.query('SELECT * FROM peeps;') # within database, connecting to table
    table.map { |result| Peep.new(result['id'], result['message'], result['posttime']) }
  end

  def self.add(message, posttime = Time.now.strftime("%Y/%m/%d"))
    result = DatabaseConnection.query("INSERT INTO peeps (message, posttime) VALUES('#{message}', '#{posttime}') RETURNING id, message, posttime;")
    Peep.new(result[0]['id'], result[0]['message'], result[0]['posttime'])
  end

end
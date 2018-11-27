require 'sqlite3'
require 'byebug'

module Database
  def insert(object)
    begin
      db = SQLite3::Database.open 'currency_exchange.db'
      db.execute(<<-SQL, *attribute_values(object))
        insert into #{object.tableize} (#{attribute_keys(object)})
        values
          (#{question_marks(object)})
      SQL
    rescue SQLite3::Exception => e
      puts e
    ensure
      db.close if db
    end
  end

  def self.all(object)
    db = SQLite3::Database.open 'currency_exchange.db'
    db.results_as_hash = true
    db.execute2 "select * from #{object.tableize}"
  end

  def self.columns(object)
    db = SQLite3::Database.open 'currency_exchange.db'
    result = db.prepare "select * from #{object.tableize} LIMIT 0"
    result.columns
  end

  private

  def question_marks(object)
    (['?'] * (object.to_hash.keys.size)).join(', ')
  end

  def attribute_keys(object)
    object.to_hash.keys.join(', ')
  end

  def attribute_values(object)
    object.to_hash.values
  end
end

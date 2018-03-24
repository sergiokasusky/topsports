require 'sqlite3'
require 'active_record'

#Conectarse a base en memoria
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'memory'
)

ActiveRecord::Schema.define do
  create_table :tournaments, force:true do |table|
    table.column :name, :string
  end
end

ActiveRecord::Schema.define do
  create_table :teams, force: true do |table|
    table.column :tournament_id, :integer
    table.column :name, :string
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class= true
end

class Tournament < ActiveRecord::Base
  has_many :teams
end

class Team < ApplicationRecord
  belongs_to :tournament
end

torneo= Tournament.create(:name => 'Olimpiadas Universitarias')
equipo= torneo.teams.create(:name => 'BUAP')

p Tournament.first.teams

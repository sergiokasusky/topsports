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


ActiveRecord::Schema.define do
  create_table :courts, force: true do |table|
    table.column :court_id, :integer
    table.column :name, :string
    table.column :address, :string
    table.column :court_number, :string
    table.column :latitude, :decimal, { precision: 10, scale: 6 }
    table.column :longitude, :decimal, { precision: 10, scale: 6 }
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
equipo= torneo.teams.create(:name => 'UDLAP')
equipo= torneo.teams.create(:name => 'UNAM')
equipo= torneo.teams.create(:name => 'IPN')

p Tournament.first.teams

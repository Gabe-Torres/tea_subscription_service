require 'factory_bot'
include FactoryBot::Syntax::Methods
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
customers = create_list(:customer, 7)

teas = create_list(:tea, 10)

customers.each do |customer|
  teas.each do |tea|
    create(:subscription, customer: customer, tea: tea)
  end
end


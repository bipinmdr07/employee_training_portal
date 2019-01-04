# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Applicationrole.new(applicationrolename: "Admin" )
Applicationrole.new(applicationrolename: "Manager")

begin
  Applicationuser.find(1)
rescue ActiveRecord::RecordNotFound
  user=Applicationuser.new(email:'user@example.com', password: 'password' , firstname: 'admin', lastname: 'admin', role_id: 1)
  user.save!
end

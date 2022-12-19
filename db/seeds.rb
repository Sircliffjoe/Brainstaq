# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create!([
  {name: "Agriculture"}, 
  {name: "Arts & Culture"}, 
  {name: "Beauty & Fashion"}, 
  {name: "Business"},
  {name: "Community"},
  {name: "Design"},
  {name: "Education"},
  {name: "Entertainment"},
  {name: "Food"},
  {name: "Gadgets"},
  {name: "Internet"},
  {name: "IT & Telecoms"},
  {name: "Kids"},
  {name: "Media & Publishing"},
  {name: "Recipes"},
  {name: "Renewable Energy"},
  {name: "Science & Technology"},
  {name: "Social Networks"},
  {name: "Social & Organization"},
  {name: "Sports & Hobbies"},
  {name: "Startups"},
  {name: "Sustainability"},
  {name: "Tourism & Travel"},
  {name: "Transportation"},
  {name: "Web & Applications"},
  {name: "Writings"},
  {name: "Other"}
])


CostItem.create!([
  {name: "Direct Costs"}, 
  {name: "Salaries"}, 
  {name: "Rent"}, 
  {name: "Utilities"},
  {name: "Marketing"},
  {name: "Advertising"},
  {name: "Maintenance"},
  {name: "Insurance"},
  {name: "Transportation"},
  {name: "Licenses"},
  {name: "Communications"},
  {name: "Administrative"},
  {name: "Other"}
])


# Country.create!([
#   {name: "Algeria"},
#   {name: "Angola"},
#   {name: "Benin"},
#   {name: "Botswana"},
#   {name: "Burkina Faso"},
#   {name: "Burundi"},
#   {name: "Cape Verde"},
#   {name: "Cameroon"},
#   {name: "Central African Republic (CAR)"},
#   {name: "Chad"},
#   {name: "Comoros"},
#   {name: "Republic of the Congo"},
#   {name: "Democratic Republic of Congo"},
#   {name: "Cote d'Ivoire"},
#   {name: "Djibouti"},
#   {name: "Egypt"},
#   {name: "Equatorial Guinea"},
#   {name: "Eritrea"},
#   {name: "Eswatini (formerly Swaziland)"},
#   {name: "Ethiopia"},
#   {name: "Gabon"},
#   {name: "Gambia"},
#   {name: "Ghana"},
#   {name: "Guinea"},
#   {name: "Guinea-Bissau"},
#   {name: "Kenya"},
#   {name: "Lesotho"},
#   {name: "Liberia"},
#   {name: "Libya"},
#   {name: "Madagascar"},
#   {name: "Malawi"},
#   {name: "Mali"},
#   {name: "Mauritania"},
#   {name: "Mauritius"},
#   {name: "Morocco"},
#   {name: "Mozambique"},
#   {name: "Namibia"},
#   {name: "Niger"},
#   {name: "Nigeria"},
#   {name: "Rwanda"},
#   {name: "Sao Tome and Principe"},
#   {name: "Senegal"},
#   {name: "Seychelles"},
#   {name: "Sierra Leone"},
#   {name: "Somalia"},
#   {name: "South Africa"},
#   {name: "South Sudan"},
#   {name: "Sudan"},
#   {name: "Tanzania"},
#   {name: "Togo"},
#   {name: "Tunisia"},
#   {name: "Uganda"},
#   {name: "Zambia"},
#   {name: "Zimbabwe"}
# ])
  
# City.create!([
#   {name: "Lagos", country_id: Country.find_by(name: "Nigeria").id},
#   {name: "Warri", country_id: Country.find_by(name: "Nigeria").id},
#   {name: "Benin", country_id: Country.find_by(name: "Nigeria").id},
#   {name: "Port Harcourt", country_id: Country.find_by(name: "Nigeria").id},
#   {name: "Abuja", country_id: Country.find_by(name: "Nigeria").id},
#   {name: "Calabar", country_id: Country.find_by(name: "Nigeria").id},
#   {name: "Uyo", country_id: Country.find_by(name: "Nigeria").id},
#   {name: "Asaba", country_id: Country.find_by(name: "Nigeria").id},
#   {name: "Jos", country_id: Country.find_by(name: "Nigeria").id}
# ])
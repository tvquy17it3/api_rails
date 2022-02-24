roles = Role.create!([
  {name: :admin, slug: :admin},
  {name: :manager, slug: :manager},
  {name: :user, slug: :user}]
)

10.times do |n|
  email = "test-#{rand(252...4350)}@branch.com"
  password = "password123"
  name = Faker::Name.unique.name
  phone = Faker::PhoneNumber.phone_number
  address = Faker::Address.full_address
  role = Role.all.sample(1).first
  gender = Faker::Gender.binary_type

  u = User.create!(email: email,
                   password: password,
                   role_id: role.id,
                   password_confirmation: password)

  u.create_contact(name: name,
                    phone: phone,
                    gender: gender,
                    address: address)
end

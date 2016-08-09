def sign_up(email: 'example@gmail.com',
            name: 'Joe Bloggs',
            password: 'password123',
            password_confirmation: 'password123')
  visit '/users/new'
  fill_in(:email, with: email)
  fill_in(:name, with: name)
  # fill_in(:password, with: password)
  # fill_in(:password_confirmation, with: password_confirmation)
  click_button('submit')
end

def create_space(name: "Inglorious Apartment",
                 description: "Beautiful bachelor pad for the whole squad")
  visit 'spaces/new'
  expect(page).to have_content("List a space")
  fill_in("space_name", :with => name)
  fill_in("space_description", :with => description)
end

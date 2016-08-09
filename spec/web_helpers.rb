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
                 description: "Beautiful bachelor pad for the whole squad",
                 price: 150,
                 start_date: '2016/08/09',
                 end_date: '2016/08/16'
                 )
  visit '/spaces/new'
  fill_in("space_name", :with => name)
  fill_in("space_description", :with => description)
  fill_in("space_price", :with => price)
  fill_in("space_start_date", :with => start_date)
  fill_in("space_end_date", :with => end_date)
  click_button("submit")
end

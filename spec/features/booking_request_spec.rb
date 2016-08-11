feature 'booking requests' do

  scenario 'create booking request' do
    sign_up
    create_space
    visit '/spaces/all'
    click_button('Space details')
    expect(page).to have_content('Inglorious Apartment')
    expect(page).to have_content('Beautiful bachelor pad for the whole squad')
    fill_in('start_date', :with => '2016/08/09')
    fill_in('end_date', :with => '2016/08/16')
    click_button('Make booking request')
    expect(page).to have_content('Booking request made for Inglorious Apartment for dates 2016-08-09 - 2016-08-16')

  end

  scenario 'requires user to be signed in when creating a booking request' do
    sign_up
    create_space
    click_button('Sign-out')
    visit '/spaces/all'
    click_button('Space details')
    fill_in('start_date', :with => '2016/08/09')
    fill_in('end_date', :with => '2016/08/16')
    click_button('Make booking request')
    expect(page).to have_content('You must be signed-in to book a space!')
  end
end

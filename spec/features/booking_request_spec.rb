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

  scenario 'does not create booking request for unavailable dates' do
      sign_up
      create_space
      visit '/spaces/all'
      click_button('Space details')
      fill_in('start_date', :with => '2015/08/09')
      fill_in('end_date', :with => '2015/08/16')
      click_button('Make booking request')
      expect(page).to have_content('The space is unavailable for the dates you have selected')
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

  scenario 'users can see booking requests for spaces they own' do
    sign_up
    create_space
    visit '/spaces/all'
    click_button('Space details')
    fill_in('start_date', :with => '2016/08/09')
    fill_in('end_date', :with => '2016/08/16')
    click_button('Make booking request')
    visit '/users/profile'
    expect(page).to have_content('Unapproved booking requests on spaces I own: 1')
  end
end

feature 'booking requests' do

  scenario 'create booking request' do
    sign_up
    create_space
    make_booking_request
    expect(page).to have_content('Booking request made for Inglorious Apartment for dates 2016-08-09 - 2016-08-16')
  end

  scenario 'does not create booking request for unavailable dates' do
      sign_up
      create_space
      make_booking_request(start_date: '09/08/1900', end_date: '10/08/1900')
      expect(page).to have_content('The space is unavailable for the dates you have selected')
    end

  scenario 'requires user to be signed in when creating a booking request' do
    sign_up
    create_space
    click_button('Sign-out')
    make_booking_request
    expect(page).to have_content('You must be signed-in to book a space!')
  end

  scenario 'users can see booking requests for spaces they own' do
    sign_up
    create_space
    make_booking_request
    visit '/users/profile'
    expect(page).to have_content('Unapproved booking requests on spaces I own: 1')
    expect(page).to have_content('Joe Bloggs requested your Inglorious Apartment property from 2016-08-09 to 2016-08-16')
  end

  scenario 'users can approve booking requests for spaces they own' do
    sign_up
    create_space
    make_booking_request
    visit '/users/profile'
    click_button 'Approve'
    expect(page).to have_content('You have actioned this request')
  end
end

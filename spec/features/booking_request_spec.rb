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

end

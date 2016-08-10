feature 'booking requests' do

  scenario 'create booking request' do
    sign_up
    create_space
    visit '/spaces/all'
    click_button('Space details')
    expect(page).to have_content('Inglorious Apartment')
    expect(page).to have_content('Beautiful bachelor pad for the whole squad')
    #click_button('Make booking request')
    #fill_in('start date', :with => '2016/08/09')
    #fill_in('end date', :with => '2016/08/16')
    #click_button('Send booking request')
    #expect(page).to have_content('Booking request made for Inglorious Apartment for dates 2016/08/09 - 2016/08/16')
  end

end

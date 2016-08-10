feature  'Viewing spaces' do
  scenario 'I can view spaces I have added' do
    sign_up
    create_space
    create_space
    visit '/users/profile'
    expect(page).to have_content("Inglorious Apartment")
    expect(page).to have_content("Beautiful bachelor pad for the whole squad")
    expect(page).to have_content("£150")
    expect(page).to have_content("Available from: 2016-08-09 to 2016-08-16")
  end

  # scenario 'I filter spaces by date available' do
  #   sign_up
  #   create_space(name: 'early date',
  #               start_date: '2016/08/09',
  #               end_date: '2016/08/16')
  #   create_space(name: 'later date',
  #               start_date: '2016/09/01',
  #               end_date: '2016/09/16')
  #   visit('/spaces/all')
  #   fill_in(:available_from, with: '2016/08/09')
  #   fill_in(:available_to, with: '2016/08/25')
  #   click_button("Filter")
  #   expect(page).to have_content('early date')
  #   expect(page).not_to have_content('later date')
  # end
end

feature  'Viewing owned spaces' do
  scenario 'I can view spaces I have added' do
    sign_up
    create_space
    create_space
    visit '/users/profile'
    expect(page).to have_content("Inglorious Apartment")
    expect(page).to have_content("Beautiful bachelor pad for the whole squad")
    expect(page).to have_content("£150")
    expect(page).to have_content("Available from: 2016/08/09 to 2016/08/16")
  end
end

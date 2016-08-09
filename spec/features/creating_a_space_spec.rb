feature 'Creating a space' do
  scenario "I can create a new space" do
    create_space
    expect{ click_button('submit') }.to change{ Space.count }.by(1)
    expect(page).to have_content("Inglorious Apartment")
    expect(page).to have_content("Beautiful bachelor pad for the whole squad")
  end
end

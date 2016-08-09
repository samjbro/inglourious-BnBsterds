feature 'Creating a space' do
  scenario "I can create a new space" do
    visit 'spaces/new'
    expect(page).to have_content("List a space")
    fill_in("name", :with => "Inglorious Apparment")
    expect{ click_button('submit') }.to change{ Space.count }.by(1)
    expect(page).to have_content("Inglorious Appartment")
  end
end

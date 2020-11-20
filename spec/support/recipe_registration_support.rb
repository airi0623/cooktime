module RecipeRegistrationSupport
  def recipe_registration
    password = 'aaaa0000'
    people = FactoryBot.create(:user, icon: icon, password: password, password_confirmation: password)
    recipe1 = FactoryBot.create(:recipe, user_id: people.id, images:[image])
    recipe2 = FactoryBot.create(:recipe, user_id: people.id, images:[image])
    recipe3 = FactoryBot.create(:recipe, user_id: people.id, images:[image])
    likes1 = FactoryBot.create(:like, user_id: people.id, recipe_id: recipe1.id)
    likes2 = FactoryBot.create(:like, user_id: people.id, recipe_id: recipe2.id)
    likes3 = FactoryBot.create(:like, user_id: people.id, recipe_id: recipe3.id)
  end
end
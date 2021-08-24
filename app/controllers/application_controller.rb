require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  #Controller action that will render a form to create a new recipe - create and save new recipe
 

  post "/recipes" do 
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end 

  #controller action that uses RESTful routes to display a single recipe
  get "/recipes/:id" do 
    @recipe = Recipe.find_by_id(params[:id])
    erb :show 
  end 
  #controller action that uses RESTful routes and renders a form to edit SINGLE recipe - update entry in db, redirect to show page
  get "/recipes/:id/edit" do 
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit 
  end 

  patch "/recipes/:id" do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save 
    redirect to "/recipes/#{@recipe.id}"
  end 
  #controller action - index - that displays all the recipes in the database 
  get "/recipes" do 
    @recipes = Recipe.all 
    erb :index 
  end 
  #add recipe show page a form for deletion - submit a ctonroller action, and redirect to index page
  delete "/recipes/:id" do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to "/recipes"
  end
end

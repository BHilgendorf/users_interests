require 'sinatra'
require 'sinatra/reloader'
require 'yaml'
require 'pry'

before do
  @user_data = YAML.load_file('users.yaml')  #hash with user names as keys
  @users = @user_data.keys

end

get "/" do
  redirect "/users"
end

get "/users" do

  erb :user_list
end

get "/users/:name" do

  user = params[:name].to_sym
  @name = params[:name]
  @email = @user_data[user][:email]
  @interests = @user_data[user][:interests].join(", ")
  @list = @users.select { |name| name != user}


# display user name, email address and interest (comma seperated)
 erb :user
end
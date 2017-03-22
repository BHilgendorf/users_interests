require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

require 'yaml'

helpers do
  def count_interests
    @users.inject(0) do |count, user|  
      count + @user_data[user][:interests].size
    end
  end
end

before do
  @user_data = YAML.load_file('users.yaml')
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
  @interests = @user_data[user][:interests]
  @list = @users.select { |name| name != user}.sort

  erb :user
end
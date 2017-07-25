require 'httparty'
rquire 'json'

class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'
    

    response = self.class.post("#{@base_url}/sessions",
      body: {email: email, password: password}
    )

    if response && response["auth_token"]
      @auth_token = response["auth_token"]
      puts "#{email} is sucessfully in with auth_token #{@auth_token}"
    else
      puts "Login invalid"
    end
  end

  def get_me
    response = self.class.get("#{@base_url}/users/", #how to refer to user you are trying to find??
    headers: { "authorization" => @auth_token })
    @user_info = JSON.parse(response.body)
  end



end
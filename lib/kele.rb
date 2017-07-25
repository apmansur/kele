require 'httparty'
require 'json'
require 'roadmap'

class Kele
  include HTTParty
  include Roadmap



  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'
    

    response = self.class.post("#{@base_url}/sessions",
      body: {email: email, password: password}
    )
      
    puts response  
      
    if response && response["auth_token"]
      @auth_token = response["auth_token"]
      puts "#{email} is sucessfully in with auth_token #{@auth_token}"
    else
      puts "Login invalid"
    end
  end

  def get_me
    response = self.class.get("#{@base_url}/users/me",
    headers: { "authorization" => @auth_token })
    @user_info = JSON.parse(response.body)
  end
    
  def get_mentor_availability(mentor_id)
    response = self.class.get("#{@base_url}/mentors/#{mentor_id}/student_availability",
    headers: { "authorization" => @auth_token })
    @availability_info = JSON.parse(response.body)
  end



end
require 'httparty'
require 'json'
require './lib/roadmap'

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
  
  def get_messages
    response = self.class.get("#{@base_url}/message_threads",
    headers: { "authorization" => @auth_token })
    @messages_info = JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, token, subject, body)
    response = self.class.post("#{@base_url}/messages",
      query: { "sender" => sender, "recipient_id" => recipient_id,
                "token" => token, "subject" => subject, "stripped-text" => body },
      headers: { "authorization" => @auth_token }
    )
    if response["success"]
      puts "Message has sucessfully sent"
    else
      puts "Message failed to send"
    end
  end
  
  def create_submission(assignment_branch,assignment_commit_link,checkpoint_id,comment,enrollment_id)
      response = self.class.post("#{@base_url}/checkpoint_submissions",
      query: { "assignment_branch" => assignment_branch, "assignment_commit_link" => assignment_commit_link,
                "checkpoint_id" => checkpoint_id, "comment" => comment, "enrollment_id" => enrollment_id },
      headers: { "authorization" => @auth_token }
    )
    if response["success"]
      puts "Submission has sucessfully sent"
    else
      puts "Submission failed to send"
    end
  end

end
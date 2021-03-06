 require 'httparty'
 require 'json'  
 require 'pry'

 module Roadmap
    include HTTParty
    
  
      def get_checkpoint(checkpoint_id)
        response = self.class.get("#{@base_url}/checkpoints/#{checkpoint_id}",
        headers: { "authorization" => @auth_token })
        @checkpoint_info = JSON.parse(response.body)
      end
      
      def get_roadmap(roadmap_id)
        response = self.class.get("#{@base_url}/roadmaps/#{roadmap_id}",
        headers: { "authorization" => @auth_token })
        @roadmap_info = JSON.parse(response.body)
      end
  
 end
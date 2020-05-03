require 'dotenv/load'
require 'sinatra'
require 'discordrb/webhooks'
post '/pivotal' do
  data = JSON.parse(request.body.read)
  client = Discordrb::Webhooks::Client.new(url: ENV.fetch('DISCORD_WEBHOOK'))
  client.execute do |builder|
    builder.content = data['message']
    data["primary_resources"].each do |resource|     
      builder.add_embed do |embed|
        embed.title = resource['name']
        embed.url = resource['url'] 
       end
    end
  end
end

require 'sinatra'
require 'discordrb/webhooks'
WEBHOOK_URL='https://discordapp.com/api/webhooks/706072018680020996/qjA1BvICOK8kTGe6-7QPudI3owzRgwtZvehLgmbOazPOEhPNAN0vti8_b1nCnmGNj5n4'
post '/pivotal' do
  data = JSON.parse(request.body.read)
  client = Discordrb::Webhooks::Client.new(url: WEBHOOK_URL)
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

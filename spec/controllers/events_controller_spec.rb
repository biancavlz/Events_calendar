require 'rails_helper'
require 'nokogiri'
require 'open-uri'


RSpec.describe EventsController, :type => :controller do
  describe '#index' do
    subject(:get_index) { get :index }

    it 'should return success response' do
      get_index
      expect(response).to have_http_status(:ok)
    end 
  end

  describe '#events_scraper' do
    

    WEBSITE = <<WEBPAGE
  <html>
    <head><title>webpage</title></head>
    <body>
    <h1>Hello Webpage!</h1>
    <div id="references">
      <p><a href="http://www.google.com">Click here</a> to go to the search engine Google</p>
      <p>Or you can <a href="http://www.bing.com">click here to go</a> to Microsoft Bing.</p>
      <p>Don't want to learn Ruby? Then give <a href="http://learnpythonthehardway.org/">Zed Shaw's Learn Python the Hard Way</a> a try</p>
    </div>
    <div id="funstuff">
      <p>Here are some entertaining links:</p>
      <ul>
         <li><a href="http://youtube.com">YouTube</a></li>
         <li><a data-category="news" href="http://reddit.com">Reddit</a></li>
      </ul>
    </div>
    <p>Thank you for reading my webpage!</p>
    </body>
  </html>
WEBPAGE

    html_data = open('http://berghain.de/events/')
    document  = Nokogiri::HTML(html_data)
    

    it 'returns a Nokogiri::HTML::Document' do
      
      expect(document).to be_a(Nokogiri::HTML::Document)
    end
  
    byebug
  end
end

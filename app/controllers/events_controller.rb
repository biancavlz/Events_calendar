class EventsController < ApplicationController
  def index
    events_scraper
    @events = Event.page(params[:page]).per(10)

    if params[:search]
      @search_term = params[:search]
      @events = @events.search_by(@search_term)
    end
  end

  private

  def events_scraper
    require 'open-uri'

    @event_entries = []
    urls           = %w[http://berghain.de/events/ https://www.co-berlin.org/en/calender]
    
    urls.each do |url|
      html_data = open(url)
      document  = Nokogiri::HTML(html_data)

      web_title = document.css('h1 span').text.include?('Berghain')
      web_title ? berghain_website_data(document) : berlin_co_website_data(document)
    end
  end

  def berghain_website_data(document)
    entries = document.css('div.marker')

    entries.each do |entry|   
      title = entry.css('a span').text.capitalize
      event = Event.find_or_initialize_by(title: title)

      event.title       = entry.css('a span').text.capitalize
      event.date        = Date.parse(entry.css('a').text, "%a, %Y-%m-%d")
      event.information = entry.css('p span').text
      event.place       = entry.css('p span b').text.capitalize
      event.source      = 'http://berghain.de/events/'
      event.save!
      
      @event_entries << event
    end
  end

  def berlin_co_website_data(document)
    entries = document.css('div.calender-text')
  
    entries.each do |entry|
      title = entry.css('div.article-title').text.capitalize
      event = Event.find_or_initialize_by(title: title)
      
      event.title       = entry.css('div.article-title').text.capitalize
      event.date        = Date.parse(entry.css('span.article-date').text.split[0].gsub("/", " "), "%a, %Y-%m-%d")
      event.information = entry.css('div.article-text').text
      event.place       = 'C/O Berlin'
      event.source      = 'https://www.co-berlin.org/en/calender'
      event.save!
      
      @event_entries << event
    end
  end
end
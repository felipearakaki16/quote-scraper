require "open-uri"
require "nokogiri"
require 'json'

class Api::V1::QuotesController < Api::V1::BaseController
  before_action :require_authentication!
  
  def show
    if Quote.friendly.where('tag': params[:id]).present?
      quote = Quote.friendly.find(params[:id])

    else
      url = "http://quotes.toscrape.com/tag/#{params[:id]}/"
      
      html_file = open(url).read
      html_doc = Nokogiri::HTML(html_file)
      
      quote = quote.create(
        "tag": params[:id],
        "quote": html_doc.search('.quote .text')&.first&.text.gsub("“","").gsub("”",""),
        "author": html_doc.search('.quote .author')&.first&.text,
        "about": "http://quotes.toscrape.com#{html_doc.search('.quote span a')&.first&.attributes["href"]&.value}",
        "tags": html_doc.search('.quote .tags .keywords')&.first&.attributes["content"]&.value&.split(","),
        )
      quote.save
        
      end
      render json: { 
        "quotes": [
          {
            "quote": quote.quote,
            "author": quote.author,
            "author-about": quote.about,
            "tags": quote.tags
          }
        ]
      }
    end

    private
    
    def require_authentication!
      throw(:warden, scope: :user) unless current_user.presence
    end
                
  end

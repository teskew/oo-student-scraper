require 'open-uri'
require 'pry'

class Scraper
     
  def self.scrape_index_page(index_url)
     html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    doc.css('.student-card').each do |card|
    
    
    students << {
    name: card.css(".student-name").text,
    location: card.css(".student-location").text,
    profile_url: card.css('a').attribute('href').value}
       
     end
      students
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
    list=doc.css(".social-icon-container").css("a")

    socialhash={}
    list.each do |social|
      socinfo=social["href"]

    if socinfo.match(/twitter.com/)
      socialhash[:twitter]=socinfo
    elsif  socinfo.match(/github.com/)
      socialhash[:github]=socinfo
    elsif  socinfo.match(/linkedin.com/)
      socialhash[:linkedin]=socinfo
      elsif  !socinfo.match(/youtube.com/) && !socinfo.match(/facebook.com/)
        socialhash[:blog] = socinfo
      end
    end
      socialhash[:profile_quote]=doc.css(".profile-quote").text
      socialhash[:bio]=doc.css(".bio-content.content-holder").css("p").text
      socialhash
     end
end


require 'nokogiri'
require 'open-uri'
require 'pry'
# require_relative '../config/environment.rb'
class Scraper
	attr_accessor :path, :state 
	def initialize(path, state=nil)
		self.path = path 
		self.state = state
	end 

	def scrape_states
		html = open(@path)
		doc = Nokogiri::HTML(html)
		states = doc.css(".hentry__content h2 + p")[0].text.split("\n")
		parameterize(states)
	end

	def scrape_birds
		html = open(@path)
		doc = Nokogiri::HTML(html)
		bird_info = doc.css("li:not(:has(span))")
		end_index = bird_info.index{|element| element.text.include?("List of")}
		bird_info = bird_info[0..end_index-1]
		bird_array = bird_info.map do |bird|
			if bird.css(":has(i)") && bird.css(":has(a)")
				if !includes_parens(bird.text)
					{common_name: bird.css(":first-child").text, latin_name: bird.css("i").text}
				end
			end
		end
		bird_array.delete_if{|element| element.class == NilClass}
		bird_array.delete_if{|element| element[:common_name].empty?}
		bird_array.delete_if{|element| element[:latin_name].empty?}
	end

	def scrape_descriptions
		html = open(@path)
		doc = Nokogiri::HTML(html)
		description = doc.css("h5 ~ p").text
	end

	def parameterize(array)
		parameterized_array = array.map do |str|
			str.gsub(/\s/, '_') 
		end
		parameterized_array
	end

	def replace_punc(array)
		no_punc = array.map do |str|
			str.gsub(/\'/, '')
		end 
		no_punc
	end

	def includes_parens(text)
		containsparens = true 
		if !text.include?("(A)") && !text.include?("(R)") && !text.include?("(N)") && !text.include?("(V)") && !text.include?("(C)") && !text.include?("(Ca)") && !text.include?("(VR)") && !text.include?("(H)") && !text.include?("(X)") && !text.include?("(Ex)") && !text.include?("(E)") && !text.include?("(Xt)")
			containsparens = false
		end
		containsparens
	end
end

statesscraper = Scraper.new("https://wordcounter.net/blog/2016/04/27/101535_alphabetical-list-50-states.html")

states = statesscraper.scrape_states

states.each do|state|
	region = Region.create({name: state})
	#to aviod scraping a list of birds from the country Georgia
	if state != "Georgia"
 		bird_scraper = Scraper.new("https://en.wikipedia.org/wiki/List_of_birds_of_#{state}")
 	else 
 		bird_scraper = Scraper.new("https://en.wikipedia.org/wiki/List_of_birds_of_#{state}_(U.S._state)")
 	end
 	birds = bird_scraper.scrape_birds
 	birds.each do |bird_hash|
 		if bird_hash[:common_name].match(/(\[)/)
 			end_index = bird_hash[:common_name].index("[")
 			bird_hash[:common_name] = bird_hash[:common_name][0..end_index-1]
 		end
 		bird_hash[:common_name] = bird_hash[:common_name].encode('UTF-8', :invalid => :replace, :undef => :replace, :replace => '')
 		found = Bird.find_by(common_name: bird_hash[:common_name])
 		if found
 			Rangemap.create({bird_id: found.id, region_id: region.id})
 		else
			bird = Bird.create(bird_hash)
			Rangemap.create({bird_id: bird.id, region_id: region.id})
		end
	end
end

grebe = Bird.all[313]
grebe.common_name = "Clarks grebe"
grebe.save
gull = Bird.all[899]
gull.common_name = "Sabine's gull"
gull.save


birds = Bird.all.map{|bird| bird.common_name}

descriptionscraper = Scraper.new("https://www.allaboutbirds.org/guide/Red-winged_blackbird/overview")

parameterized = descriptionscraper.parameterize(birds)

no_punc = descriptionscraper.replace_punc(parameterized)

no_punc.each_with_index do |bird, index|
	descriptionscraper.path = "https://www.allaboutbirds.org/guide/#{bird}/overview"
	description = descriptionscraper.scrape_descriptions
	bird = Bird.find_by(common_name: Bird.all[index][:common_name])
	bird.description = description
	bird.save
end

#sorts birds into groups
require_relative './groups'

#scrape 50 states
#scrape bird lists for each state
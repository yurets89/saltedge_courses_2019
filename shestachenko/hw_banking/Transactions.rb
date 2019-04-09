require 'nokogiri'
require 'watir'
require 'pry'
require 'json'

class Transactions

	def browser
    @browser ||= Watir::Browser.new :chrome
  end

  def login
  	browser.goto('https://www.victoriabank.md/ru/')
  	browser.img(title: "VB24_web.png").click
  	puts "enter login"
  	login = gets.chomp.to_s
  	puts "enter password"
  	password = gets.chomp.to_s
  	browser.text_field(class: "username").set(login)
  	browser.text_field(name: "password").set(password)
  	browser.button(text: "Login").click
  	browser.a(href: "#menu/MAIN_215.CP_HISTORY").click
  	browser.text_field(name: "from").click
  	browser.a(title: "< Prev").click
  	browser.a(class: "ui-state-default").click
    browser.wait_until{browser.div(class: "operations").exists?}
  	sleep 2
  	html_tr
  end

  def html_tr
  	Nokogiri::HTML.fragment(browser.div(class: "operations").html)
  end

  def tra_info
  	x = html_tr.css('li')
  	@trans_hash = {"transactions" => []}
  	x.map do |x|
  		months = x.parent.parent.parent.css('div.month-delimiter').text
  		days = x.parent.parent.css('div.day-header').text
  		times = x.css('span.history-item-time').text
  
  		info = {
  			date: days + " " + months + " " + times,
				description: x.css('a.operation-details').text,
				amount: x.css('span[class="amount"]').first.text
      }
			@trans_hash["transactions"] << info
		end
		@trans_hash
		
	end

  def saving_tra_info
    file = File.new("trans_info.json", "w")
    file.puts JSON.pretty_generate(@trans_hash)
    file.close
  end

  def initialize
  	login
  	tra_info
    saving_tra_info
  end

end

yuriy_tr = Transactions.new





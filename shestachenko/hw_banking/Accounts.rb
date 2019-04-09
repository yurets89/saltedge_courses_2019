require 'nokogiri'
require 'watir'
require 'pry'
require 'json'

class Accounts

  def initialize
    login
    saving_acc_info
  end

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
    browser.wait_until{browser.div(class: "block__cards-accounts").exists?}
    html_ac
    
  end

  def html_ac
    Nokogiri::HTML.parse(browser.html)
  end

  def acc_info
    acc = {
      name: html_ac.css('span.user-name').text,
      currency: html_ac.css('span.amount.currency.MDL').text,
      balance: html_ac.css('span.amount').first.text,
      nature: "visa"
    }
  end

  def saving_acc_info
    acc_hash = {"**Account**" => []}
    acc_hash["**Account**"] << acc_info
    file = File.new("acc_info.json", "w")
    file.puts JSON.pretty_generate(acc_hash)
    file.close
  end

end




yuriy = Accounts.new

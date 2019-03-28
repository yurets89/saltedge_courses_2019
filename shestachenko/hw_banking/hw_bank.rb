require 'pry'
require 'watir'
require 'nokogiri'


class Accounts
  BASE_URL = "https://www.victoriabank.md/ru/"

  def browser
    @browser ||= Watir::Browser.new :chrome
  end

  def run
    browser.goto('https://www.victoriabank.md/ru/')
    browser.img(title: "VB24_web.png").click
    puts "enter login"
    login = gets.chomp.to_s
    puts "enter password"
    password = gets.chomp.to_s

    browser.text_field(class: "username").set(login)
    browser.text_field(name: "password").set(password)

    browser.button(text: "Login").click
  end

  def page_html
    Nokogiri::HTML.fragment(browser.html)
  end

  def account_info
    {
       name: page_html.at_css('span[class="user-name"]').text,
       currency: page_html.at_css('span[class="amount"]').text,
       balance: page_html.at_css('span[class="amount currency MDL"]').text,
       nature: "visa"
     }
   end
 end

yuriy = Accounts.new
yuriy.account_info

binding.pry


require 'watir'
require 'nokogiri'

browser = Watir::Browser.start 'https://www.victoriabank.md/ru/'
browser.img(title: "VB24_web.png").click

puts "enter login"
login = gets.chomp.to_s
puts "enter password"
password = gets.chomp.to_s

browser.text_field(class: "username").set(login)
browser.text_field(name: "password").set(password)

browser.button(text: "Login").click

sleep 3

@page = Nokogiri::HTML.parse(browser.html)






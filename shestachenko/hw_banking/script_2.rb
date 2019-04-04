require_relative 'script_1.rb'

array = ["**Account**:"]

names = @page.css('span.user-name').text
currency = @page.css('span.amount')[1].text
balance = @page.css('span.amount')[0].text.chomp(",")
nature = "visa"
array.push(
	names,
	currency,
	balance,
	nature
	)

puts array




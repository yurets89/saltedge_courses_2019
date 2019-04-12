module Bank
  def browser
    @browser ||= Watir::Browser.new :chrome
  end

  def log_in
    browser.goto('https://www.victoriabank.md/ru/')
    browser.img(title: 'VB24_web.png').click
    puts 'enter login'
    login = gets.chomp.to_s
    puts 'enter password'
    password = gets.chomp.to_s
    browser.text_field(class: 'username').set(login)
    browser.text_field(name: 'password').set(password)
    browser.button(text: 'Login').click
    sleep 1
  end

  def acc_trans
    ac_parsed = JSON.parse(File.read('account.json'))
    tr_parsed = JSON.parse(File.read('transactions.json'))
    ac = ac_parsed.values.flatten[0]
    ac.delete('nature')
    ac['description'] = 'My checking account'
    ac['transactions'] = tr_parsed.values
    saving_json("account+transactions", ac)
  end

  def saving_json(name, value)
    file = File.new("#{name}.json", 'w')
    file.puts JSON.pretty_generate(value)
    file.close
  end
end

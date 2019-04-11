require_relative 'bank.rb'
class Accounts
  include Bank

  def initialize
    account_info
  end

  def acc_info
    acc = {
      name: @page.css('span.user-name').text,
      balance: @page.css('span.amount').first.text,
      currency: @page.css('span.amount.currency.MDL').text,
      nature: 'visa'
    }
  end

  def saving_acc_info
    acc = { 'accounts' => [] }
    acc['accounts'] << acc_info
    saving_json("account", acc)
    puts JSON.pretty_generate(acc)
  end

  def account_info
    log_in
    html_ac
    acc_info
    saving_acc_info
    browser.close
  end

  def html_ac
    @page = Nokogiri::HTML.parse(browser.html)
  end
end

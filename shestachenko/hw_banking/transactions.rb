require_relative 'bank.rb'
class Transactions
  include Bank

  def initialize
    transactions_info
  end

  def tra_info
    x = @tr_page.css('li')
    @trans_hash = { 'transactions' => [] }
    x.map do |x|
      months = x.parent.parent.parent.css('div.month-delimiter').text
      days = x.parent.parent.css('div.day-header').text.to_i.to_s
      times = x.css('span.history-item-time').text

      info = {
        date: days + ' ' + months + ' ' + times,
        description: x.css('a.operation-details').text,
        amount: x.css('span[class="amount"]').first.text
      }
      @trans_hash['transactions'] << info
    end
    puts @trans_hash
  end

  def html_tr
    @tr_page = Nokogiri::HTML.fragment(browser.div(class: 'operations').html)
  end

  def transactions_info
    log_in
    browser.a(href: '#menu/MAIN_215.CP_HISTORY').click
    dates
    sleep 1
    html_tr
    tra_info
    saving_json("transactions", @trans_hash)
    acc_trans
    browser.close
  end

  def dates
    day = Time.now.day
    browser.text_field(name: 'from').click
    browser.a(title: '< Prev').click
    browser.a(text: day.to_s).click
  end
end

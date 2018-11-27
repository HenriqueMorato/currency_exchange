class Application
  attr_reader :dollar_cashier, :real_cashier, :dollar_quotation

  BUY_DOLLAR  = '1'.freeze
  SELL_DOLLAR = '2'.freeze
  BUY_REAL    = '3'.freeze
  SELL_REAL   = '4'.freeze
  EXIT        = '5'.freeze

  def initialize
    clear
    puts "Bem-vindo ao Currency Exchange Office\n"
    puts "\nDigite a quantidade de dolar no caixa:"
    @dollar_cashier = gets.to_i
    puts "\nDigite a quantidade de real no caixa:"
    @real_cashier = gets.to_i
    puts "\nDigite a cotação do dolar:"
    @dollar_quotation = gets.to_i
    puts
  end

  def init
    loop do
      option = menu
      clear
      case option
      when BUY_DOLLAR
        dollar_withdraw
      when SELL_DOLLAR
        dollar_deposit
      when BUY_REAL
      when SELL_REAL
      when EXIT
        exit 0
      else
        puts 'Opção inválida!'
        wait_keydown
      end
    end
  end

  private

  def menu
    clear
    puts '==== Currency Exchange Office ===='
    puts
    puts "#{BUY_DOLLAR} - Comprar Dollar"
    puts "#{SELL_DOLLAR} - Vender Dollar"
    puts "#{BUY_REAL} - Compar Real"
    puts "#{SELL_REAL} - Vender Real"
    puts "#{EXIT} - Sair"
    puts
    print 'Escolha uma opção: '
    gets.chomp
  end

  def dollar_deposit
    print 'Qual a quantidade em dolar que deseja vender? $ '
    quantity = gets.to_i
    if quantity * dollar_quotation >= @real_cashier
      puts 'Quantidade de reais não disponível em caixa'
      wait_keydown
      return
    end
    @dollar_cashier += quantity
    @real_cashier -= quantity * dollar_quotation
  end

  def dollar_withdraw
    print 'Qual a quantidade em dolar que deseja comprar? $ '
    quantity = gets.to_i
    if quantity >= @dollar_cashier
      puts 'Quantidade de dolar não disponível em caixa'
      wait_keydown
      return
    end
    @dollar_cashier -= quantity
    @real_cashier += quantity * dollar_quotation
  end

  def real_deposit(quantity)
    print 'Qual a quantidade em dolar que deseja comprar? $ '
    quantity = gets.to_i
    @real_cashier += quantity
  end

  def real_without(quantity)
    @real_cashier -= quantity
  end

  def clear
    system('clear')
  end

  def wait_keydown
    puts
    puts 'Pressione qualquer tecla para continuar'
    gets
  end
end

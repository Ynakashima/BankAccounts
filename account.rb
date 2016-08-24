module Bank

  class Account
    attr_reader :id
    attr_accessor :balance

    def initialize(id, initial_balance)
      if initial_balance < 0
        raise ArgumentError.new("You cannot have an initial negative balance")
      else
      @id = id
      @balance = initial_balance
      end
    end

    def negative_balance?
      @balance < 0
    end

    def withdraw (amt_withdraw)
      @balance -= amt_withdraw
      if negative_balance?
        @balance += amt_withdraw
        return "That withdrawal did not go through because it would create a negative balance. Your balance is $#{@balance}"
      else
        return "Your balance after that withdrawal is $#{@balance}"
      end
    end

    def deposit(amt_deposit)
      @balance += amt_deposit
      return "Your balance after that deposit is $#{@balance}"
    end

    def current_balance
      puts "Your balance is currently #{@balance}."
    end
  end
end

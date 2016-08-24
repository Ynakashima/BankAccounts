require 'csv'

module Bank

  class Account
    attr_reader :id#keep as string?
    attr_accessor :balance#convert to fixnum? convert to money?
    attr_reader :date_open #must convert to date format?

    def initialize(id, initial_balance, date_open)
      if initial_balance < 0
        raise ArgumentError.new("You cannot have an initial negative balance")
      else
      @id = id
      @balance = initial_balance
      @date_open = date_open
      end
    end

    def self.all
      account_list = []
      CSV.read("/Users/YNaka/Ada/project_forks/BankAccounts/support/accounts.csv", "r").each do |line|
        account_list << self.new(line[0],line[1].to_i,line[2])
      end

      account_list
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

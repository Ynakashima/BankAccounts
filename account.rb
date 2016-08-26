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

    def self.find(this_id)
      Account.all.each do |a|
        if this_id == a.id.to_i
          return a
        else
          return "That does not match any account IDs at this bank. Please enter a valid ID."
        end
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

  class SavingsAccount < Bank::Account
    attr_reader :id
    attr_accessor :balance
    attr_reader :date_open

    def initialize(id, initial_balance, date_open)
      @balance = initial_balance
      if initial_balance < 10
        raise ArgumentError.new("The minimum amount to open a Savings Account is $10")
      else
        super(id, initial_balance, date_open)
      end
    end

    def below_min_balance?
      @balance < 10
    end

    def withdraw(amt_withdraw)
      @balance = @balance - amt_withdraw - 2
      if below_min_balance?
        @balance = @balance + amt_withdraw + 2
        puts "That withdrawal did not go through because it would put your account below the minimum balance.Your balance is $#{@balance}"
      else
      super(amt_withdraw)
      end
    end

    def add_interest(rate)
      @interest_amount = @balance * (rate/100)
      @balance = @interest_amount + @balance
      return @interest_amount
    end
  end


  class CheckingAccount < Bank::Account
    attr_reader :id
    attr_accessor :balance
    attr_reader :date_open

    def initialize(id, initial_balance, date_open)
      super(id, initial_balance, date_open)
      @free_checks = 3
    end

    def withdraw(amt_withdraw)
      @balance = @balance - amt_withdraw - 1
      if negative_balance?
        @balance = @balance + amt_withdraw + 1
        puts "That withdrawal did not go through because it would put your account below the minimum balance.Your balance is $#{@balance}"
      else
      super(amt_withdraw)
      end
    end

    def overdraft?
      @balance <= -10
    end

    def reset_free_checks
      @free_checks = 3
    end

    def withdraw_using_check(amount)
      @free_checks -= 1
      if @free_checks < 0
        @balance = @balance - amount - 2
          if overdraft?
            @balance =balance + amount + 2
            puts "That amount will overdraft your checking account, your transaction cannot be completed. Your balance is #{@balance}"
          else
            puts "Your balance is now $#{@balance}"
          end
      else
        @balance-=amount
         if overdraft?
           @balance += amount
           puts "That amount will overdraft your checking account, your transaction cannot be completed. Your balance is #{@balance}"
         else
           puts "Your balance is now $#{@balance}"
         end
      end
    end
  end
end

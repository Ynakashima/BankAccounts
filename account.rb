module Bank

  class Account
    attr_reader :id
    attr_reader :initial_balance
    attr_reader :balance

    def initialize(id, initial_balance)
      @id = id
      @initial_balance = initial_balance
      @balance = balance
    end

    # def withdraw (amt_withdraw)
    #   @balance = @initial_balance - amt_withdraw
    #   return @balance
    # end
    #
    # def deposit(amt_deposit)
    #   @balance = @init_balance + amt_deposit
    #   return @balance
    # end
  end
end

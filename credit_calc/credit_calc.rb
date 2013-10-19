class CreditCalc
  def self.calc(args)
    check_args!(args)
    
    return 0 if args[:amount].zero?

    amount, factor = args[:amount], (1 + args[:percent] / 100.0)
    args[:period].times { amount *= factor }

    return amount.ceil
  end
  
  def self.check_args!(args)
    [:amount, :percent, :period].each do |key|
      raise ArgumentError, "#{key} should be defined" unless args.has_key?(key)
      raise ArgumentError, "#{key} should be >= 0" if args[key] < 0
    end
  end
end

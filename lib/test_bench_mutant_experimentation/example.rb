module TestBenchMutantExperimentation
  module Example
    def self.value
    end
  end
end
__END__
module TestBenchMutantExperimentation
  class Example
    def logger
      @logger ||= ::Logger.new(STDERR)
    end
    attr_writer :logger

    def clock
      @clock ||= Clock::Substitute.build
    end
    attr_writer :clock

    def self.build
      instance = new
      Clock.configure(instance)
      instance
    end

    def call(number)
      ## Uncomment when logger calls can be filtered - Wed May 11 2022
      #logger.debug { "Calculating result (Number: #{number.inspect})" }

      result = String.new

      if (number % 3).zero?
        result << "Fizz"
      end

      if (number % 5).zero?
        result << "Buzz"
      end

      if result.empty?
        now = clock.now

        result << now.iso8601
      end

      ## Uncomment when logger calls can be filtered - Wed May 11 2022
      #logger.info { "Calculated result (Number: #{number.inspect}, Result: #{result.inspect})" }

      result
    end
  end
end

module Dawn #:nodoc:
  module SafeExtension #:nodoc:
    class SafeContext #:nodoc:
      # @type [Exception]
      attr_accessor :last_exception

      ###
      # @param [Object] obj
      ###
      def initialize(obj)
        @obj = obj
        @last_exception = nil
      end

      # :nodoc:
      def method_missing(sym, *args, &block)
        if @obj.respond_to?(sym)
          begin
            @obj.send sym, *args, &block
          rescue => ex
            self.last_exception = ex
            false
          end
        else
          @obj.method_missing sym, *args, &block
        end
      end
    end

    ###
    # @overload safe
    #   Creates a new SafeContext for the object
    #   @return [SafeContext]
    # @overload safe(symbol, *args, &block)
    #   @return [Object]  result from method invocation
    ###
    def safe(*args, &block)
      context = SafeContext.new(self)
      return context.send(*args, &block) unless args.empty?
      context
    end
  end
end

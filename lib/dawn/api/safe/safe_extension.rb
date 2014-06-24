module Dawn
  module SafeExtension
    class SafeContext
      attr_accessor :last_exception

      def initialize(obj)
        @obj = obj
        @last_exception = nil
      end

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

    def safe(*args, &block)
      context = SafeContext.new(self)
      return context.send(*args, &block) unless args.empty?
      context
    end
  end
end

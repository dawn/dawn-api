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
          end
        else
          @obj.method_missing sym, *args, &block
        end
      end
    end

    def safe
      SafeContext.new(self)
    end
  end
end

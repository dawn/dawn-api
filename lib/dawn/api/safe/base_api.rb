require "dawn/api/safe/safe_extension"

module Dawn #:nodoc:
  module BaseApi #:nodoc:
    module RequestExtension #:nodoc:
      include Dawn::SafeExtension
    end
  end
end

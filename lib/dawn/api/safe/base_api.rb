require "dawn/api/safe/safe_extension"

module Dawn
  module BaseApi
    module RequestExtension
      include Dawn::SafeExtension
    end
  end
end

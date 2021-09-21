class User < ApplicationRecord
  include Unsubscribe::Owner
end

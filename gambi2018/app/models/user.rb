class User < ApplicationRecord
  belongs_to :table, optional: true
end

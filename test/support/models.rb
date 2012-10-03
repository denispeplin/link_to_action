require 'ostruct'

class User < Struct.new(:id, :name)
  extend ActiveModel::Naming
end

class Comment < Struct.new(:id, :name)
  extend ActiveModel::Naming
end
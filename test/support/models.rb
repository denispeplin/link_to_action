require 'ostruct'

class User < Struct.new(:id, :name)
  extend ActiveModel::Naming
end
class User
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :firstname, type: String
  field :lastname,  type: String
  field :email,     type: String
  field :friends,   type: Array
  field :skills,    type: Array

  embeds_many :employments

  index({ friends: 1 }, { unique: false })
  index({ skills: 1 }, { unique: false })
end

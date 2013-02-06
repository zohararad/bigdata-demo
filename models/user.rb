class User
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :firstname, type: String
  field :lastname,  type: String
  field :email,     type: String
  field :friends,   type: Array
  field :skills,    type: Array

  embeds_many :employments
  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end

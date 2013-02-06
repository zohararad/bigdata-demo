class Skill
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :name, type: String

  belongs_to :user

  # You can define indexes on documents using the index macro:
  index :name, unique: true

end

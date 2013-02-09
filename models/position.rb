class Position
  include Mongoid::Document

  field :company,     type: String
  field :position,    type: String
  field :location,    type: String
  field :skills,      type: Array
  field :created_at,  type: Integer

end

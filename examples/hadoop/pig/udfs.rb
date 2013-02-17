require 'pigudf'

class Udfs < PigUdf

  #outputSchema "timestamp:int"
  def hour(timestamp)
    t = Time.at(timestamp.to_i)
    Time.utc(t.year, t.month, t.day, t.hour, 0, 0).to_i
  end
end
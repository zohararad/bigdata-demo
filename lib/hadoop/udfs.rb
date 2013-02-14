require 'pigudf'

class Udfs < PigUdf

  #outputSchema "relative_position:int"
  def group_by_day(timestamps)
    keywords = {}
    timestamps.each do |ts|
      kw, ts = ts.first, ts.last
      keywords[kw] ||= {}
      t = Time.at(ts.to_i).strftime('%Y%m%d%H00')
      keywords[kw][t] ||= 0
      keywords[kw][t] += 1
    end
    result = keywords.values.first.map{|k, v|
      {:hour => k, :count => v}
    }
    puts "======================"
    puts result.inspect
    result
  end

  def hour(timestamp)
    Time.at(timestamp.to_i).strftime('%Y%m%d%H00')
  end
end
require 'avro'

module AvroLogger

  class Position

    SCHEMA = <<-JSON
      [
        {
          "type": "record",
          "name": "position",
          "fields": [
            {"name": "company", "type": "string"},
            {"name": "position", "type": "string"},
            {"name": "location", "type": "string"},
            {"name": "created_at", "type": "int"},
            {
              "name": "skills",
              "type": {
                "type": "array",
                "items": "string"
              }
            }
          ]
        }
      ]
    JSON

    class << self

      def log(positions)
        schema = Avro::Schema.parse(SCHEMA)
        writer = Avro::IO::DatumWriter.new(schema)
        encoder ||= Avro::IO::BinaryEncoder.new(writer)
        file = File.open(File.join(Padrino.root,'log','positions.avr'), 'wb')
        dw = Avro::DataFile::Writer.new(file, writer, schema)
        positions.each do |position|
          dw << position.attributes
        end
        dw.close
      end

    end
  end

end
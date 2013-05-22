module SaasuX
  class Formatter

  	def initialize(options={})
  		@formatter = REXML::Formatters::Pretty.new(options[:tabs] || 2)
  		@formatter.compact = options[:compact] || true
  	end

  	def write(xml_obj)
  		xml_str = String.new
  		@formatter.write(xml_obj, xml_str)
  		return xml_str
  	end

  end
end
module Doxyparser

  # Representation of a 'high level' {Node} which is represented in its own XML file such as namespaces, classes, etc
  class Compound < Node

    attr_reader :xml_path

    private

    def init_attributes
      super
      @unnamed = 0      
      if @node && !@node['refid'].nil?
        @xml_path = "#{@dir}/#{self.refid}.xml"
      else
        compute_path
#        parse
      end
    end

    def find_name
      @node.child.content
    end

    def doc
      if @doc.nil?
        parse
      end
      @doc
    end

    def parse
      if @dir.to_s['http'].nil?
        parse_file
      else
        parse_url
      end
    end

    def parse_file
      raise "No file found at this location: #{@xml_path} for node #{self.class.name} #{@name}" unless File.exists? @xml_path
      
        @doc=Nokogiri::XML(File.open(@xml_path))
      
      self
    end

    def parse_url
      puts "parsing url #{@xml_path}"
      require 'open-uri'
      @doc = Nokogiri::XML(open(@xml_path))
      self
    end

  end
end

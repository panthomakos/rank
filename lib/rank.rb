module Rank
  #assumes ascending :asc, but can also use descending :desc
  def self.compare a, b, *attributes
    attributes.each do |attribute, order, conversion|
      a_attribute = self.perform_conversion a[attribute], conversion
      b_attribute = self.perform_conversion b[attribute], conversion
      use_order = order || :asc
      if a_attribute.nil? and !b_attribute.nil?
        return 1
      elsif !a_attribute.nil? and b_attribute.nil?
        return -1
      elsif !a_attribute.nil? and !b_attribute.nil?
        if a_attribute > b_attribute
          return (use_order == :asc ? 1 : -1)
        elsif a_attribute < b_attribute
          return (use_order == :asc ? -1 : 1)
        end
      end
    end
    return 0
  end

  #add_rank athletes, :attribute => :created_at, :ties => true
  def self.add_rank objects, options
    options = { :attributes => :id, :ties => true, :sort => false }.merge(options)

    current_rank = 1
    last_object = nil
    objects.sort!{ |a, b| Rank.compare(a, b, *options[:attributes]) } if options[:sort]
    objects.each_with_index do |object, i|
      current_rank = i+1 if (options[:ties] and !!last_object and Rank.compare(object, last_object, *options[:attributes]) == 1)
      current_rank = i+1 if (!options[:ties] and !!last_object)
      object[:rank] = current_rank
      last_object = object
    end

    return objects
  end
  
  def self.perform_conversion value, conversion
    begin
      if conversion.nil? || conversion == :none
        value
      elsif conversion == :float
        value.to_f
      elsif conversion == :integer
        value.to_i
      end
    rescue
      nil
    end
  end
end
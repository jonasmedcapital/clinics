class TableDecorator < SimpleDelegator  
  def self.name(table_name)
    return table_name.split("_").map{|s| s.camelize}.join()
  end
end
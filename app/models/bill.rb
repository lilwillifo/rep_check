class Bill
  def self.all
    ObjectSpace.each_object(self).to_a
  end
end

class RepBillSearch
  attr_reader :rep_id, :roll_call
  def initialize(rep_id, roll_call)
    @rep_id = rep_id
    @roll_call = roll_call
  end
end

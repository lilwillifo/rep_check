class BillSearch
  def initialize(state)
    @state = state
  end

  def bills
    raw_bills = service.bills

    raw_bills.map do |raw_bill|
      Bill.new(raw_bill)
    end
  end

  private
    attr_reader :state

    def service
      @service ||= PropublicaService.new(state)
    end
end

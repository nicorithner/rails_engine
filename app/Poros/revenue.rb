class Revenue
  attr_reader :id, :revenue
  def initialize(total)
    @revenue = total
    @id = nil
  end
end

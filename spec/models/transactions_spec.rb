require 'rails_helper'

RSpec.describe Transaction do
  describe "Relationships" do
    it { should belong_to(:invoice) }
  end
end
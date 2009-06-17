require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/shared/phase'

ruby_version_is "1.9" do
  describe "Numeric#angle" do
    it_behaves_like(:numeric_phase, :angle)
  end
end

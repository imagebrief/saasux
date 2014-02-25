require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SaasuX" do
  describe "Driver" do

    subject { uid }

    before(:all) do
      saasu_config = RSpec.configuration.saasu_config
      @driver = SaasuX::Driver.new(saasu_config)
    end

    ##
    ## Driver
    ##
 
    it "should be an instance of Driver" do
      expect(@driver).to be_an_instance_of SaasuX::Driver
    end

    it "should be configured" do
      expect(@driver).to_not be_nil
      expect(@driver.config).to_not be_nil
      expect(@driver.config).to include(:query)
    end

  end
end
    

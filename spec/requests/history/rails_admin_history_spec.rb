require 'spec_helper'

describe "RailsAdmin History" do

  describe "handle nil results" do
    before(:each) do
      @months = RailsAdmin::History.add_blank_results([], 5, 2010)
    end

    it "should pad the correct number of months" do
      @months.length.should == 5
      @months.map(&:month).should == [6, 7, 8, 9, 10]
    end
  end

  describe "history blank results single year" do
    before(:each) do
      @months = RailsAdmin::History.add_blank_results([RailsAdmin::BlankHistory.new(7, 2010), RailsAdmin::BlankHistory.new(9, 2011)], 5, 2010)
    end

    it "should pad the correct number of months" do
      @months.length.should == 5
    end

    it "should pad at the beginning" do
      @months.map(&:month).should == [6, 7, 8, 9, 10]
    end
  end

  describe "history blank results wraparound" do
    before(:each) do
      @months = RailsAdmin::History.add_blank_results([RailsAdmin::BlankHistory.new(12, 2010), RailsAdmin::BlankHistory.new(2, 2011)], 10, 2010)
    end

    it "should pad at the beginning" do
      @months.map(&:month).should == [11, 12, 1, 2, 3]
    end

    it "should handle year-to-year rollover" do
      @months.map(&:year).should == [2010, 2010, 2011, 2011, 2011]
    end
  end

  describe "history ajax update" do
    it "shouldn't use the application layout" do
      post rails_admin_history_list_path, :ref => 0, :section => 4
      response.should_not have_tag "h1#app_layout_warning"
    end
  end


end

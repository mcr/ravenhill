require 'spec_helper'

describe Guardian do
  fixtures :all

  describe "relation to student" do
    it "has zero or more students" do
      u01 = guardians(:u01)
      u01.students.count.should == 1
    end
  end

  describe "confirmation" do
    it "should not send out a confirmation email if already confirmed" do
      u01 = guardians(:u01)
      
      u01.confirmed_for?(2012).should == true
    end

    it "should send out a confirmation email if never confirmed" do
      u02 = guardians(:u02)
      
      u02.confirmed_for?(2012).should == false
    end

    it "should send out a confirmation email if confirmed last year" do
      u03 = guardians(:u03)
      
      u03.confirmed_for?(2012).should == false
    end
  end
end

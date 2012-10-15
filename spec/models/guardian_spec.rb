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
    it "should derive confirmation year from rounding down to previous sept" do
      u01 = Guardian.new

      n = Time.local(2012,"jan",1,20,15,1)
      u01.current_confirmation_year(n).should == 2011

      n = Time.local(2012,"feb",1,20,15,1)
      u01.current_confirmation_year(n).should == 2011

      n = Time.local(2012,"mar",1,20,15,1)
      u01.current_confirmation_year(n).should == 2011

      n = Time.local(2012,"apr",1,20,15,1)
      u01.current_confirmation_year(n).should == 2011

      n = Time.local(2012,"may",1,20,15,1)
      u01.current_confirmation_year(n).should == 2011

      n = Time.local(2012,"jun",1,20,15,1)
      u01.current_confirmation_year(n).should == 2011

      n = Time.local(2012,"jul",1,20,15,1)
      u01.current_confirmation_year(n).should == 2011

      n = Time.local(2012,"aug",1,20,15,1)
      u01.current_confirmation_year(n).should == 2012

      n = Time.local(2012,"sep",1,20,15,1)
      u01.current_confirmation_year(n).should == 2012

      n = Time.local(2012,"oct",1,20,15,1)
      u01.current_confirmation_year(n).should == 2012

      n = Time.local(2012,"nov",1,20,15,1)
      u01.current_confirmation_year(n).should == 2012

      n = Time.local(2012,"dec",1,20,15,1)
      u01.current_confirmation_year(n).should == 2012
    end
    it "should not send out a confirmation email if already confirmed" do
      u01 = guardians(:u01)
      
      u01.send_confirmation!.should == true
    end

    it "should send out a confirmation email if never confirmed" do
      u02 = guardians(:u02)
      
      u02.send_confirmation!.should == false
    end

    it "should send out a confirmation email if confirmed last year" do
      u03 = guardians(:u03)
      
      u03.send_confirmation!.should == false
    end

    it "should find unconfirmed guardians" do
      Guardian.mortal.unconfirmed(2012).count.should == 3
      Guardian.mortal.unconfirmed(2011).count.should == 2
    end
  end
end

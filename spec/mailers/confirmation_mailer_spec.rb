require "spec_helper"

describe ConfirmationMailer do
  fixtures :all

  describe "confirm" do
    let(:mail) {
      ConfirmationMailer.confirm(guardians(:u02))
    }

    it "renders the headers" do
      mail.subject.should eq("Churchill Alternative School: Student Directory")
      mail.to.should eq(["frank.jones.209@gmail.com"])
      mail.from.should eq(["#{$RavenhillAdminEmail}"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Dear")
    end
  end

  describe "accepted" do
    let(:mail) {
      ConfirmationMailer.accepted(guardians(:u02))
    }

    it "renders the headers" do
      mail.subject.should eq("Accepted")
      mail.to.should eq(["frank.jones.209@gmail.com"])
      mail.from.should eq([$RavenhillAdminEmail])
    end

    it "renders the body" do
      mail.body.encoded.should match("Dear")
    end
  end

  describe "declined" do
    let(:mail) {
      ConfirmationMailer.declined(guardians(:u02))
    }

    it "renders the headers" do
      mail.subject.should eq("Declined")
      mail.to.should eq(["frank.jones.209@gmail.com"])
      mail.from.should eq([$RavenhillAdminEmail])
    end

    it "renders the body" do
      mail.body.encoded.should match("Dear")
    end
  end

  describe "wrong email" do
    let(:mail) {
      ConfirmationMailer.wrongemail(guardians(:u03))
    }

    it "renders the headers" do
      mail.subject.should eq("Wrongemail")
      mail.to.should eq(["fr.ankjones.209@gmail.com"])
      mail.from.should eq([$RavenhillAdminEmail])
    end

    it "renders the body" do
      mail.body.encoded.should match("Dear")
    end
  end

end

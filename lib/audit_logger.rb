class ActiveRecord::Base
  cattr_writer :auditlogger

  def auditlogger
    self.class.auditlogger
  end
  def self.auditlogger
    @@auditlogger || logger
  end
  def self.auditlogger=(x)
    @@auditlogger = x
  end
end

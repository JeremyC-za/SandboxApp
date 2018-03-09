module ActiveRecordExtension 
  extend ActiveSupport::Concern
  def fresh?
    created_at == updated_at
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtension) # include the extension 
module SlayerRails
  module Extensions
    module Transaction
      extend ActiveSupport::Concern

      included do
        def transaction(&block)
          ActiveRecord::Base.transaction(&block) if block_given?
        end

        def self.transaction(&block)
          ActiveRecord::Base.transaction(&block) if block_given?
        end
      end
    end
  end
end

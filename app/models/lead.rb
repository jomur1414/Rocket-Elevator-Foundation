class Lead < ActiveRecord::Base

belongs_to :customers, optional: true

end
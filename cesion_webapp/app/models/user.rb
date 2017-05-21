require 'carrierwave/orm/activerecord'
class User < ApplicationRecord
  mount_uploader :certificate, UserCertUploader
  mount_uploader :private_key, UserkeyUploader
end

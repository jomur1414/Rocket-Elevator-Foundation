class Customer < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :address
  has_many :leads

  has_many :buildings

  # IF using rake db:seed, comment this line to avoid an error
  after_create :upload_lead_files

  def upload_lead_files()
    dropbox_client = DropboxApi::Client.new(ENV['dropbox_token'])

    lead = Lead.find_by_email(self.contact_email)
    
    puts '--------------------------------------------------------------------------------------------------------'

    if lead.email == self.contact_email
      puts 'le email est pareil'
      dropbox_client.create_folder("/#{self.contact_full_name}")
      dropbox_client.upload("/#{self.contact_full_name}/#{lead.file_name}", lead.file_attachment)
      client_link = dropbox_client.get_temporary_link("/#{self.contact_full_name}/#{lead.file_name}")
      puts client_link.link
      lead.file_attachment = client_link.link
      lead.save!
      puts '--------------------------------------------------------------------------------------------------------'
    end
  end

end
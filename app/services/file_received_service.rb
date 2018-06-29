class FileReceivedService < BaseService
  def initialize(attachment_url, fields_url)
    @attachment_url = attachment_url
    @fields_url = fields_url
  end

  def call
    time_slots_file = FileDownloaderService.call(@attachment_url)
    fields_file = FileDownloaderService.call(@fields_url)
    FileClassifierService.call(time_slots_file, fields_file)
  rescue FileDownloadError
    # Log action
    # Notify Admin
  rescue FileClassifierError
    # Log action
    # Notify Admin
  end
end
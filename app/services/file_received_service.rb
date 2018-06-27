class FileReceivedService < BaseService
  def initialize(attachment_path, fields_path)
    @attachment_path = attachment_path
    @fields_path = fields_path
  end

  def call
    time_slots_file = FileDownloaderService.call(@attachment_path)
    fields_file = FileDownloaderService.call(@fields_path)
    FileClassifierService.call(time_slots_file, fields_file)
  rescue FileDownloadError
    # Log action
    # Notify Admin
  rescue FileClassifierError
    # Log action
    # Notify Admin
  end
end
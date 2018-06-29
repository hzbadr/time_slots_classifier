require 'open-uri'

class FileDownloadError < StandardError; end

class FileDownloaderService < BaseService

  STORE_ROOT_PATH = Rails.root.join("data")

  def initialize(attachment_path)
    @attachment_path = attachment_path
  end

  def call
    download
  rescue
    raise FileDownloadError
  end

  private
    def download
     open(@attachment_path).read
    end

    def file_path
      "#{STORE_ROOT_PATH}/#{Time.now.to_i}_#{file_name}"
    end

    def file_name
      File.basename(@attachment_path)
    end
end
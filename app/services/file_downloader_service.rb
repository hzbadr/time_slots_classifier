require 'open-uri'

class FileDownloadError < StandardError; end

class FileDownloaderService < BaseService

  STORE_ROOT_PATH = Rails.root.join("data")

  def initialize(attachment_path, root_path=STORE_ROOT_PATH)
    @attachment_path = attachment_path
    @root_path = root_path
  end

  def call
    download
  rescue
    raise FileDownloadError
  end

  private
    def download
      File.open(file_path, "wb") do |file|
        file.write open(@attachment_path).read
      end
    end

    def file_path
      "#{@root_path}/#{Time.now.to_i}_#{file_name}"
    end

    def file_name
      File.basename(@attachment_path)
    end
end
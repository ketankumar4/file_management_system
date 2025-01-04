class FileUploadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_file_upload, only: %i[destroy share]
  before_action :set_file_upload_by_shared_link, only: [:show]

  def index
    @file_uploads = current_user.file_uploads
  end

  def new
    @file_upload = FileUpload.new
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @file_upload }
    end
  end

  def create
    @file_upload = current_user.file_uploads.build(file_upload_params)
    if @file_upload.save
      redirect_to file_uploads_path, notice: "File uploaded successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @file_upload.destroy
    redirect_to file_uploads_path, notice: "File deleted successfully."
  end

  def share
    render plain: file_upload_url(@file_upload.shared_link)
  end

  private

  def set_file_upload_by_shared_link
    @file_upload = FileUpload.find_by(shared_link: params[:shared_link])
    if @file_upload.nil?
      render plain: "File not found", status: :not_found
    end
  end

  def set_file_upload
    @file_upload = current_user.file_uploads.find(params[:id])
  end

  def file_upload_params
    params.require(:file_upload).permit(:title, :description, :file_uploaded)
  end
end

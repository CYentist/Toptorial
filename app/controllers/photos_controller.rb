class PhotosController < ApplicationController
  def index
      @photos = Photo.all
    end

   def create
      @photo = Photo.new(file_name: params[:file])
      if @photo.save!
        render json: @photo
      else
        puts 'Hello'
        render json: { error: 'Failed to process' }, status: 422
      end
    end

    def delete_media
      Photo.where(id: params[:photos]).destroy_all
      redirect_to :back
    end

    def delete_all
      Photo.delete_all
      redirect_to :back
    end
end

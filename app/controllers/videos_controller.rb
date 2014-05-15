class VideosController < ApplicationController
  before_action :brand_signed_in?, only: [:create, :destroy]
  before_action :correct_brand,   only: :destroy

  def create
  	@video = current_brand.videos.build(video_params)
  	if @video.save
  		flash[:success] = "Video successfully added!"
  		redirect_to edit_brand_path(current_brand)
  	else
  		flash[:error] = "Oops!  A problem occured while saving this video link.  Please try again."
  		redirect_to edit_brand_path(current_brand)
  	end
  end

  def destroy
  	@video.destroy
  	redirect_to edit_brand_path(current_brand)
  end

  private

		def video_params
	    	params.require(:video).permit(:link, :link_html)
	    end

		# Before Filters

	    def correct_brand
	      @video = current_brand.videos.find_by(id: params[:id])
	      redirect_to(root_url) if @video.nil?
	    end
end

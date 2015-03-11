class VideosController < ApplicationController
  before_action :brand_signed_in?, only: [:update_row_order, :create, :destroy]
  before_action :correct_brand,   only: [:update_row_order, :update, :destroy]

  def update_row_order
    @video = Video.find(video_params[:video_id]) # I don't think I need this line bc it's defined in the 'correct_brand' before_action filter
    #@video.row_order_position = video_params[:row_order_position]
    @video.update_attribute :row_order_position, :new_order_position
    if @video.save
      flash[:success] = "Video position updated!"
      render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
    else
      flash[:error] = "Oops!  A problem occured.  Please try again."
      render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
    end
  end

  def create
    ######
    # Do I need to add something to the video params to assign :row_order_position when built???
    # This is what I'm attempting to do with the second line below:
    ######
  	@video = current_brand.videos.build(video_params)
    @video.update_attribute :row_order_position, :last
  	if @video.save
  		flash[:success] = "Video successfully added!"
  		redirect_to edit_brand_path(current_brand)
  	else
  		flash[:error] = "Oops!  A problem occured while saving this video link.  Please try again."
  		redirect_to edit_brand_path(current_brand)
  	end
  end
  ## I just added this to see if it would fix video ordering routing issue.
  def update
    #note that '@brand' is omitted here because it is defined by the before filter
      if @video.update_attributes(video_params)
        flash[:success] = "Videos updated"
        redirect_to edit_brand_path(current_brand)
      else
        flash[:error] = "Oops!  Videos not updated..."
        redirect_to edit_brand_path(current_brand)
      end
  end

  def destroy
  	@video.destroy
  	redirect_to edit_brand_path(current_brand)
  end

  private

		def video_params
	    	params.require(:video).permit(:link, :link_html, :row_order_position)
	    end

		# Before Filters

	    def correct_brand
	      @video = current_brand.videos.find_by(id: params[:id])
	      redirect_to(root_url) if @video.nil?
	    end
end

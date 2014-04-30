class BrandsController < ApplicationController

	before_action :correct_brand,   only: [:edit, :update]

	def index
		@brands = Brand.paginate(page: params[:page])
	end

	def show
		@brand = Brand.find(params[:id])
	end

	def edit
		#note that '@brand' is omitted here because it is defined by the before filter
	end

	def update
		#note that '@brand' is omitted here because it is defined by the before filter
	    if @brand.update_attributes(brand_params)
	      flash[:success] = "Profile updated"
	      redirect_to @brand
	    else
	      render 'edit'
	    end
	end

	private

		def brand_params
	    	params.require(:brand).permit(:name, :email, :password,
	    								  :password_confirmation,
	    								  :website, :hometown,
	    								  :homestate, :description,
	    								  :avatar, :avatar_cache)
	    end

		# Before Filters

	    def correct_brand
	      @brand = Brand.find(params[:id])
	      redirect_to(root_url) unless current_brand.id == @brand.id
	    end

end

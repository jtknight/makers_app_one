class BrandsController < ApplicationController

	def index
		@brands = Brand.paginate(page: params[:page])
	end

	def show
		@brand = Brand.find(params[:id])
	end

	def new
		@brand = Brand.new
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end

end

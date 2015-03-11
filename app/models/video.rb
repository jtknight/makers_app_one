class Video < ActiveRecord::Base
	include RankedModel
  		ranks :row_order
  		
	belongs_to :brand
	default_scope -> { order('row_order ASC') }
	validates :link, presence: true, length: { maximum: 1000 }
	validates :link_html, presence: true, length: { maximum: 1000 }
	validates :brand_id, presence: true

	auto_html_for :link do
      html_escape
      vimeo(:width => 400, :height => 250)
      youtube(:width => 400, :height => 250)
      link :target => "_blank", :rel => "nofollow"
      simple_format
    end
end

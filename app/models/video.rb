class Video < ActiveRecord::Base
	belongs_to :brand
	default_scope -> { order('created_at DESC') }
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

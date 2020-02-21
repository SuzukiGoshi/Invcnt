module ApplicationHelper
	include HtmlBuilder

	def document_title
		if @title.present?
			"#{@title} - InvCnt"
		else
			"InvCnt"
		end
	end
end

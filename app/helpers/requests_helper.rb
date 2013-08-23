module RequestsHelper
	def settle_parts(parts)
		parts.sort {|x, y|y.created_at <=> x.created_at}
	end
end

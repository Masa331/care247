module ApplicationHelper
	def time_difference(time)
		time_diff = Time.diff(time, Time.zone.now, '%d a %H')[:diff]
	end
end

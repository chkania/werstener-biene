# Outputs the reading time

# Read this in “about 4 minutes”
# Put into your _plugins dir in your Jekyll site
# Usage: Read this in about {{ page.content | reading_time }}

module ReadingTimeFilter
	def reading_time( input )
		words_per_minute = 180
		input = input.gsub(/\{% comment %\}.+?\{% endcomment %\}/m, '')
		input = input.gsub(/\<!--.+?-->/m, '')
		words = input.split.size;
		minutes = ( words / words_per_minute ).floor
		minutes_label = minutes === 1 ? " Minute" : " Minuten"
		minutes > 0 ? "ca. #{minutes} #{minutes_label}" : "weniger als eine Minute"
	end
end

Liquid::Template.register_filter(ReadingTimeFilter)

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('select[data-reveal-section]').change(->
		section = $("##{$(@).val() + $(@).attr('data-reveal-section')}")

		if section
			$('.hide-unless-selected').hide()
			section.find(':input').removeAttr('disabled')
			section.show()
	).trigger('change')



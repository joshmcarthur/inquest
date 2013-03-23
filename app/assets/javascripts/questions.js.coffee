# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
#= require epiceditor

Inquest.Questions ||= {}

Inquest.Questions.init = ->
	new EpicEditor(
		container: $('div.epiceditor')[0], 
		textarea: $($('div.epiceditor').attr('data-sync-with'))[0],
		basePath: '/assets/editor',
		clientSideStorage: false
	).load()

$ ->
	Inquest.Questions.init()
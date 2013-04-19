#= require select2

$ ->
  $('select.select2').select2(
    'width': 'element',
    'formatResultCssClass': (object) -> 'tag'
  )

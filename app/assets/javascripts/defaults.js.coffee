defaultsReady = ->
  $('.date-timepicker').datetimepicker(
    format: "YYYY-MM-DD HH:mm:ss Z"
    locale: 'de'
    defaultDate: moment().minute(0).second(0)
    sideBySide: true
  ).next().on(ace.click_event, ->
    $(this).prev().focus()
  )

  $.each $('.date-picker'), (index, el) ->
    $(el).parent().css 'position', 'relative'
    $(el).datetimepicker(
      format: "DD.MM.YYYY"
      locale: 'de'
      useCurrent: false
      showClear: true
      widgetParent: $(el).parent()
    )

$(document).ready(defaultsReady)
$(document).on('turbolinks:load', defaultsReady)


$(document).on "turbolinks:fetch", ->
  window.prevPageYOffset = window.pageYOffset
  window.prevPageXOffset = window.pageXOffset
  window.previousLocation = window.location.pathname
$(document).on "turbolinks:load", ->
  if $(".main-container").length > 0 && window.location.pathname == window.previousLocation
    $('.main-container').hide().show() # force re-render -- having an issue with that on Chrome/OS
    window.scrollTo window.prevPageXOffset, window.prevPageYOffset

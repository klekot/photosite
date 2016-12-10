# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.coffee.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('a.fancybox').fancybox
    'transitionIn': 'elastic'
    'transitionOut': 'elastic'
    'speedIn': 800
    'speedOut': 300
    'overlayShow': true
    'margin': 50
    'showCloseButton': true
    'showNavArrows': true
    'cyclic': true
    'hideOnContentClick': true
    'modal': false
  $('.reorder_link').on 'click', ->
    $('div.reorder-photos-list').sortable tolerance: 'pointer'
    $('.reorder_link').html 'Сохранить расположение фото'
    $('.reorder_link').attr 'id', 'save_reorder'
    $('#reorder-helper').slideDown 'slow'
    $('.image_link').attr 'href', 'javascript:void(0);'
    $('.image_link').css 'cursor', 'move'
    $('#save_reorder').click (e) ->
      if !$('#save_reorder i').length
        $(this).html('').prepend '<img src="refresh-animated.gif"/>'
        $('div.reorder-photos-list').sortable 'destroy'
        $('#reorder-helper').html('Сохраняем порядок фотографий, не обновлять страницу.').removeClass('light_box').addClass 'notice notice_error'
        h = []
        $('div.reorder-photos-list span').each ->
          h.push $(this).attr('id').substr(9)
          return
        $.ajax
          type: 'POST'
          url: 'order_update'
          data: ids: ' ' + h + ''
          success: (html) ->
            window.location.reload()
            return
        return false
      e.preventDefault()
      return
    return
  return

$ ->
  $container = $('#am-container')
  $imgs = $container.find('img').hide()
  totalImgs = $imgs.length
  cnt = 0
  $imgs.each (i) ->
    $img = $(this)
    $('<img/>').load(->
      ++cnt
      $('#number_img').text cnt.toString()
      if cnt == totalImgs
        $imgs.show()
        $container.montage
          fixedHeight: 200
          fillLastRow: false
          alternateHeight: true
          alternateHeightRange:
            min: 150
            max: 300
          margin: 5
        $('#load').css 'display', 'none'
      return
    ).attr 'src', $img.attr('src')
    return
  return
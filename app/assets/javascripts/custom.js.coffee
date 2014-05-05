$(document).ready ->

  # ------------------------------------------------------
  # pretty-fy the upload field
  # ------------------------------------------------------
  $realInputField = $('#lost_item_photo')

  # drop just the filename in the display field
  $realInputField.change ->
    $('#file-display').val $(@).val().replace(/^.*[\\\/]/, '')

  # trigger the real input field click to bring up the file selection dialog
  $('#upload-btn').click ->
    $realInputField.click()
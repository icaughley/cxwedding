module ApplicationHelper

  def update_flash_messages
    raw "$('#flash_messages').html(' #{escape_javascript( render 'layouts/messages' )}');"
  end

  def hide_modal
    raw "$('#modal').modal('hide');"
  end

  def open_modal_on_click( element_id, ajax_path)
    raw "<script>$('##{element_id}').click( function( ){$.ajax('#{ajax_path}');$('#modal').modal( 'show' );});</script>"
  end

  def link_button_to_simple_form_submit( button_id )
    raw "$('##{button_id}').click( function(){\n$('.simple_form').submit();\n});"
  end

end

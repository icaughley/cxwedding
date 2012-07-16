module ApplicationHelper

  def update_flash_messages
    raw "$('#flash_messages').html(' #{escape_javascript( render 'layouts/messages' )}');"
  end

  def link_button_to_simple_form_submit( button_id )
    raw "$('##{button_id}').click( function(){\n$('.simple_form').submit();\n});"
  end

end

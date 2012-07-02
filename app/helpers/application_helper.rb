module ApplicationHelper

  def update_flash_messages
    raw "$('#flash_messages').html(' #{escape_javascript( render 'layouts/messages' )}');"
  end

  def hide_modal
    raw "$('#modal').modal('hide');"
  end

end

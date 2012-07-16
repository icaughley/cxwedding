module ModalHelper

  def hide_modal(modal_name)
    raw "$('##{modal_name}_modal').modal('hide');"
  end

  def modal_header_text(modal_name, title)
    raw "$('##{modal_name}_modal > .modal-header > h3').text( '#{title}' );"
  end

  def modal_body_render(modal_name, partial)
    modal_body_html modal_name, render(partial)
  end

  def modal_body_html(modal_name, body)
    raw "$('##{modal_name}_modal > .modal-body').html( '#{escape_javascript( body )}');"
  end

  def modal_footer_render(modal_name, partial)
    modal_footer_html modal_name, render(partial)
  end

  def modal_footer_html(modal_name, footer)
    raw "$('##{modal_name}_modal > .modal-footer').html( '#{escape_javascript( footer )}');"
  end

  def open_modal_on_click(modal_name, element_id, ajax_path)
    raw "<script>$('##{element_id}').click( function( ){$.ajax('#{ajax_path}');$('##{modal_name}_modal').modal( 'show' );});</script>"
  end
end
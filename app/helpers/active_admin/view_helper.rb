module ActiveAdmin
  module ViewHelper

    def attachment_hint_with_delete(attachment, hint = 'No file uploaded', width = 214)
      if attachment.attached?
        is_image = attachment.content_type.start_with?('image/')

        file_preview = if is_image
                         image_tag(attachment, width:)
                       else
                         attachment.filename
                       end.then do |preview_content|
          link_to(preview_content, attachment.url, target: '_blank')
        end

        delete_link = if attachment&.id
                        link_to('Delete', delete_attachment_admin_admin_user_path(attachment.id),
                                style: 'text-decoration: underline; font-size: .9em; font-style: normal;',
                                method: :delete)
                      else
                        ''
                      end

        file_preview + delete_link
      else
        hint
      end
    end

    def multi_attachments_hint(attachments, hint = 'No file uploaded', width = 80)
      return hint if attachments.empty?

      attachments.map do |attachment|
        preview_content = image_tag(attachment, width:)

        file_preview = link_to(preview_content, attachment&.url, target: '_blank')

        delete_link = if attachment&.id
                        link_to('Delete', delete_attachment_admin_admin_user_path(attachment.id),
                                style: 'text-decoration: underline; font-size: .9em; font-style: normal;',
                                method: :delete)
                      else
                        ''
                      end

        file_preview + '<br>'.html_safe + delete_link
      end.join('<br>'.html_safe).html_safe

      # "<div class='multi-attachments'>#{file_preview + '<br>'.html_safe + delete_link}</div>".html_safe
    end

    def attachment_img(attachment, size = 150)
      if attachment.attached?
        image_tag url_for(attachment), style: "width: 100%; max-width: #{size}px;"
      else
        '-'
      end
    end

    def attachment_multi_img(images, size = 150)
      images.map do |img|
        img_preview = link_to(image_tag(img, width: size), img.url, target: '_blank')
        delete_link = link_to('Delete', delete_attachment_admin_admin_user_path(img.id),
                              style: 'text-decoration: underline; font-size: .9em; font-style: normal;',
                              method: :delete)
        return img_preview + '<br>'.html_safe + delete_link
      end.join('<br>'.html_safe)
    end

    def attachment_link(attachment)
      if attachment.attached?
        link_to attachment.filename, attachment.url, target: '_blank', style: 'word-break: break-word;'
      else
        '-'
      end
    end

    def attachment_value(attachment, method)
      if attachment.attached?
        attachment.send(method)
      else
        '-'
      end
    end

    def video_link(vid_row)
      if vid_row
        link_to 'View Video', vid_row.url, target: '_blank'
      else
        '-'
      end
    end
  end
end

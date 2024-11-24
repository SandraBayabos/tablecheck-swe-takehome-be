module ActiveAdmin
  module Views
    class IndexAsTable < ActiveAdmin::Component
      class IndexTableFor < ::ActiveAdmin::Views::TableFor
        def tag_col(attr)
          column(attr) do |obj|
            div(class: 'inline-block rounded-full text-center bg-slate-200 dark:bg-slate-700 px-2.5 py-1 capitalize text-xs ') do
              obj.send(attr)
            end
          end
        end

        def img_col(attr, col_title = nil)
          column(col_title || attr) do |obj|
            attachment_img(obj.send(attr))
          end
        end

        def truncate_col(attr, length, strip_tags = true)
          column(attr) do |obj|
            content = strip_tags ? strip_tags(obj.send(attr)) : obj.send(attr)
            content.try(:truncate, length)
          end
        end
      end
    end
  end
end

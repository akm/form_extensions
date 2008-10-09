require 'form_extensions'

ActionView::Base.module_eval do 
  include FormExtensions
end

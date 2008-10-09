module FormExtensions
  
  def self.included(klass)
    klass.class_eval do 
      alias_method_chain :submit_tag, :rbc_extension
    end
  end

  
  def submit_tag_with_rbc_extension(value = "Save changes", options = {})
    options.stringify_keys!
    enctype = 'multipart/form-data' if options.delete('multipart')
    url = options.delete('url')
    action = url_for(url) if url
    method = options.delete('method')
    java_scripts = []
    java_scripts << options['onclick']
    java_scripts << "this.form.action='#{action}'" if action
    java_scripts << "if (this.form['_method'] == null){this.form.method='#{method}'}else{this.form['_method'].value = '#{method}'}" if method
    java_scripts << "this.form.enctype='#{enctype}'" if enctype
    options['onclick'] = java_scripts.compact.join(';')
    result = submit_tag_without_rbc_extension(value, options)
    if @form_extentension_submit_suffix_no
      @form_extentension_submit_suffix_no += 1
      result.sub!(/id=\"(.*?)\"/){ 'id="%s_%d"' % [$1, @form_extentension_submit_suffix_no] }
    end
    @form_extentension_submit_suffix_no ||= 0
    result
  end
  
end

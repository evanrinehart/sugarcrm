module SugarCRM; class Connection
  # Retrieves the vardef information of the specified bean.  
  def get_module_fields(module_name)
    login! unless logged_in?  
    json = <<-EOF
      {
        "session": "#{@sugar_session_id}",
        "module_name": "#{module_name}"
      }
    EOF
    json.gsub!(/^\s{6}/,'')
    fields = SugarCRM::Response.handle(send!(:get_module_fields, json), @session)
    if fields['module_fields']['duration_hours']
      fields['module_fields']['duration_hours']['type'] = 'varchar'
    end
    fields
  end
  alias :get_fields :get_module_fields
end; end

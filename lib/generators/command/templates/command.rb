<% module_namespacing do -%>
class <%= class_name %>Command < Slayer::Command
  def call(<%= file_name %>_form:)
    flunk! unless arguments_valid?(<%= file_name %>_form)

    transaction do
      # Do your database interaction here!
    end

    pass
  end

  def arguments_valid?(<%= file_name %>_form)
    <%= file_name %>_form.kind_of?(<%= class_name %>Form) && <%= file_name %>_form.valid?
  end
end
<% end -%>

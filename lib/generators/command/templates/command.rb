<% module_namespacing do -%>
class <%= class_name %>Command < Slayer::Command
  def call(<%= file_name %>_form: <%= file_name %>_form)
    fail! unless test_form.kind_of?(<%= class_name %>Form) && <%= file_name %>_form.valid?

    transaction do
      # Do your database interaction here!
    end

    pass!
  end
end
<% end -%>

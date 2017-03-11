<% module_namespacing do -%>
class <%= class_name %>Form < Slayer::Form<% if @fields && @fields.any? %><% @fields.each do |field| %>
  attribute :<%= field[0] %>, <%= field[1] ? field[1] : "String" %><% end %><% end %>
end
<% end -%>

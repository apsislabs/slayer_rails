<% module_namespacing do -%>
class <%= class_name %>Command < Slayer::Command
  def call(args:)
    return err unless args_valid?(args)

    transaction do
      # Do your database interaction here!
    end

    ok
  end

  def args_valid?(args)
    true
  end
end
<% end -%>

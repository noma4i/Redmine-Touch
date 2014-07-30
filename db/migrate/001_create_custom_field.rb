class CreateCustomField < ActiveRecord::Migration
  def self.up
    custom_field = CustomField.create({
      name: "Updated By",
      field_format: "user",
      is_required: false,
      is_for_all: true,
      is_filter: true,
      searchable: false,
      editable: true,
      visible: false,
      format_store: {:user_role=>[], :edit_tag_style=>""}
    })
    custom_field.update_column(:type, "IssueCustomField")

  end
  def self.down
    #nope
  end
end

module RedmineTouch
  class UserUpdate < Redmine::Hook::ViewListener

    def controller_issues_new_after_save(context = { })
      self.update_field(context)
    end

    def controller_issues_edit_after_save(context = { })
      self.update_field(context)
    end

    def update_field(context)
      @issue = context[:issue]
      @journal = context[:journal]

      userid = (@journal.nil?) ? @issue.author.id : @journal.user.id

      cf = CustomField.where("lower(name) = ?", "Updated by".downcase).first
      cv = CustomValue.where(:customized_type => "Issue", :customized_id => @issue.id, :custom_field_id => cf.id).last
      if cv.present?
        cv.update_attribute :value, userid
      else
        CustomValue.create!(:customized_type => "Issue", :customized_id => @issue.id, :value => userid, :custom_field_id => cf.id)
      end
    end
  end
end

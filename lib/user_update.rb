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
      @bridge_id = CustomValue.by_name(@issue.id,'BridgeID')
      @journal = context[:journal]

      fullname = "#{@journal.user.firstname} #{@journal.user.lastname}" rescue '--'
      cf = CustomField.find_by_name('Updated By')
      cv = CustomValue.where(:customized_type => "Issue", :customized_id => @issue.id, :custom_field_id => cf.id).last
      if cv.present?
        cv.update_attribute :value, fullname
      else
        CustomValue.create!(:customized_type => "Issue", :customized_id => @issue.id, :value => fullname, :custom_field_id => cf.id)
      end
    end
  end
end

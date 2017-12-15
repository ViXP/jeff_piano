module ApplicationHelper
  def copyright
    time_tag(Date.today) do
      %(© #{Date.today.strftime('%Y')})
    end
  end
end

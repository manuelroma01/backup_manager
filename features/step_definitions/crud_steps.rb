Then "I should see the following users:" do |table|
  table.raw.each do |username|
    page.should have_css("tr.#{username}")
  end
end

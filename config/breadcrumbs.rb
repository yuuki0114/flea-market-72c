# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).


# ルート
crumb :root do
  link "トップページ", root_path
end

# マイページ
crumb :mypage do
  link "マイページ", users_path
end

# マイページ/プロフィール
crumb :new_profile do
  link "プロフィール", new_profile_path
  parent :mypage
end

# マイページ/発送元・お届け先住所変更
crumb :new_address do
  link "発送元・お届け先住所変更", new_address_path
  parent :mypage
end

# マイページ/支払い方法
crumb :new_credit_card do
  link "支払い方法", new_credit_card_path
  parent :mypage
end

# マイページ/メール・パスワード
crumb :mail do
  link "メール/パスワード", edit_user_path(:user_id)
  parent :mypage
end

# マイページ/本人情報
crumb :personal_information do
  link "本人情報", personal_information_users_path
  parent :mypage
end

# マイページ/ログアウト
crumb :logout do
  link "ログアウト", logout_users_path
  parent :mypage
end

# 親カテゴリーのパンくず
crumb :parent_category do |category|
  link category.name
end

# 子カテゴリーのパンくず
crumb :children_category do |category|
  link category.name
  parent :parent_category, category.parent 
end

# 孫カテゴリーのパンくず
crumb :grandchildren_category do |category|
  link category.name
  parent :children_category, category.parent
end
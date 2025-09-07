# db/seeds.rb
admin_email = "toshiki.1018@icloud.com"

admin = User.find_or_create_by!(email: admin_email) do |u|
  u.name     = "管理者ユーザー"
  u.password = "password"
end

admin.update!(admin: true)

puts "[seed] Admin user ready: #{admin_email}"
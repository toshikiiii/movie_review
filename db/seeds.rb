# seeds.rb
genres = %w[アクション SF コメディ ホラー サスペンス クライム スリラー ロマンス ミュージカル]
genre_map = genres.to_h { |name| [name, Genre.find_or_create_by!(name: name)] }


User.find_or_create_by!(email: admin_email) do |u|
  u.name     = "管理者ユーザー"
  u.password = "password"
  u.admin    = true
end

puts "[seed] admin user ensured: #{admin_email}"
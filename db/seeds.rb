
%w[アクション SF コメディ ホラー サスペンス クライム スリラー ロマンス ミュージカル ドラマ].each do |name|
  Genre.find_or_create_by!(name: name)
end
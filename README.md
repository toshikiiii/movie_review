# Cinemarks 映画の検索・レビューアプリ

## 1.サービス概要
映画をジャンル毎に検索して、レビューを投稿出来るアプリです。ユーザーが映画に評価やコメントを残し、他のユーザーと共有できます。

<h2 style="color: blue;">2. サービス画像</h2>

![サービス画面](https://raw.githubusercontent.com/toshikiiii/movie_review/refs/heads/main/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202025-09-08%2020.06.42.png)

## 3.サービスURL・開発ユーザーアカウント
https://cinemarks.onrender.com/

メールアドレス：toshiki.1018@icloud.com 
  パスワード：robin106905

## 4.機能
- ホーム画面
  
　　映画を評価順、名前順、公開年順に並び替えて表示可能。名称検索（一部合致）、ジャンル毎に絞って表示可能。

- 映画詳細
  
　　公開年、平均評価に加え、あらすじや各ユーザーのレビューが閲覧可能。

- アカウント
  
　　アカウントを作成し、自身の評価や感想を投稿可能。開発ユーザーに限定して映画作品の登録、ジャンル項目の追加が可能。

## 5.使用技術
- フロントエンド: HTML / CSS / JavaScript
- バックエンド: Ruby 3.3.3 / Rails 8.0.2.1
- DB:
  - Development / Test: SQLite
  - Production: PostgreSQL (Render)
- 画像アップロード: AWS S3 (ActiveStorage)
- デプロイ: Render
- 認証: has_secure_password（bcrypt）

## 6.ER図

## 7.今後の展望

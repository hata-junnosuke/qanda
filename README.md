# アプリ作成メモ
## 下準備
- rails new
- bin/rails db:create
- slimに変更
- bootstrap
- エラーメッセージの日本語
    - https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/ja.ymlからコピーした。
## モデル作成
- Questionを作成
-  bin/rails g model Question title:string body:text resolved_status:boolean
## コントローラ
- クエスチョンコントローラ作成（index,show,new,edit）
- ルーティング作成（resources :questions）
- root to: 'questions#index'
## ビュー
- 質問一覧から。とりあえず、全てを表示しよう。あとで未解決などの振り分け。
- コントローラ作成時に同時に作成されている。
## 質問を投稿できるようにする（現場にそって）
- 新規投稿のためのアクションを実装(newアクション)
- 新規投稿の画面を実装（form-with）
- 投稿のアクション（createアクション、ストロングパロメータ）
- flashが表示されるように、application.htmlを修正
## 質問一覧表示機能
- indexアクション記述
- each文で一覧に表示
## 詳細表示
- showアクション（params[:id]で引っ張る）
- ビューの作成

## 編集機能

## 削除機能


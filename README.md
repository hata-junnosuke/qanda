# アプリ作成メモ
## 下準備
- rails new
- bin/rails db:create
- slimに変更
- bootstrap
- エラーメッセージの日本語
    - https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/ja.ymlからコピーした。

## 12/11
##質問投稿機能作成
### モデル作成
- Questionを作成
-  bin/rails g model Question title:string body:text resolved_status:boolean
### コントローラ
- クエスチョンコントローラ作成（index,show,new,edit）
- ルーティング作成（resources :questions）
- root to: 'questions#index'
### ビュー
- 質問一覧から。とりあえず、全てを表示しよう。あとで未解決などの振り分け。
- コントローラ作成時に同時に作成されている。
### 質問を投稿できるようにする（現場にそって）
- 新規投稿のためのアクションを実装(newアクション)
- 新規投稿の画面を実装（form-with）
- 投稿のアクション（createアクション、ストロングパロメータ）
- flashが表示されるように、application.htmlを修正
### 質問一覧表示機能
- indexアクション記述
- each文で一覧に表示
### 詳細表示
- showアクション（params[:id]で引っ張る）
- ビューの作成
### 編集機能
- 編集ボタンの作成
- editとupdateアクションの追加
- パーシャルでフォームをまとめた
### 削除機能
- 削除ボタンの作成
- destroyアクションの追加


## 12/12
## ユーザー機能作成
- userモデル作成
- パスワードダイジェスト
- アドミン
- current_userの定義
- ログイン、ログアウト
- before_actionで制限
- データベースの紐付け（クエスチョンとユーザー）マイグレーションとモデルで
- コントローラcurrent_userで探すようにする
- 管理者機能をつける。

## 一般ユーザーの登録機能を作成
- usersコントローラ作成
- adminとの兼ね合いを修正

## questionのバリデーション追加
- titleとbodyにpresence: true

## バグの修正
- 質問をユーザーと結びつけられていなかったので、コントローラの修正（createアクション）
- questionの編集を投稿者のみできるようにした。（コントローラの修正）
- 質問投稿者のみ編集削除ボタンが表示される。
- ユーザーの新規登録後に再度ログインしなくてはならないバグ修正（session[:user_id] = @user.id）

## 12/14
## メモ
- ヘッダーに管理者のもの入れる(current_user.admin?で表示)
- 質問の管理者画面を作成(admin_questionを追加、require_adminメソッドも追加)
- できれば検索について調べる。

## 12/16
## メモ
- 検索機能の実装
- ページネーションの実装（7-7）
 bootstrap4でデザインを整える際に  https://qiita.com/yuufuji0000/items/4716867ed6bad97829cb
- ユーザー画像も。(現場7-5)

## 12/18
## メモ
- 回答機能(見た目はともかく)
- 解決済みにするには？ 
1. app/controller/questions/resolved_controllerを作成
2. controllerのなかでdef createで 
```
def create
    @question == Question.find(params[:question_id])
    if @question.update(is_solved: true)
       //
    end
end
```
3. routes.rb
```
resources: questions do
    resourses: resolved, module: :question
end
```
- もうちょっと工夫必要（ステータス）

## 12/19
## メモ
- ステータスを変更できるようにしたが、やりたかった形とは違う。
- メール機能で質問が投稿されるとメール送信されるが送信先が正しくない。

## 12/20
- メール機能で回答があれば、回答者にメールすることができた。あとは質問者に送れるようにする
- メール機能で昨日の問題はwhere.notで解決した。

## 12/21
- メールで回答したら質問者へメールがいくようにする
```
to: "#{@answer.question.user.email}, #{@answer.user.email}",
```
宛先をこのようにすると複数に送れた。
だが要件は満たせていない。

## 12/25
- renderではflashどうする？
- current_userのニルガードはいかに？
- railsの慣習について（モデルにかく？コントローラーに書く？）
  
## 12/27
- メール機能の整理
- routeの不要コードを排除

## 12/28
- 文字数制限(データベースとモデル)
- pathとurlが混ざっていることを修正
- 他のユーザーがユーザーデータを編集しようとした時にフラッシュを出す。
- 新規管理者登録への導線作成
- 質問一覧の検索とステータスを入れ替え
- questions/showの見た目修正

## 12/29
- destroyの修正
- 質問一覧と詳細N＋1解決
- メールアドレスの制約

### TODO（12・27・1130）
- 管理者画面の整理(特にサイドバー)
- 見た目の整理
- ユーザー一覧の見た目修正
# Sinatraでつくったメモアプリ

フィヨルドブートキャンプのWebアプリプラクティスの提出用です。
セーブデータにJSONファイル利用とDB利用の二通りブランチを分けて開発しました。
- JSONファイル利用 ``dev``
- DB利用 ``db-dev``
# Ruby Version

Rubyのバージョンは3.0.0です

# 実行方法

1. 作業PCの任意の作業ディレクトリにて git clone してください。
2. ``dev``あるいは``db-dev``ブランチにチェックアウトしてください。
```
cd simple_memo
git checkout dev 
```
2. bundle install にてGemfileをプロジェクトに反映させてください。
```
bundle install --path vendor/bundle
```
3. 作業PCのDB設定を行ってください。（JSONファイル利用``dev``ブランチでは不必要）
  - 3-1. postgresqlがインストールされていない場合インストールをしてください。
  - 3-2. psqlにてアプリ用のデータベースとテーブルを作成して下さい。
```bash
# CREATE DATABASE simple_memo;
# CREATE TABLE memos (id serial,title varchar(100),content varchar(3000));
```
  - 3-3. psqlの任意のユーザ情報を``app/models/database.yml``に追記してください。
```yml
default: &default
  host: 'localhost'
  port: 5432
  user: '#'  # 環境ごとに設定
  password: '#'  # 環境ごとに設定
  dbname: 'simple_memo' 
```
4. bundle exec ruby app/app.rbで実行してください。

# 機能

1. 新規作成でタイトルとメモ内容を記入すると新しいメモができます。
2. 作られたメモがホーム画面で一覧表示されます。
3. メモを選択すると内容が確認できます。
4. 内容確認画面で編集ボタンを押すと編集できます。
5. 内容確認画面で削除ボタンを押すと削除できます。

JSONセーブデータの保存場所はapp/public/data/memo.jsonです。

# Sinatraでつくったメモアプリ

フィヨルドブートキャンプのWebアプリプラクティスの提出用です。
# Ruby Version

Rubyのバージョンは3.0.0です

# 実行方法

1. 作業PCの任意の作業ディレクトリにて git clone してください。
2. devブランチにチェックアウトしてください。
```
cd simple_memo
git checkout dev 
```
2. bundle install にてGemfileをプロジェクトに反映させてください。
```
bundle install --path vendor/bundle
```
3. bundle exec ruby app/app.rbで実行してください。

# 機能

1. 新規作成でタイトルとメモ内容を記入すると新しいメモができます。
2. 作られたメモがホーム画面で一覧表示されます。
3. メモを選択すると内容が確認できます。
4. 内容確認画面で編集ボタンを押すと編集できます。
5. 内容確認画面で削除ボタンを押すと削除できます。

メモの保存場所はapp/public/data/memo.jsonです。

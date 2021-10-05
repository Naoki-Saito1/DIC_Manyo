# README
# manyo

## テーブルスキーマ


|users|tasks| tasklabelings    | 
| --- | --- | --- | 
|user_name:string| task_name:string|task:references | 
|email:string|content:string | user:references    | 
|password:string|limit:date |     | 
|               |status:integer|  |
|               | pariority:integer|  |
|               |user_id:references |  | 











## herokuデプロイ（for Mac)
下記コマンドを入力
```
$ heroku login
```

「Log In」をクリックしてください。

Herokuに新しいアプリケーションを作成します
```
$ heroku create
```

これで新しいアプリケーションが作成されました。

（例）
https://fierce-mountain-94329.herokuapp.com/ | https://git.heroku.com/fierce-mountain-94329.git

アセットプリコンパイルとはアセット類を本番環境で実行できる形式に変換することです。下記のコマンドを実行します。
```
$ rails assets:precompile RAILS_ENV=production
```
```
 $ git add -A
 $ git commit -m "init"
 ```
### Heroku buildpackを追加する

作成したアプリケーションをHeroku上でコンパイルするためのものです。
```

$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```

それではHerokuにデプロイしていきましょう。


```
$ git push heroku master
```


人によっては
```
$ git push heroku main
```
```
Counting objects: 92, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (79/79), done.
Writing objects: 100% (92/92), 22.60 KiB | 0 bytes/s, done.
Total 92 (delta 2), reused 0 (delta 0)
~ (省略) ~
remote: Verifying deploy... done.
To https://git.heroku.com/fierce-mountain-94329.git
 * [new branch]      master -> master
```
上記のようになれば成功です

## データベースの移行
Herokuデータベースの作成は自動で行われますが、マイグレーション（テーブル作成）は手動で実行する必要があります。
```
$ heroku run rails db:migrate
```
アプリ名を確認
```
$ heroku config
```

アプリ起動！
```
heroku open
```  


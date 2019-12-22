Study Roadmap
====

[![CircleCI](https://circleci.com/gh/amatsukixgithub/study_roadmap/tree/master.svg?style=svg)](https://circleci.com/gh/amatsukixgithub/study_roadmap/tree/master)

## Overview

プログラミング初学者のためのロードマップ共有アプリケーションです。

WEBページ：[Roadmap of Study](https://study-roadmap.herokuapp.com/about)

## Usage

このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンしてください。
その後、次のコマンドで必要になる RubyGems をインストールします。

```
$ bundle install --without production
```

インストールとnode_modulesに既にインストールされたファイルが削除されていないことを確認します。

```
$ yarn install --check-files
```

その後、データベースへのマイグレーションを実行します。

```
$ rails db:migrate
```

最後に、テストを実行してうまく動いているかどうか確認してください。

```
$ rails test
```

テストが無事に通ったら、Railsサーバーを立ち上げる準備が整っているはずです。

```
$ rails server
```
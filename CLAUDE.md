# CLAUDE.md

## プロジェクト概要

Oils シェル（OSH/YSH）を Docker/Podman コンテナ環境で試験的に動作させるための実験用リポジトリです。

## 目的

- Oils シェルの動作検証
- OSH（Bash互換シェル）と YSH（新しいモダンシェル）の違いを理解する
- コンテナ環境での Oils のビルドと実行方法を確立する

## 構成技術

| 技術 | 用途 |
|------|------|
| Oils (OSH/YSH) | 検証対象のシェル |
| Podman | コンテナランタイム |
| Alpine Linux | コンテナのベースイメージ |

### Oils について

- **OSH**: Bash/POSIX 互換シェル
- **YSH**: Python/JavaScript ユーザー向けの新しいシェル言語
- OSH と YSH は同一バイナリ（`oils-for-unix`）から symlink で提供される
- 違いはシェルオプション（`shopt`）の設定のみ

## ディレクトリ構造

```
my-playground-oil/
├── CLAUDE.md        # このファイル（プロジェクトガイド）
├── README.md        # 使い方・実行コマンド
├── Containerfile    # Podman/Docker 用コンテナ定義
└── scripts/         # テスト用スクリプト
    ├── test-osh.sh  # OSH 動作確認用
    └── test-ysh.ysh # YSH 動作確認用
```

## ビルド依存関係（Alpine Linux）

```sh
apk add libc-dev gcc readline-dev
```

## 参考リンク

### 公式

- [Oils 公式サイト](https://oils.pub/)
- [Oils GitHub](https://github.com/oils-for-unix/oils)
- [YSH とは](https://oils.pub/ysh.html)

### ドキュメント

- [Installing Oils](https://www.oilshell.org/release/latest/doc/INSTALL.html)
- [Getting Started](https://github.com/oils-for-unix/oils/blob/master/doc/getting-started.md)
- [Oils 2023 FAQ](https://www.oilshell.org/blog/2023/03/faq.html)

### 技術詳細

- [OSH versus Oil (Wiki)](https://github.com/oils-for-unix/oils/wiki/OSH-versus-Oil)
- [Reasons for the Big Renaming](https://www.oilshell.org/blog/2023/03/rename.html)

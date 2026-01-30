# my-playground-oil

> **Note**: これは個人の実験用リポジトリです。Oils シェルの動作検証を目的としています。

## 概要

[Oils](https://oils.pub/) シェル（OSH/YSH）を Podman コンテナ環境で試すためのプロジェクトです。

## 必要なもの

- Podman（または Docker）

## クイックスタート

### 1. コンテナイメージのビルド

```sh
podman build -t oils-shell .
```

### 2. OSH を起動（Bash互換モード）

```sh
podman run -it --rm oils-shell osh
```

### 3. YSH を起動（新しいシェル言語）

```sh
podman run -it --rm oils-shell ysh
```

### 4. テストスクリプトの実行

```sh
# OSH テスト
podman run --rm oils-shell osh /scripts/test-osh.sh

# YSH テスト
podman run --rm oils-shell ysh /scripts/test-ysh.ysh
```

### 5. 静的解析（構文チェック）

`-n` オプションでスクリプトを実行せずに構文チェックができます。

```sh
# OSH スクリプトの構文チェック
podman run --rm oils-shell osh -n /scripts/test-osh.sh

# YSH スクリプトの構文チェック
podman run --rm oils-shell ysh -n /scripts/test-ysh.ysh
```

## OSH と YSH の違い

| 項目 | OSH | YSH |
|------|-----|-----|
| 互換性 | Bash/POSIX 互換 | 新しい言語 |
| 対象ユーザー | 既存シェルスクリプトの実行 | Python/JS ユーザー |
| 構文 | 従来のシェル構文 | モダンな構文 |

両者は同じバイナリ（`oils-for-unix`）から提供され、symlink で切り替わります。

## 参考リンク

- [Oils 公式サイト](https://oils.pub/)
- [Oils GitHub](https://github.com/oils-for-unix/oils)
- [YSH とは](https://oils.pub/ysh.html)

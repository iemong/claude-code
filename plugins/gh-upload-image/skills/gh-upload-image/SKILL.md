---
name: gh-upload-image
description: |
  ローカルの画像ファイル(スクリーンショット等)をGitHubにアップロードし、PR/Issue本文にMarkdownで埋め込める公開URLを取得するスキル。
  使用タイミング: (1) この画像をPRに貼りたい (2) スクリーンショットをissueに追加したい (3) gh CLIでPR/Issue本文に画像を含めたい
  トリガーキーワード: 画像アップロード、スクショ貼って、PR本文に画像、gh upload image
user-invocable: false
allowed-tools: Bash Read
---

# GitHub Image Upload Skill

`gh auth token` の認証情報を使い、GitHubの `user-attachments` アップロードAPI（Web UIのドラッグ&ドロップ添付と同じ内部API）に画像をPOSTして公開URLを取得する。取得したURLは `![alt](url)` としてPR/Issue本文にそのまま埋め込める。

## 使用方法

```bash
bash ${CLAUDE_PLUGIN_ROOT}/skills/gh-upload-image/scripts/upload.sh <owner/repo> <file-path> [name]
```

成功すると `{"url":"https://github.com/user-attachments/assets/<uuid>"}` が返る。この `url` をそのままMarkdown画像として本文に貼る。

## 注意事項

- `uploads.github.com` は多くのサンドボックス環境でネットワーク許可リストに含まれていないため、実行にはサンドボックス無効化が必要になることがある。TLS証明書検証エラーが出た場合もサンドボックス起因のことが多い。
- 会話にユーザーが貼り付けた画像は、ローカル環境のファイルシステム上に実体を持たないことがある。アップロードできるのはローカルにファイルパスとして存在する画像だけ（自分で撮ったスクリーンショット等）。
- アップロードは実際にGitHub上へ公開コンテンツを作成する操作。機密性のある画像は事前に確認する。

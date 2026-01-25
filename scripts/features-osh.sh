#!/usr/bin/env osh
# =============================================================================
# OSH の特徴的な機能デモ
# OSH Features Demo - Bashより優れたエラーハンドリングと厳密性
# =============================================================================
#
# OSH は Bash 互換でありながら、以下の点で優れています:
# 1. より厳密なエラーハンドリング
# 2. 静的パースによる早期エラー検出
# 3. command_sub_errexit によるコマンド置換のエラー検出
# 4. sigpipe_status_ok による SIGPIPE の適切な処理
# 5. 詳細なパースエラーメッセージ

echo "=== OSH Features Demo ==="
echo ""

# =============================================================================
# 1. Strict Mode の強化
# =============================================================================
echo "1. Strict Mode (set -o errexit, pipefail, nounset)"
echo "   OSH では Bash の strict mode の問題点を修正しています"
echo ""

# OSH では errexit がより確実に動作
set -o errexit
set -o pipefail
set -o nounset

# =============================================================================
# 2. command_sub_errexit - コマンド置換でのエラー検出
# =============================================================================
echo "2. command_sub_errexit オプション"
echo "   Bash: \$(false) の失敗を無視してしまう"
echo "   OSH:  command_sub_errexit で検出可能"
echo ""

# OSH 独自のオプション: コマンド置換内のエラーも検出
# shopt -s command_sub_errexit  # これを有効にすると $(false) でも停止

demo_command_sub() {
    # この関数内でのみ errexit を無効化してデモ
    set +o errexit

    # Bash では以下のエラーを無視してしまう
    local result
    result=$(echo "success")
    echo "   コマンド置換成功: result=$result"

    set -o errexit
}
demo_command_sub

# =============================================================================
# 3. sigpipe_status_ok - パイプラインの改善
# =============================================================================
echo ""
echo "3. sigpipe_status_ok オプション"
echo "   'yes | head' のような場合の SIGPIPE を適切に処理"
echo ""

# OSH では sigpipe_status_ok で SIGPIPE を「成功」として扱える
# shopt -s sigpipe_status_ok  # これにより yes | head が失敗しない

# デモ: パイプラインの例
echo "   パイプライン例: seq 1 10 | head -3"
seq 1 10 | head -3 | while read -r line; do
    echo "     $line"
done

# =============================================================================
# 4. 静的パース - 早期エラー検出
# =============================================================================
echo ""
echo "4. 静的パース"
echo "   Bash: 実行時までシンタックスエラーが分からない"
echo "   OSH:  スクリプト読み込み時にエラーを検出"
echo ""

# OSH は静的にパースするため、以下のような問題を早期発見
# (実際のエラーコードはコメントアウト)
#
# Bash では実行されるまでエラーが分からない:
# if true; then
#     echo "ok"
# done  # fi の代わりに done - Bash は実行時まで気づかない
#
# OSH では読み込み時に検出される

echo "   静的パースにより、スクリプトの品質が向上します"

# =============================================================================
# 5. 詳細なエラーメッセージ
# =============================================================================
echo ""
echo "5. 詳細なエラーメッセージ"
echo "   OSH は問題箇所を正確に指し示します"
echo ""

# エラーデモ用の関数
demo_error_message() {
    # errexit を一時的に無効化
    set +o errexit

    # 存在しないコマンドを実行
    nonexistent_command_12345 2>/dev/null || true

    set -o errexit
}
echo "   (エラーメッセージのデモはスキップ)"

# =============================================================================
# 6. 配列の改善
# =============================================================================
echo ""
echo "6. 配列操作"
echo "   OSH は Bash の配列構文を完全サポート"
echo ""

# 配列の作成と操作
declare -a colors=(red green blue yellow)
echo "   配列: ${colors[*]}"
echo "   長さ: ${#colors[@]}"

# 連想配列
declare -A capitals
capitals["japan"]="tokyo"
capitals["france"]="paris"
capitals["usa"]="washington"

echo "   連想配列:"
for country in "${!capitals[@]}"; do
    echo "     $country -> ${capitals[$country]}"
done

# =============================================================================
# 7. プロセス置換のサポート
# =============================================================================
echo ""
echo "7. プロセス置換"
echo "   <(command) と >(command) をサポート"
echo ""

# プロセス置換の例
echo "   <(seq 1 3) の内容:"
while read -r num; do
    echo "     Line: $num"
done < <(seq 1 3)

# =============================================================================
# 8. Here String
# =============================================================================
echo ""
echo "8. Here String (<<<)"
echo ""

read -r first_word <<< "Hello World from OSH"
echo "   最初の単語: $first_word"

# =============================================================================
# 9. 拡張グロブ
# =============================================================================
echo ""
echo "9. 拡張グロブパターン"
echo "   OSH は Bash の extglob をサポート"
echo ""

shopt -s extglob
demo_pattern="file.txt.bak"
# extglob パターンの例
echo "   パターンマッチング例: $demo_pattern"

# =============================================================================
# 10. 終了ステータスの追跡
# =============================================================================
echo ""
echo "10. 終了ステータスの追跡"
echo "    OSH は終了コードを失わない"
echo ""

# errexit を一時的に無効化してデモ
set +o errexit

# パイプラインの各コマンドの終了ステータス
echo "first" | grep "first" | cat
echo "    PIPESTATUS: ${PIPESTATUS[*]}"

# falseを含むパイプライン
false | true | echo "test" > /dev/null
echo "    PIPESTATUS (false|true|echo): ${PIPESTATUS[*]}"

set -o errexit

# =============================================================================
# まとめ
# =============================================================================
echo ""
echo "=== OSH の主な利点 ==="
echo "1. Bash 互換性を保ちながらより安全"
echo "2. strict mode の穴を塞ぐオプション群"
echo "3. 静的パースによる早期エラー検出"
echo "4. 詳細で分かりやすいエラーメッセージ"
echo "5. YSH への移行パスを提供"
echo ""
echo "=== OSH Features Demo Complete ==="

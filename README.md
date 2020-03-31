# Secret Dinner
## 使い方
### Docker
以下を実行すると、太宰治『人間失格』の一部を基に日本語の文章を返します。
```sh
docker run ayumitamai97/secret_dinner:latest
```

または、お好きなテキストを渡すこともできます。

```sh
docker run ayumitamai97/secret_dinner:latest 私はその人を常に先生と呼んでいた。だからここでもただ先生と書くだけで本名は打ち明けない。
# => 私はその先生と常に人で呼んでいない。だから私だけただ先生を書くだけを先生は打ち明けない。

echo "私はその人を常に先生と呼んでいた。" > kokoro.txt
cat kokoro.txt | xargs docker run ayumitamai97/secret_dinner:latest
# => 私はその人と常に人を呼んでいた。
```

### ローカル環境
* Ruby をインストール (v2.7.0で動作確認済)
* MeCab をインストール(mecab v0.996, mecab-ipadic v2.7.0 (20070801) で動作確認済)
  * MacOS: `brew install mecab mecab-ipadic`
  * MacOS or Linux: [公式](https://taku910.github.io/mecab/#install)
    typoがあること、文字コードを変更する必要があることに注意
* `bundle install`
* [natto gemのREADME](https://github.com/buruzaemon/natto#explicit-configuration-via-mecab_path-and-mecab_charset)に従い`MECAB_PATH`を設定

以下を実行すると、太宰治『人間失格』の一部を基に日本語の文章を返します。
```sh
ruby secret_dinner.rb
```

または、お好きなテキストを渡すこともできます。

```sh
ruby secret_dinner.rb 私はその人を常に先生と呼んでいた。だからここでもただ先生と書くだけで本名は打ち明けない。
# => 私はその先生と常に人で呼んでいない。だから私だけただ先生を書くだけを先生は打ち明けない。
```

## 仕様
* 日本語のみ対応
* 品詞・活用形ごとに語をシャッフル & 再構成
  * （適切な頻度での句読点挿入 / 括弧の組 / 最低限の文脈構成 などはできません ><）
* [mecab-ipadic-NEologd](https://github.com/neologd/mecab-ipadic-neologd)は未対応（対応予定）


![test_result](https://circleci.com/gh/waday/pair_pro/tree/master.svg?style=shield&circle-token=:circle-token)


```
       　　　　―＼＼＼＼＼
       　　―　　　　　　　　　｀｀
       　／　　　　　　　　　　　　 ＼
       　／　　　　　　　　　　　　　　ヽ
       　／　　　　　　　　　　　　　　　し
       　/|　　　　　　　　 /ルﾉﾙ　　　　ノ
       　　|/|　　　　　　 /(O ) ﾉ　´ヽ　 彡
       　　　|/|　　　 /|/＼　　/　|6/　 彡
       　　　　|/|/|/く　　　＼|￣￣￣￣￣|
       　　|￣￣ヽ　―‐　┌┘
       　　|　　　　＼⌒ ＿|
        　　　　　　　￣
 ____  _        _    ____ _  __   _   _    ____ _  __
 | __ )| |      / \  / ___| |/ /  | | / \  / ___| |/ /
 |  _ \| |     / _ \| |   | ' /_  | |/ _ \| |   | ' / 
 | |_) | |___ / ___ \ |___| . \ |_| / ___ \ |___| . \ 
 |____/|_____/_/   \_\____|_|\_\___/_/   \_\____|_|\_\
                                                      
```

# ゲームの起動

```
$ ruby game.rb
```

# 操作方法

以下のように入力を求められる。  

- 1:hit（カードを引く）
- 2:stay（カードを引かない）

```
hit or stay? (1:hit, 2:stay) [2]:
```

# ルール

- カードの合計が21になるように組をつくる
- 合計が22以上になってしまったら負け
- Aは1とも11ともカウントできる
- J、Q、Kは10としてカウントする
- AとJ、Q、Kの組み合わせが一番強い

# 参考

[TDD Boot Camp Tokyo for C++ 2014-01 課題](http://www.slideshare.net/imagire/tdd-boot-camp-tokyo-for-c-30153762)

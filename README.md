# PseudoPhaser

Is it worth throwing some 30 dollars for getting only a straightforward filter?

## 各パラメーターの説明 (Japanese)

### Order

直列に接続するオールパスフィルタの数を設定します。この価を高ければ高く設定するほど、CPUパワーを使うため注意してください。（普通の使用であれば1から32くらいが妥当でしょう。）

### Frequency (Hz)

ディレイ効果を適用したい中心周波数を決定します。

20Hz から 5,000Hz (5kHz) まで設定できます。

### Q

この設定は **ALT** スイッチが**オンになっているときのみ**動作します。

Order を盛った状態でフィルタのQ幅を高い値(0.5\~)に設定すると不思議な音が出ます。

0\.0 から 1.0 まで設定できます。

### Mix (%)

エフェクトを適用しない原音とエフェクト適用後の音声をミックスする割合を設定します。有効な設定例は以下の通りです。

* 0% -- 原音のみ
* 50% -- 原音とエフェクトのミックス（Phase Cancellationが発生してノッチが出現します。本来のフェイザーはこのようにして動作しています。）
* 100% -- エフェクト適用後の音声

### Gain (dB)

DAW側に出力する音量を設定します。

### ALT

**ALT**ernativeの略です。他のフィルターを利用します。（技術的に言えば、'phase1' から 'phase2' への切り替えスイッチです。）これをオンにすることで、Q幅が設定できるようになります。

### CENTER

スピーカーを破損させたり音圧に悪い影響を与えるDCオフセットをカットします。

勾配のある Chebyshev Type I の 4-Pole の ハイパスフィルタを利用しています。20Hz 地点が固定でカットオフ地点に設定してあります。

## Features for each parameters (pOoR-eNgLiSh)

### Order

It determines how many filters are in line. Note that the more you would set this value high, the more CPU loads increase.

The range between 1 to 256 is available.

### Frequency

You can set the frequency on which you make the *difference*.

The range between 20Hz to 5,000Hz (5kHz) is available.

### Mix (%)

* 0% -- You might hear the original sound without processed one
* 50% -- You can obviously hear the notch effect phase cancellation makes (This is the way typical phaser works)
* 100% -- Now you are ready to have fun with delayed sound made by \*pure\* all-pass filter!

### Gain (dB)

Just a simple overall volume changer. 

### ALT

Yet another filter. Technically, checking this checkbox means using 'phaser2' instead of 'phaser1', while you are able to use **Q-knob.** 

### CENTER

It blocks DC-offset (0Hz) signals by built-in 4-Poles Chebyshev Type I high-pass filter. Cut-off point is fixed at 20Hz.

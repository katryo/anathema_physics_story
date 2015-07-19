#coding:utf-8
class Scenario
  attr_accessor :text
  def initialize(text, file_number)
    @text = text
    @file_number = file_number
  end
  def convert_and_output
    self.convert
    output_file = open("anathema_krkr#{@file_number}.txt", "w")
    output_file.write(self.text)
    output_file.close
  end

  def convert
    #;;＠のあとに、セーブ用のラベルを追加
    @text.gsub!(/;;＠$/, ";;＠\r\n*|\r\n[cm]");  # 
    #□で始まり途中に／のある行を、セーブ用のラベルにする
    @text.gsub!(/^□シーン(.*?)(-|ー|−)([\w\d]+)／([\w\d]+)/, "*scene\\1−\\3|\\1−\\3\r\n[cm]");  # 
    #□で始まり途中に／のない行を、セーブ用のラベルにする
    @text.gsub!(/^□シーン(.*?)(-|ー|−)([\w\d]+)/, "*scene\\1−\\3|\\1−\\3\r\n[cm]");  # 
    #！の直後に;;＠が入ると、クリック待ちが出現しなくなる。？も同じ
    @text.gsub!(/！\\r\\n/, "！[l][r]\\r\\n"); # 
    @text.gsub!(/。\\r\\n/, "。[l][r]\\r\\n"); # 
    @text.gsub!(/？\\r\\n/, "？[l][r]\\r\\n"); # 
    @text.gsub!(/^　\\r\\n/, "[r]\\r\\n");  # 
    @text.gsub!(/」\\r\\n/, "」[l][r]\\r\\n"); # 
    @text.gsub!(/』\\r\\n/, "』[l][r]\\r\\n"); # 
    @text.gsub!(/【(.)】「/, "「");  # 
    @text.gsub!(/【(..)】「/, "「"); # 
    @text.gsub!(/【(...)】「/, "「");  # 
    @text.gsub!(/【(....)】「/, "「"); # 
    @text.gsub!(/【(.....)】「/, "「");  # 
    @text.gsub!(/【(......)】「/, "「"); # 
    #クリック待ちの直後の;;＠を改ページにする
    @text.gsub!(/。;;＠/, "。[p][cm]"); # 
    #」直後の;;＠を改ページにする
    @text.gsub!(/」;;＠/, "」[p][cm]"); # 
    #！の;;＠を改ページにする
    @text.gsub!(/！;;＠/, "！[p][cm]"); # 
    #？の;;＠を改ページにする
    @text.gsub!(/？;;＠/, "？[p][cm]"); # 
    #ＡＤＶモードにする置換
    @text.gsub!(/^;;☆ＡＤＶモード/, "[position top=420 height=170 margint=3][style size=22]"); # 
    #ビジュアルノベルモードにする置換
    @text.gsub!(/^;;☆ビジュアルノベルモード/, "[position top=30 height=540 margint=40][style size=26]");  # 
    #ウェイトの置換
    @text.gsub!(/^;;☆ウェイト：([\d]+)/, "[wait time=\\1]"); # 
    #揺らしの置換
    @text.gsub!(/^;;☆揺らし：([\d]+)/, "[quake time=\\1]"); # 
    #揺らすの置換
    @text.gsub!(/^;;☆揺らす：([\d]+)/, "[quake time=\\1]"); # 
    #ＢＧＭの置換クロスフェード
    @text.gsub!(/^;;♪ＢＧＭ：([\w\d_.]+)／クロスフェード([\d]+)\r\n/, "[xchgbgm storage=\"\\1\" loop=true time=\\2]\r\n"); # 
    #ＢＧＭの置換フェードあり
    @text.gsub!(/^;;♪ＢＧＭ：([\w\d_.]+)／フェード([\d]+)\r\n/, "[fadeinbgm storage=\"\\1\" loop=true time=\\2]\r\n");  # 
    #ＢＧＭの置換フェードなし
    @text.gsub!(/^;;♪ＢＧＭ：([\w\d_.]+)\r\n/, "[playbgm storage=\"\\1\" loop=true]\r\n");  # 
    #ＢＧＭ止めの置換フェードあり
    @text.gsub!(/^;;♪ＢＧＭ止め／フェード([\d]+)/, "[fadeoutbgm time=\\1]");  # 
    #ＢＧＭ止めの置換フェードなし
    @text.gsub!(/^;;♪ＢＧＭ止め/, "[pausebgm]");  # 
    #ループの効果音はバッファ１から
    #効果音の置換ループ
    @text.gsub!(/^;;♭効果音：([\w\d_.]+)／ループ\r\n/, "[playse buf=1 storage=\"\\1\" loop=true]\r\n"); # 
    #効果音の置換フェードイン
    @text.gsub!(/^;;♭効果音：([\w\d_.]+)／フェード([\d]+)\r\n/, "[fadeinse buf=1 storage=\"\\1\" loop=true time=\\2]\r\n"); # 
    #効果音止めの置換フェードあり
    @text.gsub!(/^;;♭効果音止め／フェード([\d]+)/, "[fadeoutse buf=1 time=\\1]"); # 
    #効果音止めの置換フェードなし
    @text.gsub!(/^;;♭効果音止め/, "[stopse buf=1][stopse buf=0]");  # 
    #効果音ワンショット止めの置換フェードあり
    @text.gsub!(/^;;♭ワンショット効果音止め／フェード([\d]+)/, "[fadeoutse buf=0 time=\\1]"); # 
    #効果音ワンショットの置換フェードなし
    @text.gsub!(/^;;♭ワンショット効果音止め/, "[stopse buf=0]");  # 
    #ワンショットの効果音はバッファ０から
    #効果音の置換ワンショット
    @text.gsub!(/^;;♭効果音：([\w\d_.]+)\r\n/, "[playse buf=0 storage=\"\\1\"]\r\n"); # 
    #背景の置換デフォルトフェードあり
    @text.gsub!(/^;;◇背景：([\w\d_.]+)／デフォルトフェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=base page=back visible=true][trans method=crossfade time=\\2][wt]\r\n"); # 
    #背景の置換ブラインドフェードあり（標準）
    @text.gsub!(/^;;◇背景：([\w\d_.]+)／フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=base page=back visible=true][trans method=universal rule=\"blind\" time=\\2 vague=20][wt]\r\n");  # 
    #背景の置換右フェードあり
    @text.gsub!(/^;;◇背景：([\w\d_.]+)／右フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=base page=back visible=true][trans method=universal rule=\"\" time=\\2 vague=20][wt]\r\n"); # 
    #背景の置換左フェードあり
    @text.gsub!(/^;;◇背景：([\w\d_.]+)／左フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=base page=back visible=true][trans method=universal rule=\"left\" time=\\2 vague=20][wt]\r\n");  # 
    #背景の置換走りフェードあり
    @text.gsub!(/^;;◇背景：([\w\d_.]+)／走りフェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=base page=back visible=true][trans method=universal rule=\"run\" time=\\2 vague=20][wt]\r\n");  # 
    #背景の置換恐怖フェードあり
    @text.gsub!(/^;;◇背景：([\w\d_.]+)／恐怖フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=base page=back visible=true][trans method=universal rule=\"terror\" time=\\2 vague=20][wt]\r\n"); # 
    #背景の置換フェードなし
    @text.gsub!(/^;;◇背景：([\w\d_.]+)\r\n/, "[image layer=base storage=\"\\1\" page=fore]\r\n");  # 
    #立ち絵はレイヤー0〜1、イベント絵はレイヤー2で統一する
    #右の立ち絵は△立ち右：〜で対処する。右の立ち絵はレイヤー１を使う
    #立ち絵の置換フェードあり
    @text.gsub!(/^;;△立ち右：([\w\d_.]+)／フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=1 page=back visible=true pos=right][trans method=crossfade time=\\2][wt]\r\n");  # 
    #立ち絵の置換縦フェードあり
    @text.gsub!(/^;;△立ち右：([\w\d_.]+)／縦フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=1 page=back visible=true pos=right][trans method=universal rule=\"vertical\" time=\\2 vague=20][wt]\r\n");  # 

    #立ち消しの置換縦フェードあり
    @text.gsub!(/^;;△立ち消し右／縦フェード([\d]+)\r\n/, "[backlay][layopt layer=1 page=back visible=false pos=right][trans method=universal rule=\"vertical\" time=\\2 vague=20][wt]\r\n"); # 

    #立ち消しの置換縦フェードあり
    @text.gsub!(/^;;△立ち右消し／縦フェード([\d]+)\r\n/, "[backlay][layopt layer=1 page=back visible=false pos=right][trans method=universal rule=\"vertical\" time=\\2 vague=20][wt]\r\n"); # 

    #立ち絵の置換フェードなし
    @text.gsub!(/^;;△立ち右：([\w\d_.]+)\r\n/, "[image layer=1 storage=\"\\1\" page=fore visible=true pos=right]\r\n"); # 

    #立ち消しの置換フェードあり
    @text.gsub!(/^;;△立ち消し右／フェード([\d]+)\r\n/, "[backlay][layopt layer=1 page=back visible=false pos=right][trans method=crossfade time=\\1][wt]\r\n"); # 

    #立ち消しの置換フェードなし
    @text.gsub!(/^;;△立ち消し右\r\n/, "[layopt layer=1  visible=false page=fore pos=right]\r\n"); # 

    #立ち消しの置換フェードあり
    @text.gsub!(/^;;△立ち右消し／フェード([\d]+)\r\n/, "[backlay][layopt layer=1 page=back visible=false pos=right][trans method=crossfade time=\\1][wt]\r\n"); # 

    #立ち消しの置換フェードなし
    @text.gsub!(/^;;△立ち右消し\r\n/, "[layopt layer=1  visible=false page=fore pos=right]\r\n"); # 


    #左の立ち絵は△立ち左：〜で対処する

    #立ち絵の置換縦フェードあり
    @text.gsub!(/^;;△立ち左：([\w\d_.]+)／縦フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=1 page=back visible=true pos=left][trans method=universal rule=\"vertical\" time=\\2 vague=20][wt]\r\n"); # 

    #立ち消しの置換縦フェードあり
    @text.gsub!(/^;;△立ち消し左／縦フェード([\d]+)\r\n/, "[backlay][layopt layer=1 page=back visible=false pos=left][trans method=universal rule=\"vertical\" time=\\2 vague=20][wt]\r\n");  # 

    #立ち消しの置換縦フェードあり
    @text.gsub!(/^;;△立ち左消し／縦フェード([\d]+)\r\n/, "[backlay][layopt layer=1 page=back visible=false pos=left][trans method=universal rule=\"vertical\" time=\\2 vague=20][wt]\r\n");  # 

    #立ち絵の置換フェードあり
    @text.gsub!(/^;;△立ち左：([\w\d_.]+)／フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=0 page=back visible=true pos=left][trans method=crossfade time=\\2][wt]\r\n"); # 

    #立ち絵の置換フェードなし
    @text.gsub!(/^;;△立ち左：([\w\d_.]+)\r\n/, "[image layer=0 storage=\"\\1\" page=fore visible=true pos=left]\r\n");  # 

    #立ち消しの置換フェードあり
    @text.gsub!(/^;;△立ち消し左／フェード([\d]+)\r\n/, "[backlay][layopt layer=0 page=back visible=false pos=left][trans method=crossfade time=\\1][wt]\r\n");  # 

    #立ち消しの置換フェードなし
    @text.gsub!(/^;;△立ち消し左\r\n/, "[layopt layer=0  visible=false page=fore pos=left]\r\n");  # 

    #立ち消しの置換フェードあり
    @text.gsub!(/^;;△立ち左消し／フェード([\d]+)\r\n/, "[backlay][layopt layer=0 page=back visible=false pos=left][trans method=crossfade time=\\1][wt]\r\n");  # 

    #立ち消しの置換フェードなし
    @text.gsub!(/^;;△立ち左消し\r\n/, "[layopt layer=0  visible=false page=fore pos=left]\r\n");  # 


    #中央の立ち絵は△立ち：〜で対処する

    #立ち絵の置換縦フェードあり
    @text.gsub!(/^;;△立ち：([\w\d_.]+)／縦フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=1 page=back visible=true pos=center][trans method=universal rule=\"vertical\" time=\\2 vague=20][wt]\r\n");  # 

    #立ち消しの置換縦フェードあり
    @text.gsub!(/^;;△立ち消し／縦フェード([\d]+)\r\n/, "[backlay][layopt layer=1 page=back visible=false pos=center][trans method=universal rule=\"vertical\" time=\\2 vague=20][wt]\r\n"); # 

    #立ち絵の置換フェードあり
    @text.gsub!(/^;;△立ち：([\w\d_.]+)／フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=0 page=back visible=true pos=center][trans method=crossfade time=\\2][wt]\r\n");  # 

    #立ち絵の置換フェードなし
    @text.gsub!(/^;;△立ち：([\w\d_.]+)\r\n/, "[image layer=0 storage=\"\\1\" page=fore visible=true pos=center]\r\n"); # 

    #立ち消しの置換フェードあり
    @text.gsub!(/^;;△立ち消し／フェード([\d]+)\r\n/, "[backlay][layopt layer=0 page=back visible=false pos=center][trans method=crossfade time=\\1][wt]\r\n"); # 

    #立ち消しの置換フェードなし
    @text.gsub!(/^;;△立ち消し\r\n/, "[layopt layer=0  visible=false page=fore pos=center]\r\n"); # 

    #イベント絵の置換回転フェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／回転フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"回転\" time=\\2 vague=20][wt]\r\n"); # 


    #イベント絵の置換まばたきフェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／まばたき開きフェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"まばたき開き\" time=\\2 vague=20][wt]\r\n"); # 

    #イベント絵の置換まばたきフェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／まばたき閉じフェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"まばたき閉じ\" time=\\2 vague=20][wt]\r\n"); # 

    #イベント絵の置換上下フェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／上下フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"上から下へ\" time=\\2 vague=20][wt]\r\n");  # 

    #イベント絵の置換左上フェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／下上フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"下から上へ\" time=\\2 vague=20][wt]\r\n");  # 

    #イベント絵の置換左上フェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／左上フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"upleft\" time=\\2 vague=20][wt]\r\n"); # 

    #イベント絵の置換上フェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／上フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"up\" time=\\2 vague=20][wt]\r\n");  # 

    #イベント絵の置換右上フェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／右上フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"upright\" time=\\2 vague=20][wt]\r\n");  # 
    #イベント絵の置換走りフェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／右フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"run\" time=\\2 vague=20][wt]\r\n"); # 
    #イベント絵の置換左下フェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／左下フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"downleft\" time=\\2 vague=20][wt]\r\n"); # 
    #イベント絵の置換下フェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／下フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"down\" time=\\2 vague=20][wt]\r\n");  # 
    #イベント絵の置換右下フェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／右下フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"downright\" time=\\2 vague=20][wt]\r\n");  # 
    #イベント絵の置換中央フェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／中央フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=universal rule=\"center\" time=\\2 vague=20][wt]\r\n"); # 
    #イベント絵の置換フェードあり
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)／フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=2 page=back visible=true][trans method=crossfade time=\\2][wt]\r\n");  # 
    #イベント絵の置換フェードなし
    @text.gsub!(/^;;◎イベント絵：([\w\d_.]+)\r\n/, "[image layer=2 storage=\"\\1\" page=fore visible=true]\r\n"); # 
    #イベント絵消しの置換フェードあり
    @text.gsub!(/^;;◎イベント絵消し／フェード([\d]+)\r\n/, "[backlay][layopt layer=2 page=back visible=false][trans method=crossfade time=\\1][wt]\r\n"); # 
    #イベント絵消しの置換フェードなし
    @text.gsub!(/^;;◎イベント絵消し\r\n/, "[layopt layer=2  visible=false page=fore]\r\n"); # 
    #フラッシュなどのイベント絵の置換
    @text.gsub!(/^;;☆イベント絵：([\w\d_.]+)／フェード([\d]+)\r\n/, "[backlay][image storage=\"\\1\" layer=4 page=back visible=true][trans method=crossfade time=\\2][wt]\r\n");  # 
    #フラッシュなどの画面演出の置換フェードあり
    @text.gsub!(/^;;☆イベント絵消し／フェード([\d]+)\r\n/, "[backlay][layopt layer=4 page=back visible=false][trans method=crossfade time=\\1][wt]\r\n"); # 
    #;;｛でメッセージレイヤ消し／400にする
    @text.gsub!(/^;;｛\r\n/, "[backlay][layopt layer=message page=back visible=false][trans method=crossfade time=400][wt]\r\n"); # 
    #;;｝でメッセージレイヤ表示／400にする
    @text.gsub!(/^;;｝\r\n/, "[backlay][layopt layer=message page=back visible=true][trans method=crossfade time=400][wt]\r\n");  # 
    #メッセージレイヤ消しの置換フェードあり
    @text.gsub!(/^;;☆メッセージレイヤ消し／フェード([\d]+)\r\n/, "[backlay][layopt layer=message page=back visible=false][trans method=crossfade time=\\1][wt]\r\n");  # 
    @text.gsub!(/^;;☆メッセージレイヤ表示／フェード([\d]+)\r\n/, "[backlay][layopt layer=message page=back visible=true][trans method=crossfade time=\\1][wt]\r\n"); # 
    #メッセージレイヤ消しの置換
    @text.gsub!(/^;;☆メッセージレイヤ消し\r\n/, "[layopt layer=message visible=false]\r\n"); # 
    @text.gsub!(/^;;☆メッセージレイヤ表示\r\n/, "[layopt layer=message visible=true]\r\n");  # 
  end
end


(20..29).each do |n|
  file_number = n 
  scenario = Scenario.new(File.read("anathema_scenario#{file_number}.txt"), file_number)
  scenario.convert_and_output
end

file_number = 1
scenario = Scenario.new(File.read("anathema_scenario#{file_number}.txt"), file_number)
scenario.convert_and_output

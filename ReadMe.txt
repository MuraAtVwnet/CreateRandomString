■ これは何?
ランダムな文字列を生成します。
パスワード作成とかに使ってください

■ 使い方
CreateRandomString.ps1 文字列の長さ
文字列の長さを省略するとヘルプが表示されます

■ オプション
生成する文字数(-StringLength)
	生成するランダム文字数を指定します
	省略時には8文字のランダム文字列が生成されます

拡張記号を除く(-IncludeExtendMark)
	以下の拡張記号を含むようにします
	'`"``()-^~\|[]{};:<>,/_
	省略時は拡張記号を除きます

基本記号を除く(-RejectBaseMark)
	以下の基本記号を含まないようにします
	!.?+$%#&*=@
	省略時は基本記号を含みます

アルファベットを除く(-RejectAlphabet)
	アルファベットを含まないようにします
	省略時はアルファベット含みます

■ 例
~\CreateRandomString 10
10文字のランダム文字列を生成します

~\CreateRandomString 10 -IncludeExtendMark
拡張記号を含んだ10文字のランダム文字列を生成します

~\CreateRandomString 10 -RejectBaseMark
基本記号を含まない10文字のランダム文字列を生成します
(アルファベットと数字だけの10文字のランダム文字列を生成します)

~\CreateRandomString 10 -RejectBaseMark -RejectAlphabet
基本記号とアルファベットを含まない10文字のランダム文字列を生成します
(数字だけの10文字のランダム文字列を生成します)

■ Web サイト
PowerShell で指定サイズのランダムな文字列/バイナリ列を生成する
http://www.vwnet.jp/Windows/PowerShell/CreateRandomData.htm


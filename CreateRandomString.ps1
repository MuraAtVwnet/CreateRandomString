##################################################
# パスワード生成
##################################################
Param(
	[int]$StringLength = 0,		# 生成する文字数
	[switch]$IncludeExtendMark,	# 拡張記号を含む
	[switch]$RejectBaseMark,	# 基本記号を除く
	[switch]$RejectAlphabet 	# アルファベットを除く
)

##################################################
# Help
##################################################
function Usage(){
	$HelpText = @'
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
'@

	Write-Output $HelpText
}

##################################################
# ランダム文字列生成
##################################################
function CreateRandomString(
			$ByteSize, 			# 生成する文字数
			$RejectExtendMark,	# 拡張記号を除く
			$RejectBaseMark,	# 基本記号を除く
			$RejectAlphabet 	# アルファベットを除く
		){
	# アセンブリロード
	Add-Type -AssemblyName System.Security

	# ランダム文字列にセットする値
	$BaseString = '1234567890'
	$Alphabet = 'ABCDEFGHIJKLNMOPQRSTUVWXYZabcdefghijklnmopqrstuvwxyz'
	$BaseMark = '!.?+$%#&*=@'
	$ExtendMark = "'`"``()-^~\|[]{};:<>,/_"

	# アルファベット
	if( $RejectAlphabet -ne $true ){
		$BaseString += $Alphabet
	}

	# 拡張記号
	if( $RejectExtendMark -ne $true ){
		$BaseString += $ExtendMark
	}

	# 基本記号
	if( $RejectBaseMark -ne $true ){
		$BaseString += $BaseMark
	}

	# 乱数格納配列
	[array]$RandomValue = New-Object byte[] $ByteSize

	# オブジェクト 作成
	$RNG = New-Object System.Security.Cryptography.RNGCryptoServiceProvider

	# 乱数の生成
	$RNG.GetBytes($RandomValue)

	# 乱数を文字列に変換
	$ReturnString = ""
	$Max = $BaseString.Length
	for($i = 0; $i -lt $ByteSize; $i++){
		$ReturnString += $BaseString[($RandomValue[$i] % $Max)]
	}

	# オブジェクト削除
	$RNG.Dispose()

	return $ReturnString
}

##################################################
# main
##################################################

if( $StringLength -eq 0 ){
	Usage
	exit
}

$RejectExtendMark = -not $IncludeExtendMark
CreateRandomString $StringLength $RejectExtendMark $RejectBaseMark $RejectAlphabet

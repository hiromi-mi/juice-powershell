# Add-Type を用い C# ソースコードをコンパイルする例

# Add-Type は .NET Framework 上にある型を PowerShell に挿入するものです. それを使用し C# ソースコードをコンパイルします
# -TypeDefinition : 型の定義
# -ReferencedAssemblies : 使用するアセンブリ参照
# -Language : 言語 CSharp, VisualBasic
# -OutputType : 出力形式 WindowsApplication, ConsoleApplication, Library
# -OutputAssembly : 出力ファイル

# カレントディレクトリにあるすべての cs ファイルをもとに Windows アプリケーション $output を作成
# 古いソースコード
# System, System.Windows.Forms, System.IO, System.Collections, System.Drawing を using してかつ参照している
function CompileWindowsAppOld($output) { 
    $source = ("using System;", "using System.Windows.Forms;", "using System.IO;", "using System.Collections;", "using System.Drawing;")
    $source += ls .\*.cs | Get-Content -Encoding UTF8 | foreach -Process { if ($_ -notmatch "^using") { $_ } }
    $source2 = $source -join "`n"
    $assemblies = ("System", "System.Windows.Forms", "System.IO", "System.Collections", "System.Drawing")
    Add-Type -TypeDefinition $source2 -ReferencedAssemblies $assemblies -Language CSharp -OutputType WindowsApplication -OutputAssembly $output
}

# カレントディレクトリにあるすべての cs ファイルをもとに Windows アプリケーション $output を作成
# -Path オプションを用いることで
function CompileWindowsApp($output) {
    $assemblies = ("System", "System.Windows.Forms", "System.IO", "System.Collections", "System.Drawing")
    Add-Type -Path .\*.cs -ReferencedAssemblies $assemblies -OutputAssembly $output -OutputType WindowsApplication
}
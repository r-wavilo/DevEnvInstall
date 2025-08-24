. $PSScriptRoot\DevEnvInstallUtil.ps1
DownloadAndInstallProgram -sourceUrl "https://github.com/clangd/clangd/releases/download/20.1.8/clangd-windows-20.1.8.zip" -dstInstallDirName ".clangd" -dstBinDirName "bin"
DownloadAndInstallProgram -sourceUrl "https://github.com/clangd/clangd/releases/download/20.1.8/clangd_indexing_tools-windows-20.1.8.zip" -dstInstallDirName ".clangd" -dstBinDirName "bin"


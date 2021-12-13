curl https://crftwr.github.io/keyhac/download/keyhac_182.zip -o ./keyhac_182.zip
unzip ./keyhac_182.zip
mv ./keyhac/ ~/keyhac
mkdir -p $(dirname $env:APPDATA/Keyhac/config.py)
gsudo New-Item -Force -Value $HOME/dotfiles/keyhac/config.py -Path $env:APPDATA/Keyhac -Name config.py -ItemType SymbolicLink

$starup = $(Get-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders').startup
gsudo New-Item -Force -Value $HOME/keyhac/keyhac.exe -Path $starup -Name keyhac.exe -ItemType SymbolicLink
rm ./keyhac_182.zip
rmdir .\keyhac\

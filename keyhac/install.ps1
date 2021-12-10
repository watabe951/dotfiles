curl https://crftwr.github.io/keyhac/download/keyhac_182.zip -o ./keyhac_182.zip
unzip ./keyhac_182.zip
mv ./keyhac/ ~/keyhac
mkdir -p $(dirname $env:APPDATA/Keyhac/config.py)
gsudo ln -T -s -f $HOME/dotfiles/keyhac/config.py $env:APPDATA/Keyhac/config.py

$starup = $(Get-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders').startup
gsudo ln -T -s  -f $HOME/keyhac/keyhac.exe $($starup + "\keyhac.exe")
rm ./keyhac_182.zip
rmdir .\keyhac\

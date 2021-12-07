# download change key
curl.exe http://satoshi3.sakura.ne.jp/f_soft/dw_win.files/ChgKey15.LZH --output .\chgkey.lzh

# extract lzh
7z x .\chgkey.lzh -o"./chgkey"

# haichi
Move-Item -Force ./chgkey $env:APPDATA/chgkey
gsudo ln -f -T -s $HOME/dotfiles/ChangeKey/chgkey.ini $env:APPDATA/chgkey/chgkey.ini
Remove-Item .\chgkey -r
Remove-Item .\chgkey.lzh
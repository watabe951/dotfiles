# install dein
Invoke-WebRequest https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.ps1 -OutFile installer.ps1
# Allow to run third-party script
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# For example, we just use `~/.cache/dein` as installation directory
./installer.ps1 ~/.cache/dein
Remove-Item ./installer.ps1

# set symlinks
mkdir -p $HOME/.config/nvim/dein/toml
gsudo ln -T -s -f $HOME/dotfiles/dein/dein.toml $HOME/.config/nvim/dein/toml/dein.toml
gsudo ln -T -s -f $HOME/dotfiles/dein/dein_lazy.toml $HOME/.config/nvim/dein/toml/dein_lazy.toml

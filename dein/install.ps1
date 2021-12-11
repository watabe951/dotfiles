# install dein
Invoke-WebRequest https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.ps1 -OutFile installer.ps1
# Allow to run third-party script
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# For example, we just use `~/.cache/dein` as installation directory
./installer.ps1 ~/.cache/dein
Remove-Item ./installer.ps1

# set symlinks
if (-Not( Test-Path $HOME/.config/nvim/dein/toml)){
	mkdir -p $HOME/.config/nvim/dein/toml
}
mkdir -p $HOME/.config/nvim/dein/toml
gsudo New-Item -Value $HOME/dotfiles/dein/dein.toml -Path $HOME/.config/nvim/dein/toml -Name dein.toml -ItemType SymbolicLink -Force
gsudo New-Item -Value $HOME/dotfiles/dein/dein_lazy.toml -Path $HOME/.config/nvim/dein/toml -Name dein_lazy.toml -ItemType SymbolicLink -Force

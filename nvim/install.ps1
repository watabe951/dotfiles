if (-Not(Test-Path $HOME\.config\nvim)){
	mkdir -p $HOME/.config/nvim

}
if (Test-Path $HOME\.config\nvim\init.vim){
	Rename-Item -Path $HOME\.config\nvim\init.vim -NewName $HOME\.config\nvim\init.vim.backup
}
gsudo New-Item -Path $HOME/.config/nvim -Name init.vim -Value $HOME/dotfiles/nvim/init.vim -ItemType SymbolicLink -Force

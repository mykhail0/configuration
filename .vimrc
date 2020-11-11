" For default windows.
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backupdir=$HOME/.vim/backup//,.
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undodir=$HOME/.vim/undo//,.
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

set encoding=utf-8

set softtabstop=4
set shiftwidth=4
set expandtab

# brew zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -Uz colors && colors
# makes color constants available
export CLICOLOR=1

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars no_list_beep no_beep 
DIRSTACKSIZE=5

cdpath=($HOME/Projects $HOME/Sites $HOME/Code)

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch
unsetopt correctall
unsetopt multios

eval "$(fasd --init auto)"




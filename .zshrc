# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

######################################################################################
#                                 ZSH CONFIGURATION                                  #
######################################################################################

# -----------------------------------------------------
# 1. ENVIRONMENT & PATH
# -----------------------------------------------------
export PATH=$HOME/.local/bin:$PATH
export EDITOR='nvim'
export VISUAL='nvim'

# -----------------------------------------------------
# 2. HISTORY
# -----------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY          # Append to history file instead of overwriting
setopt SHARE_HISTORY           # Share history between different terminals
setopt HIST_IGNORE_DUPS        # Do not record duplicate commands
setopt HIST_IGNORE_SPACE       # Ignore commands starting with space

# -----------------------------------------------------
# 3. AUTOCOMPLETION & STYLE
# -----------------------------------------------------
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

# Kill process list colors
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# -----------------------------------------------------
# 4. PLUGINS (Arch Linux System Plugins)
# -----------------------------------------------------
# Syntax Highlighting
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Sudo plugin
[ -f /usr/share/zsh-sudo/sudo.plugin.zsh ] && source /usr/share/zsh-sudo/sudo.plugin.zsh 

# -----------------------------------------------------
# 5. INPUT & KEYBINDINGS (FULL FIX)
# -----------------------------------------------------
# Force Emacs mode (Standard behavior)
bindkey -e

# --- 1. Fix Arrow Keys & Alt shortcuts ---
bindkey '^[f' forward-word      # Alt + F
bindkey '^[b' backward-word     # Alt + B
bindkey '^[[C' forward-char     # Right Arrow
bindkey '^[[1;5C' forward-word  # Ctrl + Right Arrow
bindkey '^[[D' backward-char    # Left Arrow
bindkey '^[[1;5D' backward-word # Ctrl + Left Arrow

# --- 2. Fix Home / End / Delete / Insert ---
# We use terminfo to adapt to whatever terminal you are using (Kitty/Alacritty/etc)
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"

# Bind the keys only if they are detected
[[ -n "${key[Home]}" ]]      && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}" ]]       && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}" ]]    && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Delete]}" ]]    && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[PageUp]}" ]]    && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history

# Fallback for common terminals if terminfo fails
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

# Fix for Autosuggestions interactions
bindkey '^e' end-of-line
bindkey '^a' beginning-of-line

# -----------------------------------------------------
# 6. VISUALS (LS_COLORS & MANPAGER)
# -----------------------------------------------------
# Colored Man Pages using BAT
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# LS_COLORS Configuration
eval "$(dircolors -b)"
export LS_COLORS="rs=0:di=34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

# Apply colors to completion menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# -----------------------------------------------------
# 7. FZF & BAT INTEGRATION
# -----------------------------------------------------
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Preview Logic
_FZF_PREVIEW_CMD='[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -n 500'

# Ctrl+T: Search Files
export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD' --preview-window right:60%:wrap"

# Ctrl+R: Search History
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
  --color header:italic
  --header 'Press CTRL-/ to toggle preview'"

# -----------------------------------------------------
# 8. ALIASES
# -----------------------------------------------------
# --- Modern Replacements ---
alias cat='bat'
alias catn='bat --style=plain'
alias catnp='bat --style=plain --paging=never'
alias ls='lsd --group-dirs=first'
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias grep='grep --color=auto'

# --- Navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ~="cd ~"
alias c="clear"
alias reload="source ~/.zshrc"
alias h="history"

# --- Tools ---
alias wi-fi="nmtui"
alias v="nvim"
alias vf="fzf --preview '$_FZF_PREVIEW_CMD' --bind 'enter:execute(nvim {})'"
alias clearclip="cliphist wipe"
alias copy="wl-copy"

# --- Config Management ---
alias hyprconf='nvim ~/.config/hypr/hyprland.conf'
alias zshconf='nvim ~/.zshrc'
alias day="hyprctl hyprsunset identity"
alias night="hyprctl hyprsunset temperature 4500"

# -----------------------------------------------------
# 9. THEME LOAD (Powerlevel10k)
# -----------------------------------------------------
source /home/apereza/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# =============================================================================
# 10. FUNCTIONS
# =============================================================================

# Set Target for Waybar (htb_target)
function settarget(){
    if [ $# -eq 1 ]; then
        echo $1 > $HOME/.config/waybar/scripts/target
    elif [ $# -gt 2 ]; then
        echo "Usage: settarget [IP] [NAME] | settarget [IP]"
    else
        echo $1 $2 > $HOME/.config/waybar/scripts/target
    fi
}


# Create Pentesting Workspace
function mkt(){
    mkdir {nmap,content,exploits,scripts}
}

# Extract Ports from Nmap & Copy to Clipboard
function extractPorts(){
    local tmp_file=$(mktemp)
    # Extract ports and IP
    ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
    ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
    
    # Output formatting
    echo -e "\n[*] Extracting information...\n" > "$tmp_file"
    echo -e "\t[*] IP Address: $ip_address"  >> "$tmp_file"
    echo -e "\t[*] Open ports: $ports\n"  >> "$tmp_file"
    
    # Copy to clipboard
    echo "$ports" | tr -d '\n' | xclip -sel clip
    echo -e "[*] Ports copied to clipboard\n"  >> "$tmp_file"
    
    cat "$tmp_file"
    rm "$tmp_file"
}

# Secure Delete
function rmk(){
    scrub -p dod $1
    shred -zun 10 -v $1
}


function cleanDocker(){
    docker rm  $(docker ps -a -q) --force 2> /dev/null
    docker rmi $(docker images  -q) 2> /dev/null
    docker network rm $(docker network ls -q) 2> /dev/null
    docker volume rm $(docker volume ls -q) 2>  /dev/null
}















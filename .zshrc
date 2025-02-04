# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

# Disable .NET Telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Export Path
PATH=/root/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/local/zig:/usr/local/jdk-23/bin:$HOME/.local/bin

# Setting up the Path for .NET tools
export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Set History options
setopt hist_ignore_dups
setopt share_history

# Use modern completion system
autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)

eval "$(dircolors -b)"
zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Enable Oh-my-posh.
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.toml)"

# Manual aliases
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias malbian='sudo qemu-system-x86_64 -enable-kvm -boot menu=on -drive file=/var/lib/libvirt/images/debImage.img -m 4G -cpu host -smp 2 -vga virtio -display sdl,show-cursor=on'
alias blackarch='sudo qemu-system-x86_64 -enable-kvm -boot menu=on -drive file=/var/lib/libvirt/images/archImage.img -m 4G -cpu host -smp 2 -vga virtio -display sdl,show-cursor=on'
alias flareVM='sudo qemu-system-x86_64 -enable-kvm --boot menu=on -drive file=/var/lib/libvirt/images/flarevmImage.img -m 4G -cpu host -smp 2 -vga virtio -display sdl,show-cursor=on -usbdevice tablet'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || source <(fzf --zsh)

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Customized Functions listed below

# Set and Unset an Environmental variable for a target in a CTF Environment.
function settarget() {
  pkill -RTMIN+10 dwmblocks
  /bin/mkdir /tmp/environ 2>/dev/null
  echo "$1" > /tmp/environ/environment
  echo "$1 now set as your Target."
}

function clstarget(){
  /bin/rm -rf /tmp/environ/environment
  echo "Your target is now Cleared."
  pkill -RTMIN+10 dwmblocks
}

function checknet(){
  pkill -RTMIN+11 dwmblocks
}

# Show md5 and sha256 hashes of a file:
function getHashes(){
  echo "MD5: $(md5sum $1)"
  echo "SHA1: $(sha1sum $1)"
  echo "SHA256: $(sha256sum $1)"
  echo "SHA384: $(sha384sum $1)"
  echo "SHA512: $(sha512sum $1)"
  echo -e "\t Look for this hashes in: https://www.virustotal.com/en/file/$(md5sum $1)"
}

# Show open TCP/UDP ports on the terminal from a nmap tcp/udp scan.
function showPorts(){
  targetip=$(cat /tmp/environ/environment | awk '{print $1}')
  ipAddress=$(grep -i 'nmap scan report for' $1 | awk '{print$5}')
  tcpPorts=$(grep -oP '\d{1,5}/tcp' $1 | awk '{print $1}' FS='/' | xargs | tr ' ' ',')
  udpPorts=$(grep -oP '\d{1,5}/udp' $1 | awk '{print $1}' FS='/' | xargs | tr ' ' ',')
  echo -e "\n[!] Target: $targetip"
  echo -e "\t - IP Address: $ipAddress"
  printf $tcpPorts >/dev/null 2>&1 && echo -e "\t - Open TCP Ports: $tcpPorts"
  printf $udpPorts >/dev/null 2>&1 && echo -e "\t - Open UDP Ports: $udpPorts"
}

# Create working directories for Pentesting.
function workdir(){
	mkdir {Content,Exploits,Recon}
}

# Get rid of every container, image, network and volume used in docker.
function dockercls(){
  docker rm $(docker ps -a -q) --force 2>/dev/null
  docker rmi $(docker images -q) 2>/dev/null
  docker network rm $(docker network ls -q) 2>/dev/null
  docker volume rm $(docker volume ls -q) 2>/dev/null
}

# fzf improvement
function fzf-lovely(){

	if [ "$1" = "h" ]; then
		fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
 	                echo {} is a binary file ||
	                 (bat --style=numbers --color=always {} ||
	                  highlight -O ansi -l {} ||
	                  coderay {} ||
	                  rougify {} ||
	                  cat {}) 2> /dev/null | head -500'

	else
	        fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
	                         echo {} is a binary file ||
	                         (bat --style=numbers --color=always {} ||
	                          highlight -O ansi -l {} ||
	                          coderay {} ||
	                          rougify {} ||
	                          cat {}) 2> /dev/null | head -500'
	fi
}

# A better way to remove files/directories
function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

bindkey "^[[H" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

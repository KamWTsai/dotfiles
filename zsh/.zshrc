# 尝试启动p10k主题，加快首屏速度
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

COMPLETION_WAITING_DOTS="true"  # 补全等待时显示一些点
ENABLE_CORRECTION="false"  # 关闭命令拼写自动纠错

# 历史记录容量设置
HISTSIZE=1000000  # 内存
SAVEHIST=500000  # 硬盘
setopt EXTENDED_HISTORY  # 记录命令时间戳
setopt INC_APPEND_HISTORY  # 实时追加写入硬盘，多窗口独立
setopt HIST_IGNORE_DUPS  # 忽略连续重复的命令
setopt HIST_EXPIRE_DUPS_FIRST  # 历史满时，优先删除重复命令
setopt HIST_REDUCE_BLANKS  # 自动清理命令中多余的空格
setopt HIST_IGNORE_SPACE  # 在命令前添加空格，不将此命令添加到纪录文件中
setopt AUTO_PUSHD  # cd - 进入历史路径
setopt PUSHD_IGNORE_DUPS  # 相同的历史路径去重

# zsh插件管理器Antidote
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt
# Lazy-load antidote from its functions directory.
fpath=(${ZDOTDIR:-$HOME}/.antidote/functions $fpath)
autoload -Uz antidote
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi
autoload -Uz compinit && compinit -u
source ${zsh_plugins}.zsh

bindkey '^j' autosuggest-accept  # Ctrl + J：全额采纳
bindkey '^g' forward-word  # Ctrl + G：逐词采纳

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias l="ls -a"
alias ll="ls -alh"
alias python='python3'
alias pip='pip3'
# alias py3='source ~/env/python_env/global-da/.venv/bin/activate'
alias fp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias pon='export http_proxy=http://127.0.0.1:7897 https_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897'
alias poff='unset http_proxy https_proxy all_proxy'
alias ptest='curl -sS -o /dev/null -w "code=%{http_code}\ntime=%{time_total}s\nip=%{remote_ip}\n" https://www.google.com'

# 设置 Homebrew 镜像源为清华大学镜像，加速下载
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
# # JAVA_HOME：优先读缓存路径，缓存失效则用 java_home 重新解析并回写
# [[ -r ~/.java_home ]] && JAVA_HOME=$(<~/.java_home)
# [[ -x $JAVA_HOME/bin/java ]] || { JAVA_HOME=$(/usr/libexec/java_home -v 21) && print -r -- "$JAVA_HOME" > ~/.java_home; }
# export JAVA_HOME
# # JDK 版本持久切换
# juse() {
#   case "$1" in
#     8)  local ver="1.8" ;;
#     17) local ver="17" ;;
#     21) local ver="21" ;;
#     *)  echo "版本不存在，仅支持: 8, 17, 21"; return 1 ;;
#   esac
#   export JAVA_HOME=$(/usr/libexec/java_home -v "$ver") || return 1
#   print -r -- "$JAVA_HOME" > ~/.java_home
#   java -version
# }

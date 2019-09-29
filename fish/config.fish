setenv EDITOR "emacsclient -nw"
setenv ALTERNATE_EDITOR emacs
setenv REACT_EDITOR $EDITOR

set fish_greeting ""

# Android
if test -d $HOME/Android
  setenv ANDROID_HOME $HOME/Android/Sdk
  setenv ANDROID_SDK $ANDROID_HOME

  set PATH $PATH $ANDROID_SDK/emulator
  set PATH $PATH $ANDROID_SDK/tools
  set PATH $PATH $ANDROID_SDK/tools/bin
  set PATH $PATH $ANDROID_SDK/platform-tools
end

# Remember passphrases
# https://github.com/fish-shell/fish-shell/issues/4583#issuecomment-350540671
if status --is-interactive
  keychain --quiet --agents ssh id_rsa
end

begin
  set -l HOSTNAME (hostname)
  if test -f ~/.keychain/$HOSTNAME-fish
    source ~/.keychain/$HOSTNAME-fish
  end
end

if test -d "/usr/lib/jvm/java-1.8.0-openjdk"
  setenv JAVA_HOME "/usr/lib/jvm/java-1.8.0-openjdk"
end

if test -d $HOME/src/buck
   set PATH $PATH $HOME/src/buck/bin/
end

if test -d $HOME/bin
   set PATH $PATH $HOME/bin
end

# Ruby
setenv RUBY_CONFIGURE_OPTS "--with-readline-dir=/usr/lib"

# Postgres
setenv POSTGRES_USER $USER

# asdf versioning
if test -d $HOME/.asdf
  source "$HOME/.asdf/asdf.fish"
end

# Yarn bin
if test -d $HOME/.config/yarn/global/node_modules
  set PATH $PATH "$HOME/.config/yarn/global/node_modules/.bin/"
end

alias be="bundle exec"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias git_contributors="git log --all --format='%aN' | sort -u"

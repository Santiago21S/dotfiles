eval "$(starship init zsh)"
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Ruta donde se guardará el archivo con tus comandos
HISTFILE=~/.zsh_history

# Cuántos comandos se guardan en la memoria de la sesión actual
HISTSIZE=10000

# Cuántos comandos se guardan como máximo en el archivo del disco
SAVEHIST=10000

# No guardar comandos duplicados seguidos en el historial
setopt HIST_IGNORE_DUPS

# Eliminar espacios en blanco sobrantes antes de guardar
setopt HIST_REDUCE_BLANKS

# Guardar los comandos en el archivo inmediatamente después de ejecutarlos
# (Así, si abres otra pestaña de Kitty, compartirá el historial al instante)
setopt SHARE_HISTORY


# Added by Antigravity CLI installer
export PATH="/home/santiago/.local/bin:$PATH"
export PATH="/home/santiago/.local/bin:$PATH"
export PATH="/home/santiago/.local/bin:$PATH"

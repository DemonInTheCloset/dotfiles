# Prompt Setup
prompt_ditc_setup() {
    # Left Prompt
    #             user        @ hostname                  ❯    (# if root)
    PS1='%F{green}%n%f%F{blue}@%f%F{magenta}%m%f %B%F{white}%*%f%b%F{yellow}❯%f%(!,#, )'

    # Right Prompt
    #               ❮  program exit code   YYYY-mm-dd       current directory
    RPS1='%F{yellow}❮%(1V, ,)%f%(?,,%F{red}[%?]%f)%F{cyan}%D{%F}%f %F{blue}%(4.,%-1~/../%1~,%~)%f'
}

# Add as a theme
prompt_themes+=(ditc)

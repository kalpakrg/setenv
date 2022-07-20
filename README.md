# setenv
Oh my zsh plugin to run script on change directory. 

This plugins sources the `.setenv` file if it exists in the current directory and if it is executable. 

## Motivation
While working on number of different Java projects which were using different version of Java, I had to constantly change `JAVA_HOME` when switching projects. To automate this process, I wrote this plugin which did the required setup when I enter a specific project directory.

## Whitelist
The plugin maintains a whitelist of directories for which it does not ask before executing the `.setnev` script. The whitelist is maintained to ensure that you do not end up accidentally executing the `.setenv` file in a directory shared by someone else. 
 - To add the current directory to whitelist, you can run `setenv_whitelist` 
 - To remove the current directory from whitelist you can run `setenv_whitelist_remove`

## Installation
-   Ensure you have [Oh My ZSH](https://github.com/robbyrussell/oh-my-zsh) installed. 
-   Clone this repository in **$ZSH_CUSTOM/plugins/** directory.
-   Enable **setenv** plugin in **$HOME/.zshrc**

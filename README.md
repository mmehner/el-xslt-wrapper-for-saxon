# el-xslt-wrapper-for-saxon
emacs lisp wrapper for saxon XSLT processors

## Dependencies
- Java
- Saxon XSLT processor
- (optional) TeX Live

## Provided Functions
This package currently provides the following interactive function
- **xslt-process-buffer-file** :
- **xslt-process-buffer-file-tex-compile** : 

## Installation
1. Add `xslt-wrapper-for-saxon.el` to a directory included in the list `load-path` or modify this list to include the directory with
   `(add-to-list 'load-path "/PATH/TO/el-xslt-wrapper-for-saxon/")` in your init file,
2. add `(require 'el-xslt-wrapper-for-saxon)` to your init-file,
3. set the global variable `xslt-wrap-saxonpath` with `(setq xslt-wrap-saxonpath "/PATH/TO/saxonXhe.jar")`,
4. (optional) set the global variable `xslt-wrap-texcommand` for instance with `(setq xslt-wrap-texcommand "latexmk -pdflatex")`, the default is pdflatex.

## Usage
1. Evaluate one the above functions with `M-x xslt-process-buffer` or `M-x xslt-process-buffer-tex-compile`,
3. (optional) if you are frequently using one of these functions, consider [creating a keybinding](https://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Binding-Commands.html).

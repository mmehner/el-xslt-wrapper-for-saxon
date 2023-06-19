# el-xslt-wrapper-for-saxon
emacs lisp wrapper for saxon XSLT processors

## Dependencies
- Java
- Saxon XSLT processor
- (optional) TeX Live

## Provided Functions
This package currently provides the following interactive function
- **xslt-process-buffer-file** : apply stylesheet and find buffer in another window
- **xslt-process-buffer-file-tex-compile** : apply stylesheet, compile resulting LaTeX-file and show that in PDF viewer 

## Installation
1. Add `xslt-wrapper-for-saxon.el` to a directory included in the list `load-path` or modify this list to include the directory with
   `(add-to-list 'load-path "/PATH/TO/el-xslt-wrapper-for-saxon/")` in your init file,
2. add `(require 'xslt-wrapper-for-saxon)` to your init-file,
3. set the global variable `xslt-wrapper-saxonpath` with `(setq xslt-wrapper-saxonpath "/PATH/TO/saxonXhe.jar")`,
4. (optional) set the global variable `xslt-wrapper-texcommand` for instance with `(setq xslt-wrapper-texcommand "latexmk -pdflatex")`, the default is pdflatex,
5. (optional) set the global variable `xslt-wrapper-pdfviewer` for instance with `(setq xslt-wrapper-pdfviewer "mupdf")`, if unset defaulting to Emacs DocView mode.

## Usage
1. Evaluate one the above functions with `M-x xslt-process-buffer` or `M-x xslt-process-buffer-tex-compile`,
3. (optional) if you are frequently using one of these functions, consider [creating a keybinding](https://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Binding-Commands.html).

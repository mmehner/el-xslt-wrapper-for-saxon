(provide 'el-xslt-wrapper-for-saxon)

(defvar xslt-wrap-saxonpath ""
  "The path of the saxon xslt-processor jar-file for xslt-wrapper")

(defvar xslt-wrap-texcommand "pdflatex"
  "LaTeX compile command for xslt-wrapper, defaults to pdflatex")

(defun  xslt-process-buffer-file ( &optional proc xsl ext)
  (interactive)
  (unless proc (setq proc xslt-wrap-saxonpath))
  (unless xsl (setq xsl (xslt-get-encoded-stylesheet)))
  (unless xsl (setq xsl (read-string "Path of XSL stylesheet: ")))
  
  (unless ext  (setq ext (read-string "Extension of transformation target: ")))
  
  (xslt-check-files proc)
  
  (let ((outfile (concat (substring (buffer-file-name) 0 -3) ext)))
    (shell-command (concat "java -jar " proc " -s:" (buffer-file-name) " -xsl:" xsl  " -o:" outfile ) "*xslt-out*" "*xslt-err*")
    
    (find-file-other-window outfile)
    (revert-buffer outfile)
    )
  )

(defun  xslt-process-buffer-file-tex-compile ( &optional proc xsl comp )
  (interactive)
  (unless proc (setq proc xslt-wrap-saxonpath))
  (unless xsl (setq xsl (xslt-get-encoded-stylesheet)))
  (unless xsl (setq xsl (read-string "Path of XSL stylesheet: ")))
  
  (unless comp (setq comp xslt-wrap-texcommand))

  (xslt-check-files proc)

  (let ((outfile (concat (substring (buffer-file-name) 0 -3) "tex"))
	(pdffile (concat (substring (buffer-file-name) 0 -3) "pdf")))
    (shell-command (concat "java -jar " proc " -s:" (buffer-file-name) " -xsl:" xsl " -o:" outfile ) "*xslt-out*" "*xslt-err*")
    (shell-command (concat comp " " outfile) "*latex-out*" "*latex-err*")
    
    (find-file-other-window pdffile)
    (revert-buffer pdffile)
    )
  )
  
(defun xslt-check-files ( proc )
  (unless (file-exists-p (buffer-file-name)) (error "buffer file does not exist"))
  (unless (file-exists-p proc) (error "processor not found, please set xslt-wrap-saxonpath correctly."))
  )

(defun xslt-get-encoded-stylesheet ()
  (save-excursion
    (goto-char (point-min))
    (save-match-data
      (re-search-forward "<\\?xml-stylesheet .* href=\"\\(.+\\)\"" nil t)
      (match-string-no-properties 1)
      )
    )
  )

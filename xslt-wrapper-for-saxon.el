(provide 'xslt-wrapper-for-saxon)

(defvar xslt-wrapper-saxonpath ""
  "The path of the saxon xslt-processor jar-file for xslt-wrapper")

(defvar xslt-wrapper-texcommand "pdflatex"
  "LaTeX compile command for xslt-wrapper, defaults to pdflatex")

(defvar xslt-wrapper-pdfviewer ""
  "pdfviewer-command, if unset default to emacs")

(defun  xslt-process-buffer-file ( &optional proc xsl ext)
  (interactive)
  (unless ext  (setq ext (read-string "Extension of transformation target: ")))
  
  (let ((outfile (concat (substring (buffer-file-name) 0 -3) ext)))
    (xslt-process proc xsl (buffer-file-name) outfile)

    (find-file-other-window outfile)
    (revert-buffer outfile)
    )
  )

(defun  xslt-process-buffer-file-tex-compile ( &optional proc xsl comp )
  (interactive)
  (unless comp (setq comp xslt-wrapper-texcommand))
  (unless comp (setq comp (read-string "LaTeX compile command: ")))

  (let ((outfile (concat (substring (buffer-file-name) 0 -3) "tex"))
	(pdffile (concat (substring (buffer-file-name) 0 -3) "pdf")))

    (xslt-process proc xsl (buffer-file-name) outfile)
    
    (shell-command (concat comp " " outfile) "*latex-out*" "*latex-out*")

    (if (not (eq xslt-wrapper-pdfviewer ""))
	(shell-command (concat xslt-wrapper-pdfviewer " " pdffile))
      (find-file-other-window pdffile)
      (revert-buffer pdffile))
    )
  )

(defun xslt-process (proc xsl basexml outfile)
  (unless proc (setq proc xslt-wrapper-saxonpath))
  (unless xsl (setq xsl (xslt-get-encoded-stylesheet)))
  (unless xsl (setq xsl (read-string "Path of XSL stylesheet: ")))

  (xslt-check-files basexml proc)
  
  (shell-command (concat "java -jar " proc " -s:" basexml " -xsl:" xsl  " -o:" outfile ) "*xslt-out*" "*xslt-out*")
  )

(defun xslt-check-files ( basexml proc )
  (unless (file-exists-p basexml) (error "buffer file does not exist"))
  (unless (file-exists-p proc) (error "processor not found, please set xslt-wrapper-saxonpath correctly."))
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

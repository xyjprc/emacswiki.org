;;; mon-url-utils.el --- interactive utils for URL data lookups
;; -*- mode: EMACS-LISP; -*-

;;; ================================================================
;; Copyright © 2009, 2010 MON KEY. All rights reserved.
;;; ================================================================

;; FILENAME: mon-url-utils.el
;; AUTHOR: MON KEY
;; MAINTAINER: MON KEY
;; CREATED: 2009-06-16T08:39:52-04:00Z
;; VERSION: 1.0.0
;; COMPATIBILITY: Emacs23.*
;; KEYWORDS: hypermedia, processes, convenience

;;; ================================================================

;;; COMMENTARY: 

;; =================================================================
;; DESCRIPTION:
;; Provides interactive utilities for URL data lookups and in-buffer
;; modification of web/internet scrapes.
;;
;; FUNCTIONS:►►►
;; `mon-htmlfontify-buffer-to-firefox',`mon-htmlfontify-region-to-firefox'
;; `mon-htmlfontify-dir-purge-on-quit',
;; `mon-hexcolor-add-to-font-lock', `mon-search-ulan',
;; `mon-search-ulan-for-name', `mon-search-wikipedia', `mon-search-loc',
;; `mon-search-bnf', `mon-insert-dbc-link', `mon-insert-dbc-doc-link',
;; `mon-wrap-all-urls', `mon-wrap-one-url', `mon-wrap-url',`mon-wrap-span',
;; `mon-make-html-table-string' `mon-make-html-table',`mon-tld-find-tld',
;; `mon-tld-find-name', `mon-tld', `mon-get-w3m-url-at-point-maybe',
;; `mon-get-w3m-url-at-point' `mon-w3m-read-gnu-lists-nxt-prv',
;; `mon-url-encode', `mon-url-decode' `mon-get-host-address',
;; `mon-url-retrieve-to-new-buffer', `mon-its-all-text-purge-on-quit',
;; `mon-html-fontify-generate-file-name'
;; FUNCTIONS:◄◄◄
;;
;; MACROS:
;;
;; METHODS:
;;
;; CLASSES:
;;
;; CONSTANTS:
;; `*mon-tld-list*'
;;
;; VARIABLES:
;; `*hexcolor-keywords*',
;; 
;; ALIASES:
;; `mon-search-wiki'                    -> `mon-search-wikipedia'
;; `mon-url-escape'                     -> `mon-url-encode'
;; `mon-url-unescape'                   -> `mon-url-decode'
;; `mon-w3m-get-url-at-point-maybe'     -> `mon-get-w3m-url-at-point-maybe'
;; `mon-w3m-get-url-at-point'           -> `mon-get-w3m-url-at-point'
;; `mon-get-w3m-read-gnu-lists-nxt-prv' -> `mon-w3m-read-gnu-lists-nxt-prv'
;; `w3m-print-this-url'                 -> `w3m-copy-this-url-as-kill'   
;; `w3m-print-current-url'              -> `w3m-copy-current-url-as-kill'
;;
;; SUBST:
;; `mon-tld-tld', `mon-tld-name' 
;;
;; RENAMED: 
;; `*hexcolor-keywords*'       -> `*regexp-hexcolor-keywords*'
;; `hexcolor-add-to-font-lock' -> `mon-hexcolor-add-to-font-lock'
;;
;; RENAMED: Dave Pearson's tld-* 
;; :SEE (URL `http://www.davep.org/emacs/tld.el')
;; `tld'           -> `mon-tld'
;; `tld-find-name' -> `mon-tld-find-name'
;;                 -> `mon-tld-find-tld'
;; `tld-name'      -> `mon-tld-name'
;; `tld-tld'       -> `mon-tld-tld'
;; `tld-list'      -> `*mon-tld-list*'
;; `tld-list'      -> `*mon-tld-list*'
;;
;; MOVED: 
;; `mon-get-image-dimensions'    -> mon-rename-image-utils.el
;; `mon-get-image-dimensions-im' -> mon-rename-image-utils.el
;; `mon-get-image-md5'           -> mon-rename-image-utils.el
;; `mon-w3m-dired-file'          <- mon-dir-utils.el
;; `mon-w3m-kill-url-at-point'   <- mon-dir-utils.el
;;
;; REQUIRES:
;; `mon-htmlfontify-buffer-to-firefox', `mon-htmlfontify-region-to-firefox'  
;;  | mon-dir-locals-alist.el           <-`*mon-ebay-images-temp-path*'
;; `mon-htmlfontify-buffer-to-firefox'  -> html-fontify.el
;; `mon-htmlfontify-region-to-firefox'  -> html-fontify.el
;; `mon-get-w3m-url-at-point-maybe'     -> w3m
;; `mon-get-w3m-url-at-point'           -> w3m
;; `mon-w3m-read-gnu-lists-nxt-prv'     -> w3m
;; `mon-url-retrieve-to-new-buffer'     -> lisp/url/url.el
;; `mon-url-encode'                     -> lisp/url/url-util.el
;; `mon-url-decode'                     -> lisp/url/url-util.el
;; `mon-tld-*-'                         -> cl
;; 
;;
;; TODO:
;; Adjust `mon-search-ulan', `mon-search-ulan-for-name' to retrieve url (a)synchronously. 
;;
;; NOTES:
;;
;; URL: `http://www.emacswiki.org/emacs/mon-url-utils.el'
;; FIRST-PUBLISHED: <Timestamp: #{2009-09-20}#{} - by MON>
;; 
;; FILE-CREATED:
;; <Timestamp: #{2009-06-16T08:39:52-04:00Z} - by MON KEY>
;;
;; =================================================================

;;; LICENSE:

;; =================================================================
;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;; =================================================================
;; Permission is granted to copy, distribute and/or modify this
;; document under the terms of the GNU Free Documentation License,
;; Version 1.3 or any later version published by the Free Software
;; Foundation; with no Invariant Sections, no Front-Cover Texts,
;; and no Back-Cover Texts. A copy of the license is included in
;; the section entitled ``GNU Free Documentation License''.
;; 
;; A copy of the license is also available from the Free Software
;; Foundation Web site at:
;; (URL `http://www.gnu.org/licenses/fdl-1.3.txt').
;;; ==============================
;; Copyright © 2009, 2010 MON KEY 
;;; ==============================

;;; CODE:

;;; ==============================
;; To use all features of this package you may need to bind `IS-MON-SYSTEM-P' to
;; a non-nil value if it isn't already. This lets Emacs know that you have
;; configured the neccesary system types, user names, conditionals, paths,
;; etc. required to use all features defined below.
;; :SEE 
;;  This file should
;; byte-compile with `IS-MON-SYSTEM-P' null but not all features will be
;; evaluated. To bind `IS-MON-SYSTEM-P' non-nil uncomment the line below:
;;
;;  (unless (bound-and-true-p IS-MON-SYSTEM-P) (setq IS-MON-SYSTEM-P t))
;;
;;; ==============================

;; :REQUIRED-BY in `mon-tld-xxx' functions.
(eval-when-compile (require 'cl))

;; :REQUIRED-BY `mon-htmlfontify-buffer-to-firefox'
;; :REQUIRED-BY `mon-htmlfontify-region-to-firefox'
;; :WAS (when (locate-library "htmlfontify") (require 'htmlfontify))
(require 'htmlfontify nil t)

;; :REQUIRED-BY `mon-get-w3m-url-at-point-maybe'
;; :REQUIRED-BY `mon-w3m-read-gnu-lists-nxt-prv'
;; :REQUIRED-BY `mon-get-w3m-url-at-point'
;; :WAS (when (locate-library "w3m") (require 'w3m))
(require 'w3m nil t)

;; :REQUIRED-BY `mon-url-retrieve-to-new-buffer'
(require 'url)
;; :REQUIRED-BY `mon-url-encode'
;; :REQUIRED-BY `mon-url-decode' 
(require 'url-util)


(declare-function 'w3m-view-this-url "ext:w3m.el" t t)
(declare-function 'w3m-find-file   "ext:w3m.el" t t )
(declare-function 'mon-get-w3m-url-at-point-maybe "mon-url-utils")

;;; ==============================
;;; :CREATED <Timestamp: #{2010-03-27T16:36:32-04:00Z}#{10126} - by MON KEY>
(defun mon-its-all-text-purge-on-quit ()
  "Remove .txt files in the current user's Mozilla profile itsalltext directory.\n
On w32 these may get left behind when remoting field text from Firefox using the
itsalltext add-on extension.\n
This procedure invokes `file-expand-wildcards' with the following pattern:
 \"/Mozilla/Firefox/Profiles/*.default/itsalltext/*.txt*\"
:NOTE You _should_ set/verify the path value associated with the key 
the-itsalltext-temp-dir in the variable `*mon-misc-path-alist*'.\n
The intent of this procedure that it be run as a hook on `kill-emacs-hook'.\n
When `IS-MON-SYSTEM-P', this function is evaluated with:
`mon-purge-emacs-temp-files-on-quit' on the `kill-emacs-hook'.\n
:SEE (URL `https://addons.mozilla.org/en-US/firefox/addon/4125')\n
:SEE (URL `http://trac.gerf.org/itsalltext')\n
:SEE-ALSO `mon-htmlfontify-dir-purge-on-quit', `mon-purge-doc-view-cache-directory',
`mon-purge-thumbs-directory', `mon-purge-temporary-file-directory',
`*mon-purge-emacs-temp-file-dir-fncns*'.\n►►►"
  (when (or (and (intern-soft "IS-MON-SYSTEM-P") IS-MON-SYSTEM-P)
            (and (intern-soft "IS-W32-P")  IS-W32-P))
    (let ((chk-i-a-t (cadr (assoc 'the-itsalltext-temp-dir *mon-misc-path-alist*))))
      (when (and chk-i-a-t (file-exists-p chk-i-a-t))
        (dolist (i-a-t (file-expand-wildcards (concat chk-i-a-t "/*.txt*") t))
          (unless (car (file-attributes i-a-t)) ;; Its a directory!
            (delete-file i-a-t)))))))
;;
;;; (add-hook 'kill-emacs-hook 'mon-its-all-text-purge-on-quit)
;;; (remove-hook 'kill-emacs-hook 'mon-its-all-text-purge-on-quit)

;;; ==============================
;; :HTML-FONTIFY
;; :NOTE Variables `*emacs2html-temp*', `*mon-html-fontify-file-name-template*'
;;       are bound in :FILE mon-dir-locals-alist.el
;;; ==============================

(when (featurep 'htmlfontify)
;;; ==============================
;;; :CREATED <Timestamp: #{2010-04-02T12:30:11-04:00Z}#{10135} - by MON KEY>
(defun mon-html-fontify-generate-file-name ()
  "Generate a temporary file-name for `mon-htmlfontify-*' procedures.\n
:EXAMPLE\n\n(mon-html-fontify-generate-file-name)\n
:SEE-ALSO `mon-htmlfontify-region-to-firefox', `*emacs2html-temp*',
`mon-htmlfontify-dir-purge-on-quit', `*mon-html-fontify-file-name-template*'.\n►►►"
  (let ((mhfgfn #'(lambda ()
                    (format *mon-html-fontify-file-name-template* 
                            *emacs2html-temp* (random t))))
        mhfgfn-myb-regen)
    (setq mhfgfn-myb-regen (funcall mhfgfn))
    (while (file-exists-p mhfgfn-myb-regen)
      (setq mhfgfn-myb-regen (funcall mhfgfn)))
    mhfgfn-myb-regen))
;;
;;; :TEST-ME (mon-html-fontify-generate-file-name)

;;; ==============================
;;; :CREATED <Timestamp: #{2010-03-23T21:05:10-04:00Z}#{10123} - by MON KEY>
(defun mon-htmlfontify-dir-purge-on-quit ()
  "Delete files in `*emacs2html-temp*' matching \"emacs2firefox-.*\.html\".\n
These are temp files generated with `mon-htmlfontify-buffer-to-firefox' and
`mon-htmlfontify-region-to-firefox'.\n
This procedure is meant to be run as a hook on `kill-emacs-hook'.\n
:NOTE When `IS-MON-SYSTEM-P', this function is evaluated with
`mon-purge-emacs-temp-files-on-quit' on the `kill-emacs-hook'.\n
:EXAMPLE\n\(directory-files *emacs2html-temp* t \"emacs2firefox-.*\.html\")\n
\n\(mon-htmlfontify-dir-purge-on-quit\)\n
:SEE-ALSO `mon-its-all-text-purge-on-quit', `mon-purge-doc-view-cache-directory',
`mon-purge-thumbs-directory', `mon-purge-temporary-file-directory'.\n►►►"
  (interactive)
  (when (and (and (intern-soft "IS-MON-SYSTEM-P") 
                  (bound-and-true-p IS-MON-SYSTEM-P))
             (not (null *emacs2html-temp*))
             (file-exists-p *emacs2html-temp*)
             (file-directory-p *emacs2html-temp*))
    (let ((cln-emacs2html-temp 
           (directory-files *emacs2html-temp* t "emacs2firefox-.*\.html~?")))
      (dolist (prg cln-emacs2html-temp)
        (unless (car (file-attributes prg)) ;; Its a directory!
          (delete-file prg))))))
;;
;;; :TEST-ME (mon-htmlfontify-dir-purge-on-quit)

;;; ==============================
;;; :COURTESY Thierry Volpiatto  :HIS tv-utils.el :WAS `tv-htmlfontify-buffer-to-firefox'
;;; :NOTE :REQUIRES :FILE `htmlfontify.el'
;;; :MODIFICATIONS <Timestamp: #{2010-03-23T20:37:55-04:00Z}#{10123} - by MON KEY>
;;; :CREATED <Timestamp: Tuesday June 16, 2009 @ 08:28.49 PM - by MON>
(defun mon-htmlfontify-buffer-to-firefox ()
  "Convert fontified buffer to an HTML file display it with Firefox.\n
:SEE `hfy-tags-cache', `hfy-load-tags-cache', `hfy-etags-cmd', `hfy-parse-tags-buffer'
:SEE-ALSO `mon-htmlfontify-region-to-firefox', `*emacs2html-temp*',
`mon-html-fontify-generate-file-name', `*mon-html-fontify-file-name-template*',
`mon-htmlfontify-dir-purge-on-quit'.\n►►►"
  (interactive)
  (let* ((ffox-fname (mon-html-fontify-generate-file-name))
         (this-bfr-file (buffer-file-name))
         (this-bfr-dir 
          (when this-bfr-file 
            (directory-file-name (file-name-directory this-bfr-file))))
         (this-bfr-has-TAGS 
          (when this-bfr-dir 
            (car (member "TAGS"  (directory-files  this-bfr-dir)))))
         h-fnty-bfr)
    (with-current-buffer 
        (get-buffer    
         (if this-bfr-has-TAGS 
             (setq h-fnty-bfr (htmlfontify-buffer this-bfr-dir this-bfr-file))
           (setq h-fnty-bfr (htmlfontify-buffer))))
      (set (make-local-variable 'delete-auto-save-files) t)
      (set (make-local-variable 'backup-inhibited) t)
      (setq h-fnty-bfr (current-buffer))
      (write-file ffox-fname))
    (when (get-buffer h-fnty-bfr) 
      (kill-buffer h-fnty-bfr))
    (browse-url-firefox (format "file:///%s" ffox-fname))))
;;
;;; ==============================
;;; :COURTESY Thierry Volpiatto :HIS tv-utils.el :WAS `tv-htmlfontify-region-to-firefox'
;;; :NOTE :REQUIRES :FILE `htmlfontify.el'
;;; :MODIFICATIONS <Timestamp: #{2010-03-23T20:38:06-04:00Z}#{10123} - by MON KEY>
;;; :CREATED <Timestamp: Tuesday June 16, 2009 @ 08:28.49 PM - by MON>
(defun mon-htmlfontify-region-to-firefox (fontify-from fontify-to)
  "Convert fontified region to an html file and display it with Firefox.\n
:SEE-ALSO `mon-htmlfontify-region-to-firefox', 
`mon-htmlfontify-dir-purge-on-quit', `mon-html-fontify-generate-file-name',
`*mon-html-fontify-file-name-template*', `*emacs2html-temp*'.\n►►►"
  (interactive "r")
  (let ((ffox-rg-fname (mon-html-fontify-generate-file-name))
        mhr2f-fontify-this
        h-fnty-bfr)
    (setq mhr2f-fontify-this 
          (buffer-substring fontify-from fontify-to))
    (unwind-protect
         (with-current-buffer (get-buffer-create ffox-rg-fname)
           (set (make-local-variable 'delete-auto-save-files) t)
           (set (make-local-variable 'backup-inhibited) t)
           (insert mhr2f-fontify-this)
           (emacs-lisp-mode)
           ;; (font-lock-fontify-syntactically-region  (buffer-end 0) (buffer-end 1))
           ;;  (font-lock-fontify-buffer)
           (setq h-fnty-bfr
                 (htmlfontify-buffer))
           (write-file ffox-rg-fname)
           (kill-buffer (get-buffer ffox-rg-fname)))
      (when (get-buffer h-fnty-bfr)
        (kill-buffer (get-buffer h-fnty-bfr))))
    (browse-url-firefox (format "file:///%s" ffox-rg-fname))))
) ;; :CLOSE htmlfontify

;;; ==============================
;;; :RENAMED `*hexcolor-keywords*' -> `*regexp-hexcolor-keywords*'
;;; :COURTESY Xah Lee
;;; :SEE (URL `http://xahlee.org/emacs/emacs_html.html')
(defvar *regexp-hexcolor-keywords* 'nil
  "*Keywords for fontification of hex code color values \(e.g. CSS\).\n
:SEE-ALSO `mon-hexcolor-add-to-font-lock', `*regexp-rgb-hex*'.\n►►►")
(when (not (bound-and-true-p *regexp-hexcolor-keywords*))
  (setq *regexp-hexcolor-keywords*
        '(("#[abcdefABCDEF[:digit:]]\\{6\\}"
           (0 (put-text-property
               (match-beginning 0)
               (match-end 0)
               'face (list :background 
                           (match-string-no-properties 0)))))))) 
;;
;;; (progn (makunbound '*regexp-hexcolor-keywords*)
;;;        (unintern '*regexp-hexcolor-keywords*) )

;;; ==============================
;;; :RENAMED `hexcolor-add-to-font-lock' -> `mon-hexcolor-add-to-font-lock'
;;; :NOTE `naf-mode' is `derived-mode-p' -> t
;;; To add them for derived modes we have to pass nil for
;;; `font-lock-add-keywords' MODE arg and add the call to `naf-mode-hook'.
;;; :NOTE We call this from `naf-mode' with: 
;;;       (add-hook 'naf-mode-hook 'mon-hexcolor-add-to-font-lock)
(defun mon-hexcolor-add-to-font-lock ()
  "Add font-lock keywords for hex code color values for fontification.\n
:SEE-ALSO `*regexp-hexcolor-keywords*', `*regexp-rgb-hex*'.\n►►►"
  (font-lock-add-keywords nil *regexp-hexcolor-keywords*))

;;; ==============================
;;; :COURTESY Alex Schroeder :HIS ConfigConfusibombus :WAS `url-decode'
;;; :SEE (URL `http://www.emacswiki.org/emacs-en/AlexSchroederConfigConfusibombus')
;;; :CHANGESET 1756 <Timestamp: #{2010-05-21T12:22:16-04:00Z}#{10205} - by MON KEY>
;;; :CREATED <Timestamp: #{2009-11-27T17:08:03-05:00Z}#{09485} - by MON KEY>
(defun mon-url-encode (url-enc-str &optional insrtp intrp)
  "Return the encoded url string URL-ENC-STR.\n
When optional arg INSRTP is non-nil or called-interactively insert return value
at point. Moves point.\n
:EXAMPLE\n\n\(mon-url-encode 
 \"www.encode-me.com/ cash$<change[@+make:some|steal&&lie]\"\)\n
:ALIASED-BY `mon-url-escape'\n
:SEE-ALSO `mon-url-decode'.\n►►►"
  (interactive "sURL-encode :\ni\p")
  (let ((mud-encd (url-hexify-string url-enc-str)))
    (if (or intrp insrtp)
        (insert (format " %s " mud-encd))
      mud-encd)))
;;
;;; :TEST-ME (mon-url-encode "www.encode-me.com/ cash$<change[@+make:some|steal&&lie]")
;;; 
(defalias 'mon-url-escape 'mon-url-encode)

;;; ==============================
;;; :COURTESY Alex Schroeder :HIS ConfigConfusibombus :WAS `url-decode'
;;; :SEE (URL `http://www.emacswiki.org/emacs-en/AlexSchroederConfigConfusibombus')
;;; :CHANGESET 1756 <Timestamp: #{2010-05-21T12:15:42-04:00Z}#{10205} - by MON KEY>
;;; :CREATED <Timestamp: #{2009-11-27T17:08:21-05:00Z}#{09485} - by MON KEY>
(defun mon-url-decode (url-dec-str &optional insrtp intrp)
  "Return the decoded url string URL-DEC-STR.\n
When optional arg insrtp is non-nil or called-interactively insert return value
at point. Moves point.\n
:EXAMPLE\n\n\(mon-url-decode 
 \"www.encode-me.com%2f%20cash%24%3cchange%5b%40%2bmake%3asome%7csteal%26%26lie%5d\"\)\n
\(mon-url-decode
 \(mon-url-encode \"www.encode-me.com/ cash$<change[@+make:some|steal&&lie]\"\)\)\n
:ALIASED-BY `mon-url-unescape'\n
:SEE-ALSO `mon-url-encode'.\n►►►"
  (interactive "sURL-decode :\ni\p")
  (let ((mud-decd
         (decode-coding-string
          (url-unhex-string url-dec-str)
          'utf-8)))
    (if (or insrtp intrp)
        (insert (format " %s " mud-decd))
      mud-decd)))
;;
(defalias 'mon-url-unescape 'mon-url-decode)
;;
;;; :TEST-ME (mon-url-decode 
;;;              "www.encode-me.com%2f%20cash%24%3cchange%5b%40%2bmake%3asome%7csteal%26%26lie%5d")
;;; :TEST-ME (mon-url-decode
;;;              (mon-url-encode "www.encode-me.com/ cash$<change[@+make:some|steal&&lie]"))

;;; ==============================
;;; :NOTE Maybe better to use firefox for ULAN - conkeror doesn't scroll well :(
;;;       Or, better even, just retrieve url synchronously. 
;;; :CHANGESET 1759 <Timestamp: #{2010-05-21T14:12:08-04:00Z}#{10205} - by MON KEY>
;;; :CREATED <Timestamp: Friday February 13, 2009 @ 07:01.59 PM - by MON>
(defun mon-search-ulan (&optional w-ulan-query)
  "Open ULAN in web browser.\n
When W-ULAN-QUERY is non-nil search the ULAN artist name.\n
When the region is active search ULAN for name between point and mark. Attempts to rotate
the nameform intelligently to catch one of three different configurations:\n
A\) Lastname \(Firstname\) 
B\) Lastname, Firstname 
C\) Firstname Lastname\n
A, B, and C  are each transformed to ==> Lastname%2C+Fristname and then wrapped 
for ULAN query to \(URL `http://www.getty.edu/vow/ULANFullDisplay?find='\).\n When region
is not active and W-ULAN-QUERY is ommitted or null open a blank ULAN query in browser at:\n
\(URL `http://www.getty.edu/research/conducting_research/vocabularies/ulan/'\)\n
:EXAMPLE\n\n\(mon-search-ulan\)\n
\(mon-search-ulan \"Pyle, Howard\"\)\n
\(mon-search-ulan t\)\n
:NOTE for an interactive version which automatically defaults to a prompt for
ULAN name to search use: `mon-search-ulan-for-name'.\n
:SEE-ALSO `mon-search-wikipedia', `mon-search-loc', `mon-search-bnf'.\nUsed in `naf-mode'.\n►►►"
  (interactive "p")
  (let* ((use-empty-active-region nil)
         (msu-uqp (cond 
                   ((and w-ulan-query (not (use-region-p)) (stringp w-ulan-query))
                    (concat "http://www.getty.edu/vow/ULANServlet?english=Y&find="       
                            (replace-regexp-in-string 
                             ", " "%2C+"
                             (read-string "Artist Name to Query \"Lastname, Firstname\"?: ") t)
                            "&role=&page=1&nation="))
                   ((stringp w-ulan-query)
                    (concat "http://www.getty.edu/vow/ULANServlet?english=Y&find="       
                            (replace-regexp-in-string ", " "%2C+" w-ulan-query t)
                            "&role=&page=1&nation="))
                   ((and w-ulan-query (use-region-p) (not (stringp w-ulan-query))) t)
                   ((and w-ulan-query (not (use-region-p)))
                    (error (concat ":FUNCTION `mon-search-ulan' "
                                   " -- arg W-ULAN-QUERY not a string and no active-region")))))
	 (msu-rgn-url (when (and (use-region-p) (not (stringp msu-uqp)))
		       (buffer-substring-no-properties (region-beginning) (region-end))))
	 (msu-tst-rgn (when msu-rgn-url
                        (save-match-data
                          (cond  ((string-match 
                                   "\\(\\([A-Z][a-z]+\\)\\([[:blank:]](\\)\\([A-Z][a-z]+\\)\\()\\)\\)" msu-rgn-url) 
                                  (concat (match-string 2 msu-rgn-url) "%2C+"  (match-string 4 msu-rgn-url)))
                           ((string-match 
                             "\\(\\([A-Z][a-z]+\\)\\(,[[:blank:]]\\)\\([A-Z][a-z]+\\)\\)" msu-rgn-url)
                            (concat (match-string 2 msu-rgn-url) "%2C+" (match-string 4 msu-rgn-url)))
                           ((string-match 
                             "\\(\\([A-Z][a-z]+\\)\\([[:blank:]]\\)\\([A-Z][a-z]+\\)\\)" msu-rgn-url)
                            (concat (match-string 4 msu-rgn-url) "%2C+" (match-string 2 msu-rgn-url)))))))
	 (msu-bld-url (when msu-tst-rgn
		      (concat "http://www.getty.edu/vow/ULANServlet?english=Y&find="
                              msu-tst-rgn "&role=&page=1&nation=")))
	 (msu-ulan-url (cond (msu-bld-url msu-bld-url)
                         (msu-uqp msu-uqp)
                         ((and (not msu-bld-url) (not msu-uqp))
                          "http://www.getty.edu/research/conducting_research/vocabularies/ulan/"))))
    ;; (browse-url msu-ulan-url)))  :NOTE See above w/re conkeror/generic browswer
    (browse-url-firefox msu-ulan-url)))
;;
;;; :TEST-ME (mon-search-ulan "Pyle, Howard")
;;; :TEST-ME (mon-search-ulan t)
;;; :TEST-ME W/ region point and mark on following names interactively call `mon-search-ulan':
;;,----
;;| Pyle (Howard)
;;| Pyle, Howard
;;| Howard Pyle
;;`----

;;; ==============================
(defun mon-search-ulan-for-name ()
  "Interactive version of `mon-search-ulan'.
Default behavior is to prompt for name to search.\n
:SEE-ALSO `mon-search-wikipedia'.\nUsed in `naf-mode'.\n►►►"
  (interactive)
  (mon-search-ulan t))

;;; ==============================
;;; :CHANGESET 1760 <Timestamp: #{2010-05-21T14:27:09-04:00Z}#{10205} - by MON KEY>
(defun mon-search-wikipedia (&optional wiki-word)
  "Look up word or phrase on Wikipedia.\n
Generate a url from with the a word or phrase in the active region
opens it in a browser.\n
When optional arg WIKI-WORD is non-nil use it instead.
:EXAMPLE\n\n(mon-search-wikipedia \"monkey meat\")\n
:SEE-ALSO `mon-search-ulan', `mon-search-ulan-for-name',
`mon-search-loc', `mon-search-bnf'.\n\nUsed in `naf-mode'.►►►"
  (interactive "sSearch wiki for :")
  (let ((msw-word wiki-word))
    (when (null msw-word)
      (setq msw-word
            (if (use-region-p) ;; (and transient-mark-mode mark-active)
                (buffer-substring-no-properties (region-beginning) (region-end))
              (thing-at-point 'symbol))))
    (setq msw-word 
          (concat "http://en.wikipedia.org/wiki/"
                  (replace-regexp-in-string " " "_" msw-word t)))
    (browse-url msw-word)))
;;
(defalias 'mon-search-wiki 'mon-search-wikipedia)
;;
;;; :TEST-ME (mon-search-wikipedia "monkey meat")

;;; ==============================
;;; :NOTE `mon-search-loc' needs to take arguments to build the search.
(defun mon-search-loc  ()
  "Open the LOC Authority Headings Search Page in the default browser. 
:SEE \(URL `http://authorities.loc.gov/cgi-bin/Pwebrecon.cgi?DB=local&PAGE=First')
:SEE-ALSO `mon-search-ulan', `mon-search-ulan-for-name', `mon-search-bnf',
`mon-search-wikipedia'.\nUsed in `naf-mode'.\n►►►"
  (interactive)
  (browse-url "http://authorities.loc.gov/cgi-bin/Pwebrecon.cgi?DB=local&PAGE=First"))

;;; ==============================
;;; :NOTE `mon-search-bnf' needs to take arguments to build the search.
;;; :SEE :FILE "../naf-mode/a1-working-notes.el"
(defun mon-search-bnf  ()
  "Open the BNF Authority Headings Search Page in the default browser. 
:SEE \(URL `http://catalogue.bnf.fr/jsp/recherche_autorites_bnf.jsp?host=catalogue')
:SEE-ALSO `mon-search-ulan', `mon-search-ulan-for-name', `mon-search-loc',
`mon-search-wikipedia'.\nUsed in `naf-mode'.\n►►►"
  (interactive)
  (browse-url "http://catalogue.bnf.fr/jsp/recherche_autorites_bnf.jsp?host=catalogue"))

;;; ==============================
(defun mon-insert-dbc-link ()
  "Insert a vanilla (relative path) href template at point.
Inserts the following:\n
<a class=\"link_green_bold\" href=\"../insert-path-here\" \"> insert-link-text </a>\n
Link will be colored according to to DBC .css for link_gree_bold.\n
:SEE-ALSO `mon-insert-dbc-doc-link' for a pre-formatted href to doc-detail page.
Used in `naf-mode'.\n►►►"
  (interactive)
  (insert "<a class=\"link_green_bold\" href=\"../insert-path-here\" \"> insert-link-text </a>"))

;;; =======================
;;; :NOTE
;;; ,---- CSS
;;; | .link_green_bold {
;;; | 	font-family: Verdana, Arial, Helvetica, sans-serif;
;;; | 	font-size: 9px;
;;; | 	color: #5A8F5D;
;;; | 	font-weight:bold;
;;; | }
;;; `----
(defun mon-insert-dbc-doc-link (&optional doc-num doc-type link-text)
  "Insert a vanilla \(relative path\) href template at point. 
Called interactively prompts for:
DOC-NUM (a 3-4 digit number), default is \"####\";
DOC-TYPE (artist, author, brand, book, people), default is \"naf-type\";
LINK-TEXT (text with .css class \"link_green_bold\") default is \" insert link text \".
Inserts:\n
<a class=\"link_green_bold\" href=\"../doc-details-DOC-NUM-DOC-TYPE.htm\" \">LINK-TEXT</a>\n
:SEE-ALSO `mon-insert-dbc-link' which inserts a vanilla href link formatted for a
page URL.\nUsed in `naf-mode'.\n►►►"
(interactive "n3-4 digit document number:\nsDoc's NAF type:\nsText for link title:")
  (let* ((dn
	  (if (and doc-num)
	      doc-num
	    "####"))
	 (dt (if (and doc-type)
		 (downcase doc-type)
	       "naf-type"))
	 (lt (if (and link-text)
		 link-text
	       " insert link text "))
	 (dbc-url 
          (format 
           "<a class=\"link_green_bold\" href=\"../doc-details-%d-%s.htm\" \">%s</a>" 
           dn dt lt)))
    (insert  dbc-url)))

;;; ==============================
;;; :TODO Needs to be re-written using:
;;; (search-forward-regexp { ... } (replace-match { ... } 
;;; instead of the existing wacko `replace-string' calls!
;;;
;;; :NOTE not 100% correct yet because doesn't detect pre-existing wrapped urls
;;; in _some_ buffer locations.
;;;
;;; :REQUIRES `*regexp-wrap-url-schemes*' <- mon-regexp-symbols.el
;;; :CREATED <Timestamp: Saturday April 18, 2009 @ 06:51.27 PM - by MON>
(defun mon-wrap-all-urls ()
  "Wraps all URLs in buffer _after point_ with (URL `*').
Conditional prefix matching regexps in `*regexp-wrap-url-schemes*' global.
Won't replace recursively on pre-existing wrapped URLs.\n
:SEE-ALSO `thing-at-point-url-at-point', `mon-wrap-url', `mon-wrap-text', 
`mon-wrap-span', `mon-wrap-selection', `mon-wrap-with'.\n►►►"
  (interactive)
  (save-excursion
    (while
	(if (search-forward-regexp *regexp-wrap-url-schemes* nil t)
	    (let* ((bnd-start (car (bounds-of-thing-at-point 'url)))
		   (bnd-pre (- bnd-start 6))
		   (url-targ (thing-at-point-url-at-point))
		   (url-rep (concat "(URL `" url-targ "')")))
	      (cond
	       ((< bnd-pre 0)
                (replace-string url-targ url-rep)
		(skip-syntax-forward "^w"))
	       ((not (string-match-p "(URL `" (buffer-substring bnd-pre bnd-start)))
		(skip-syntax-backward "^-")
		(replace-string url-targ url-rep)
		(skip-syntax-forward "^w"))))))
    ))
;;
;;; :TEST-ME http://www.somethign.xomthing.com/blotto
;;; :TEST-ME ftp://some.site.com
;;; :TEST-ME http://www.somethign.xomthing.com/blamop

;;; ==============================
;;; :TODO Add ability to evaluate the region programatically and otherwise.
;;; :MODIFICATIONS <Timestamp: Monday June 29, 2009 @ 06:22.48 PM - by MON>
(defun mon-wrap-one-url () ;;(&optional start end insertp)
  "Wrap 1\(one\)the URL  _after point_ with (URL `*').\n
Conditional prefix matching regexps in `*regexp-wrap-url-schemes*' global.
Won't replace recursively on pre-existing wrapped URLs.\n
:SEE-ALSO `mon-wrap-all-urls', `thing-at-point-url-at-point',
`mon-wrap-url', `mon-wrap-text', `mon-wrap-span', `mon-wrap-with'
`mon-wrap-selection'.\n►►►"
  (interactive)
  (save-excursion
    (let* ((url-bnds (bounds-of-thing-at-point 'url))
           (bnd-start (car url-bnds))
           (bnd-end (cdr url-bnds))
           rep-url)
      (setq rep-url 
            (concat "(URL `" (buffer-substring-no-properties bnd-start bnd-end) "')"))
      (goto-char bnd-start)
      (delete-region bnd-start bnd-end)
      (insert rep-url))))
;;
;;; :TEST-ME http://www.somethign.xomthing.com/blotto
;;; :TEST-ME ftp://some.site.com
;;; :TEST-ME http://www.somethign.xomthing.com/blamop

;;; ==============================
;;; :COURTESY Xah Lee
(defun mon-wrap-url ()
  "Make thing at cursor point into an HTML link.\n
:EXAMPLE\n http://wikipedia.org\nbecomes:\n
<a href=\"http://en.wikipedia.org/\">http://wikipedia.org/</a>\n
Or:\n'test' becomes <a href=\"test\">test</a>\n
:SEE-ALSO `mon-wrap-all-urls', `mon-wrap-one-url', `*regexp-wrap-url-schemes*',
`thing-at-point-url-at-point',`mon-wrap-text', `mon-wrap-span',
`mon-wrap-selection', `mon-wrap-with'.\n►►►"
  (interactive)
  (re-search-backward "[\n\t ()]" nil t)
  (looking-at "[\n\t ()]?\\([^\n\t ()]+\\)")
  (let ((p1 (match-beginning 1))
        (p2 (match-end 1))
        (url (match-string 1)))
    (delete-region p1 p2)
    (goto-char p1)
    (insert "<a href=\"" url "\">" url "</a>" )))
;;
;;; http://sosof.org/
;;; => <a href="http://sosof.org/">http://sosof.org/</a>

;;; `mon-wrap-text' is defined in mon-utils.el
;;; ==============================
;;; :COURTESY Xah Lee
(defun mon-wrap-span ()
  "Wrap a HTML <span> tag around current word or region.
Uses MON's link_green_bold CSS.\n\n:EXAMPLE
,----
| .link_green_bold {
| 	font-family: Verdana, Arial, Helvetica, sans-serif;
| 	font-size: 9px;
| 	color: #5A8F5D;
| 	font-weight:bold;
| }
`----\n
:SEE-ALSO `mon-wrap-selection', `mon-wrap-text', `mon-wrap-with',
`mon-wrap-url', `mon-wrap-all-urls'.\n►►►"
  (interactive)
  (mon-wrap-text "<span class=\"link_green_bold\">" "</span>"))

;;; ==============================
;; (add-hook 'html-mode-hook
;; (lambda ()
;; (define-key html-mode-map "\M-5" 'wrap-url)))
;;  (global-set-key (kbd "<f6>") 'wrap-span-xnt)
;;; ==============================
;;; ==============================
(defun mon-make-html-table-string (textblock delim)
  "Turn a text string into an HTML table.\n
Helper function for `mon-make-html-table'.\n
:EXAMPLE
\(mon-make-html-table-string 
 \(mon-string-justify-left
 \(car \(mon-string-wonkify
  \"THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS''
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR\" 1\)\) 18 4\)\"A\"\)\n :)
:SEE-ALSO .\n►►►"
  (let (;; I really don't like setq'ing args outside of let bindings...
        (textblock textblock)
        (delim delim))
    (setq textblock (replace-regexp-in-string delim "</td><td>" textblock))
    (setq textblock (replace-regexp-in-string "\n" "</td></tr>\n<tr><td>" textblock))
    ;; delete the beginning "<tr><td>" in last line
    (setq textblock (substring textblock 0 -8)) 
    (concat "<table border=\"1\" cellpadding=\"5\" cellspacing=\"0\">\n<tr><td>" textblock "</table>")
    ))

;;; ==============================
(defun mon-make-html-table (sep)
  "Turn the current paragraph into a HTML table.
Where \"current paragraph\" has empty lines before and after the block of 
text after point.\n
:EXAMPLE
With \"-\" as separator transforms this:\n
a-b-c\n  1-2-3\n  this-and-that\n
Into the following html table:\n
<table border=\"1\" cellpadding=\"5\" cellspacing=\"0\">
 <tr><td>a</td><td>b</td><td>c</td></tr>
 <tr><td>1</td><td>2</td><td>3</td></tr>
 <tr><td>this</td><td>and</td><td>that</td></tr>\n </table>\n
:SEE-ALSO `mon-make-html-table-string'.\n►►►"
  (interactive "sEnter string pattern for column separation:")
  (let (bds p1 p2 myStr)
    (setq bds (bounds-of-thing-at-point 'paragraph))
    (setq p1 (+ (car bds) 1))
    (setq p2 (cdr bds))
    (setq myStr (buffer-substring-no-properties p1 p2))
    (delete-region p1 p2)
    (insert (mon-make-html-table-string myStr sep) "\n")))


;;; ==============================
;;; :CREATED <Timestamp: #{2010-03-23T19:33:48-04:00Z}#{10122} - by MON KEY>
(defun mon-url-retrieve-to-new-buffer (fetch-this-url)
  "Return FETCH-THIS-URL displayed in an new buffer-window.\n
Fetches URL as with `url-retrieve-synchronously'.\n
:EXAMPLE\n
\(mon-url-retrieve-to-new-buffer \"http://tools.ietf.org/rfc/rfc2822.txt\")\n
:SEE-ALSO `url-copy-file', `url-retrieve', `url-retrieve-synchronously', 
`url-http', `mon-get-w3m-url-at-point-maybe', `google-define',
`mon-get-host-address', `mon-url-encode', `mon-url-decode'
`mon-get-w3m-url-at-point', `mon-w3m-dired-file'\n►►►"
  (let ((the-buff (url-retrieve-synchronously fetch-this-url)))
    (when (get-buffer the-buff) (display-buffer the-buff t))))

;;; ==============================
;;; :COURTESY Dave Love <fx@gnu.org> :HIS fx-misc.el :WAS `gethostaddr'
;;; :CREATED <Timestamp: #{2009-12-19T00:53:06-05:00Z}#{09516} - by MON KEY>
(defun mon-get-host-address (name-or-number)
  "Return IP host name or address corresponding to NAME-OR-NUMBER using host\(1\).
If the arg is an IP number, return the host name, else return the address
corresponding to the host name arg.\n
:EXAMPLE\n\(mon-get-host-address \"google.com\"\)\n
:SEE-ALSO `mon-url-retrieve-to-new-buffer'.\n►►►"
  (if (string-match "^[[:digit:]]+\\(\\.[[:digit:]]+\\)\\{3\\}$"
		    name-or-number)
      name-or-number
    (let ((str (shell-command-to-string
		(concat "host " (shell-quote-argument name-or-number)))))
      (string-match "\\s-+\\([[:digit:]]+\\(\\.[[:digit:]]+\\)\\{3\\}\\)$" str)
      (match-string 1 str))))
;;
;;; :TEST-ME (mon-get-host-address "google.com")

;;; ==============================
;; :W3M-URL-GRABBER  

;;; check-declare-verify

;;(declare-function 'w3m-view-this-url "ext:w3m.el")
;;(declare-function 'w3m-find-file   "ext:w3m.el")
;;(declare-function 'mon-get-w3m-url-at-point-maybe "mon-url-utils")
;; w3m-current-url <VARIABLE>

;; (eval-when-compile (defvar w3m-current-url))

(with-no-warnings
;;; ==============================
;;; :CREATED <Timestamp: #{2009-12-16T23:00:32-05:00Z}#{09513} - by MON KEY>
(when (and (or (featurep 'w3m-load) (featurep 'w3m))
         ;;(and (intern-soft "w3m-dired-file") (fboundp 'w3m-dired-file)))    
         ;;(fboundp 'w3m-dired-file)
         (executable-find "w3m"))
(defun mon-w3m-dired-file (&optional file-to-w3m)
  "Browse dired file at point with w3m.\n
:SEE-ALSO `mon-w3m-kill-url-at-point', `mon-get-w3m-url-at-point-maybe',
`mon-get-w3m-url-at-point', `mon-w3m-read-gnu-lists-nxt-prv',
`mon-copy-file-dired-as-list', `mon-copy-file-dired-as-string',
`dired-get-marked-files'.\n►►►"
  (interactive)
  (w3m-find-file 
   (or file-to-w3m (car (dired-get-marked-files)))))
;;
(defalias 'mon-get-w3m-dired-file  'mon-w3m-dired-file)
;;
;;; ==============================
;;; :CREATED <Timestamp: #{2010-02-17T23:18:19-05:00Z}#{10073} - by MON>
(defun mon-w3m-kill-url-at-point ()
  "Put the w3m URL at point on the kill ring.\n
Examines for URL with `get-text-property' the 'w3m-href-anchor property if found
the property value on the kill ring and message user.\n
:SEE-ALSO `mon-get-w3m-dired-file', `mon-get-w3m-url-at-point-maybe',
`mon-get-w3m-url-at-point', `mon-w3m-read-gnu-lists-nxt-prv',
`w3m-print-this-url', `mon-get-w3m-url-at-point-maybe',
`mon-get-w3m-url-at-point'.\n►►►"
  (interactive)
  (let ((w3mgtp (get-text-property (point) 'w3m-href-anchor)))
      (when (and w3mgtp (stringp w3mgtp))
        (kill-new w3mgtp)
        (message w3mgtp))))

;;; ==============================
;;; :CREATED <Timestamp: #{2009-11-22T16:50:15-05:00Z}#{09477} - by MON>
(defun mon-get-w3m-url-at-point-maybe ()
  "Return two elt list as \(MEHTOD \"URL\"\) when text-properties at point has
w3m-href-anchor value and is a 'file 'http 'https.\n
:SEE-ALSO `mon-get-w3m-url-at-point', `mon-w3m-read-gnu-lists-nxt-prv'
`mon-w3m-dired-file', `w3m-print-this-url', `mon-get-w3m-url-at-point-maybe',
`mon-get-w3m-url-at-point'.\n►►►"
  (let* ((is-url (get-text-property (point) 'w3m-href-anchor))
         (match-with "\\(file\\|http\\|https\\)")
         (is-match (if (stringp is-url)
                       (string-match match-with is-url)))
         (got-match (if (and is-url is-match)
                        (match-string-no-properties 0 is-url))))
    (if got-match
        (cond ((string= got-match "file")  `(file  ,is-url))
              ((string= got-match "http")  `(http  ,is-url))
              ((string= got-match "https") `(https ,is-url))
              (t nil)))))
;;
(defalias 'mon-w3m-get-url-at-point-maybe 'mon-get-w3m-url-at-point-maybe)
;;
;;; ============================== 
;;; :CREATED <Timestamp: #{2009-11-22T16:59:12-05:00Z}#{09477} - by MON>
(defun mon-get-w3m-url-at-point (&optional insrtp buffer intrp)
  "Return w3m-href-anchor value and is a 'file 'http 'https.
When INSRTP in non-nil and BUFFER names an existing buffer insert the w3m URL in
BUFFER. If BUFFER is nil or does no exist return URL.\n
:SEE-ALSO `mon-get-w3m-url-at-point-maybe', `mon-w3m-read-gnu-lists-nxt-prv',
`mon-w3m-kill-url-at-point', `mon-w3m-dired-file', `w3m-print-this-url',
`mon-get-w3m-url-at-point-maybe', `mon-get-w3m-url-at-point'.\n►►►"
  (interactive "i\ni\np")
  (let ((url-maybe (mon-get-w3m-url-at-point-maybe))
        (do-buff (if buffer (get-buffer buffer))))
    (when url-maybe
      (cond (intrp (princ (cadr url-maybe)))
            ((and insrtp do-buff)
             (save-excursion                
               (princ (concat "\n" (cadr url-maybe)) do-buff)))
            (t url-maybe)))))
;;
(defalias 'mon-w3m-get-url-at-point 'mon-get-w3m-url-at-point)
;;; ==============================
;;; ;WORKING-BUT-BUGGY-AS-OF
;;; :CREATED <Timestamp: #{2009-11-22T19:00:33-05:00Z}#{09477} - by MON>
(defun mon-w3m-read-gnu-lists-nxt-prv (prev next)
  "Browse GNU mailing lists with w3m selecting next in thread prev in thread.\n
:SEE \(URL `http://lists.gnu.org/archive/html/emacs-devel/'\)
:SEE \(URL `http://lists.gnu.org'\)\n
:SEE-ALSO `mon-get-w3m-url-at-point', `mon-get-w3m-url-at-point-maybe',
`mon-w3m-dired-file', `w3m-print-this-url', `mon-get-w3m-url-at-point-maybe',
`mon-get-w3m-url-at-point'.\n►►►"
  (let ((nxt-prev-p
         (if (save-excursion
               (goto-char (buffer-end 0))
               (search-forward-regexp
                (cond (prev "Prev in Thread")
                      (next "Next in Thread"))
                nil t))
             (match-end 0))))
    (if nxt-prev-p
        (progn 
          (goto-char (1- nxt-prev-p))
          (let ((is-http (mon-get-w3m-url-at-point-maybe)))
            (if (string= (cadr is-http) w3m-current-url)
                ;; We found 
                (cond (prev (message "No previous in thread"))
                      (next (message "No next in thread" )))
                (if (eq (car is-http) 'http)
                    (prog1
                        (message (cadr is-http))
                      (w3m-view-this-url))
                    (message 
                     (cond (prev (message "Can't locate previous in thread"))
                           (next (message "Can't locate next in thread")))))))))))
;;;
(defalias 'mon-get-w3m-read-gnu-lists-nxt-prv 'mon-w3m-read-gnu-lists-nxt-prv)
;;
;;
;; (mon-w3m-read-gnu-lists-nxt-prv nil t)
;;
;; ,---- :UNCOMMENT-TO-TEST
;; | (dolist (i '(("1" "2007-06/msg00634.html") ("2" "2007-06/msg00725.html")))
;; |   (search-forward-regexp (concat  (car i) "\\[\\(.* in Thread\\)]") nil t)
;; |   (put-text-property  
;; |    (match-beginning 1) (match-end 1)
;; |    'w3m-href-anchor (concat "http://lists.gnu.org/archive/html/emacs-devel/" (cadr i))))
;; | 
;; | 1[Prev in Thread] ;with-tp
;; | 2[Next in Thread] ;with-tp
;; |  [Prev in Thread] ;without-tp
;; |  [Next in Thread] ;without-tp
;; `----
;;; ==============================
;;; :NOTE Alternate approach to `mon-w3m-read-gnu-lists-nxt-prv'
;;; :NOT-WOKRING-AS-OF
;;; :CREATED <Timestamp: #{2009-11-23T12:28:11-05:00Z}#{09481} - by MON>
;;; ,----
;;; | (defun mon-w3m-read-gnu-lists-nxt-prv (prev next)
;;; |   (let* ( (match-on (cond (prev "Prev in Thread")
;;; |                           (next "Next in Thread")))
;;; |          (got-one
;;; |           (save-excursion
;;; |             (goto-char (buffer-end 1))
;;; |             (let ((is-wha (previous-single-property-change (point) 'w3m-href-anchor)))
;;; |               (while is-wha
;;; |                 (if (looking-back match-on) 
;;; |                     ;;    :FIXME
;;; |                     ;;    {....}
;;; |                     ))))))
;;; |     (if got-one 
;;; |         (save-excursion
;;; |           (goto-char (1- got-one))
;;; |           (setq got-one (mon-get-w3m-url-at-point-maybe))
;;; |         (if (string=   (cadr got-one) w3m-current-url)
;;; |             (message (format "%s is current URL." match-on))
;;; |               (w3m-view-this-url)))) ))
;;; `----
;;
(unless (fboundp 'w3m-copy-this-url-as-kill)
  (defalias 'w3m-print-this-url 'w3m-copy-this-url-as-kill))
;;
(unless (fboundp 'w3m-copy-current-url-as-kill)
  (defalias 'w3m-print-current-url 'w3m-copy-current-url-as-kill))
;;
) ;; :CLOSE when
(unless  (and (or (featurep 'w3m-load) (featurep 'w3m))
              ;;(and (intern-soft "w3m-dired-file") (fboundp 'w3m-dired-file)))    
              ;;(fboundp 'w3m-dired-file)
              (executable-find "w3m"))
  (message "Can not find the w3m executable or a required feature"))
) ;; :CLOSE with-no-warnings
;;; ==============================


;;; ==============================
;;; :COURTESY Dave Pearson <davep@davep.org> :HIS tld.el 
;;; :SEE (URL `http://www.davep.org/emacs/tld.el')
;;; :VERSION $Revision: 1.5 $ - Copyright 2000-2008 - GPLv2
;;; TLD -> Top Level Domain names
;;; A TLD lookup tool tld.el provides a command for looking up TLDs, either by searching for a
;;; specific TLD or by searching country names. One command is provided: `tld'.
;;;
;;; :NOTE To some degree, this code duplicates the functionality
;;;       provided by `what-domain' (a command that is part of emacs). tld.el
;;;       differs slightly in that it allows for both TLD and country name
;;;       searches. Also, compared to emacs 20.7, the list of TLDs is more complete.
;;; (autoload 'tld "tld" "Perform a TLD lookup" t)
;;; ==============================
;;; :CREATED <Timestamp: Tuesday May 19, 2009 @ 12:11.29 PM - by MON>
;;; :MODIFICATIONS Altered the original tld alist keys to reflect the those of
;;; mail-extr.el (e.g. notes pertaining to `what-doman') :SEE :FILE mail-extr.el
;;; Keep in mind that the country abbreviations follow ISO-3166.  There is
;;; a U.S. FIPS that specifies a different set of two-letter country
;;; abbreviations. Updated by the RIPE Network Coordination Centre.
;;; :SOURCE ISO 3166 Maintenance Agency - Latest change: 2007/11/15
;;; :SEE (URL `http://www.iso.org/iso/en/prods-services/iso3166ma/02iso-3166-code-lists/list-en1-semic.txt')
;;; :SEE (URL `http://www.iana.org/domain-names.htm')
;;; :SEE (URL `http://www.iana.org/cctld/cctld-whois.htm')
;;; ==============================
;;; :WAS `tld-list' -> `*mon-tld-list*'
(defconst *mon-tld-list*
  '(;; ISO 3166 codes:
    ("AC" . "Ascension Island")  
    ("AD" . "Andorra")
    ("AE" . "United Arab Emirates")
    ("AF" . "Afghanistan")
    ("AG" . "Antigua and Barbuda")
    ("AI" . "Anguilla")
    ("AL" . "Albania")
    ("AM" . "Armenia")
    ("AN" . "Netherlands Antilles")
    ("AO" . "Angola")
    ("AQ" . "Antarctica")		;Continent
    ("AR" . "Argentina")		;"Argentine Republic"
    ("AS" . "American Samoa")
    ("AT" . "Austria")			;"The Republic of %s"
    ("AU" . "Australia")
    ("AW" . "Aruba")
    ("AX" . "Aland Islands")
    ("AZ" . "Azerbaijan")
    ("BA" . "Bosnia-Herzegovina")
    ("BB" . "Barbados")
    ("BD" . "Bangladesh")
    ("BE" . "Belgium")			;"The Kingdom of %s"
    ("BF" . "Burkina Faso")
    ("BG" . "Bulgaria")
    ("BH" . "Bahrain")
    ("BI" . "Burundi")
    ("BJ" . "Benin")
    ("BL" . "Saint Barthelemy")
    ("BM" . "Bermuda")
    ("BN" . "Brunei Darussalam")
    ("BO" . "Bolivia")			;"Republic of %s"
    ("BR" . "Brazil")			;"The Federative Republic of %s"
    ("BS" . "Bahamas")
    ("BT" . "Bhutan")
    ("BV" . "Bouvet Island")
    ("BW" . "Botswana")
    ("BY" . "Belarus")
    ("BZ" . "Belize")
    ("CA" . "Canada")
    ("CC" . "Cocos (Keeling) Islands")
    ("CD" . "Congo")			;"The Democratic Republic of the %s"
    ("CF" . "Central African Republic")
    ("CG" . "Congo")
    ("CH" . "Switzerland")		;"The Swiss Confederation"
    ("CI" . "Ivory Coast")		;Cote D'ivoire
    ("CK" . "Cook Islands")
    ("CL" . "Chile")			;"The Republic of %s"
    ("CM" . "Cameroon")			;In .fr domain
    ("CN" . "China")			;"The People's Republic of %s"
    ("CO" . "Colombia")
    ("CR" . "Costa Rica")		;"The Republic of %s"
    ("CU" . "Cuba")
    ("CV" . "Cape Verde")
    ("CX" . "Christmas Island")
    ("CY" . "Cyprus")
    ("CZ" . "Czech Republic")
    ("DE" . "Germany")
    ("DJ" . "Djibouti")
    ("DK" . "Denmark")
    ("DM" . "Dominica")
    ("DO" . "Dominican Republic")	;"The %s"
    ("DZ" . "Algeria")
    ("EC" . "Ecuador")			;"The Republic of %s"
    ("EE" . "Estonia")
    ("EG" . "Egypt")			;"The Arab Republic of %s"
    ("EH" . "Western Sahara")
    ("ER" . "Eritrea")
    ("ES" . "Spain")			;"The Kingdom of %s"
    ("ET" . "Ethiopia")
    ("EU" . "European Union")
    ("FI" . "Finland")			;"The Republic of %s"
    ("FJ" . "Fiji")
    ("FK" . "Falkland Islands (Malvinas)")
    ("FM" . "Micronesia")		;"Federated States of %s"
    ("FO" . "Faroe Islands")
    ("FR" . "France")
    ("GA" . "Gabon")
    ("GB" . "United Kingdom")
    ("GD" . "Grenada")
    ("GE" . "Georgia")
    ("GF" . "French Guiana")
    ("GG" . "Guernsey")
    ("GH" . "Ghana")
    ("GI" . "Gibraltar")
    ("GL" . "Greenland")
    ("GM" . "Gambia")
    ("GN" . "Guinea")
    ("GP" . "Guadeloupe (Fr.)")
    ("GQ" . "Equatorial Guinea")
    ("GR" . "Greece")			;"The Hellenic Republic (%s)"
    ("GS" . "South Georgia and The South Sandwich Islands")
    ("GT" . "Guatemala")
    ("GU" . "Guam (U.S.)")
    ("GW" . "Guinea-Bissau")
    ("GY" . "Guyana")
    ("HK" . "Hong Kong")
    ("HM" . "Heard Island and Mcdonald Islands")
    ("HN" . "Honduras")
    ("HR" . "Croatia")			;"Croatia (Hrvatska)"
    ("HT" . "Haiti")
    ("HU" . "Hungary")			;"The Hungarian Republic"
    ("ID" . "Indonesia")
    ("IE" . "Ireland")
    ("IL" . "Israel")		    ;"The State of %s"
    ("IM" . "Isle of Man")	    ;"The %s") ; NOT in ISO 3166-1 of 2001-02-26
    ("IN" . "India")		    ;"The Republic of %s"
    ("IO" . "British Indian Ocean Territory")
    ("IQ" . "Iraq")
    ("IR" . "Iran")			;"Islamic Republic of %s"
    ("IS" . "Iceland")			;"The Republic of %s"
    ("IT" . "Italy")			;"The Italian Republic"
    ("JE" . "Jersey")
    ("JM" . "Jamaica")
    ("JO" . "Jordan")
    ("JP" . "Japan")
    ("KE" . "Kenya")
    ("KG" . "Kyrgyzstan")
    ("KH" . "Cambodia")
    ("KI" . "Kiribati")
    ("KM" . "Comoros")
    ("KN" . "Saint Kitts and Nevis")
    ("KP" . "Korea (North)")	       ;"Democratic People's Republic of Korea"
    ("KR" . "Korea (South)")	       ;"Republic of Korea"
    ("KW" . "Kuwait")
    ("KY" . "Cayman Islands")
    ("KZ" . "Kazakhstan")
    ("LA" . "Lao People's Democratic Republic")
    ("LB" . "Lebanon")
    ("LC" . "Saint Lucia")
    ("LI" . "Liechtenstein")
    ("LK" . "Sri Lanka")	     ;"The Democratic Socialist Republic of %s"
    ("LR" . "Liberia")
    ("LS" . "Lesotho")
    ("LT" . "Lithuania")
    ("LU" . "Luxembourg")
    ("LV" . "Latvia")
    ("LY" . "Libyan Arab Jamahiriya")
    ("MA" . "Morocco")
    ("MC" . "Monaco")
    ("MD" . "Moldova")			;"The Republic of %s"
    ("ME" . "Montenegro")
    ("MF" . "Saint Martin (French part)")
    ("MG" . "Madagascar")
    ("MH" . "Marshall Islands")
    ("MK" . "Macedonia")		;"The Former Yugoslav Republic of %s"
    ("ML" . "Mali")
    ("MM" . "Myanmar")
    ("MN" . "Mongolia")
    ("MO" . "Macao")
    ("MP" . "Northern Mariana Islands")
    ("MQ" . "Martinique")
    ("MR" . "Mauritania")
    ("MS" . "Montserrat")
    ("MT" . "Malta")
    ("MU" . "Mauritius")
    ("MV" . "Maldives")
    ("MW" . "Malawi")
    ("MX" . "Mexico")			;"The United Mexican States"
    ("MY" . "Malaysia")
    ("MZ" . "Mozambique")
    ("NA" . "Namibia")
    ("NC" . "New Caledonia (Fr.)")
    ("NE" . "Niger")			;In .fr domain
    ("NF" . "Norfolk Island")
    ("NG" . "Nigeria")
    ("NI" . "Nicaragua")		;"The Republic of %s"
    ("NL" . "Netherlands")		;"The Kingdom of the %s"
    ("NO" . "Norway")			;"The Kingdom of %s"
    ("NP" . "Nepal")			; Via .in domain
    ("NR" . "Nauru")
    ("NU" . "Niue")
    ("NZ" . "New Zealand")
    ("OM" . "Oman")
    ("PA" . "Panama")
    ("PE" . "Peru")
    ("PF" . "French Polynesia")
    ("PG" . "Papua New Guinea")
    ("PH" . "Philippines")		;"The Republic of the %s"
    ("PK" . "Pakistan")
    ("PL" . "Poland")
    ("PM" . "Saint Pierre and Miquelon")
    ("PN" . "Pitcairn")
    ("PR" . "Puerto Rico (U.S.)")
    ("PS" . "Palestinian Territory, Occupied")
    ("PT" . "Portugal")			;"The Portuguese Republic"
    ("PW" . "Palau")
    ("PY" . "Paraguay")
    ("QA" . "Qatar")
    ("RE" . "Reunion (Fr.)")		;In .fr domain
    ("RO" . "Romania")
    ("RS" . "Serbia")
    ("RU" . "Russia")			;"Russian Federation"
    ("RW" . "Rwanda")
    ("SA" . "Saudi Arabia")
    ("SB" . "Solomon Islands")
    ("SC" . "Seychelles")
    ("SD" . "Sudan")
    ("SE" . "Sweden")			;"The Kingdom of %s"
    ("SG" . "Singapore")		;"The Republic of %s"
    ("SH" . "Saint Helena")
    ("SI" . "Slovenia")
    ("SJ" . "Svalbard and Jan Mayen")	;In .no domain
    ("SK" . "Slovakia")			;"The Slovak Republic"
    ("SL" . "Sierra Leone")
    ("SM" . "San Marino")
    ("SN" . "Senegal")
    ("SO" . "Somalia")
    ("SR" . "Suriname")
    ("ST" . "Sao Tome and Principe")
    ("SU" . "U.S.S.R.")		     ;"The Union of Soviet Socialist Republics"
    ("SV" . "El Salvador")
    ("SY" . "Syrian Arab Republic")
    ("SZ" . "Swaziland")
    ("TC" . "Turks and Caicos Islands")
    ("TD" . "Chad")
    ("TF" . "French Southern Territories")
    ("TG" . "Togo")
    ("TH" . "Thailand")			;"The Kingdom of %s"
    ("TJ" . "Tajikistan")
    ("TK" . "Tokelau")
    ("TL" . "East Timor")
    ("TM" . "Turkmenistan")
    ("TN" . "Tunisia")
    ("TO" . "Tonga")
    ("TP" . "East Timor")
    ("TR" . "Turkey")			;"The Republic of %s"
    ("TT" . "Trinidad and Tobago")
    ("TV" . "Tuvalu")
    ("TW" . "Taiwan")			;"%s, Province of China"
    ("TZ" . "Tanzania"	)		;"United Republic of %s"
    ("UA" . "Ukraine")
    ("UG" . "Uganda")
    ("UK" . "United Kingdom") ;	"The %s of Great Britain and Northern Ireland"
    ("UM" . "United States Minor Outlying Islands")
    ("US" . "United States")		;"The %s of America"
    ("UY" . "Uruguay")			;"The Eastern Republic of %s"
    ("UZ" . "Uzbekistan")
    ("VA" . "Holy See (Vatican City State)")
    ("VC" . "Saint Vincent and the Grenadines")
    ("VE" . "Venezuela")		;"The Republic of %s"
    ("VG" . "Virgin Islands, British")
    ("VI" . "Virgin Islands, U.S.")
    ("VN" . "Vietnam")
    ("VU" . "Vanuatu")
    ("WF" . "Wallis and Futuna")
    ("WS" . "Samoa")
    ("YE" . "Yemen")
    ("YT" . "Mayotte")
    ("YU" . "Yugoslavia")		;"Yugoslavia, AKA Serbia-Montenegro"
    ("ZA" . "South Africa")		;"The Republic of %s"
    ("ZM" . "Zambia")
    ("ZW" . "Zimbabwe")			;"Republic of %s"
    ;; GENERIC DOMAINS:
    ;;("bitnet" t		"Because It's Time NET"
    ;;("nato" t		"North Atlantic Treaty Organization"
    ("AERO" . "Air Transport Industry")
    ("ASIA" . "Pan-Asia and Asia Pacific community")
    ("BIZ" . "Businesses")
    ("CAT" . "Catalan language and culture")
    ("COM" . "Commercial")
    ("COOP" . "Cooperative Associations")
    ("INFO" . "Info")
    ("JOBS" . "Employment")
    ("MOBI" . "Mobile products")
    ("MUSEUM" . "Museums")
    ("NAME" . "Individuals")
    ("NET" . "Network")
    ("ORG" . "Non-profit Organization")
    ("PRO" . "Credentialed professionals")
    ("TEL" . "Contact data")
    ("TRAVEL" . "Travel industry")
    ("GOV" . "United States Government")
    ("EDU" . "Educational")
    ("MIL" . "United States Military")
    ("INT" . "International Treaties")
    ("UUCP" . "Unix to Unix CoPy")
    ("ARPA" . "Advanced Research Projects Agency (U.S. DoD)"))
  "Association list of TLDs per ISO-3166 codes.
:NOTE Country abbreviations are per ISO 3166 spec. There is an U.S. FIPS that
specifies a different set of two-letter country abbreviations.
Updated by the RIPE Network Coordination Centre. 
:SOURCE ISO 3166 Maintenance Agency - :VERSION 2007-11-15.
:SEE \(URL `http://www.iso.org/iso/en/prods-services/iso3166ma/02iso-3166-code-lists/list-en1-semic.txt');
:SEE \(URL `http://www.iana.org/domain-names.htm');
:SEE \(URL `http://www.iana.org/cctld/cctld-whois.htm').\n
:SEE-ALSO `mon-tld-find-name', `mon-tld-tld', `mon-tld-find-tld', `mon-tld-name', `mon-tld'.\n►►►")
;;
;;; :WAS `tld-tld' -> `mon-tld-tld'
(defsubst mon-tld-tld (tld)
  "Return the TLD portion of a TLD pair.\n
:SEE-ALSO `mon-tld-find-name',`mon-tld-find-tld', `mon-tld-name',
`mon-tld',`*mon-tld-list*'.\n►►►"
  (car tld))
;;; :WAS `tld-name' -> `mon-tld-name'
(defsubst mon-tld-name (tld)
  "Return the name portion of a TLD pair.\n
:SEE-ALSO `mon-tld-find-name', `mon-tld-tld', `mon-tld-find-tld',
`mon-tld',`*mon-tld-list*'.\n►►►"
  (cdr tld))
;;
;;; :WAS `mon-tld-find-tld'
(defun mon-tld-find-tld (tld)
  "Lookup a TLD. If found a (TLD . NAME) pair is returned.\n
:SEE-ALSO `mon-tld-find-name', `mon-tld-tld',`mon-tld-name', `mon-tld',
`*mon-tld-list*'\n►►►."
  (assoc (upcase tld) *mon-tld-list*))
;;
;;; :WAS `tld-find-name' -> `mon-tld-find-name'
(defun mon-tld-find-name (name)
  "Lookup a TLD name. Returns a list of hits.\n
:SEE-ALSO `mon-tld-tld', `mon-tld-find-tld', `mon-tld-name', `mon-tld', 
`*mon-tld-list*'."
  (let ((case-fold-search t))
    (loop for tld in *mon-tld-list*
          when (string-match name (mon-tld-name tld))
          collect tld)))
;;
;;; :WAS `tld' -> `mon-tld'
;;;###autoload
(defun mon-tld (search)
  "Search the TLD list.\n
:SEE-ALSO `mon-tld-find-name', `mon-tld-tld', `mon-tld-find-tld', `mon-tld-name',
`*mon-tld-list*'.\n►►►"
  (interactive "sSearch: ")
  (let* ((tld-lookup (string= (substring search 0 1) "."))
         (result     (if tld-lookup (mon-tld-find-tld (substring search 1)) (mon-tld-find-name search))))
    (if result
        (flet ((message-tld (tld)
                 (message "%s is %s" (mon-tld-tld tld) (mon-tld-name tld))))
          (if tld-lookup
              (message-tld result)
            (if (= (length result) 1)
                (message-tld (car result))
              (with-output-to-temp-buffer "*tld*"
                (princ "TLD    Name\n====== ========================================\n\n")
                (loop for tld in result
                      do (princ (format "%-6s %s\n" (mon-tld-tld tld) (mon-tld-name tld))))))))
      ;; If nothing was found and it wasn't a tld-lookup but it looks like
      ;; it might be a TLD re-submit it with a leading dot.
      (if (and (not tld-lookup) (< (length search) 7))
          (mon-tld (concat "." search))
        (error "No TLD match found")))))

;;; ==============================
(provide 'mon-url-utils)
;;; ==============================

;;; ==============================
;;; mon-url-utils.el ends here
;;; EOF

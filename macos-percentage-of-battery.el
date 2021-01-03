;; Imports
(require 'subr-x)  ; string-trim

;; Variables
(setq battery-info (split-string (shell-command-to-string "/usr/sbin/ioreg -rc AppleSmartBattery") "\n"))

;; Functions
(defun get-value (key)
  (let (raw-line)
    (setq raw-line (car (seq-filter (lambda (line) (string-match (regexp-quote key) line)) battery-info)))
    (string-trim (car (last (split-string raw-line "="))))))

;; Get info battery
(setq current-capacity (float (string-to-number (get-value "CurrentCapacity"))))
(setq max-capacity (float (string-to-number (get-value "MaxCapacity"))))
(setq battery-current-percentage (ceiling (* 100 (/ current-capacity max-capacity))))

(print battery-current-percentage)

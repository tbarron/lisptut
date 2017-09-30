;; Emacs Lisp Tutorial 02: Sequence
;;
;; Programming languages have three basic control structures:
;; sequence, iteration, and selection.
;;
;; SEQUENCE just means putting instructions in order, one after
;; another. For example, here is a sequence of instructions:

(progn (message "ten ...")
       (sleep-for 2.8)
       (message "nine ...")
       (sleep-for 2.6)
       (message "eight ...")
       (sleep-for 2.4)
       (message "seven ...")
       (sleep-for 2.2)
       (message "six ...")
       (sleep-for 2.0)
       (message "five ...")
       (sleep-for 1.8)
       (message "four ...")
       (sleep-for 1.6)
       (message "three ...")
       (sleep-for 1.4)
       (message "two ...")
       (sleep-for 1.2)
       (message "one ...")
       (sleep-for 1.0)
       (message "*** BOOM ***"))

;; We've already met the <message> function. The <sleep-for> function
;; tells Lisp to do nothing for the indicated number of seconds. As you
;; can see, floating point numbers are allowed, so you can sleep for
;; fractions of a second.
;;
;; The <progn> function tells Lisp to evaluate each of the forms in
;; the rest of its body and return the value of the last one. We'll
;; learn about return values later on.
;;
;; The second control structure is ITERATION. The code above is a bit
;; cumbersome. Our code could be more compact if we put the strings
;; and wait times in a list. Then we could write a small amount of
;; code to cycle through the list to produce the count down. For
;; example:

(progn
  (setq count-list '("ten ..." "nine ..." "eight ..."
                     "seven ..." "six ..." "five ..."
                     "four ..." "three ..." "two ..."
                     "one ..." "*** BOOM ***"))
  (setq sltm 2.8)

  (while (setq count (car count-list))
    (setq count-list (cdr count-list))
    (message "%s" count)
    (sleep-for sltm)
    (setq sltm (- sltm 0.2))
    )
)

;; This example introduces several new functions:
;;
;; <setq> binds a symbol to a value so the next time we reference the
;; symbol, we'll get that value back. We used setq to to bind the
;; symbol "count-list" to the list of count down strings and the
;; symbol "sltm" to the initial sleep time.
;;
;; <car> returns the first element from the list passed as its
;; argument. Each time we call it, it pulls the next item from
;; count-list so we can display it using <message>.
;;
;; <cdr> returns the rest of the list after the first element. Once
;; we've used <car> to get the first element from the list, we want to
;; remove it so on the next iteration, we'll get the next element. So
;; right after calling <car>, we use <cdr> to update count-list with
;; the list minus the first element.
;;
;; <-> subtracts its second argument from the first. Since sltm
;; contains the length of time we just slept for, the last line will
;; reduce the sleep time by another .2 seconds.
;;
;; SELECTION, the third control structure provides for following
;; different pathways of control.

(if 

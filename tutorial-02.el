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
;; cumbersome. Our code could be more compact if we put the strings in
;; a list. Then we could write a small amount of code to cycle through
;; the list to produce the count down. For example:

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
;; <setq> binds a symbol to a value so the next time we use the
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
;; <-> in "(- sltm 0.2)" subtracts its second argument from the first.
;; Since sltm contains the length of time we just slept for, the last
;; line will reduce the sleep time by .2 seconds each time we run it.
;;
;; SELECTION, the third control structure provides for following
;; different pathways of control.
;;
;; In a sense, we've already seen an example of selection at the top
;; of the while loop. If the first expression after while evaluates to
;; true ('t in Lisp), the next iteration of the body takes place. If
;; the expression evaluates to false (nil or () in Lisp), control
;; falls to after the end of the while expression.
;;
;; More generally, selection between two paths is implemented with the
;; if form:

(progn
  (setq count-list '("ten ..." "nine ..." "eight ..."
                     "seven ..." "six ..." "five ..."
                     "four ..." "three ..." "two ..." "one ..."))
  (setq direction "down")
  (setq direction "up")

  (if (string= direction "up")
      (setq count-list (reverse count-list)))

  (while (setq count (car count-list))
    (setq count-list (cdr count-list))
    (message "%s" count)
    (sleep-for 1.0)))

;; This example uses the same basic while loop as the iteration
;; example above to cycle through the count elements in the list.
;; However, in this case we have the option of reversing them first so
;; the count goes from low to high rather than from high to low.
;;
;; You can add a semicolon in front of '(setq direction "up")' to see
;; the count go from ten to one.
;;
;; The <if> form takes its first argument as a test. If it evaluates
;; to true (anything other than nil), the second argument is
;; evaluated. If the first argument evaluates to nil, the second
;; argument is skipped and the third and following arguments, if any,
;; are evaluated.
;;
;; This example also uses <string=>, which returns 't if the two
;; strings being compared have identical contents.
;;
;; You may be thinking, "Okay, I can do multiple things in the else
;; branch, but what if I want to do more than one thing in the true
;; side?" You can use <progn> with <if> to execute a series of forms
;; on the true side of the <if>.
;;
;; Also, you may notice that after displaying each of the items from
;; count-list, the last thing that shows up in the message area is
;; 'nil'. That's not in the list. Why is it displayed? Take a moment
;; and see if you can answer that question before reading the next
;; paragraph.
;;
;; In this file, we have looked at the three basic control structures
;; of software -- sequence, iteration, and selection -- and how they
;; are specified in Lisp. In the process, we've learned quite a number
;; of Lisp functions: progn, sleep-for, setq, while, car, cdr, if,
;; string=
;;
;; In the next file, we'll look at how to write and call our own
;; functions. Navigate to file tutorial-03.el or evaluate the
;; following expression.

(find-file "tutorial-03.el")

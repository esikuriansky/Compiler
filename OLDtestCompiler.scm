;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;; Comp171 - Compiler - Tests

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "compiler.scm")	    

(define tests-counter 0)
(define failed-tests-counter 0)

;;;; Configuration
(define show-passed-tests #t)
(define show-summary #t)
(define catch-exceptions #f)

(define try-catch
  (lambda (try-thunk catch-thunk)
    (if catch-exceptions
      (guard (c (else (catch-thunk)))
      (try-thunk))
      (try-thunk))
))
		
(define tests-file->string
  (lambda (in-file)
    (let ((in-port (open-input-file in-file)))
      (letrec ((run
	(lambda ()
	  (let ((ch (read-char in-port)))
	    (if (eof-object? ch)
	      (begin
		(close-input-port in-port)
		'())
	      (cons ch (run)))))))
	(list->string (run))))
))

(define tests-string->file
  (lambda (str out-file)
    (letrec ((out-port (open-output-file out-file))
	  (run (lambda (lst)
		  (if (null? lst) #t
		      (begin (write-char (car lst) out-port)
			     (run (cdr lst)))))))
	(begin
	  (run (string->list str))
	  (close-output-port out-port)))
	    
))

 (define prepare-func
   (lambda (lst)
     (map (lambda (x) (annotate-tc 
 		  (pe->lex-pe
 		    (box-set
 		      (remove-applic-lambda-nil
 			(eliminate-nested-defines
 			  (parse x))))))) lst)
))

(define test-input
  (lambda (input)
    (system "rm -f outResult")
    (system "rm -f outFile")
    (system "rm -f outFile.c")
    (system "rm -f outFile.scm")
    (tests-string->file input "outFile.scm")
    (compile "outFile.scm" "outFile.c")
    (system "gcc -o outFile outFile.c")
    (system "./outFile > outResult")
    (let ((result (tests-file->string "outResult")))
      result)
))

(define test-func
  (lambda (input)
    (system "rm -f outResult")
    (system "rm -f outFile")
    (system "rm -f outFile.c")
    (system "rm -f outFile.scm")
    (tests-string->file input "outFile.scm")
    (compile "outFile.scm" "outFile.c")
    (system "gcc -o outFile outFile.c")
    (system "./outFile > outResult")
    (let ((result (tests-file->string "outResult")))
      (system "rm -f outResult")
      (system "rm -f outFile")
      ; (system "rm -f outFile.c")
      (system "rm -f outFile.scm")
      result)
))

(define expected-result
  (lambda (input)
    (let* ((exp-res (eval input))
	  (exp-res-str (tests-file->string (tests-string->file exp-res "expRes.scm"))))
      exp-res-str)
))
		
(define assert
	(lambda (input expected-output)
		(set! tests-counter (+ 1 tests-counter))
		(try-catch (lambda ()
		(let ((actual-output (test-func input)))			
			(cond ((equal? actual-output expected-output)
				(if show-passed-tests
				  (begin (display (format "~s) ~a\n" tests-counter input))
				  (display (format "\033[1;32m Success! ☺ \033[0m \n\n")))) 
				  #t)
				(else
				  (set! failed-tests-counter (+ 1 failed-tests-counter))
				  (display (format "~s) ~a\n" tests-counter input))
				  (display (format "\033[1;31mFailed! ☹\033[0m\n\n\033[1;34mExpected:\n ~s\033[0m\n\n\033[1;29mActual:\n ~a\033[0m\n\n" expected-output actual-output))
				#f))))
			(lambda () (set! failed-tests-counter (+ 1 failed-tests-counter))
				(display (format "~s) ~a\n" tests-counter input))
				(display 
				    (format "\n\033[1;31mEXCEPTION OCCURED. PLEASE CHECK MANUALLY THE INPUT:\n ~s\033[0m\n\n" input)) #f))
			))
			
(define runTests
  (lambda (tests-name lst)
	(newline)
	(display tests-name)
	(display ":")
	(newline)
	(display "==============================================")
	(newline)
	(let ((results (map (lambda (x) (assert (car x) (cdr x))) lst)))
	(newline)
	(cond ((andmap (lambda (exp) (equal? exp #t)) results)	
		(display (format "\033[1;32m~s Tests: SUCCESS! ☺ \033[0m\n \n" tests-name)) #t)		
		(else
		(display (format "\033[1;31m~s Tests: FAILED! ☹ \033[0m\n \n" tests-name)) #f)))
))

(define runAllTests
  (lambda (lst)
    (let ((results (map (lambda (test) (runTests (car test) (cdr test))) lst)))
	(if show-summary
	  (begin
	    (display (format "Summary\n=============================\n\033[1;32mPassed: ~s of ~s tests ☺\033[0m\n" (- tests-counter failed-tests-counter) tests-counter))
	    (if (> failed-tests-counter 0)
	      (display (format "\033[1;31mFailed: ~s of ~s tests ☹\033[0m\n\n" failed-tests-counter tests-counter)))))
      	(cond ((andmap (lambda (exp) (equal? exp #t)) results)		
		(display "\033[1;32m!!!!!  ☺  ALL TESTS SUCCEEDED  ☺  !!!!\033[0m\n") #t)
		(else (display "\033[1;31m#####  ☹  SOME TESTS FAILED  ☹  #####\033[0m\n") #f))
		(newline))
))



(define set-tests
  (list
    ; set pvar
    (cons "((lambda (x) (set! x 1)) 4)" "")
    (cons "((lambda (x) (set! x 12) x) 5)" "12\n")
    (cons "((lambda (x y . z) (set! z #t) z) 5 9 34)" "#t\n")
    (cons "((lambda (x y . z) (set! y '(1 2 3 4 5)) y) 5 9)" 
	  "(1 . (2 . (3 . (4 . (5 . ())))))\n")
    (cons "((lambda x (set! x '#(1 2 3)) x) 5 6 7)" "#3(1 2 3)\n")
    (cons "((lambda (x . y) ((lambda (x) y x (set! x #f) x) 58)) 34)" "#f\n")
    
    ;; set bvar
    (cons "((lambda (x) ((lambda (y) (set! x 12)) 3)) 5)" "")
    (cons "((lambda (x) ((lambda (y) (set! x 12) x) 3)) 5)" "12\n")
    (cons "((lambda (x) ((lambda (y) ((lambda (z) (set! x '(1 2 3)) x) 3)) 85)) 5)"
	  "(1 . (2 . (3 . ())))\n")
	  
    ;;set fvar
    (cons "(set! x 5) x" "5\n")
    (cons "(begin (set! x 5) (set! y x) y)" "5\n")
    (cons "(begin (set! x 5) (set! y -12/35) y)" "-12/35\n")
    (cons "(begin (set! x 5) (set! x -12/35) x)" "-12/35\n")
    
    ;;;; box-set box-get box test
    (cons "((lambda (x) ((lambda (y) (set! x 12) 2) 3) x) 5)" "12\n")
))



(define primitive-functions-tests
  (list
;     ; car, cdr and combinations
;     (cons "(car '(a b))" "a\n")
;     (cons "(car '(a))" "a\n")
;     (cons "(car '(a b c))" "a\n")
;     (cons "(car (cons 3 4))" "3\n")
    
;     (cons "(cdr '(a b))" "(b . ())\n")
;     (cons "(cdr '(a))" "()\n")
;     (cons "(cdr '(a b c))" "(b . (c . ()))\n")
;     (cons "(cdr (cons 3 4))" "4\n")
;     ;(cons "(caaaar '((((a))) b))" "a\n")
;     ;(cons "(cdadr '((((a))) (((b) c)) (((c))) (((d)))))" "()\n")
;     ;(cons "(cdaadr '((((a))) (((b e) c)) (((c))) (((d)))))" "(c . ())\n")
    
    
;     ;not
    ; (cons "(not (< 4 5))" "#f\n")    
    
    ;apply
 ;    (cons "(apply car '((a)))" "a\n")
 ;    (cons "(apply (lambda (x y z) (list x y z)) '(1 2 3))" "(1 . (2 . (3 . ())))\n")
 ;    (cons "((lambda x ((lambda (y) (apply car x)) 5)) '(1 2 3 4))" "1\n")
 ;    (cons "(apply + '(4 5))" "9\n") 
 ;    (cons "(define min 
	; 	(lambda lst
	; 	  (if (null? (cdr lst)) (car lst)
	; 	    (if (< (car lst) (apply min (cdr lst)))
	; 		  (car lst)
	; 		  (apply min (cdr lst))))))
	;     (apply min '(6 8 3 2 5))" "2\n") 

 ;    (cons "(apply vector '(a b c d e))" "#5(a b c d e)\n")

 ;    (cons "(define first
 ;      (lambda (l)
	; (apply (lambda (x . y) x)
	; 	l)))
 ;    (define rest
 ;      (lambda (l)
	; (apply (lambda (x . y) y) l)))
 ;    (first '(a b c d))" "a\n")

 ;    (cons "(define first
 ;      (lambda (l)
	; (apply (lambda (x . y) x)
	; 	l)))
 ;    (define rest
 ;      (lambda (l)
	; (apply (lambda (x . y) y) l)))
 ;    (rest '(a b c d))" "(b . (c . (d . ())))\n")    
     
    
;     ;map
;     (cons "(map (lambda (x) x) '(1 2 3))" "(1 . (2 . (3 . ())))\n")
;     (cons "(map car '((1) (2) (3)))" "(1 . (2 . (3 . ())))\n")
;     ;(cons "(map caar '(((1)) ((2)) ((3))))" "(1 . (2 . (3 . ())))\n")
;     (cons "(map cdr (list))" "()\n")
;     (cons "(define abs (lambda (x) (if (< x 0) (- x) x)))
; 	  (map abs '(1 -2 3 -4 5 -6))" "(1 . (2 . (3 . (4 . (5 . (6 . ()))))))\n")    
;     ;(cons "(map (lambda (x y) (cons x y)) '(1 2) '(3 4))" "((1 . 3) . ((2 . 4) . ()))\n")
;     ;(cons "(map list '(1 2) '(3 4) '(5 6) '(7 8) '(9 10))" "((1 . (3 . (5 . (7 . (9 . ()))))) . ((2 . (4 . (6 . (8 . (10 . ()))))) . ()))\n")

;     ;append
;     (cons "(append '(a b c) '())" "(a . (b . (c . ())))\n")
;     (cons "(append '() '(a b c))" "(a . (b . (c . ())))\n")
;     (cons "(append '(a b) '(c d))" "(a . (b . (c . (d . ()))))\n")
;     (cons "(append '(a b) 'c)"  "(a . (b . c))\n")
;     (cons "(let ((x (list 'b)))
; 	    (eq? x (cdr (append '(a) x))))" "#t\n")
;     (cons "(append #t)" "#t\n")    
;     (cons "(append '(1 2) '(3 4 5))" "(1 . (2 . (3 . (4 . (5 . ())))))\n")
;     (cons "(append '(1 2) '())" "(1 . (2 . ()))\n")
;     (cons "(append '(1) '(2))" "(1 . (2 . ()))\n")
;     (cons "(append '() '(1 2))" "(1 . (2 . ()))\n")
;     (cons "(append)" "()\n")
;     (cons "(append '(1 2 3) '(4) '(5 6) '(#t a b c) '())" 
; 	  "(1 . (2 . (3 . (4 . (5 . (6 . (#t . (a . (b . (c . ()))))))))))\n")
;     (cons
;       "(define x '(1 2))
;        (define y '(3 4))
;        (define z '(5 6))
;        (define f (append x y z))
;        f" "(1 . (2 . (3 . (4 . (5 . (6 . ()))))))\n")
;     (cons
;       "(define x '(1 2))
;        (define y '(3 4))
;        (define z '(5 6))
;        (define f (append x y z))
;        (set-car! x 'a)
;        f" "(1 . (2 . (3 . (4 . (5 . (6 . ()))))))\n") 
;     (cons
;       "(define x '(1 2))
;        (define y '(3 4))
;        (define z '(5 6))
;        (define f (append x y z))
;        (set-car! x 'a)
;        (set-car! y 'b)
;        f" "(1 . (2 . (3 . (4 . (5 . (6 . ()))))))\n") 
;     (cons
;       "(define x '(1 2))
;        (define y '(3 4))
;        (define z '(5 6))
;        (define f (append x y z))
;        (set-car! x 'a)
;        (set-car! y 'b)
;        (set-car! z 'c)
;        f" "(1 . (2 . (3 . (4 . (c . (6 . ()))))))\n")     
;     (cons "(append '(a b) 'c)" "(a . (b . c))\n")
;     (cons "(append '(1 2) '(3 4))" "(1 . (2 . (3 . (4 . ()))))\n")
;     (cons "(append '(1 2) 3)" "(1 . (2 . 3))\n")
;     (cons "(append '(a b) '(#t #f) 'e)" "(a . (b . (#t . (#f . e))))\n")
;     (cons "(define x '(5)) 
; 	   (define y (append '(a b) '(#t #f) '(1 2 3 4) '(5 6 7) '(8 9 -1/2) x))
; 	   y
; 	   (set-car! x #t)
; 	   y" 
; 	 "(a . (b . (#t . (#f . (1 . (2 . (3 . (4 . (5 . (6 . (7 . (8 . (9 . (-1/2 . (5 . ())))))))))))))))
; (a . (b . (#t . (#f . (1 . (2 . (3 . (4 . (5 . (6 . (7 . (8 . (9 . (-1/2 . (#t . ())))))))))))))))\n")    
	
;     ;make-string = CHECKED
    ; (cons "(make-string 1)" "\"\\000\"\n")
    ; (cons "(make-string 3)" "\"\\000\\000\\000\"\n")    
    ; (cons "(make-string 1 #\\a)" "\"a\"\n")
    ; (cons "(make-string 5 #\\A)" "\"AAAAA\"\n")
    ; (cons "(make-string 0 #\\space)" "\"\"\n")
    ; (cons "(make-string 0)" "\"\"\n")
    ; (cons "(make-string 0 #\\x)" "\"\"\n")
    ; (cons "(make-string 5 #\\x)" "\"xxxxx\"\n")    
    
;     ;make-vector
;     (cons "(make-vector 1 #\\a)" "#1(#\\a)\n")
;     (cons "(make-vector 5 #\\A)" "#5(#\\A #\\A #\\A #\\A #\\A)\n")
;     (cons "(make-vector 0 #\\space)" "#0()\n") 
;     (cons "(make-vector 0 #\\Z)" "#0()\n") 
;     (cons "(make-vector 12 #t)" "#12(#t #t #t #t #t #t #t #t #t #t #t #t)\n")  
;     (cons "(make-vector 4 -6/8)" "#4(-3/4 -3/4 -3/4 -3/4)\n")  
;     (cons "(make-vector 1)" "#1(0)\n")
;     (cons "(make-vector 3)" "#3(0 0 0)\n")
;     (cons "(make-vector 0)" "#0()\n")
;     (cons "(make-vector 0 'a)" "#0()\n")
;     (cons "(make-vector 5 'a)" "#5(a a a a a)\n")
  

;     ;vector?
    ; (cons "(vector? (vector 'a 'b 'c))" "#t\n")

    
;     ;zero?
    ; (cons "(zero? 2/13)" "#f\n")
    ; (cons "(zero? (- 3 3))" "#t\n")
    
    
    ;vector
    ; (cons "(vector)" "#0()\n")
    ; (cons "(vector 1)" "#1(1)\n")
    ; (cons "(vector #\\a #\\A #\\space)" "#3(#\\a #\\A #\\space)\n")
    ; (cons "(vector 1 2 3 #t #f -1/2 \"a\" #\\b)" "#8(1 2 3 #t #f -1/2 \"a\" #\\b)\n")
    ; (cons "(vector 'a 'b 'c)" "#3(a b c)\n")

    
;     ;+ = CHECKED
    ; (cons "(+ 3/2 3/2)" "3\n")
    ; (cons "(+ -3/2 -3/2)" "-3\n")
    ; (cons "(+ 3/2 -3/2)" "0\n")
    ; (cons "(+ 1/2 2)" "5/2\n")
    ; (cons "(+ 1 -1/2)" "1/2\n")
    ; (cons "(+ 1 -1/2 -1/2)" "0\n")
    ; (cons "(+ 11 12 1 2)" "26\n")
    ; (cons "(+ 11 -12)" "-1\n")
    ; (cons "(+ 10/10 -120/110)" "-1/11\n")
    ; (cons "(+ 1 2 3 -1/2 -3/4 -5/6 -7/8 9 12/5)" "1733/120\n")
    ; (cons "(+ (+ 1 2 3) (+ -1/2 -3/4) (+ -5/6 -7/8 9) 12/5)" "1733/120\n")    
    ; (cons "(+)" "0\n")
    ; (cons "(+ -5/6)" "-5/6\n")
    ; (cons "(+ (+ 1 2) 1/3)" "10/3\n")
    ; (cons "(+ 1 2)" "3\n")
    ; (cons "(+ 1/2 2/3)" "7/6\n")
    ; (cons "(+ 3 4 5)" "12\n")
    ; (cons "(apply + '(1 2 3 4 5))" "15\n")
    
;     ;-
;     (cons "(- 5)" "-5\n")
;     (cons "(- 5 6 7)" "-8\n")
;     (cons "(- 5/6 6/7 7/8 9)" "-1663/168\n")
;     (cons "(- (- 5/6 6/7) (- 7/8 9))" "1361/168\n")
;     (cons "(- 3)" "-3\n")
;     (cons "(- 0 3)" "-3\n")
;     (cons "(- -2/3)" "2/3\n")
;     (cons "(- 4 3)" "1\n")
    ; (cons "(- 4 3 2 1)" "-2\n")
;     (cons "(apply - '(-1 -2 -3 -4 -5))" "13\n")    
    
;     ;*
    ; (cons "(*)" "1\n")
;     (cons "(* -2/3)" "-2/3\n")
;     (cons "(* -2/3 5/6 1 2 3)" "-10/3\n")
;     (cons "(* -2/3 5/6 1 2 3 0)" "0\n")
;     (cons "(* 3/4)" "3/4\n")
;     (cons "(* 1 1/2)" "1/2\n")
;     (cons "(* 3 4 11/2)" "66\n")
;     (cons "(* 3 (* 4 11/2))" "66\n")
;     (cons "(* 3 (* 4 -11/2))" "-66\n")
    ; (cons "(* 3 2 2)" "12\n")
    ; (cons "(apply * '(1 2 3 4 5))" "120\n")    
    
;     ;/
    (cons "(/ 2)" "1/2\n")
;     (cons "(/ -2)" "-1/2\n")
;     (cons "(/ -2/3)" "-3/2\n")
;     (cons "(/ -2/4)" "-2\n")
    (cons "(/ 1 2 3)" "1/6\n")
;     (cons "(/ -2/3 4/5 1 2 12/13)" "-65/144\n")
;     (cons "(/ -2/3 4/5 1 2 -12/13)" "65/144\n")
;     (cons "(/ 1/2 1/4)" "2\n")
;     (cons "(/ 1/2 -1/4)" "-2\n")
;     (cons "(/ -1/2 1/4)" "-2\n")
;     (cons "(/ -1/2 -1/4)" "2\n")
;     (cons "(/ -17)" "-1/17\n")
    (cons "(/ 1/2)" "2\n")
    (cons "(/ 3 4)" "3/4\n")    
    ; (cons "(/ 60 5 4 3 2)" "1/2\n")
;     (cons "(apply / '(60 5 4 3 2))" "1/2\n")
    
;     ;>
;     (cons "(> 0)" "#t\n")
;     (cons "(> 100)" "#t\n")
;     (cons "(> 2/3)" "#t\n")
;     (cons "(> 2 -1)" "#t\n")
;     (cons "(> 2 -1 -1/2)" "#f\n")
;     (cons "(> 2 -1 1/2)" "#f\n")
;     (cons "(> 5 4 2 3)" "#f\n")
;     (cons "(> 5 4 3 2 5/4 1 1/2 0 -1/2 -1)" "#t\n")
;     (cons "(> 3/4 1/2)" "#t\n")
;     (cons "(> 5/4 1)" "#t\n")
;     (cons "(> 1 5/4)" "#f\n")
;     (cons "(> 2 5/4)" "#t\n")
;     (cons "(> 1 2 2 3 3 4)" "#f\n")
;     (cons "(apply > '(4 3 3 2))" "#f\n")
    
;     ;<
;     (cons "(< -1/2)" "#t\n")
;     (cons "(< 1 -1/2)" "#f\n")
;     (cons "(< -1 -1/2)" "#t\n")
;     (cons "(< -1 -1/2 -2)" "#f\n")
;     (cons "(< 1/2 3/4)" "#t\n")
;     (cons "(< 3/4 1/2)" "#f\n")
;     (cons "(< -1 -1/2 0 1 3/2 2 5/2 3 7/2 4 100)" "#t\n")
;     (cons "(< -5 -4 -3/2 0 1 2 3 4 9/2 10/2 11/2 12/2 13/2 12)" "#t\n")
;     (cons "(< -5 -4 -3/2 0 1 2 3 4 9/2 10/2 11/2 12/2 13/2 -1/2 12)" "#f\n")
;     (cons "(< -1 -1/2 0 1 3/2 2 5/2 3 7/2 -5 100)" "#f\n")
;     (cons "(< 1 -1/2 0 1 3/2 2 5/2 3 7/2 -5 100)" "#f\n")
;     (cons "(< 1/2 2/3 3/4)" "#t\n")
;     (cons "(apply < '(1 2 3 4))" "#t\n")
    
;     ;=
    ; (cons "(apply = (list 1 1 1 1 1 1 1 2/2 -4/4 1 1))" "#f\n")

      
	
;     ;vector-set!
    ; (cons "(let ((v (vector 'a 'b 'c 'd 'e)))
    ;   (vector-set! v 2 'x)
    ;   v)" "#5(a b x d e)\n")	    
	  
    
;     ;symbol->string
    ; (cons "(symbol->string 'AbC)" "\"abc\"\n") 

))


(define internal-helper-procedures-tests
  (list
    ;one-list-map
    (cons "(asaf-lior-one-list-map (lambda (x) x) '(1 2 3))" "(1 . (2 . (3 . ())))\n")
    (cons "(asaf-lior-one-list-map car '((1) (2) (3)))" "(1 . (2 . (3 . ())))\n")
    ;(cons "(asaf-lior-one-list-map caar '(((1)) ((2)) ((3))))" "(1 . (2 . (3 . ())))\n")
    (cons "(asaf-lior-one-list-map cdr (list))" "()\n")
    
    ;foldr
    (cons "(asaf-lior-foldr cons '() '(1 2 3))" "(1 . (2 . (3 . ())))\n")
    
    ;binary-append
    ;(cons "(binary-append '(1 2) '(3 4 5))" "(1 . (2 . (3 . (4 . (5 . ())))))\n")
    ;(cons "(binary-append '(1 2) '())" "(1 . (2 . ()))\n")
    ;(cons "(binary-append '(1) '(2))" "(1 . (2 . ()))\n")
    ;(cons "(binary-append '() '(1 2))" "(1 . (2 . ()))\n")
    
    ;list-to-vector - helper procedure
    (cons "(asaf-lior-list-to-vector '())" "#0()\n")
    (cons "(asaf-lior-list-to-vector '(1))" "#1(1)\n")
    (cons "(asaf-lior-list-to-vector (list 1 2 3 #t #f -1/2 \"a\" #\\b))" "#8(1 2 3 #t #f -1/2 \"a\" #\\b)\n")
   
    
    ;box-get box-set box
;;     (cons "((lambda (x) (box-get x)) (box 5))" "5\n")
;;     (cons "((lambda (y) ((lambda (x) (box-get y)) 5)) (box '(a b c)))" "(a . (b . (c . ())))\n")
;;     (cons "((lambda (y) ((lambda (x) (begin (box-set y 12) (box-get y))) 5)) (box '(a b c)))" "12\n")
;;     (cons "((lambda (x) (begin (box-set x \"AbC\") (box-get x))) (box 5))" "\"AbC\"\n")
;;     (cons "((lambda (y) ((lambda (x) (set! x (box x)) (box-get x)) 1)) (box '(a b c)))" "1\n")
;;     (cons
;; 	  "(define *example*
;; 	    (let ((a 0))
;; 	      (begin (lambda () a)
;; 	      (lambda () (set! a (+ a 1)))
;; 	      ((lambda (b) (set! a b) a) a)))) *example*" "0\n")
	      
    ;+
    (cons "(asaf-lior-reduce-num 10/2)" "5\n")
    (cons "(asaf-lior-binary-int-frac-plus 3 5/3)" "14/3\n")
    (cons "(asaf-lior-binary-int-int-plus 3 24)" "27\n")
    (cons "(asaf-lior-binary-frac-frac-plus 3/2 3/2)" "12/4\n")
    (cons "(asaf-lior-binary-frac-frac-plus -3/2 -3/2)" "-12/4\n") 
    (cons "(asaf-lior-reduce-num 1/2)" "1/2\n")
    (cons "(asaf-lior-opposite-num 1)" "-1\n")
    (cons "(asaf-lior-opposite-num 1/2)" "-1/2\n")
    
    ;*
    (cons "(asaf-lior-binary-int-int-mul 1 2)" "2\n")
    (cons "(asaf-lior-binary-int-int-mul -3 12)" "-36\n")
    (cons "(asaf-lior-binary-int-int-mul 5 0)" "0\n")
    (cons "(asaf-lior-binary-int-frac-mul 2 1/2)" "2/2\n")
    (cons "(asaf-lior-reduce-num (asaf-lior-binary-int-frac-mul 2 1/2))" "1\n")
    (cons "(asaf-lior-reduce-num (asaf-lior-binary-int-frac-mul 12 4/6))" "8\n")
    (cons "(asaf-lior-reduce-num (asaf-lior-binary-int-frac-mul 5 2/4))" "5/2\n")
    (cons "(asaf-lior-binary-frac-frac-mul 1/3 3/2)" "3/6\n")
    (cons "(asaf-lior-reduce-num (asaf-lior-binary-frac-frac-mul 1/3 3/2))" "1/2\n")
    (cons "(asaf-lior-reduce-num (asaf-lior-binary-frac-frac-mul -2/3 3/2))" "-1\n")
    
    (cons "(asaf-lior-inverse-num -2)" "-1/2\n")
    (cons "(asaf-lior-inverse-num 2/3)" "3/2\n")
    (cons "(asaf-lior-inverse-num -2/3)" "-3/2\n")
    
    (cons "(asaf-lior-greater-than-int-int 1 2)" "#f\n")
    (cons "(asaf-lior-greater-than-int-int 3 -2)" "#t\n")
    
    (cons "(asaf-lior-binary-gt 2 -1)" "#t\n")
    (cons "(asaf-lior-binary-gt 3/4 1/2)" "#t\n")
    (cons "(asaf-lior-binary-gt 5/4 1)" "#t\n")
    (cons "(asaf-lior-binary-gt 1 5/4)" "#f\n")
    (cons "(asaf-lior-binary-gt 2 5/4)" "#t\n")
    
    (cons "(asaf-lior-binary-lt 1 2)" "#t\n")
    (cons "(asaf-lior-binary-lt 1 -1/2)" "#f\n")
    (cons "(asaf-lior-binary-lt -1 -1/2)" "#t\n")
    (cons "(asaf-lior-binary-lt -1/2 -3/4)" "#f\n")
    (cons "(asaf-lior-binary-lt 1/2 3/4)" "#t\n")
    (cons "(asaf-lior-binary-lt 3/4 1/2)" "#f\n")
    
    (cons "(asaf-lior-binary-eq 1 1)" "#t\n")
    (cons "(asaf-lior-binary-eq 1 2)" "#f\n")
    (cons "(asaf-lior-binary-eq 1/2 1/4)" "#f\n")
    (cons "(asaf-lior-binary-eq 1/2 2/4)" "#t\n")
    (cons "(asaf-lior-binary-eq 2 4/2)" "#t\n")
    (cons "(asaf-lior-binary-eq -1 -1)" "#t\n")
    
    ;(cons "(string-equal \"a\" \"a\")" "#t\n")
    ;(cons "(string-equal \"aa\" (make-string 3 #\\a))" "#f\n")
    ;(cons "(string-equal \"abc\" \"abd\")" "#f\n")
    ;(cons "(string-equal \"aaa\" (make-string 3 #\\a))" "#t\n")
    ;(cons "(string-equal \"aaa\" (make-string 3 #\\A))" "#f\n")
    ;(cons "(string-equal \"aab\" (make-string 3 #\\a))" "#f\n")
    ;(cons "(begin 'abc (string-equal \"abc\" (symbol->string 'abc)))" "#t\n")    
))

;;; Tests list for debugging purposes
(define tests
  (list   
))    


(display (format "\033[1mComp171 - Compiler Tests\033[0m\n================================\n"))

(runAllTests
  (list      
      ; (cons "Set" set-tests)
      (cons "Primitive Functions" primitive-functions-tests)
      ;(cons "Internal Helper Procedures" internal-helper-procedures-tests)
      ;(cons "Debugging" tests)  
      
))
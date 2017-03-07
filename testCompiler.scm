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
    (compile-scheme-file "outFile.scm" "outFile.c")
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
    (compile-scheme-file "outFile.scm" "outFile.c")
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

(define constants-table-tests
  (list
  
    ;;Numbers
    (cons "0" "0\n")
    (cons "1" "1\n")
    (cons "5" "5\n")
    (cons "-10" "-10\n")
    
    ;;Fractions
    (cons "2/4" "1/2\n")
    (cons "-3/5 " "-3/5\n")
    
    ;;Strings
    (cons "\"123abc\"" "\"123abc\"\n")
    (cons "\"AbCDeFGHiJKLMNOPQRSTUVWXYZ01234567891011121314151617181920\"" 
	  "\"AbCDeFGHiJKLMNOPQRSTUVWXYZ01234567891011121314151617181920\"\n")
    (cons "\"aA\"" "\"aA\"\n")
    (cons "\"\"" "\"\"\n")
    
    ;;Sybmols
    (cons "'a" "a\n")
    (cons "'AsAF" "asaf\n")
    (cons "'this-is-a-symbol12345" "this-is-a-symbol12345\n")
    
    ;;Boolean
    (cons "#t" "#t\n")
    (cons "#f" "#f\n")
    
    ;;Chars
    (cons "#\\a" "#\\a\n")
    (cons "#\\space" "#\\space\n")
    (cons "#\\newline" "#\\newline\n")

    ;;Lists
    (cons "'()" "()\n") 
    (cons "'(1 2 3)" "(1 . (2 . (3 . ())))\n")
    (cons "'(1 2 3 a)" "(1 . (2 . (3 . (a . ()))))\n")
    
    ;;Vectors
    (cons "'#()" "#0()\n") 
    (cons "'#(1 2 3)" "#3(1 2 3)\n")
    (cons "'#(1 2 3 a b c)" "#6(1 2 3 a b c)\n")
    (cons "'#(1 (1 2 3) #t #f)" "#4(1 (1 . (2 . (3 . ()))) #t #f)\n")
    (cons "'#((1 2) 3 4 #t #f -8/17 #(5 6))" "#7((1 . (2 . ())) 3 4 #t #f -8/17 #2(5 6))\n")
    (cons "'#(#(1))" "#1(#1(1))\n") 
    (cons "'#(#(5 6))" "#1(#2(5 6))\n")
    
    ;Quasi-Quote
    (cons "(define x 5) `(,x)" "(5 . ())\n")
    (cons "(define x 5) `(,@x)" "5\n")
    (cons "(quasiquote (1 2 (unquote (+ 3 4))))" "(1 . (2 . (7 . ())))\n")
))

(define or-if-begin-tests
(list
    (cons "(or)" "#f\n")
    (cons "(or #t)" "#t\n")
    (cons "(or #f)" "#f\n")
    (cons "(or (or #f #f) (or #t))" "#t\n")
    (cons "(or (or #f #f) (or 0))" "0\n")
    
    (cons "(or #f #f)" "#f\n")
    (cons "(or #f #t)" "#t\n")
    (cons "(if #t 1 0)" "1\n")
    
    ;;Nested If
    (cons "(if #t (if #t (if #t (if #t (if #t
	    (if #t (if #t (if #t (if #t 
	    (if #t (if #t (if #t (if #t (if #t #t #f) #f) #f) #f) #f) #f) #f) #f) #f) 
	    #f) #f ) #f) #f) #f)" "#t\n")
    
    
    (cons "(if #f 1 0)" "0\n")
    (cons "(or 25 #t #f 1 2 3 #f)" "25\n")
    (cons "(and 25 #t #f 1 2 3 #f)" "#f\n")
    
    (cons "(begin (or #t #t) (or #f))" "#f\n")
    (cons "(begin #\\a)" "#\\a\n")
    (cons "(begin (or #t #t) (or #f) (begin 1 2 3 45 \"Its a String\"))" "\"Its a String\"\n")
))

(define lambda-simple-tests
  (list
    (cons "((lambda () 1))" "1\n")
    (cons "((lambda () #t))" "#t\n")
    (cons "((lambda () -1/2))" "-1/2\n")
    (cons "((lambda () '(1 2 3 4 5 6)))" "(1 . (2 . (3 . (4 . (5 . (6 . ()))))))\n")
    (cons "((lambda () '#(1 2 3)))" "#3(1 2 3)\n")
    (cons "((lambda () \"abCdE123\"))" "\"abCdE123\"\n")
    (cons "((lambda (x) x) 5)" "5\n")
    (cons "((lambda (a) a) #t)" "#t\n")
    (cons "((lambda (x y) x) 5 6)" "5\n")
    (cons "((lambda (x y) y) 5 6)" "6\n")
    (cons "((lambda (x y) '(4 5)) 5 6)" "(4 . (5 . ()))\n")
    (cons "((lambda (x y z) z) 5 6 #t)" "#t\n")
    (cons "((lambda (x y z) z) 5 6 #f)" "#f\n")
    (cons "((lambda (x y z) x y z) 5 6 #f)" "#f\n")
    (cons "((lambda (x y z) (if x y z)) 5 6 #f)" "6\n")
    (cons "((lambda (x y z) (or x y z)) \"AbC1234567890\" 6 #f)" "\"AbC1234567890\"\n")
    (cons "((lambda (x y z) (if x y z)) #f -8/17 '#((1 2) 3 4 #(5 6)))" "#4((1 . (2 . ())) 3 4 #2(5 6))\n")
    
    ;;Nested Lambdas
    (cons "((lambda () ((lambda () 5))))" "5\n")
    (cons "((lambda (x) ((lambda () x))) -24)" "-24\n")
    (cons "((lambda (x y z) 
	      ((lambda () z))) 10 12 -24/36)" "-2/3\n")
    (cons "((lambda (x y z) 
	      ((lambda () x))) 10 12 -24/36)" "10\n")
    (cons "((lambda (x y z) 
	      ((lambda () y))) 10 '#(1 2) -24/36)" "#2(1 2)\n")
    (cons "((lambda () 
	      ((lambda (a) a) #t)))" "#t\n")		      
    (cons "((lambda (x y z) 
	      ((lambda (a) a) #t)) 10 '#(1 2) -24/36)" "#t\n")	
    (cons "((lambda (x y z) 
	      ((lambda (y) y) #f)) 10 '#(1 2) -24/36)" "#f\n")

    (cons "((lambda (x y z) ((lambda (a) x) 5)) 1 2 3)" "1\n")	      
    (cons "((lambda (x y z) ((lambda (a) y) 5)) 1 2 3)" "2\n")
    (cons "((lambda (x y z) ((lambda (a) z) 5)) 1 2 3)" "3\n")    
	      
    ;; Parameters and Bound Variables	      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      z) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
			  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "5\n")
    
    
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      y) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
			  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "4\n") 
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      x) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
			  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "3\n")       
	
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      w) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
			  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "2\n")  
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      v) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
			  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "1\n") 
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      u) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
			  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "0\n")      

    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      t) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
			  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "9\n")   
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      s) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
			  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "8\n")  
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      r) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "7\n")  

    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      q) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "6\n") 
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      p) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "#\\z\n")  
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      o) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "#1(1)\n")  
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      n) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "()\n")          
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      m) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "#f\n")   
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      l) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "#t\n")    
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      k) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "\"Matata\"\n") 
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      j) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "\"Akuna\"\n") 
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      i) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "\"BCD\"\n") 
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      h) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "\"A\"\n")   
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      g) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "#\\g\n")  
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      f) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "#\\f\n")   
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      e) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "#\\e\n") 
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      d) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "#\\d\n")       
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      c) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "#\\c\n")   
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      b) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "#\\b\n") 
      
    (cons
      "((lambda (a b c d e f g) 
	      ((lambda (h i j k)
		((lambda (l m n o p)
		  ((lambda (q r s t u)
		    ((lambda (v w x y z)
		      a) 1 2 3 4 5))
			6 7 8 9 0)) #t #f '() '#(1) #\\z))
		  \"A\" \"BCD\" \"Akuna\" \"Matata\")) #\\a #\\b #\\c #\\d #\\e #\\f #\\g)"
      "#\\a\n") 
      
      ;; Mayer Comp161 Lambda Simple Torture Test
      (cons "(((((lambda (a)
	(lambda (b)
	  (((lambda (a) (lambda (b) ((a b) (lambda (x) (lambda (y) y)))))
	    ((lambda (n)
	      ((n (lambda (x) (lambda (x) (lambda (y) y))))
		(lambda (x) (lambda (y) x))))
	    (((lambda (a)
		(lambda (b)
		  ((b (lambda (n)
			((lambda (p) (p (lambda (a) (lambda (b) b))))
			  ((n (lambda (p)
				(((lambda (a)
				    (lambda (b) (lambda (c) ((c a) b))))
				  ((lambda (n)
				    (lambda (s)
				      (lambda (z) (s ((n s) z)))))
				  ((lambda (p)
				      (p (lambda (a) (lambda (b) a))))
				    p)))
				((lambda (p)
				    (p (lambda (a) (lambda (b) a))))
				  p))))
			  (((lambda (a)
			      (lambda (b) (lambda (c) ((c a) b))))
			    (lambda (x) (lambda (y) y)))
			    (lambda (x) (lambda (y) y)))))))
		    a)))
	      a)
	      b)))
	  ((lambda (n)
	      ((n (lambda (x) (lambda (x) (lambda (y) y))))
	      (lambda (x) (lambda (y) x))))
	    (((lambda (a)
		(lambda (b)
		  ((b (lambda (n)
			((lambda (p) (p (lambda (a) (lambda (b) b))))
			((n (lambda (p)
			      (((lambda (a)
				  (lambda (b) (lambda (c) ((c a) b))))
				((lambda (n)
				    (lambda (s)
				      (lambda (z) (s ((n s) z)))))
				  ((lambda (p)
				    (p (lambda (a) (lambda (b) a))))
				  p)))
				((lambda (p)
				  (p (lambda (a) (lambda (b) a))))
				p))))
			  (((lambda (a)
			      (lambda (b) (lambda (c) ((c a) b))))
			    (lambda (x) (lambda (y) y)))
			  (lambda (x) (lambda (y) y)))))))
		  a)))
	      b)
	    a)))))
      ((lambda (n)
	((lambda (p) (p (lambda (a) (lambda (b) b))))
	  ((n (lambda (p)
		(((lambda (a) (lambda (b) (lambda (c) ((c a) b))))
		  ((lambda (n) (lambda (s) (lambda (z) (s ((n s) z)))))
		  ((lambda (p) (p (lambda (a) (lambda (b) a)))) p)))
		(((lambda (a)
		    (lambda (b)
		      ((b (a (lambda (a)
				(lambda (b)
				  ((a (lambda (n)
					(lambda (s)
					  (lambda (z) (s ((n s) z))))))
				  b)))))
			(lambda (x) (lambda (y) y)))))
		  ((lambda (p) (p (lambda (a) (lambda (b) a)))) p))
		  ((lambda (p) (p (lambda (a) (lambda (b) b)))) p)))))
	  (((lambda (a) (lambda (b) (lambda (c) ((c a) b))))
	    (lambda (x) x))
	    (lambda (x) x)))))
      (lambda (x) (lambda (y) (x (x (x (x (x y)))))))))
    (((lambda (a)
	(lambda (b)
	  ((b (a (lambda (a)
		    (lambda (b)
		      ((a (lambda (n)
			    (lambda (s) (lambda (z) (s ((n s) z))))))
		      b)))))
	    (lambda (x) (lambda (y) y)))))
      (((lambda (a)
	  (lambda (b)
	    ((b (a (lambda (a)
		      (lambda (b)
			((a (lambda (n)
			      (lambda (s) (lambda (z) (s ((n s) z))))))
			b)))))
	      (lambda (x) (lambda (y) y)))))
	((lambda (x) (lambda (y) (x (x (x y)))))
	  (lambda (x) (lambda (y) (x (x y))))))
	(lambda (x) (lambda (y) (x (x (x y)))))))
      (lambda (x) (lambda (y) (x (x (x (x (x y)))))))))
    #t)
  #f)" "#t\n")
))

(define lambda-opt-tests
  (list
    (cons "((lambda (x . y) y) 1 2)" "(2 . ())\n")
    (cons "((lambda (x . y) y) 1 2 3 4 5 6)" "(2 . (3 . (4 . (5 . (6 . ())))))\n")
    (cons "((lambda (x y . z) x) 1 2)" "1\n")
    (cons "((lambda (x y . z) y) 1 2)" "2\n")
    (cons "((lambda (x y . z) z) 1 2)" "()\n")
    (cons "((lambda (x y . z) z) 1 2 3)" "(3 . ())\n")
    (cons "((lambda (x y . z) z) 1 2 3 4 5 6 7 #t)" "(3 . (4 . (5 . (6 . (7 . (#t . ()))))))\n")
    (cons "((lambda (a b . c) c) 1 2 -3/4 5/6)" "(-3/4 . (5/6 . ()))\n")
    (cons "((lambda (x) ((lambda (a b . c) c) 1 2 -3/4 5/6)) 12)" "(-3/4 . (5/6 . ()))\n")
    (cons "((lambda (x y . z) ((lambda (a b . c) z) 1 2 -3/4 5/6)) 12 13 14)" "(14 . ())\n")
    (cons "((lambda (x y . z) 
	      ((lambda (a b . c) z) 1 2 -3/4 5/6)) 12 13)" "()\n")
    (cons "((lambda (x y . z) 
	      ((lambda (a b . c) ((lambda (d e f . g) g) 1 2 3)) 1 2 -3/4 5/6)) 12 13)" "()\n")	 
    (cons "((lambda (x y . z) 
	      ((lambda (a b . c) ((lambda (d e f . g) g) 1 2 3 4 5 6 7 8 9 0)) 1 2 -3/4 5/6)) 12 13)" 
	  "(4 . (5 . (6 . (7 . (8 . (9 . (0 . ())))))))\n")		      		      

))

(define lambda-var-tests
  (list
    (cons "((lambda x x) 1 #t #f 2 3)" "(1 . (#t . (#f . (2 . (3 . ())))))\n")
    (cons "((lambda x x) 1)" "(1 . ())\n")
    (cons "((lambda x x))" "()\n")
    (cons "((lambda x ((lambda y x))))" "()\n")
    (cons "((lambda x ((lambda y y))))" "()\n")
    (cons "((lambda x ((lambda y y))) 1 2 3 4 5 #\\a 7 8 9 0 100)" "()\n")
    (cons "((lambda x ((lambda y x))) 1 2 3 4 5 '#(1 2 3))" 
	  "(1 . (2 . (3 . (4 . (5 . (#3(1 2 3) . ()))))))\n")
    (cons "((lambda x ((lambda y y) #t #f \"AbC123\")) 1 2 3 4 5 '#(1 2 3))" 
	  "(#t . (#f . (\"AbC123\" . ())))\n")

    ;; Lambda-var in Lambda-simple
    (cons "((lambda (a) ((lambda x x))) -12/36)" "()\n")
    (cons "((lambda (a) ((lambda x x) \"Akuna\")) -12/36)" "(\"Akuna\" . ())\n")
    (cons "((lambda (a) ((lambda x x) \"Akuna\" \"Matata\")) -12/36)" 
	  "(\"Akuna\" . (\"Matata\" . ()))\n")
    (cons "((lambda (a) ((lambda x a) \"Akuna\" \"Matata\")) -12/36)" 
	  "-1/3\n")
    (cons "(((lambda (z) (lambda x x)) 2) 1)" 
      "(1 . ())\n")
	  
    ;; Lambda-var in Lambda-opt
    (cons "((lambda (a . b) ((lambda x x))) -12/36)" "()\n")
    (cons "((lambda (a . b) ((lambda x x) \"Akuna\")) -12/36 98)" "(\"Akuna\" . ())\n")
    (cons "((lambda (a b . c) ((lambda x x) \"Akuna\" \"Matata\")) -12/36 #t)" 
	  "(\"Akuna\" . (\"Matata\" . ()))\n")
    (cons "((lambda (a b c . d) ((lambda x a) \"Akuna\" \"Matata\")) -12/36 #\\a '#())" 
	  "-1/3\n")
    (cons "((lambda (a b c . d) ((lambda x d) \"Akuna\" \"Matata\")) -12/36 #\\a '#())" 
	  "()\n")
	  
    (cons "((lambda x x) 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
			  '#(1 2 3 4 5 6 7 8 9 #t #f)
			  '(1 2 3 4 5 6 7 8 9 -12/35))" 
			  "(1 . (2 . (3 . (4 . (5 . (6 . (7 . (8 . (9 . (10 . (11 . (12 . (13 . (14 . (15 . (16 . (17 . (18 . (19 . (20 . (#11(1 2 3 4 5 6 7 8 9 #t #f) . ((1 . (2 . (3 . (4 . (5 . (6 . (7 . (8 . (9 . (-12/35 . ())))))))))) . ()))))))))))))))))))))))\n")

    (cons "(let ()
  ((lambda s
     (let ()
       ((lambda s s) s s s)))
   #t))" "((#t . ()) . ((#t . ()) . ((#t . ()) . ())))\n")

))

(define comp161-torture-test-for-compiler-unsorted
  (list
    (cons "(let ((x #f))
	    (let () x))" "#f\n")
	    
    (cons "(let ((x #f) (y #t))
  (let ((x #f))
    (let ((x #f) (z #f) (t #f))
      (let ((x #f) (t #f))
	y))))" "#t\n")

  (cons "((((lambda (x)
     (lambda (y)
       y))
   (lambda (p)
     (p (lambda (x y)
	  (lambda (p)
	    (p y x))))))
  (lambda (z) (z #t #f)))
 (lambda (x y) x))" "#t\n")
 
 (cons "((((lambda (x)
     (lambda (y)
       (x y)))
   (lambda (p)
     (p (lambda (x y)
	  (lambda (p)
	    (p y x))))))
  (lambda (z) (z #t #f)))
 (lambda (x y) x))" "#f\n")
 
 (cons "((((lambda (x)
     (lambda (y)
       (x (x y))))
   (lambda (p)
     (p (lambda (x y)
	  (lambda (p)
	    (p y x))))))
  (lambda (z) (z #t #f)))
 (lambda (x y) x))" "#t\n")
 
 (cons "(((((lambda (x) ((x x) (x x)))
    (lambda (x)
      (lambda (y)
	(x (x y)))))
   (lambda (p)
     (p (lambda (x y)
	  (lambda (p)
	    (p y x))))))
  (lambda (z) (z #t #f)))
 (lambda (x y) x))" "#t\n")
 
))

(define tc-applic-tests
  (list
    (cons "((lambda (x) ((lambda (y) y) 5)) 6)" "5\n")
    (cons "((lambda (x) ((lambda (y) ((lambda (z) z) 1)) 5)) 6)" "1\n")
    (cons "((lambda (x) ((lambda (y) ((lambda (z) y) 1)) 5)) 6)" "5\n")
    (cons "((lambda (x) ((lambda (y) ((lambda (z) x) 1)) 5)) 6)" "6\n")
    (cons "((lambda (x) 
	    (if x ((lambda (z) z) 1) ((lambda (y . z) z) 1 2))) #f)" 
	  "(2 . ())\n")
    (cons "((lambda (x) 
	(or x ((lambda (z) z) 1) ((lambda (y . z) z) 1 2))) #f)" 
      "1\n")
    (cons "((lambda (x) 
	(begin x ((lambda (z) z) 1) ((lambda (y . z) z) 1 2))) #f)" 
      "(2 . ())\n")
    (cons "((lambda (x) 
	((lambda (z) z) 1) ((lambda (y . z) ((lambda x x))) 1 2)) #f)" 
      "()\n")
))

(define set-tests
  (list
    ;; set pvar
    (cons "((lambda (x) (set! x 1)))" "")
    (cons "((lambda (x) (set! x 12) x) 5)" "12\n")
    (cons "((lambda (x y . z) (set! z #t) z) 5 9 34)" "#t\n")
    (cons "((lambda (x y . z) (set! y '(1 2 3 4 5)) y) 5 9)" 
	  "(1 . (2 . (3 . (4 . (5 . ())))))\n")
    (cons "((lambda x (set! x '#(1 2 3)) x) 5 6 7)" "#3(1 2 3)\n")
    (cons "((lambda (x . y) ((lambda (x) y x (set! x #f) x) 58)) 34)" "#f\n")
    
    ; set bvar
    (cons "((lambda (x) ((lambda (y) (set! x 12)) 3)) 5)" "")
    (cons "((lambda (x) ((lambda (y) (set! x 12) x) 3)) 5)" "12\n")
    (cons "((lambda (x) ((lambda (y) ((lambda (z) (set! x '(1 2 3)) x) 3)) 85)) 5)"
	  "(1 . (2 . (3 . ())))\n")
	  
    ; set fvar
    (cons "(set! x 5) x" "5\n")
    (cons "(begin (set! x 5) (set! y x) y)" "5\n")
    (cons "(begin (set! x 5) (set! y -12/35) y)" "-12/35\n")
    (cons "(begin (set! x 5) (set! x -12/35) x)" "-12/35\n")
    
    ;;; box-set box-get box test
    (cons "((lambda (x) ((lambda (y) (set! x 12) 2) 3) x) 5)" "12\n")
))

(define pvar-bvar-tests
  (list
    ;; pvar
    (cons "((lambda (x) x) 5)" "5\n")
    (cons "((lambda (x y z) y) 5 6 7)" "6\n")
    (cons "((lambda (x y z) z) 5 6 7)" "7\n")
    (cons "((lambda x x) 5 6 7)" "(5 . (6 . (7 . ())))\n")
    (cons "((lambda (x . y) y) 5 6 7)" "(6 . (7 . ()))\n")
    (cons "((lambda (x . y) x) 5 6 7)" "5\n")

    ;; bvar
    (cons "((lambda (x) ((lambda (y) x) 12)) 5)" "5\n")
    (cons "((lambda (x y z) ((lambda (z) y) 12)) 5 6 7)" "6\n")
    (cons "((lambda (x y z) ((lambda (y) z) 12)) 5 6 7)" "7\n")
    (cons "((lambda x ((lambda (y) x) 12)) 5 6 7)" "(5 . (6 . (7 . ())))\n")
    (cons "((lambda (x . y) ((lambda (z . a) y) 12 13)) 5 6 7)" "(6 . (7 . ()))\n")
    (cons "((lambda (x . y) ((lambda y x) 12)) 5 6 7)" "5\n")    
))

(define define-tests
  (list
    (cons "(define x 5) x" "5\n")
    (cons "(define x 5) (define b 6) x" "5\n")
    (cons "(define x 5) (define b 6) b" "6\n")
    (cons "(define x (lambda (x y) y)) (x 1 2)" "2\n")
    (cons "(define x (lambda (x y) x)) (x 1 2)" "1\n")
    (cons "(define not (lambda (x) (if x #f #t))) (not 1)" "#f\n")
    (cons "(define not (lambda (x) (if x #f #t))) (not #f)" "#t\n")
))

(define primitive-functions-tests
  (list
    
    ; list
    ; (cons "(list (if #f #f))" "(#<void> . ())\n")
    ; (cons "(list 'a 1 'b (if #f #f))" "(a . (1 . (b . (#<void> . ()))))\n")

    
        

    	; (cons "(define tail_test (lambda (n1) ((lambda (n2 n3) (+ n1 n3)) 10 15)))" "17\n")

;     ;map
    	; (cons "(map (lambda (x) x) '(1 2 3))" "(1 . (2 . (3 . ())))\n")
   ;  (cons "(map car '((1) (2) (3)))" "(1 . (2 . (3 . ())))\n")
   ;  (cons "(map caar '(((1)) ((2)) ((3))))" "(1 . (2 . (3 . ())))\n")
   ;  (cons "(map cdr (list))" "()\n")
   ;  (cons "(define abs (lambda (x) (if (< x 0) (- x) x)))
	  ; (map abs '(1 -2 3 -4 5 -6))" "(1 . (2 . (3 . (4 . (5 . (6 . ()))))))\n")    
   ;  (cons "(map (lambda (x y) (cons x y)) '(1 2) '(3 4))" "((1 . 3) . ((2 . 4) . ()))\n")
   ;  (cons "(map list '(1 2) '(3 4) '(5 6) '(7 8) '(9 10))" "((1 . (3 . (5 . (7 . (9 . ()))))) . ((2 . (4 . (6 . (8 . (10 . ()))))) . ()))\n")
   
   

;     ;append
    (cons "(append '(a b c) '())" "(a . (b . (c . ())))\n")
    ; (cons "(append '() '(a b c))" "(a . (b . (c . ())))\n")
    (cons "(append '(a b) '(c d))" "(a . (b . (c . (d . ()))))\n")
    (cons "(append '(a b) 'c)"  "(a . (b . c))\n")
    (cons "(let ((x (list 'b)))
	    (eq? x (cdr (append '(a) x))))" "#t\n")
    (cons "(append #t)" "#t\n")    
    (cons "(append '(1 2) '(3 4 5))" "(1 . (2 . (3 . (4 . (5 . ())))))\n")
    (cons "(append '(1 2) '())" "(1 . (2 . ()))\n")
    (cons "(append '(1) '(2))" "(1 . (2 . ()))\n")
    (cons "(append '() '(1 2))" "(1 . (2 . ()))\n")
    (cons "(append)" "()\n")
    (cons "(append '(1 2 3) '(4) '(5 6) '(#t a b c) '())" 
	  "(1 . (2 . (3 . (4 . (5 . (6 . (#t . (a . (b . (c . ()))))))))))\n")
    (cons
      "(define x '(1 2))
       (define y '(3 4))
       (define z '(5 6))
       (define f (append x y z))
       f" "(1 . (2 . (3 . (4 . (5 . (6 . ()))))))\n")
    (cons
      "(define x '(1 2))
       (define y '(3 4))
       (define z '(5 6))
       (define f (append x y z))
       (set-car! x 'a)
       f" "(1 . (2 . (3 . (4 . (5 . (6 . ()))))))\n") 
    (cons
      "(define x '(1 2))
       (define y '(3 4))
       (define z '(5 6))
       (define f (append x y z))
       (set-car! x 'a)
       (set-car! y 'b)
       f" "(1 . (2 . (3 . (4 . (5 . (6 . ()))))))\n") 
    (cons
      "(define x '(1 2))
       (define y '(3 4))
       (define z '(5 6))
       (define f (append x y z))
       (set-car! x 'a)
       (set-car! y 'b)
       (set-car! z 'c)
       f" "(1 . (2 . (3 . (4 . (c . (6 . ()))))))\n")     
    (cons "(append '(a b) 'c)" "(a . (b . c))\n")
    (cons "(append '(1 2) '(3 4))" "(1 . (2 . (3 . (4 . ()))))\n")
    (cons "(append '(1 2) 3)" "(1 . (2 . 3))\n")
    (cons "(append '(a b) '(#t #f) 'e)" "(a . (b . (#t . (#f . e))))\n")
    (cons "(define x '(5)) 
	   (define y (append '(a b) '(#t #f) '(1 2 3 4) '(5 6 7) '(8 9 -1/2) x))
	   y
	   (set-car! x #t)
	   y" 
	 "(a . (b . (#t . (#f . (1 . (2 . (3 . (4 . (5 . (6 . (7 . (8 . (9 . (-1/2 . (5 . ())))))))))))))))
(a . (b . (#t . (#f . (1 . (2 . (3 . (4 . (5 . (6 . (7 . (8 . (9 . (-1/2 . (#t . ())))))))))))))))\n")    
	

  


     
    



   
	

))

(define eq-tests
  (list
    ;void
    (cons "(begin (define x 5) (eq? (set! x 6) (set! x -1/2)))" "#t\n")
    
    ;nil
    (cons "(eq? '() (list))" "#t\n")
    (cons "(eq? '() (append))" "#t\n")
    
    ;char
    (cons "(eq? #\\a #\\a)" "#t\n")
    
    ;string
    (cons "(eq? \"a\" (make-string 1 #\\a))" "#f\n")
    ;(cons "(eq? (symbol->string 'abc) (symbol->string 'abc))" "#t\n")
    
    ;integer
    (cons "(eq? 1 (+ 1/2 1/2))" "#t\n")
    (cons "(eq? 1 (+ 1/2 1/4))" "#f\n")
    
    ;fraction
    (cons "(eq? 1/2 (/ 2 4))" "#t\n")
    
    ;boolean
    (cons "(eq? #t (zero? 0))" "#t\n")
    (cons "(eq? #t (integer? 1))" "#t\n")
    (cons "(eq? #f (integer? 1/2))" "#t\n")
    
    ;list
    (cons "(eq? '(1) '(1))" "#t\n")
    (cons "(eq? '(1) (list 1))" "#f\n")
    (cons "(eq? (list 1) (list 1))" "#f\n")
    
    ;vector
    (cons "(eq? '#(1) '#(1))" "#t\n")
    (cons "(eq? '#(1) (make-vector 1 1))" "#f\n")
    (cons "(eq? (make-vector 1 1) (make-vector 1 1))" "#f\n")
    
    ;symbol
    (cons "(eq? (string->symbol \"a\") (string->symbol (make-string 1 #\\a)))" "#t\n")
    (cons "(eq? (string->symbol (make-string 1 #\\a)) (string->symbol (make-string 1 #\\a)))" "#t\n")
    (cons "(eq? (string->symbol \"bb\") (string->symbol (make-string 2 #\\b)))" "#t\n")
    (cons "(eq? (string->symbol \"aa\") (string->symbol (make-string 2 #\\b)))" "#f\n")
    (cons "(eq? (string->symbol \"x\") 'x)" "#t\n")
    (cons "(eq? (string->symbol \"X\") 'x)" "#f\n")
    
    ;closures
    (cons "(eq? car car)" "#t\n")
    (cons "(eq? map map)" "#t\n")
    (cons "(eq? car cdr)" "#f\n")
    (cons "(eq? car 'car)" "#f\n")
    (cons "(eq? (lambda (x) x) (lambda (x) x))" "#f\n")
    
    ;others
    (cons "(eq? #t 1)" "#f\n")
    (cons "(eq? #t '#(t))" "#f\n")
    (cons "(eq? 'a #\\a)" "#f\n")
    (cons "(eq? -1/2 1)" "#f\n")
    (cons "(eq? \"A\" \"a\")" "#f\n")
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
      ; (cons "Constants Table" constants-table-tests) ; + DONE
      ; (cons "Or, If and Begin" or-if-begin-tests)     ; + DONE 
      ; (cons "Lambda-simple" lambda-simple-tests)	; + DONE
      ; (cons "Lambda-opt" lambda-opt-tests)	; + DONE
      ; (cons "Lambda-var" lambda-var-tests) ; + DONE
      ; (cons "tc-applic-tests" tc-applic-tests) ; + DONE
      ; (cons "comp161 torture test for compiler unsorted" comp161-torture-test-for-compiler-unsorted) 	; + DONE
      ; (cons "Set" set-tests)	; + DONE
      ; (cons "pvar-bvar" pvar-bvar-tests)	; + DONE
      ; (cons "Define" define-tests)
      (cons "Primitive Functions" primitive-functions-tests)
      ; (cons "eq?" eq-tests) 
      ; (cons "Internal Helper cProcedures" internal-helper-procedures-tests)
      ;(cons "Debugging" tests)  
      
))
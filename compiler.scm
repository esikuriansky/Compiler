(load "pattern-matcher.scm")

(define reserved-words '(and begin cond define do else if lambda let let* letrec or quasiquote unquote unquote-splicing quote set!))

;; ====================
;; 	 Helper functions
;; ====================

(define const? 
	(lambda (expr)
		(or 
			(null? expr)
			(boolean? expr)
			(vector? expr)
			(char? expr)
			(number? expr)
			(string? expr)
			)))

(define reserved-word? 
	(lambda (word reserved) 
		(if (null? reserved)
			#f
			(if (eq? word (car reserved))
				(error 'parse
					(format "Unknown form: ~s" word))
				(reserved-word? word (cdr reserved)
		)))))

(define not-reserved-word?
	(lambda (e )
			(not (reserved-word? e reserved-words))))

(define var?
	(lambda (expr)
		(and (symbol? expr)
			 (not (reserved-word? expr reserved-words)
		))))

(define seq-prefix (list 'seq ))

(define seq 
	(lambda (list_of_exp)
		(append 
			seq-prefix
			(map (lambda (exp) (parse exp)) list_of_exp)
		
		)))


(define identify-lambda
	(lambda (argl ret-simple ret-opt ret-var)
		(cond 
			((null? argl) (ret-simple '()))
			((var? argl) (ret-var argl))   
			(else (identify-lambda (cdr argl)
					(lambda (s) (ret-simple `(,(car argl) ,@s))) ;simple
					(lambda (s opt) (ret-opt `(,(car argl) ,@s) opt)) ;opt
					(lambda (var) (ret-opt `(,(car argl)) var)))))))

(define body-hanlder 
	(lambda (body bodies)
		(if (null? bodies)
			(parse body)
			; (p `(begin ,body))
			`(seq ,(map parse (cons body bodies))
		))))

(define legit-params?
  (lambda (lst)
    (andmap (lambda (x)
              (if (= (length (filter (lambda (y) (equal? x y)) lst)) 1)
                    #t
                    #f))
             lst)))


(define build-sets
	(lambda (ribs)
		 (map 
			(lambda (pair)
				`(set! ,(car pair) ,(cadr pair)))
		ribs)
	))

(define make-flat
	(lambda (seq)
      	(fold-left
        	(lambda (acc x)
          		(match `(begin ,@(? 'seq)) x (lambda (seq) `(,@acc ,@(make-flat seq))) (lambda () `(,@acc ,x))))
        	'() seq)))


;; ====================
;;         QQ
;; ====================

(define ^quote?
  (lambda (tag)
    (lambda (e)
      (and (pair? e)
	   (eq? (car e) tag)
	   (pair? (cdr e))
	   (null? (cddr e))))))

(define quote? (^quote? 'quote))
(define unquote? (^quote? 'unquote))
(define unquote-splicing? (^quote? 'unquote-splicing))

(define const?
  (let ((simple-sexprs-predicates
	 (list boolean? char? number? string?)))
    (lambda (e)
      (or (ormap (lambda (p?) (p? e))
		 simple-sexprs-predicates)
	  (quote? e)))))

(define quotify
  (lambda (e)
    (if (or (null? e)
	    (pair? e)
	    (symbol? e)
	    (vector? e))
	`',e
	e)))

(define unquotify
  (lambda (e)
    (if (quote? e)
	(cadr e)
	e)))

(define const-pair?
  (lambda (e)
    (and (quote? e)
	 (pair? (cadr e)))))

(define expand-qq
  (letrec ((expand-qq
	    (lambda (e)
	      (cond ((unquote? e) (cadr e))
		    ((unquote-splicing? e)
		     (error 'expand-qq
		       "unquote-splicing here makes no sense!"))
		    ((pair? e)
		     (let ((a (car e))
			   (b (cdr e)))
		       (cond ((unquote-splicing? a)
			      `(append ,(cadr a) ,(expand-qq b)))
			     ((unquote-splicing? b)
			      `(cons ,(expand-qq a) ,(cadr b)))
			     (else `(cons ,(expand-qq a) ,(expand-qq b))))))
		    ((vector? e) `(list->vector ,(expand-qq (vector->list e))))
		    ((or (null? e) (symbol? e)) `',e)
		    (else e))))
	   (optimize-qq-expansion (lambda (e) (optimizer e (lambda () e))))
	   (optimizer
	    (compose-patterns
	     (pattern-rule
	      `(append ,(? 'e) '())
	      (lambda (e) (optimize-qq-expansion e)))
	     (pattern-rule
	      `(append ,(? 'c1 const-pair?) (cons ,(? 'c2 const?) ,(? 'e)))
	      (lambda (c1 c2 e)
		(let ((c (quotify `(,@(unquotify c1) ,(unquotify c2))))
		      (e (optimize-qq-expansion e)))
		  (optimize-qq-expansion `(append ,c ,e)))))
	     (pattern-rule
	      `(append ,(? 'c1 const-pair?) ,(? 'c2 const-pair?))
	      (lambda (c1 c2)
		(let ((c (quotify (append (unquotify c1) (unquotify c2)))))
		  c)))
	     (pattern-rule
	      `(append ,(? 'e1) ,(? 'e2))
	      (lambda (e1 e2)
		(let ((e1 (optimize-qq-expansion e1))
		      (e2 (optimize-qq-expansion e2)))
		  `(append ,e1 ,e2))))
	     (pattern-rule
	      `(cons ,(? 'c1 const?) (cons ,(? 'c2 const?) ,(? 'e)))
	      (lambda (c1 c2 e)
		(let ((c (quotify (list (unquotify c1) (unquotify c2))))
		      (e (optimize-qq-expansion e)))
		  (optimize-qq-expansion `(append ,c ,e)))))
	     (pattern-rule
	      `(cons ,(? 'e1) ,(? 'e2))
	      (lambda (e1 e2)
		(let ((e1 (optimize-qq-expansion e1))
		      (e2 (optimize-qq-expansion e2)))
		  (if (and (const? e1) (const? e2))
		      (quotify (cons (unquotify e1) (unquotify e2)))
		      `(cons ,e1 ,e2))))))))
    (lambda (e)
      (optimize-qq-expansion
       (expand-qq e)))))

;; ===================
;; 	 Macro Expansion
;; ===================


;; ================
;;	     Main
;; ================

(define parse 
	(let ((run

			;; ribs
			(compose-patterns

				;; --- patterns --- ;; 


				;; ---  quote --- ;;

				(pattern-rule 
					`(quote ,(? 'c))  
					(lambda (c) `(const ,c)))

				;; ---  const --- ;;

				(pattern-rule 
					(? 'c const?) 
					(lambda (c) `(const ,c)))

				;; ---  variables --- ;;

				(pattern-rule
					(? 'v var?)
					(lambda (v) `(var ,v)))

				;; ---  conditional --- ;;

				; - if - then
				(pattern-rule
					`(if ,(? 'test) ,(? 'dit))
					(lambda (test dit) `(if3 ,(parse test) ,(parse dit) (const ,(void)))))

				; - if -then -else
				(pattern-rule
					`(if ,(? 'test) ,(? 'dit) ,(? 'dif))
					(lambda (test dit dif) `(if3 ,(parse test) ,(parse dit) ,(parse dif))))

				;; ---  disjunctions --- ;;

				(pattern-rule
					`(or . ,(? 'args))
					(lambda (args) 
						(cond ((null? args) '(const #f))
							  ((null? (cdr args)) (parse (car args)))
							  (else `(or ,(map (lambda (x) (parse x)) args))))))

				;; ---  and --- ;;

				(pattern-rule
					`(and . ,(? 'exps))
					(lambda ( exps)
						(cond 

							((null? exps) (parse #t)) 
							((= (length exps) 1) (parse (car exps)))
							(else 

								(parse `(if  ,(car exps) (and ,@(cdr exps)) #f))
						))))

				;; ---  cond --- ;;

				(pattern-rule
					`(cond . ,(? 'conds))
					(lambda (conds)
						(cond 
							((null? conds) (parse #t))
							((= (length conds) 1) 
								(if (eq? (caar conds) 'else)
									(parse `(begin ,@(cdar conds)))
									(if (> (length (cdar conds)) 1)
										(parse `(if ,(caar conds) (begin ,@(cdar conds))))	
										(parse `(if ,(caar conds) ,(cadar conds)))
									)
								))
							(else (if (> (length (cdar conds)) 1)
								  		(parse `(if ,(caar conds) (begin ,@(cdar conds)) (cond ,@(cdr conds))))
								  		(parse `(if ,(caar conds) ,(cadar conds) (cond ,@(cdr conds)))))
					))))


				;; --- let --- ;;

				(pattern-rule 
					`(let ,(? 'ribs) ,(? 'body) . ,(? 'rest))
					(lambda (ribs body rest)
						(let
							;; let ribs 
							((params (map car ribs))
							 (args (map car (map cdr ribs))))
							;; let body
							(if (legit-params? params)

								(parse `((lambda ,params ,@(append (list body) rest)) ,@args))
								(error 'parser
									(format "Invalid parameter list ~s" params))

						))))

				;; --- let* --- ;;

				(pattern-rule 
					`(let* ,(? 'ribs) ,(? 'body) . ,(? 'rest))
					(lambda (ribs body rest)
						(if (null? ribs)
							(parse `((lambda () ,@(append (list body) rest)) ,@(list)))
							(let
								;; let ribs 
								((first-varval (car ribs)))
								;; let body
								(if (null? (cdr ribs))
									(parse `((lambda (,(car first-varval)) ,body ,@rest) ,@(cdr first-varval)))
									(parse `((lambda (,(car first-varval)) (let* ,(cdr ribs) ,body ,@rest)) ,@(cdr first-varval)))
						)))))


				;; --- set! --- ;;

				(pattern-rule
					`(set! ,(? 'var) ,(? 'val))
					(lambda ( var val)
						`(set ,(parse var) ,(parse val))
					))


				;; --- letrec --- ;;

				(pattern-rule 
					`(letrec ,(? 'ribs) . ,(? 'exprs))
					(lambda (ribs exprs)

						(let
							;; let-ribs 
							((params (map car ribs))
							 (sets   (build-sets ribs))
							 (const-f (map (lambda (_) #f) ribs)))

							;; let-body
							(display const-f)
							(display "\n")
							(parse `((lambda ,params ,@sets ((lambda () ,@exprs) ,@(list)))  ,@const-f))

						)))

				;; ---  seq --- ;;

				(pattern-rule
          			`(begin ,@(? 'exprs))
            		(lambda (exprs)
            			(if (null? exprs) `(const ,(void))
              			(let ((flat-exprs (make-flat exprs)))
                			(cond ((null? flat-exprs) `(const ,*void-object*))
                      		((null? (cdr flat-exprs)) (parse (car flat-exprs)))
                      		(else `(seq ,(map parse flat-exprs))))))))

				;; --- lambda --- ;;

				(pattern-rule
					`(lambda ,(? 'argl) ,(? 'body) . ,(? 'bodies))
					(lambda (argl body bodies) 
						`(,@(identify-lambda argl 
							(lambda (x) `(lambda-simple ,x)) 
							(lambda (x opt) `(lambda-opt ,x ,opt)) 
							(lambda (x) `(lambda-var ,x))) ,(parse `(begin ,@(cons body bodies))))))
	
				;; --- define  --- ;;

				; - regular
				(pattern-rule
					`(define ,(? 'var var?) . ,(? 'expr))
					(lambda (var expr)
						`(def ,(parse var) ,(parse `(begin ,@expr)))))

				; - mit
				(pattern-rule
					`(define ,(? 'name-args) . ,(? 'body))
					(lambda (name-args body)
						(let
							;; ribs 
							((def-name (car name-args))
							 (args (cdr name-args)))
							;;body
							(parse `(define ,def-name (lambda (,@args) ,@body)))
						)))

				; ;; ---  quasiquote --- ;;

				(pattern-rule
					`(,'quasiquote ,(? 'exp))
					(lambda (expr) (parse (expand-qq expr))))

				 ;; ---  applic --- ;;

				 (pattern-rule
				 	`(,(? 'e1 not-reserved-word?) . ,(? 'rest))
				 	(lambda (e1 rest) `(applic ,(parse e1) ,(map (lambda (x) (parse x)) rest))))

			)))

		;; ---  body

		(lambda (e)
			(run e
				(lambda ()
					(error 'parse
					(format "I can't recognize this: ~s" e)))))
		))

; ========================
; 		ASS 3
; ========================

; (define test0
; 	(lambda(exp)
; 		(eliminate-nested-defines(parse exp))))

; (define test1
; 	(lambda(exp)
; 		(remove-applic-lambda-nil(eliminate-nested-defines(parse exp)))))

; (define test2
; 	(lambda(exp)
; 		(box-set(remove-applic-lambda-nil(eliminate-nested-defines(parse exp))))))

; (define test3
; 	(lambda(exp)
; 		(pe->lex-pe(box-set(remove-applic-lambda-nil(eliminate-nested-defines(parse exp)))))))

; (define test4
; 	(lambda(exp)
; 		(annotate-tc(pe->lex-pe(box-set(remove-applic-lambda-nil(eliminate-nested-defines(parse exp))))))))


; ===============================================================================================================================
; 													eliminate-nested-defines
; ===============================================================================================================================	

(define seperate-nested-define
  (lambda (pes cont)
    (if (null? pes) (cont '() '())
        (seperate-nested-define
         (cdr pes)
         (lambda (dfs es)
           (cond ((eq? (caar pes) 'def) (cont (cons (car pes) dfs) es))
                 ((eq? (caar pes) 'seq)
                  (seperate-nested-define
                   (cadar pes) (lambda (dfs1 es1) (cont (append dfs1 dfs) (append es1 es)))))
                 (else (cont dfs (cons (car pes) es))))))))) 


(define should-combine-define?
  (lambda (exp)
    (seperate-nested-define exp (lambda (dfs eps) (not (null? dfs))))))


(define lambda-exp?
	(lambda (exp)
	(and
		(list? exp)
		(or (equal? (car exp) 'lambda-simple)
			(equal? (car exp) 'lambda-var)
			(equal? (car exp) 'lambda-opt)
			))))

(define get-all-args-from-def-lst
	(lambda (def-lst)
		(map
			(lambda (def) `(,@(cadadr def)))
			def-lst)))

(define get-all-vals-from-def-lst
	(lambda (def-lst)
		(map (lambda (def) `(set ,(cadr def) ,@(eliminate-nested-defines (cddr def)))) def-lst)))
		

(define cont
    (lambda (dfs eps)

            (if (null? dfs) (eliminate-nested-defines eps)
            	(let ((args (get-all-args-from-def-lst dfs))
                 	(vals (get-all-vals-from-def-lst dfs))
                  	(f-lst (fold-left (lambda (df d) (cons `(const #f) df)) '() dfs)))


                  `((applic (lambda-simple ,args (seq (,@vals ,@(eliminate-nested-defines eps)))) ,f-lst)))
                  )))

(define lambda-body
	(lambda(lambda-exp)
		(cddr lambda-exp)))

(define lambda-args
	(lambda(lambda-exp)
		(cadr lambda-exp)))

(define eliminate-nested-defines
  (lambda (prsd-exp)
	  (cond 
	  	((null? prsd-exp) prsd-exp)
     	 
     	;; prsd-exp is a lambda-exp
     	((and (list? prsd-exp) (lambda-exp? prsd-exp))
     		; (display "2 \n")
     		(cond

	         ;;lambda-simple
	         ((equal? (car prsd-exp) 'lambda-simple) 
	         	(if (should-combine-define? (lambda-body prsd-exp))
	         		`(lambda-simple ,(lambda-args prsd-exp) ,@(seperate-nested-define (lambda-body prsd-exp) cont))
	                `(lambda-simple ,(lambda-args prsd-exp) ,@(eliminate-nested-defines (lambda-body prsd-exp)))))

	         ;;lambda-opt
	         ((equal? (car prsd-exp) 'lambda-opt) 
	          (if (should-combine-define? (cdddr prsd-exp)) 
	          `(lambda-opt ,(cadr prsd-exp) ,(caddr prsd-exp) ,@(seperate-nested-define (cdddr prsd-exp)  cont)) 
	           `(lambda-opt ,(cadr prsd-exp) ,(caddr prsd-exp) ,@(eliminate-nested-defines (cdddr prsd-exp)))))

	         ;;lambda-var
	         ((equal? (car prsd-exp) 'lambda-var) 
	         (if (should-combine-define?(cddr prsd-exp)) 
	         `(lambda-var ,(cadr prsd-exp) ,@(seperate-nested-define (lambda-body prsd-exp)  cont))
	          `(lambda-var ,(cadr prsd-exp) ,@(eliminate-nested-defines (lambda-body prsd-exp)))))))
            
            ;;if a list - continue eliminating recursivly  
           	((list? prsd-exp)
           			; (display "3 \n")
           			(map eliminate-nested-defines prsd-exp))

           	;; return exp as at is
           	(else prsd-exp))))

; ===============================================================================================================================
; 													remove-applic-lambda-nil
; ===============================================================================================================================													

(define get-lambda-lst-of-args
	(lambda (exp)
		(cadr exp)))
	

(define is-application?
	(lambda (exp)
		(equal? (car exp) 'applic)))

(define is-lambda-simple?
	(lambda (exp)
		(equal? (car exp) 'lambda-simple)))

(define get-applic-bdy
	(lambda (exp)
		(cadr exp)))

(define has-no-args?
	(lambda(exp)
		(equal? exp '())))

(define get-lambda-body
	(lambda (exp)
		 (caddr exp)))

(define remove-applic-layer
	(lambda (exp)
			;(car (cddadr expr)
			(get-lambda-body (get-applic-bdy exp))))

(define remove-applic-lambda-nil
	(lambda (exp)
			(if (null? exp) exp
				(if
					(and
						(list? exp)
						(is-application? exp)
						(list? (cadr exp))
						(is-lambda-simple? (get-applic-bdy exp))
						(has-no-args? (get-lambda-lst-of-args (get-applic-bdy exp)))
						(null? (cadadr exp))
						(null? (caddr exp))
					)
					;;call recursivly 
					(remove-applic-lambda-nil (remove-applic-layer exp))

					(if (list? exp) 
						(map remove-applic-lambda-nil exp) 
						exp)
					
				))))

; ===============================================================================================================================
; 													box-set
; ===============================================================================================================================	

(define set?
  (lambda (param body)
    (cond ((null? body) #f)
    		((not (list? body)) #f)
           ((and (equal? (car body) 'lambda-simple) (member param (cadr body))) #f)  
           ((and (equal? (car body) 'lambda-opt)  (member param (append (cadr body) (list (caddr body))))) #f)
           ((and (equal? (car body) 'lambda-var)  (member param (list (cadr body)))) #f)

          ((and  (equal? 'set (car body)) (equal? `(var ,param) (cadr body))) #t)
          ((list? body) (ormap (lambda (x) (set? param x)) body))
          (else #f))))          
                
          
(define get?
    (lambda (param body)
        (cond ((null? body) #f)
        		((not (list? body)) #f)
        		((equal? (car body) 'var) (equal? body (list 'var param)))
              ((and  (equal? (car body) 'lambda-simple) (member param (cadr body))) #f)  
              ((and (equal? (car body) 'lambda-opt)  (member param (append (cadr body) (list (caddr body))))) #f)
              ((and  (equal? (car body) 'lambda-var)  (member param (list (cadr body)))) #f)
              ((and  (equal? `(var ,param) body)) #t)
              ((and  (equal? 'set (car body)) (equal? `(var ,param) (cadr body))) (get? param (cddr body)))
              ((list? body) (ormap (lambda (x) (get? param x)) body))
             (else #f))))

(define should-box? 
	(lambda (param body params)
		 (and (get? param body) (set? param body) (bound? param params body 0))))


(define is-depthd-bound
    (lambda (param depth)
        (if (> depth 0) #t #f)))


(define bound?
    (lambda (param params body depth)
        (cond
         ((null? body) #f)

         ((not (list? body)) #f)

         ((equal? (car body) 'lambda-simple)
         	(if (member param (lambda-args body)) #f
         		(bound? param (lambda-args body) (cddr body) (+ 1 depth))))


         ((equal? (car body) 'lambda-opt)
         	(if (member param (append (lambda-args body) (list (lambda-opt-rest body)))) #f
         		(bound? param (append (lambda-args body) (lambda-opt-rest body)) (cdddr body) (+ 1 depth))))


         ((equal? (car body) 'lambda-var)
         	(if (member param (list (lambda-args body))) #f
         		(bound? param (lambda-args body) (cddr body) (+ 1 depth))))
   
         
         ((and (equal? `(var ,param) body) (is-depthd-bound param depth)) #t)
         ((list? body) (ormap (lambda (x) (bound? param params x depth)) body)) 
         
         (else #f))
        
        ))

(define get-params-to-box
	(lambda(params body)
		(filter (lambda (param) (should-box? param body params)) params)))

(define make-box-get
	(lambda (param-to-box body)
		`(box-get (var ,(cadr body)) ,@(swapParamWithBoxes param-to-box (cddr body)))))
		
(define make-box-set
	(lambda (param-to-box body)
		`(box-set (var ,(cadadr body)) ,@(swapParamWithBoxes param-to-box (cddr body)))))

(define dose-param-appears-in-inner-lambda?
	(lambda (param-to-box inner-body-params)
		(member param-to-box inner-body-params)))

(define lambda-opt-all-params
	(lambda(body)
		(append (lambda-args body) (list (lambda-opt-rest body)))))
		


	
(define swapParamWithBoxes
    (lambda (param-to-box body)
            (cond
               	((null? body) body)
               	((not (list? body)) body)
               	((and (equal? 'var (car body)) (equal? param-to-box (cadr body))) (make-box-get param-to-box body))
                ((and (equal? 'set (car body)) (equal? param-to-box (cadadr body))) (make-box-set param-to-box body))	
	            ((and (equal? (car body) 'lambda-simple) (dose-param-appears-in-inner-lambda? param-to-box (lambda-args body))) body)  
	            ((and (equal? (car body) 'lambda-opt)  (dose-param-appears-in-inner-lambda? param-to-box (lambda-opt-all-params body)) body))
	            ((and (equal? (car body) 'lambda-var)  (dose-param-appears-in-inner-lambda? param-to-box (list (lambda-args body)))) body)

                ((list? body) (map (lambda (x) (swapParamWithBoxes param-to-box x)) body))
                (else body))))

(define make-new-body
  (lambda (boxed-body)
    (fold-right (lambda (e bd)
        (if (eq? (car e) 'seq) (append (make-new-body (cdr e)) bd)                        
             (if (list? (car e))
                     (append e bd)
                     (cons e bd))))
                '() boxed-body)))

  (define fixBody
    (lambda (params-to-box body)
       (if (null? params-to-box) (box-set body)
       		(let* 
       			((param-to-box (car params-to-box))
       			(rest-params-to-box (cdr params-to-box))
       			(fixedBodyParam (swapParamWithBoxes param-to-box body)))

           		(fixBody rest-params-to-box fixedBodyParam )))))
   
   (define make-set-exp
   		(lambda(params-to-box)
   			(map (lambda (param) `(set (var ,param) (box (var ,param)))) params-to-box)))
   			      

	(define build-boxed-lambda
		(lambda (head params rest-params body params-to-box)
			(let*
				((set-exp (make-set-exp params-to-box))
				(boxed-body (fixBody params-to-box body))
				(new-body (make-new-body boxed-body)))

				(cond
					((equal? head 'lambda-simple)
						`(,head ,params (seq  (,@set-exp ,@new-body))))

					((equal? head 'lambda-var)
						`(,head ,@params (seq  (,@set-exp ,@new-body))))

					((equal? head 'lambda-opt)
						
						`(,head ,params ,rest-params (seq  (,@set-exp ,@new-body))))

					))))
		
(define box-set-lambda
	(lambda (lambda-exp)
		;(display "box-set-la \n")
		(let*
			((head (car lambda-exp))
			(params (cadr lambda-exp))
			(var-params (list params)) 
			(body (cddr lambda-exp)))
		(cond
			;;lambda-simple
			((equal? head 'lambda-simple)
				(let 
					((params-to-box (get-params-to-box params body)))
					(if (null? params-to-box)
						`(,head ,params ,@(box-set body))
						(build-boxed-lambda head params '() body params-to-box))))

; 			;;lamnda-var
			((equal? head 'lambda-var)
				(let 
					
					((params-to-box (get-params-to-box var-params body)))
					(if (null? params-to-box)
						`(lambda-var ,@var-params ,@(box-set body))
						(build-boxed-lambda head var-params '() body params-to-box))))

			;;lamnda-opt
			((equal? head 'lambda-opt)

				(let 

					((params-to-box (get-params-to-box (lambda-opt-all-params lambda-exp) (cadddr lambda-exp))))
					(if (null? params-to-box)
						`(lambda-opt ,params ,(lambda-opt-rest lambda-exp) ,@(box-set (cdddr lambda-exp)))

						
						(build-boxed-lambda head params (lambda-opt-rest lambda-exp) (cdddr lambda-exp) params-to-box))))))))


(define box-set
    (lambda (exp)
        (cond
         	((null? exp) exp)
        	((not (list? exp)) exp)
        	((lambda-exp? exp) (box-set-lambda exp))
            ((list? exp) (map box-set exp))
            (else exp))))

;; ===============================================================================================================================
;; 													pe->lex-pe
;; ===============================================================================================================================	

(define lambda-opt-rest
	(lambda(exp)
		(caddr exp)))

(define lambda-opt-body
	(lambda(exp)
		(cadddr exp)))

(define pe->lex-pe
	(lambda (exp)
		(change-to-lex exp '() '())))

(define is-bound?
    (lambda (param env)
        (cond 
            ((null? env) #f)
            ((member param (car env)) #t)
            (else (is-bound? param (cdr env))))))
            

 (define find-bound
    (lambda (param bounds)
        (if (member param (car bounds))  
        	(list 0 (find-minor param (car bounds)))
            (let ((find-idx (find-bound param (cdr bounds))))
                    (cons (+ 1 (car find-idx)) (cdr find-idx))))))
                    

 (define find-minor
    (lambda (param params)
       (if  (equal? (car params) param) 0
            (+ 1 (find-minor param (cdr params))))))
            

 (define param-in-params?
 	(lambda (param params)
 		(member param params)))   

(define make-lex-var
    (lambda (param params bounds)
      (cond 
            ((param-in-params? param params) `(pvar ,param ,(find-minor param params)))
            ((is-bound? param bounds) `(bvar ,@(cons param (find-bound param bounds))))
            (else `(fvar ,param)))
            ))


(define make-lambda-lex
	(lambda (lambda-exp params bounds)
		(cond
			((equal? (car lambda-exp) 'lambda-simple) 
				`(lambda-simple ,(lambda-args lambda-exp) ,@(change-to-lex (lambda-body lambda-exp) (lambda-args lambda-exp) (cons params bounds))))
			((equal? (car lambda-exp) 'lambda-opt)   
				 `(lambda-opt ,(lambda-args lambda-exp) ,(lambda-opt-rest lambda-exp) ,@(change-to-lex (lambda-opt-body lambda-exp) (append (lambda-args lambda-exp) (list (lambda-opt-rest lambda-exp))) (cons params bounds))))
			((equal? (car lambda-exp) 'lambda-var)
				`(lambda-var ,(lambda-args lambda-exp) ,@(change-to-lex (lambda-body lambda-exp) (list (lambda-args lambda-exp)) (cons params bounds)))))))

(define change-to-lex 
    (lambda (pes params bounds) 
            (cond 
            	((or (not (list? pes)) (null? pes)) pes)	
            	((and (list? pes) (equal? (car pes) 'var)) (make-lex-var (cadr pes) params bounds))
            	((lambda-exp? pes) (make-lambda-lex pes params bounds))
				((list? pes) (map (lambda (exp) (change-to-lex exp params bounds)) pes))
				(else pes))))


; ===============================================================================================================================
; 													                              annotate-tc
; ===============================================================================================================================	

(define is-var-exp?
	(lambda (exp)
		(or (equal? exp 'var) (equal? exp 'fvar) (equal? exp 'bvar) (equal? exp 'pvar))))

(define tc-or-exp 
	  (lambda (annotate-tp lst)
	  	(let*
	  		((last-exp (car (reverse lst)))
	  		(last-exp-annotated (annotate-tp last-exp))
	  		(rest-exp (reverse(cdr (reverse lst))))
	  		(rest-exp-annotated (reverse (map (lambda (e) (annotate e #f)) rest-exp))))

	    	(reverse (cons last-exp-annotated rest-exp-annotated)))))

(define annotate
	(lambda (exp tp?)
	  (cond
	  	((null? exp) exp)
	  	((not (list? exp)) exp)
	    ((is-var-exp? (car exp)) exp)
	    ((equal? (car exp) 'const) exp)
	    ((equal? (car exp) 'box-get) `(,(car exp) ,(cadr exp) ,@(annotate (cddr exp) #f)))
	    ((or (equal? (car exp) 'set) (equal? (car exp) 'box-set) (equal? (car exp) 'def)) `(,(car exp) ,(cadr exp) ,@(annotate (cddr exp) #f)))
	    ((or (equal?(car exp)'or) (equal? (car exp) 'seq)) `(,(car exp) ,(tc-or-exp (lambda (e) (annotate e tp?)) (cadr exp))))
	    ((equal? (car exp) 'if3) `(if3 ,(annotate (cadr exp) #f) ,(annotate (caddr exp) tp?) ,(annotate (cadddr exp) tp?)))
        ((equal? (car exp) 'lambda-simple) `(lambda-simple ,(cadr exp) ,(annotate (caddr exp) #t)))
        ((equal? (car exp) 'lambda-opt) `(lambda-opt ,(cadr exp) ,(caddr exp)  ,(annotate (cdddr exp) #t)))
        ((equal? (car exp) 'lambda-var) `(lambda-var ,(cadr exp) ,(annotate (caddr exp) #t)))
	    ((equal? (car exp) 'applic)
	    	(if tp?
	     	`(tc-applic ,(annotate (cadr exp) #f) ,(map (lambda (e) (annotate e #f)) (caddr exp)))
	     	`(applic ,(annotate (cadr exp) #f) ,(map (lambda (e) (annotate e #f)) (caddr exp)))))
	    ((list? exp) `(,(annotate (car exp) tp?) ,@(annotate (cdr exp) tp?))))))



(define annotate-tc
	(lambda (exp)
		(annotate exp #f)))
		

;; ====================================
;; 			  Final Project
;; ====================================

(define (compilation-error message . more)
	(display message)
	(display "\n")
	(display more)
	(display "\n")
	(exit 1)
)

(define disp 
	(lambda (to-disp func-name)
		(display func-name)
		(display ": ")
		(display to-disp)
		(display "\n")
	))

(define ^eq? (lambda (exp q) (eq? (car exp) q)))

(define (if3-pe? exp)  (^eq?  exp 'if3))
(define (pvar-pe? exp) (^eq? exp 'pvar))
(define (bvar-pe? exp) (^eq? exp 'bvar))
(define (fvar-pe? exp) (^eq? exp 'fvar))
(define (applic-pe? exp) (^eq? exp 'applic))
(define (tc-applic-pe? exp) (^eq? exp 'tc-applic))
(define (lambda-simple-pe? exp) (^eq? exp 'lambda-simple))
(define (lambda-opt-pe? exp) (^eq? exp 'lambda-opt))
(define (lambda-var-pe? exp) (^eq? exp 'lambda-var))
(define (const-pe? exp) (^eq? exp 'const))
(define (define-pe? exp) (^eq? exp 'def))
(define (seq-pe? exp) (^eq? exp 'seq))
(define (or-pe? exp) (^eq? exp 'or))
(define (set-pe? exp) (^eq? exp 'set))
(define (box-pe? exp) (^eq? exp 'box))
(define (box-set-pe? exp) (^eq? exp 'box-set))
(define (box-get-pe? exp) (^eq? exp 'box-get))

(define ^make-label
	(lambda (label-name)
		(let ((n 0))
			(lambda ()
				(set! n (+ n 1))
				(string-append label-name (number->string n))
		))))

;; IF3
(define if3-label-else (^make-label "L_IF3_ELSE"))
(define if3-label-done (^make-label "L_IF3_DONE"))

;; OR
(define or-label-done (^make-label "L_OR_DONE"))

;; LAMBDA
(define lambda-label (^make-label "L_CLOSURE"))
(define lambda-label-done (^make-label "L_CLOSURE_DONE"))

;; LAMBDA OPT
(define lambda-opt-loop (^make-label "L_OPT_LOOP"))
(define lambda-opt-loop-done (^make-label "L_OPT_LOOP_DONE"))
(define lambda-opt-new-args (^make-label "L_OPT_NEW_ARGS"))
(define lambda-opt-new-args-done (^make-label "L_OPT_NEW_ARGS_DONE"))

;; LAMBDA VARIADIC
(define lambda-var-loop (^make-label "L_VAR_LOOP"))
(define lambda-var-loop-done (^make-label "L_VAR_LOOP_DONE"))


;; === Helper Function
(define newl (list->string (list #\newline)))

(define number-sign
 (lambda (number)
      (if (< number 0) "0" "1")))

(define rm-lst-dups
	(lambda (lst)
	(if (null? lst) (list)
		(let 
			((first (car lst)))
			(cons 
				first 
				(rm-lst-dups 
					(filter 
						(lambda (x) (not (equal? x first)))
						(cdr lst)))
)))))


;; ===============================================================================================================================
;; 													                           code-gen
;; ===============================================================================================================================	


(define cgen-ct 
	(lambda ()
		(letrec 
			((cg (lambda (tbl)
				(if (null? tbl) 
						"" 
						(let* 
							;; ribs
							((curr (car tbl))
							 (addr (car curr))
							 (type (cadr curr))
							 (val  (caddr curr)))

							;;body

							(string-append
								(cond
									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_VOID) (string-append
												"// Making VOID object" 								newl
												"CALL(MAKE_SOB_VOID); " 								newl newl 
												))
									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_BOOL) (let ((arg (if val 1 0))) 
												(string-append
												"// Making BOOL object"									newl	
		    								"PUSH(IMM(" (number->string arg) "));" 	newl
												"CALL(MAKE_SOB_BOOL);"									newl
												"DROP(1);"															newl newl
												)))
									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_NIL) (string-append
												"// Making NIL object"									newl
												"CALL(MAKE_SOB_NIL);"										newl newl
												))
									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_CHAR) (let ((arg (char->integer val)))
												(string-append
												"// Making CHAR object"	 								newl
		    								"PUSH(IMM(" (number->string arg) "));"	newl
												"CALL(MAKE_SOB_CHAR);"									newl
												"DROP(1);"															newl newl
												)))
									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_INTEGER) 
												(string-append 
												"// Making INT object"									newl
		    								"PUSH(IMM("(number->string val)"));"		newl
												"CALL(MAKE_SOB_INTEGER);"								newl
												"DROP(1);"															newl newl
												))
									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_FRACTION) 
											(let 
													;; ribs
													((sign (number-sign val))
														(numer (numerator val))
														(denom (denominator val)))
												;; body
												(string-append
												"PUSH(IMM(" sign "));" 										newl
												"PUSH(IMM(" (number->string numer) "));"	newl
												"PUSH(IMM(" (number->string denom) "));" 	newl
												"CALL(MAKE_SOB_FRACTION);"								newl
												"DROP(3);"																newl
											))
										)
									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_STRING) (let*
													((chars (map char->integer (string->list val)))
													 (str-len (string-length val)))
												(string-append
												"// Making STRING object" 																newl
		    								(apply string-append 
		    									(map (lambda (char) 
		    									(string-append 
		    									"PUSH(IMM(" (number->string char) "));\n"))
		    									 chars))

		    								"PUSH(IMM(" (number->string str-len) "));"  							newl
												"CALL(MAKE_SOB_STRING);"																	newl
												"DROP(" (number->string (+ 1 str-len)) ");"								newl newl
												)))

									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_SYMBOL) 
												(let* 
												((string-addr (get-from-ct (symbol->string val))))
												(string-append

												"// Makeing SYMBOL object"											newl											
		    								"PUSH(IMM("(number->string string-addr)"));"		newl	
												"CALL(MAKE_SOB_SYMBOL);"												newl
												"DROP(1);"																			newl

					    					"// Build symbol link" 													newl
					    					"PUSH(IND(SOB_SYM_LIST));" 											newl 											
												"PUSH(R0);"  																		newl
												"CALL(MAKE_SOB_PAIR);" 													newl
												"DROP(2);"																			newl
												"MOV(IND(SOB_SYM_LIST), R0);" 									newl newl
												)))

									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_PAIR) 
		
												(string-append
												"// Makeing PAIR object"																				newl
												"PUSH(IMM(" (number->string (get-from-ct (cdr val))) "));"			newl
		    								"PUSH(IMM(" (number->string (get-from-ct (car val))) "));"			newl
												"CALL(MAKE_SOB_PAIR);"																					newl
												"DROP(2);"																											newl newl
												))

									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_VECTOR) 
												(let 
													;; ribs
													((vec-elements (vector->list val))
													 (vec-length (length (vector->list val))))
												;; body
												(string-append
												"// Making vector object"		newl
												(apply string-append 
													(map (lambda (vec-element)
																	(string-append 
																		"PUSH(IMM(" (number->string (get-from-ct vec-element)) "));" newl)
																	) vec-elements)) 		newl
												"PUSH(IMM(" (number->string vec-length) "));" 	newl
												"CALL(MAKE_SOB_VECTOR);" 												newl
												"DROP(" (number->string (+ 1 vec-length)) ");"	newl newl
												)))
									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_CLOSURE) (string-append

												))
									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									(else "")
								)
							(cg (cdr tbl)))
				)))))
		(cg const-table)
	)))

(define cgen-if3
	(lambda (pe env-len params-len)
		(let 
				;; ribs
				((test (cgen (car pe) env-len params-len))
				 (then (cgen (cadr pe) env-len params-len))
				 (else (cgen (caddr pe) env-len params-len))
				 (label-else (if3-label-else))
				 (label-done (if3-label-done)))
			;;body 
			(string-append
					"// ---if3--- exp " newl
					test newl
					"CMP(R0, IMM(SOB_BOOL_FALSE));" newl
					"JUMP_EQ(" label-else ");" newl
					then newl
					"JUMP(" label-done ");" newl
					label-else ":" newl
					else newl
					label-done ":" newl)
		)))

(define cgen-or 
	(lambda (pe env-len params-len)
	(let* 
	   ((label-done (or-label-done))
	   	(generated-conds (map (lambda (exp) (cgen exp env-len params-len)) pe))
	   	(conds-code (map (lambda (code)
	   			(string-append 
	   				code
	   				"CMP(R0, SOB_BOOL_FALSE);" newl
	   				"JUMP_NE(" label-done ");" newl
	   			)
	   		) generated-conds))
	   	(cgen-or-code (apply string-append conds-code)))

		(string-append 


			newl newl
			"// ---or--- exp " 		newl
			cgen-or-code			 		newl
			label-done ":" 				newl
		)
	)))

(define cgen-seq
	(lambda (pe env-len params-len)
		(string-append 
			newl
			"// ---seq--- " 		newl
			(apply string-append 
				(map (lambda (item) (cgen item env-len params-len)) pe)
			))
	))

(define cgen-const
	(lambda (pe)
		(string-append "MOV(R0, IMM(" (number->string  (get-from-ct pe)) "));\n")
	))

(define cgen-arg
	(lambda (arg env-len params-len) 
		(string-append
			(cgen arg env-len params-len)
			"PUSH(R0);" newl
		)))

(define cgen-bvar 
	(lambda (bvar)
		(let
			;; ribs 
			((minor (number->string (caddr bvar)))
			 (major (number->string (cadr bvar))))
		;; body
		(string-append 
																				newl 
			"// ---bvar---" 									newl
			"// "(symbol->string (car bvar)) 	newl 
			"MOV(R0, FPARG(0));" 							newl
			"MOV(R0, INDD(R0, " major "));" 	newl
			"MOV(R0, INDD(R0, " minor "));" 	newl newl
		))
	))

(define cgen-pvar 
	(lambda (pvar)
		(let 
			((arg-position (+ 2 (cadr pvar))))
		(string-append 
																														newl 
			"// ---pvar---"									 											newl
			"// " (symbol->string (car pvar)) 											newl
			"MOV(R0, FPARG(" (number->string arg-position) "));" 	newl newl
		))
	))

(define cgen-fvar-set
	(lambda (fvar set-val-code env-len params-len)
		; (disp fvar "cgen-fvar-set")
		(let* 
			;; ribs
			((generated-val (cgen set-val-code env-len params-len))
			(exists-resolve (find-symbol (cadr fvar)))
			(address (number->string (car exists-resolve))))
		;; body
		(string-append
			generated-val 
			" MOV(IND(" address "),R0);"	newl
			" MOV(R0,IMM(1));"						newl
		))
	))

(define cgen-pvar-set
	(lambda (pvar set-val-code env-len params-len)
		; (disp pvar "cgen-pvar-set")
		; (disp (caddr pvar) "cgen-pvar-set-minor")
		(let
			;; ribs 
			((minor (caddr pvar))
			(generated-val (cgen set-val-code env-len params-len)))
		;;body
    (string-append 
     generated-val
     "MOV(FPARG(" (number->string (+ 2 minor)) "), R0);"		newl
     "MOV(R0, IMM(1))"																			newl
    ))
	))

(define cgen-bvar-set
	(lambda (bvar set-val-code env-len params-len)
		; (disp bvar "cgen-bvar-set")
		; (disp (caddr bvar) "bvar-major")
		; (disp (cadddr bvar) "bvar-minor")
		; (disp set-val-code "bvar-val-vode")
		(let 
			;; ribs
			((major (caddr bvar))											
			 (minor (cadddr bvar))
			 (generated-val (cgen set-val-code env-len params-len)))
		;; body
	  (string-append
	  	generated-val
	  	"MOV(R1,R0);"																	newl
	  	"MOV(R0,FPARG(0));"														newl
	  	"MOV(R0,INDD(R0,"(number->string major)"));" 	newl
	  	"MOV(INDD(R0,"(number->string minor) "),R1);"	newl
	  	"MOV(R0, IMM(1));"														newl
	   ))
	))

(define cgen-set 
	(lambda (pe env-len params-len)
			; (disp pe "code-gen-set")
			(let 
				;; ribs
				((var (car pe))
				 (set-val-code (cadr pe)))
			;; body
			(cond 
				((equal? (car var) 'pvar) (cgen-pvar-set var set-val-code env-len params-len))	
				((equal? (car var) 'bvar) (cgen-bvar-set var set-val-code env-len params-len))
				((equal? (car var) 'fvar) (cgen-fvar-set var set-val-code env-len params-len))
			))
	))

; (define code-gen-box
;   (lambda (setvar envLevel paramsLevel)
;     (if (equal? (caar setvar) 'pvar)
; 		    (let ((mindex (caddar setvar)))
; 		    (string-append
; 		      "/* box-pvar */" nl
; 		      "MOV(R10, IMM("(number->string mindex)"));" nl
; 		      "ADD(R10,IMM(2));" nl
; 		      (malloc 1) nl
; 		      "MOV(IND(R0),FPARG(R10));" nl
; 		      ;
; 		      ))
; 		    (let (
; 		          (mjrdex (caddar setvar))
; 		          (mindex (car (cdddar setvar))))
; 		    (string-append
; 		      "/* box-bvar */" nl
; 		      "MOV(R1, FPARG(IMM(0)));" nl
; 		      "ADD(R1,INDD(R1,IMM("(number->string mjrdex)")));" nl
; 		      (malloc 1) nl
; 		      "MOV(IND(R0),INDD(R1,IMM("(number->string mindex)")));" nl
; 		      ))
;     )))

(define cgen-box 
	(lambda (var env-len params-len)
			(disp var "lala")
			(let ((minor (caddr var)))
			  (string-append
			      " MOV(R2, FPARG("(number->string (+ 2 minor))"));"	newl
			      " PUSH(IMM(1));"			newl
			      " CALL(MALLOC);"			newl
			      " DROP(1);"						newl
			      " MOV(IND(R0), R2);"	newl
			  )
	)))
			      
(define cgen-box-get 
	(lambda (pe env-len params-len)
		; (disp pe "cgen-box-set")
		(let
			;; ribs
			((generated-get-code (cgen pe env-len params-len)))
		;; body
	  (string-append
      generated-get-code
      " MOV(R0,IND(R0));" newl
	  ))
	))
		  
(define cgen-box-set 
	(lambda (pe env-len params-len)
		; (disp (car pe) "cgen-box-set")
		; (disp (cadr pe) "cgen-box-set")
		(let
			;; ribs
			((to-set-code (cgen (car pe) env-len params-len))
			(set-with-code (cgen (cadr pe) env-len params-len)))
		;; body
	 	(string-append
      to-set-code
      " MOV(R1,R0);"			newl
      set-with-code
      " MOV(IND(R0),R1);"	newl
	  ))
	))	

(define cgen-fvar 
	(lambda (fvar)
		; (disp fvar "cgen-fvar")
		(let* 
			;; ribs
			((exists-resolve (find-symbol (car fvar)))
			(address (number->string (car exists-resolve))))
		;; body
		; (disp address "cgen-fvar")
		; (if (not exists-resolve) (compilation-error "[!] FVAR: symbol does not exist." fvar))
		(string-append 
																			newl 
			"// ---fvar---"									newl
			"MOV(R0, IND(" address "));" 		newl
		))
	))

(define cgen-define 
	(lambda (pe env-len params-len)
		; (disp pe "cgen-define")
		(let* 
			;; ribs
			((fvar (cadar pe))
			(expr (cadr pe))
			(exists-resolve (find-symbol fvar))
			(address (number->string (car exists-resolve))))
		;; body
		; (if (not exists-resolve) (compilation-error "[!] FVAR: symbol does not exist." fvar))
		(string-append 
																			newl 
			"// ---define--- "  						newl
			(cgen expr env-len params-len) 	newl
			"MOV(IND(" address "), R0);" 		newl
		))
	))

(define cgen-applic 
	(lambda (pe env-len params-len)
		(let* (
			(expr (car pe))
			(args (cadr pe))
			(num-of-args (length args))
			(generated-code (cgen expr env-len params-len))
			(all-args (apply string-append 
				(map 
					(lambda (arg) 
						(cgen-arg arg env-len params-len)) 
					(reverse args))))
			)
		(string-append 
													newl 
			"//---applic---" 		newl
			;; arguments
			all-args
			;; num of argments
			"PUSH(IMM(" (number->string num-of-args) "));" 	newl

			generated-code 									newl
		
			"// check valid closuse" 				newl
			"CMP(INDD(R0,0), T_CLOSURE);" 	newl
			"JUMP_NE(L_RUNTIME_ERROR);" 		newl

			;; env argument
			"PUSH(INDD(R0,1)); "			 			newl

			;; go to funtion code
			"CALLA(INDD(R0, 2));" 					newl
			"DROP(2 + STARG(0));"						newl
		))
	))

(define cgen-tc-applic 
	(lambda (pe env-len params-len)
		(let* 
			;; ribs
			((proc (car pe))
			(args (cadr pe))
			(num-of-args (length args))
			(all-args (apply string-append 
					(map (lambda (arg) (cgen-arg arg env-len params-len)) 
						(reverse args))))
			(generated-proc (cgen proc env-len params-len)))
		;; body
		(string-append 
																														newl 
			"// ---applic-tc---" 																	newl
			;; args to stack
			all-args

			"PUSH(IMM("(number->string num-of-args) "));"					newl

			; ----- Get function -----
			generated-proc 																				newl
			
			"// validate closure" 																newl
			"CMP(INDD(R0,0), T_CLOSURE);" 												newl
			"JUMP_NE(L_RUNTIME_ERROR);" 													newl

			; env
			"PUSH(INDD(R0,1)); "			 														newl

			"MOV(R1, FPARG(-2));" 																newl
			"PUSH(FPARG(-1));" 																		newl newl
																			
			"// overwrite old-fp" 																newl
			"PUSH(IMM(" (number->string (+ 3 num-of-args))"));" 	newl
			"PUSH(FP);"									  												newl
			"MOV(R2, FP);" 																				newl
			"SUB(R2, 4);" 																				newl 
			"SUB(R2, FPARG(1));" 																	newl 
			"PUSH(R2);     " 																			newl
			"CALL(STACKCPY);" 																		newl
			
			; update fp
			"MOV(FP, R1); " 																			newl
			"ADD(R2, " (number->string (+ 3 num-of-args)) ");" 		newl
			"MOV(SP, R2);" 																				newl
			; jump to function
			"JUMPA((void *) INDD(R0, 2));" 												newl
		))
	))

;; ------------------- lambda code gen -------------------- ;;

(define cgen-lambda-code 
	(lambda (pe body env-len params-len)
		(let 
			;;ribs
			((label-code (lambda-label))
			 (label-code-done (lambda-label-done)))
		;;body
		(string-append 
																													newl 
			"//---lambda-code---"																newl

			"// Init env " 																			newl
			"PUSH(IMM(" (number->string (+ 1 env-len)) "));" 		newl
			"CALL(MALLOC);" 																		newl 
			"DROP(1);" 																					newl
			;; Back up env pointer
			"MOV(R1, R0);" 																			newl
			; Create new env
			(if (zero? env-len)
				"MOV(INDD(R1, 0), SOB_NIL);"
				(string-append 
					; Copy ENV
					"// Copying old env "	 																								newl
					"MOV(R2, FPARG(0));" 																									newl

	        "for(i=0, j=1 ; i < " (number->string env-len) "; ++i, ++j)" 					newl
	        "{"																																		newl
					"		MOV(INDD(R1,IMM(j)), INDD(R2, IMM(i)));" 													newl
	        "}" 																																	newl newl

					"// Allocate memory for env" 																					newl 
					"PUSH(FPARG(IMM(1)));" 																								newl
					"CALL(MALLOC);" 																											newl
					"DROP(1);" 																														newl newl

					"// Expand env with params" 																					newl
					"for (i=0;i<FPARG(IMM(1));++i)" 																			newl
					"{"																																		newl
	        "  	MOV(INDD(R0,i),FPARG((IMM(2+i))));" 															newl
	        "}" 																																	newl newl

	    		"// Update env "																											newl
					"MOV(INDD(R1, 0), R0);" 																							newl
				)
			)
			
			;; Make closure object
			"PUSH(LABEL(" label-code "));" 					newl newl
			"PUSH(R1);" 																newl 
			"CALL(MAKE_SOB_CLOSURE);" 									newl 
			"DROP(2);" 																	newl

			; Finished builder closure
			"JUMP(" label-code-done ");" 								newl
			; Function code
			label-code ":" 															newl
			"PUSH(FP);" 																newl
	  	"MOV(FP, SP);"															newl
			body 																				newl
			"POP(FP);" 																	newl 
			"RETURN;" 																	newl

			label-code-done ":" 												newl
		))
	))

(define cgen-lambda-simple
	(lambda (pe env-len params-len)
		(let
				;;ribs 
				((compiled-body (cgen (cadr pe) (+ 1 env-len) params-len)))
			;;body
			(cgen-lambda-code pe compiled-body env-len params-len))
  ))

(define cgen-lambda-opt
	(lambda (pe env-len params-len)
		(let* 
			;; ribs
			((args (car pe))
			(num-of-args (length args))
			(body (caddr pe))
			(label-opt-loop (lambda-opt-loop))
			(label-opt-loop-done (lambda-opt-loop-done))
			(label-new-args (lambda-opt-new-args))
			(label-new-args-done (lambda-opt-new-args-done))
			(generated-body (cgen body (+ 1 env-len) params-len)))
		;; body
		(cgen-lambda-code pe (string-append

				"// ---lambda-opt--- " 	newl
				"// convert optional " 	newl
				"// arguments to list"  newl newl

				"MOV(R1, FPARG(1));" 		newl 
				"INCR(R1);" 						newl

				;; args to stack
				label-opt-loop ":" 																				newl
				"CMP(" (number->string (+ 1 num-of-args)) ", R1);" 				newl
				"JUMP_EQ(" label-opt-loop-done ");" 											newl
				"PUSH(FPARG(R1));" 																				newl
				"DECR(R1);" 																							newl
				"JUMP("label-opt-loop");" 																newl
				label-opt-loop-done ":" 																	newl

				"MOV(R1, FPARG(1));" 																			newl
				"SUB(R1, IMM(" (number->string num-of-args) "));" 				newl
				"PUSH(R1);" 																							newl
				"CALL(BUILD_LIST);" 																			newl
				"DROP(1);"																								newl
				"DROP(R1);" 																							newl

				"MOV(R3, SP);"																						newl
				"PUSH(R0);" 																							newl 					

				;; push args
				"MOV(R1, " (number->string (+ 1 num-of-args)) ");" 	newl
				label-new-args ":" 									newl 
				"CMP(1, R1);" 											newl
				"JUMP_EQ(" label-new-args-done ");" newl
				"PUSH(FPARG(R1));" 									newl
				"DECR(R1);" 												newl
				"JUMP(" label-new-args ");" 				newl
				label-new-args-done ":" 						newl 
				
				"PUSH(IMM(" (number->string (+ 1 num-of-args)) "));" 	newl
				"PUSH(FPARG(0));" 																		newl			
				"PUSH(FPARG(-1));" 																		newl			
				"PUSH(FPARG(-2));" 																		newl newl 		

				"PUSH(IMM(" (number->string (+ 5 num-of-args)) "));"  newl
				"PUSH(R3);  /* source */"  														newl
				"MOV(R3, FP);" 																				newl
				"SUB(R3, 4);" 																				newl 
				"SUB(R3, FPARG(1));" 																	newl 

				"PUSH(R3); /* destination */"  												newl
				"CALL(STACKCPY);" 																		newl
				"DROP(3);" 																						newl newl
																												
				"ADD(R3, " (number->string (+ 5 num-of-args)) ");" 		newl 	
				"MOV(FP, R3);" 																				newl 	 
				"MOV(SP, R3);" 																				newl 

				generated-body
			) env-len params-len)
		)
	))

(define cgen-lambda-variadic 
	(lambda (pe env-len params-len)
		(let* 
			;; ribs
			((body (cadr pe))
			(args (car pe))
			(label-var-loop (lambda-var-loop))
			(label-var-loop-done (lambda-var-loop-done))
			(generated-body (cgen body (+ 1 env-len) params-len)))
		;; body
		(cgen-lambda-code pe (string-append
				"// ---lamda-variadic--- " 	newl
				"MOV(R1, FPARG(1));" 				newl
				"INCR(R1);" 								newl

				label-var-loop ":" 									newl
				"CMP(1, R1);" 											newl
				"JUMP_EQ(" label-var-loop-done ");" newl
				"PUSH(FPARG(R1));" 									newl
				"DECR(R1);" 												newl
				"JUMP(" label-var-loop ");" 				newl
				label-var-loop-done ":" 						newl

				"PUSH(FPARG(1));" 		newl
				"CALL(BUILD_LIST);" 		newl
				"DROP(1);"						newl
				"DROP(FPARG(1));" 		newl 
				"MOV(R3, SP);" 				newl
				"PUSH(R0);" 					newl 					
				"PUSH(IMM(1));" 			newl				
				"PUSH(FPARG(0));" 		newl			
				"PUSH(FPARG(-1));" 		newl			
				"PUSH(FPARG(-2));" 		newl newl 	
				"PUSH(IMM(5));"  			newl
				"PUSH(R3);"  					newl
				"MOV(R3, FP);" 				newl
				"SUB(R3, 4);" 				newl 		
				"SUB(R3, FPARG(1));" 	newl 
				"PUSH(R3);" 					newl
				"CALL(STACKCPY);" 		newl
				"DROP(3);" 						newl newl							
				"ADD(R3, 5);" 				newl
				"MOV(FP, R3);" 				newl	 
				"MOV(SP, R3);" 				newl

				generated-body
			) env-len params-len)
		)
	))

(define cgen
	(lambda (pe env-len params-len) 
		; (disp pe "cgen")
		(cond 
			((const-pe? pe) (cgen-const (cadr pe)))
			((seq-pe? pe) (cgen-seq (cadr pe) env-len params-len))
			((if3-pe? pe) (cgen-if3 (cdr pe) env-len params-len))
			((or-pe? pe) (cgen-or (cadr pe) env-len params-len))
			((lambda-simple-pe? pe) (cgen-lambda-simple (cdr pe) env-len params-len))
			((lambda-opt-pe? pe) (cgen-lambda-opt (cdr pe) env-len params-len))
			((lambda-var-pe? pe) (cgen-lambda-variadic (cdr pe) env-len params-len))
			((applic-pe? pe) (cgen-applic (cdr pe) env-len params-len))
			((tc-applic-pe? pe) (cgen-tc-applic (cdr pe) env-len params-len))
			((define-pe? pe) (cgen-define (cdr pe) env-len params-len))
			((bvar-pe? pe) (cgen-bvar (cdr pe)))
			((pvar-pe? pe) (cgen-pvar (cdr pe)))
			((fvar-pe? pe) (cgen-fvar (cdr pe)))
			((set-pe? pe) (cgen-set (cdr pe) env-len params-len))
			((box-pe? pe) (cgen-box (cadr pe) env-len params-len))
			((box-set-pe? pe) (cgen-box-set (cdr pe) env-len params-len))
			((box-get-pe? pe) (cgen-box-get (cadr pe) env-len params-len))

			(else (compilation-error "Unsupported symbol" pe))
		)))

(define cgen-lst 
	(lambda (pexprs)
		; (disp pexprs "code-gen-lst")
		(if (null? pexprs) 
				""
				(string-append 
					(cgen (car pexprs) 0 0)
					(cgen-lst (cdr pexprs))
		))))

(define get-const-occur
	(lambda (pe)
		(cond 
			((null? pe) (list))
			((not (pair? pe)) (list))
			((eq? (car pe) 'const) (handle-const (cadr pe)))
			(else `(,@(get-const-occur (car pe)) ,@(get-const-occur (cdr pe))))
		)
))

(define handle-const
	(lambda (exp)
		(cond
			((pair? exp)
				`(,@(handle-const (car exp)) ,@(handle-const (cdr exp)) ,exp))
			((symbol? exp)
				`(,(symbol->string exp) ,exp))
			((vector? exp)
				`(,@(apply append (map handle-const (vector->list exp))) ,exp))
			(else `(,exp)))
))

;; ======================================================================================================================
;; 																						Const table functions
;; ======================================================================================================================

(define const-table
	`(
		(2 T_VOID ,(if #f #f))
		(3 T_NIL ())
		(4 T_BOOL #t)
		(6 T_BOOL #f)
		(8 T_INTEGER 0)
	 )
)

(define print-ct 
	(lambda ()
		display const-table))

(define ct-next-index 10)

(define is-in-ct?
	(lambda (const)
		(not (null? (get-from-ct const)))
	)	
)

(define get-from-ct
	(lambda (const)
		(if (symbol? const)
				(get-from-ct-helper (symbol->string const))
				(get-from-ct-helper const))
	))

(define get-from-ct
	(lambda (const)
		(letrec ((find 
			(lambda (lst)
				(if (null? lst)
						'()
						(let ((const-entry (car lst)))
								(if (equal? const (caddr const-entry))
										(car const-entry)
										(find (cdr lst)))
								)))))
		(find const-table)
	)))

(define add-to-ct
	(lambda (const)
		; (disp const "In add-to-ct with: ")
		; (disp (symbol? const) "Is symbol?: ")
		(cond
			((is-in-ct? const) (void))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((integer? const)
				; (disp const "In integer?")
				(begin 	(set! const-table `(,@const-table ,(list ct-next-index 'T_INTEGER const)))
								(set! ct-next-index (+ ct-next-index 2))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((rational? const)
				; (disp const "In rational?")
				(begin (set! const-table `(,@const-table ,(list ct-next-index 'T_FRACTION const)))
							 (set! ct-next-index (+ ct-next-index 4))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((boolean? const) 
				(begin 	(set! const-table `(,@const-table ,(list ct-next-index 'T_BOOL const)))
								(set! ct-next-index (+ ct-next-index 2))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((char? const)
				; (disp const "added char to constant table")
				(begin 	(set! const-table `(,@const-table ,(list ct-next-index 'T_CHAR const)))
								(set! ct-next-index (+ ct-next-index 2))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((string? const) 
				; (disp const "added string to constant table")
				(begin	(set! const-table `(,@const-table ,(list ct-next-index 'T_STRING const)))
								(set! ct-next-index (+ ct-next-index 1 1 (string-length const)))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((symbol? const)
				; (disp const "added symbol to constant table")
				(begin 	(set! const-table `(,@const-table ,(list ct-next-index 'T_SYMBOL const)))
								(set! ct-next-index (+ ct-next-index 2 3))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((vector? const)
				(begin 	(set! const-table `(,@const-table ,(list ct-next-index 'T_VECTOR const)))	
								(set! ct-next-index (+ ct-next-index 2 (vector-length const)))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((pair? const) 
				(begin	(set! const-table `(,@const-table ,(list ct-next-index 'T_PAIR const)))
								(set! ct-next-index (+ ct-next-index 3))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	)))

(define add-consts-to-table
	(lambda (consts)
		(cond
			((null? consts)  void)
			(else
				(begin (add-to-ct (car consts))
				(add-consts-to-table (cdr consts)))
			)
		)))


;; ======================================================================================================================
;; 																						Symbols | Fvar
;; ======================================================================================================================

(define primitive-symbols
  '(apply boolean? car cdr char->integer char? cons eq? integer? integer->char make-string make-vector
	null? pair? number? procedure? remainder set-car! set-cdr!
	string-length string-ref string-set! string->symbol string?
	symbol? symbol->string vector-length vector-ref
	vector-set! vector? zero? + - * / = < void?))

(define symbol-table '())

(define (get-all-symbols pe)
	(cond 
		((null? pe) (list))
		((not (pair? pe)) (list))
		((eq? (car pe) 'fvar) (cdr pe))
		(else `(,@(get-all-symbols (car pe)) ,@(get-all-symbols (cdr pe))))
	))

(define add-symbols-to-table
	(lambda (symbol-list next-free-index)
		(letrec
		((helper (lambda (symbol-list index)
			(cond
				((or (null? symbol-list) (not (pair? symbol-list))) '())
			    (else
			    	(cons (cons index (car symbol-list)) (helper (cdr symbol-list) (add1 index)))
			    ))
		)))
		(set! symbol-table (helper symbol-list next-free-index)))
	))

;; Cgen Symbol talble
(define cgen-st
	(lambda (symbol-table) 
		(cond
			((or (null? symbol-table) (not (pair? symbol-table))) "")
	    (else
	    	(string-append
	    		"\n// Space for sym: " (symbol->string (cdar symbol-table)) 	newl
	    		"PUSH(IMM(1));"																					newl
	    		"CALL(MALLOC);"																					newl
	    		"DROP(1);"																							newl
	    		"MOV(IND(R0), T_VOID);"																	newl
	    		(cgen-st (cdr symbol-table))																							
		)))
	))

(define find-symbol
	(lambda (sym)
		; (disp sym "find-symbol")
		(letrec 
			((helper 
				(lambda (symbol lst)
						(cond 
							((or (null? lst) (not (pair? lst))) #f)
					    	((eq? symbol (cdar lst)) (car lst))
					    	(else (helper symbol (cdr lst)))
					    )	
					)))
		(helper sym symbol-table)
		)
))


;; ==================================================
;;   Primitives
;; ==================================================

(define (get-primitive-label name)
	(cond  
		((equal? name "apply") "PAPPLY") ; apply 
		((equal? name "+") "PLUS") ; + variadic
		; < variadic
		; > variadic
		((equal? name "-") "MINUS") ; - not yet variadic
		((equal? name "=") "EQUAL_MATH") ; = variadic
		((equal? name "/") "DIVIDE"); / not yet variadic
		((equal? name "*") "MULTIPLY"); * not yet variadic
		((equal? name "boolean?") "IS_BOOL") ; boolean?
		((equal? name "car") "CAR") ; car 
		((equal? name "cdr") "CDR") ; cdr
		((equal? name "char?") "IS_CHAR") ; char?
		((equal? name "cons") "CONS") ; cons
		((equal? name "denominator") "DENOMINATOR") ; denominator
		((equal? name "eq?") "IS_EQ") ; eq?
		((equal? name "integer?") "IS_INTEGER") ; integer?
		((equal? name "char->integer") "CHAR_TO_INTEGER") ; char->integer
		((equal? name "integer->char") "INTEGER_TO_CHAR") ; integer->char
		((equal? name "list") "LIST") ; list variadic
		((equal? name "make-string") "MAKE_STRING") ; make-string
		((equal? name "make-vector") "MAKE_VECTOR") ; make-vector
		; map
		((equal? name "not") "NOT"); not
		((equal? name "null?") "IS_NILL") ; null?
		((equal? name "number?") "IS_NUMBER") ; number?
		((equal? name "numerator") "NUMERATOR"); numerator
		((equal? name "pair?") "IS_PAIR") ; pair?
		((equal? name "procedure?") "IS_CLOSURE") ; procedure?
		((equal? name "rational?") "IS_RATIONAL") ; rational?
		((equal? name "remainder") "REMAINDER") ; remainder
		((equal? name "set-car!") "SET_CAR") ; set-car!
		((equal? name "set-cdr!") "SET_CDR") ; set-cdr!
		((equal? name "string-length") "STRING_LENGTH") ; string-length
		((equal? name "string-ref") "STRING_REF") ; string-ref
		((equal? name "string-set!") "STRING_SET") ; string-set!
		((equal? name "string->symbol") "STRING_TO_SYMBOL"); string->symbol
		((equal? name "string?") "IS_A_STRING") ; string?
		((equal? name "symbol?") "IS_SYMBOL") ; symbol?
		((equal? name "symbol->string") "SYMBOL_TO_STRING") ; symbol->string
		((equal? name "vector-length") "VECTOR_LENGTH") ; vector-length
		((equal? name "vector-ref") "VECTOR_REF") ; vector-ref
		((equal? name "vector-set!") "VECTOR_SET") ; vector-set!
		((equal? name "vector?") "IS_VECTOR") ; vector?
		((equal? name "zero?") "ZERO") ; zero?
	  (else #f)
	)
)

(define (primitives-cg symbol-table)
	(cond
		((or (null? symbol-table) (not (pair? symbol-table))) "")
		((get-primitive-label (symbol->string (cdar symbol-table))) (string-append
			"PUSH(LABEL(" (get-primitive-label (symbol->string (cdar symbol-table))) "));" newl
			"PUSH(IMM(SOB_NIL));" newl
			"CALL(MAKE_SOB_CLOSURE);" newl
			"DROP(2);" newl
			"MOV(IND(" (number->string (caar symbol-table)) "), R0);" newl newl
			(primitives-cg (cdr symbol-table))
		))
	    (else
	    	(primitives-cg (cdr symbol-table))
	    )
	)
)

;; ===================================
;;         Program Start
;; ===================================

; Read sexpr's from file
(define read-input-file
	(lambda (file-path)
		(let ((input (open-input-file file-path)))
			(letrec ((run 
						(lambda () 
							(let ((e (read input)))
								(if (eof-object? e)
									(begin (close-input-port input)
										'())
									(cons e (run)))))))
			(run)))))

(define test
	(lambda (filename)
		(read-input-file filename)))

(define run-parsing
	(lambda (list-of-exprs)
		(map (lambda (exp) 
			(annotate-tc(pe->lex-pe(box-set(remove-applic-lambda-nil(eliminate-nested-defines(parse exp)))))))
			list-of-exprs)))

;; Compile scheme file to CISC
(define compile
	(lambda (file-in file-out)
		;(system (string-append  "rm -f " file-out))
		(let* 
				;; ribs
				(
				; (helper-code (read-input-file "helper-functions.scm"))
				(input-exprs (read-input-file file-in))
				; (exprs (append helper-code input-exprs))
				(parsed-exprs (run-parsing input-exprs))
				(consts-list (get-const-occur parsed-exprs))
				(partial-symbol-list (rm-lst-dups (get-all-symbols parsed-exprs)))
				(symbol-list (rm-lst-dups (append primitive-symbols partial-symbol-list)))
				(out-pipe (open-output-file file-out)))

				;; add consts to table
				(add-consts-to-table consts-list)

				;; add symbols to table
				(add-symbols-to-table partial-symbol-list ct-next-index)


				;; body
				;; ==== Write to CISC generated output file ====

				; (disp consts-list "compile-const")
				; (disp symbol-list "compile-symbol")
				; (disp const-table "compile-const-table")
				; (disp symbol-table "symbol-table")
				; (display "=========================")
				; (display "\n")

				(display 

				(string-append 

				"#include <stdio.h>" 										newl 
				"#include <string.h>" 									newl
				"#include <string.h>" 									newl

				"#include \"cisc.h\"" 									newl newl
				

				"int main()" 														newl
				"{" 																		newl 

				"START_MACHINE;" 												newl newl
				"JUMP(CONTINUE);"												newl 

				"#define DO_SHOW 1"											newl newl			
				"int i,j;"															newl newl

				"#define SOB_SYM_LIST 1"								newl
				"#define SOB_VOID  2"										newl							
				"#define SOB_NIL   3"										newl
				"#define SOB_BOOL_TRUE 4"								newl
				"#define SOB_BOOL_FALSE 6"							newl
				"#define SOB_ZERO 8"   									newl newl

				"#include \"char.lib\""									newl	
				"#include \"io.lib\""										newl
				"#include \"math.lib\""									newl
				"#include \"string.lib\""								newl
				"#include \"system.lib\""								newl
				"#include \"scheme.lib\""								newl
				"#include \"builtins.lib\""							newl newl

				"CONTINUE:"															newl newl

				"/*==================*/" 	newl
				"/* Init symbol list */" 	newl
				"/*==================*/" 	newl

				"PUSH(1);" 							 	newl
				"CALL(MALLOC);" 					newl
				"DROP(1);" 								newl
				"MOV(IND(R0), SOB_NIL);" 	newl

				newl
				newl
				"/*=============================*/" 		newl
				"/*   Const table cgen code     */" 		newl
				"/*=============================*/" 		newl newl
				(cgen-ct)

				newl
				newl
				"/*=============================*/" 		newl
				"/*   Symbol table cgen code    */" 		newl
				"/*=============================*/" 		newl newl
				(cgen-st symbol-table)


				"/**************************************************/" newl
				"/* Update primitive symbols */" newl
				"/**************************************************/" newl newl
				(primitives-cg symbol-table)

				newl
				newl
				"/*=============================*/" 		newl
				"/*         Compiled code       */" 		newl
				"/*=============================*/" 		newl newl
				(cgen-lst parsed-exprs)        		

				newl
				newl
				"/*==============================*/" 		newl
				"/*    Finished compiling code   */"		newl
				"/*==============================*/"		newl


				"/* Display result on STDOUT */"			  newl
				"PUSH(R0);"															newl
				"CALL(WRITE_SOB);"											newl
				"DROP(1);"															newl newl
				"OUT(2,10);"														newl

				"STOP_MACHINE;"													newl
				"	return 0;"														newl newl

				"L_RUNTIME_ERROR:"											newl
				"	printf(\"Error :( !\\n\");"				newl newl

				"STOP_MACHINE;"													newl newl

				"return 1;"															newl
				"}"																			newl																		

				) out-pipe)

				(close-output-port out-pipe)
				)))
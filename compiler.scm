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
(define (lamdda-simple-pe? exp) (^eq? exp 'lambda-simple))
(define (lambda-opt-pe? exp) (^eq? exp 'lambda-opt))
(define (lambda-var-pe? exp) (^eq? exp 'lambda-var))
(define (const-pe? exp) (^eq? exp 'const))
(define (define-pe? exp) (^eq? exp 'def))
(define (seq-pe? exp) (^eq? exp 'seq))
(define (or-pe? exp) (^eq? exp 'or))

(define ^make-label
	(lambda (label-name)
		(let ((n 0))
			(lambda ()
				(set! n (+ n 1))
				(string-append label-name (number->string n))
		))))

(define if3-label-else (^make-label "L_IF3_ELSE"))
(define if3-label-done (^make-label "L_IF3_DONE"))



(define newl (list->string (list #\newline)))


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
							;; ribsW
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
									((eq? type 'T_CHAR) (let ((arg (char->number val)))
												(string-append
												"// Making CHAR object"	 								newl
		    								"PUSH(IMM(" (number->string arg) "));"	newl
												"CALL(MAKE_SOB_CHAR);"									newl
												"DROP(1);"															newl newl
												)))
									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_INTEGER) (string-append 
												"// Making INT object"									newl
		    								"PUSH(IMM("(number->string val)"));"		newl
												"CALL(MAKE_SOB_INTEGER);"								newl
												"DROP(1);"															newl newl
												))
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
									((eq? type 'T_SYMBOL) (let* 
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
												"MOV(IND(SOB_SYM_LIST), R0);" 								newl
												)))

									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_PAIR) 
												(disp val "cgen-TPAIR:")
												(string-append

												"// Makeing PAIR object"																				newl
												"PUSH(IMM(" (number->string (get-from-ct (cdr val))) "));"			newl
		    								"PUSH(IMM(" (number->string (get-from-ct (car val))) "));"			newl
												"CALL(MAKE_SOB_PAIR);"																					newl
												"DROP(2);"																											newl
												))
									;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									((eq? type 'T_VECTOR) (string-append

												))
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
	(lambda (pe)
		(let 
				;; ribs
				((test (cgen (car pe)))
				 (then (cgen (cadr pe)))
				 (else (cgen (caddr pe)))
				 (label-else (if3-label-else))
				 (label-done (if3-label-done)))
			;;body 
			(string-append
					"//--if3-- exp " newl
					test newl
					"CMP(R0, IMM(SOB_BOOL_FALSE));" newl
					"JUMP_EQ(" label-else ");" newl
					then newl
					"JUMP(" label-done ");" newl
					label-else ":" newl
					else newl
					label-done ":" newl)
		)))

(define cgen-const
	(lambda (pe)
		(string-append "MOV(R0, IMM(" (number->string  (get-from-ct pe)) "));\n")
	))

(define cgen
	(lambda (pe) 
		(cond 
			((const-pe? pe) (cgen-const (cadr pe)))
			; ((seq-pe? pe) (cgen-seq (cadr pe)))
			((if3-pe? pe) (cgen-if3 (cdr pe)))
			; ((or-pe?) pe) (cgen-or ())
			; ((pvar-pe? exp)  )
			; ((bvar-pe? exp)  )
			; ((fvar-pe? exp)  )
			; ((applic-pe? exp) )
			(else (compilation-error "Unsupported symbol" pe))
		)))


(define cgen-lst 
	(lambda (pexprs)
		; (disp pexprs "code-gen-lst")
		(if (null? pexprs) 
				""
				(string-append 
					(cgen (car pexprs))
					(cgen-lst (cdr pexprs))
		))))

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
	 )
)

(define print-ct 
	(lambda ()
		display const-table))

(define ct-next-index 8)

(define is-in-ct?
	(lambda (const)
		(not (null? (get-from-ct const)))
	)	
)

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
		(cond
			((is-in-ct? const) (void))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((number? const)
				(begin 	(set! const-table `(,@const-table ,(list ct-next-index 'T_INTEGER const)))
								(set! ct-next-index (+ ct-next-index 2))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((boolean? const) 
				(begin 	(set! const-table `(,@const-table ,(list ct-next-index 'T_BOOL const)))
								(set! ct-next-index (+ ct-next-index 2))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((char? const)
				(begin 	(set! const-table `(,@const-table ,(list ct-next-index 'T_CHAR const)))
								(set! ct-next-index (+ ct-next-index 2))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((string? const) 
				(begin	(set! const-table `(,@const-table ,(list ct-next-index 'T_STRING const)))
								(set! ct-next-index (+ ct-next-index 1 1 (string-length const)))))
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			((symbol? const)
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


; (add-to-ct 0)
; (add-to-ct 1)
; (add-to-ct 2)
; (add-to-ct 3)
; (add-to-ct 4)
; (add-to-ct 5)
; (add-to-ct 6)
; (add-to-ct 7)
; (add-to-ct 8)
; (add-to-ct 9)

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
	vector-set! vector? zero? bin+ bin- bin* bin/ bin=? bin<? void?))

(define symbols-table '())

(define (get-all-symbols pe)
	(cond 
		((null? pe) (list))
		((not (pair? pe)) (list))
		((eq? (car pe) 'fvar) (cdr pe))
		(else `(,@(get-all-symbols (car pe)) ,@(get-all-symbols (cdr pe))))
	))

(define add-symbols-to-table
	(lambda (symbol-list next-free-index)
		'()
		))

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
		(system (string-append  "rm -f " file-out))
		(let* 
				;; ribs
				((input-exprs (read-input-file file-in))
				(parsed-exprs (run-parsing input-exprs))
				(consts-list (get-const-occur parsed-exprs))
				(partial-symbol-list (rm-lst-dups (get-all-symbols parsed-exprs)))
				(symbol-list (rm-lst-dups (append primitive-symbols partial-symbol-list)))
				(out-pipe (open-output-file file-out)))

				;; add consts to table
				(add-consts-to-table consts-list)

				;; add symbols to table
				(add-symbols-to-table symbol-list ct-next-index)


				;; body
				;; ==== Write to CISC generated output file ====

				; (disp consts-list "compile-const")
				; (disp symbol-list "compile-symbol")
				; (display "=========================")

				(display 

				(string-append 

				"#include <stdio.h>" 										newl 
				"#include <string.h>" 									newl
				"#include <string.h>" 									newl

				"#include \"cisc.h\"" 									newl newl
				
				"#define DO_SHOW 1"											newl newl				

				"int main()" 														newl
				"{" 																		newl 

				"START_MACHINE;" 												newl newl
				"JUMP(CONTINUE);"												newl 

				"#define SOB_SYM_LIST 1"								newl
				"#define SOB_VOID  2"										newl							
				"#define SOB_NIL   3"										newl
				"#define SOB_BOOL_TRUE 4"								newl
				"#define SOB_BOOL_FALSE 6"							newl newl

				"#include \"char.lib\""									newl	
				"#include \"io.lib\""										newl
				"#include \"math.lib\""									newl
				"#include \"string.lib\""								newl
				"#include \"system.lib\""								newl
				"#include \"scheme.lib\""								newl newl
				; "#include \"builtins.lib\""							newl newl

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
				"OUT(2,10)"	newl

				"STOP_MACHINE;"													newl
				"	return 0;"														newl newl

				"L_RUNTIME_ERROR:"											newl
				"	printf(\"Runtime error!\\n\");"				newl newl

				"STOP_MACHINE;"													newl newl

				"return 1;"															newl
				"}"																			newl																		

				) out-pipe)

				(close-output-port out-pipe)
				)))
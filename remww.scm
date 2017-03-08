

(define bottoms-up
	(lambda (code-lines)
		(reverse code-lines)))


(define remww 
	(lambda (input) 
			(let*
				;; ribs
				((bottoms-up-instructions (bottoms-up input))
				(writes (caddar bottoms-up-instructions))
				(reads (cadar bottoms-up-instructions))
				(first-instruction (list (car bottoms-up-instructions)))
				(rest-instructions (cdr bottoms-up-instructions)))
				;; body 
				(build-code 
					(filter-unused-instructions writes reads) 
					rest-instructions 
					first-instruction '() '())
			)
		))


(define remove-element
	(lambda (element lst)
		(remove element lst)))

(define filter-unused-instructions
	(lambda (writes reads)
		(if (null? reads)
			writes
			(let*
				;; ribs
				((ele (car reads))
				(rest-ele (cdr reads))
				(without-ele (remove-element ele writes)))
				;;body
				(filter-unused-instructions without-ele rest-ele)
			))
		)
	)

(define get-writes (lambda (instruction) (caddr instruction)))
(define get-reads (lambda (instruction) (cadr instruction)))
(define get-instruction (lambda (code) (car code)))

(define all-vars-writen-to 
	(lambda (writes-to writes) 
		(andmap (lambda (variable) (member variable writes-to)) writes)
		))

(define build-code 
	(lambda (writes-to instructions new-instructions l1 l2)
		(if (null? instructions) 
				;; then
				new-instructions
				;; else
				(let* 
					;; ribs
					((instruction (get-instruction instructions))
					(rest-instructions (cdr instructions))		
					(writes (get-writes instruction))
					(reads (get-reads instruction)))
					;; body
					(cond 
						((null? reads) (build-code writes-to rest-instructions new-instructions l1 l2))
						((null? writes) (build-code writes-to rest-instructions new-instructions l1 l2))
						((all-vars-writen-to writes-to writes) (build-code writes-to rest-instructions new-instructions l1 l2))
						(else (build-code (filter-unused-instructions `(,@writes ,@writes-to) reads) rest-instructions `(,instruction ,@new-instructions) l1 l2)))
				))
		))


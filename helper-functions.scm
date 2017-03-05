



(define *
  (letrec ((loop
	    (lambda (s)
	      (if (null? s)
		  1
		  (bin* (car s)
			(loop (cdr s)))))))
    (lambda s (loop s))))
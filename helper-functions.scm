(define cadr 
	(lambda (x) (car (cdr x))))

(define cdar 
	(lambda (x) (cdr (car x))))

(define caar 
	(lambda (x) (car (car x))))

(define cddr 
	(lambda (x) (cdr (cdr x))))

(define caddr 
	(lambda (x) (car (cdr (cdr x))))) 

(define cdadr 
	(lambda (x) (cdr (car (cdr x))))) 

(define cdaadr 
	(lambda (x) (cdr (car (car (cdr x))))))

(define caadr 
	(lambda (x) (car (car (cdr x))))) 

(define cdaar 
	(lambda (x) (cdr (car (car x))))) 

(define cdddr 
	(lambda (x) (cdr (cdr (cdr x))))) 

(define caaar 
	(lambda (x) (car (car (car x))))) 

(define caaadr 
	(lambda (x) (car (car (car (cdr x))))))

(define caaddr 
	(lambda (x) (car (car (cdr (cdr x))))))

(define cadddr 
	(lambda (x) (car (cdr (cdr (cdr x))))))

(define cddddr 
	(lambda (x) (cdr (cdr (cdr (cdr x))))))

(define caaaar 
	(lambda (x) (car (car (car (car x))))))


(define map
  ((lambda (y) 
     ((lambda (map1) 
	((lambda (maplist) 
	   (lambda (f . s) 
	     (maplist f s))) 
	 (y (lambda (maplist) 
	      (lambda (f s) 
		(if (null? (car s)) '() 
		    (cons (apply f (map1 car s)) 
			  (maplist f (map1 cdr s))))))))) 
      (y (lambda (map1) 
	   (lambda (f s) 
	     (if (null? s) '() 
		 (cons (f (car s)) 
		       (map1 f (cdr s))))))))) 
   (lambda (f) 
     ((lambda (x) 
	(f (lambda (y z)
	     ((x x) y z))))
      (lambda (x) 
	(f (lambda (y z)
	     ((x x) y z))))))))

(define last-pair


(define append-helper2
	  (lambda (x y)
	      (if (null? x) y
		  (cons (car x)
		   (append-helper2 (cdr x) y)))))

(define append-helper1
	(lambda (x y)
	      (if (null? y) x
		  (append-helper2 x (append-helper1 (car y) (cdr y))))))

(define append
    (lambda x
      (if (null? x) '()
	  (append-helper1 (car x) (cdr x))))))
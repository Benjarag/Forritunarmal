
(define (my_append L M)
  (cond ((null? L) M)
        ((null? M) L)
        (else (cons (car L) (append (cdr L) M)))
  )
)

;(my_append '(1 3 5) '(2 4 6))
;(my_append '(1 3 5) '(1 4 5))

(define (strip elem lis)
  (cond ((null? elem) lis)
        ((null? lis) '())
        ((= elem (car lis)) (strip elem (cdr lis)))
        (else lis)
  )
)
  
;(strip 1 '(1 1 1 2 3 1 1))
;(strip 2 '(3 1 2 1 4 5))


(define (flatten list)
  (lambda (lis)
    (list (car lis) (cadr lis))
    )
  )

;((flatten +) '(2 3))
;((flatten *) '(2 3))


(define (sorted? lis)
  (or (null? lis)
      (null? (cdr lis))
      (and (<= (car lis) (cadr lis))
           (sorted? (cdr lis))
           )
      )
  )

;(sorted? '(1))
;(sorted? '(1 2 2 3 3))
;(sorted? '(5 6 7 2))
;(sorted? '())


(define (apply_functions funcs x y)
  (map (lambda (f) (f x y)) funcs))

;(display (apply_functions (list + * max) 4 2))
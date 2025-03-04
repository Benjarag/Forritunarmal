
(define (merge L M)
  (cond ((null? L) M)
        ((null? M) L)
        ((< (car L) (car M)) (cons (car L) (merge (cdr L) M)))
        (else (cons (car M) (merge L (cdr M))))
  )
)

(merge '(1 3 5) '(2 4 6))
(merge '(1 3 5) '(1 4 5))

(define (first_k lis k)
  (cond ((null? lis) '())
        ((= k 0) '())
        (else (cons (car lis) (first_k (cdr lis) (- k 1))))
  )
)

(first_k '(1 2 3 4 5) 3)
(first_k '() 2)


(define (rest_k lis k)
  (cond ((null? lis) '())
        ((= k 0) lis)
        (else (rest_k (cdr lis) (- k 1)))
  )
)
    
(rest_k '(1 2 3 4 5) 3)
(rest_k '() 2)


(define (merge_sort lis)
  (cond ((<= (length lis) 1) lis)
        (else (let ((half (quotient (length lis) 2)))
             (merge
               (merge_sort (first_k lis half))
               (merge_sort (rest_k lis half)))))
  )
)
         
(merge_sort '(3 6 5 7 2 3))
(merge_sort '(3 6 5 7 2))


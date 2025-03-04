(define (doubleList lis) 
  (map (lambda(x) (* x 2)) lis)
)

(define (tripleList lis) 
  (map (lambda(x) (* x 3)) lis)
)

(define (multList n lis)
  (map (lambda(x) (* x n)) lis)
)

(define (multListFunc n)
  (lambda(lis) (multList n lis)) 
)

(define doubleList (multListFunc 2))
(define tripleList (multListFunc 3))


(define (operList n op lis)
  (map (lambda(x) (op n x)) lis)
)

(define (operListFunc n op)
  (lambda(lis) (operList n op lis))
)

(define doubleList (operListFunc 2 *))
(define tripleList (operListFunc 3 *))
(define addOneList (operListFunc 1 +))
(define addThreeList (operListFunc 3 +))
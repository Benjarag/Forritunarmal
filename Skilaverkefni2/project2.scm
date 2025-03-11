(declare (unit project2))
(import (chicken sort))

; 1. (30%) Ýmis föll / Various functions

; a. (6%) `lessthan`  
; Skrifið fallið `lessthan` sem tekur lista `lis` sem fyrsta viðfang og  
; atom `k` sem seinna viðfang. Fallið skilar nýjum lista sem inniheldur stök úr  
; `lis` sem eru minni en `k`.

(define (lessthan lis k)
  (cond ((null? lis) '())
        ((> k (car lis)) (cons (car lis) (lessthan (cdr lis) k)))
        (else (lessthan (cdr lis) k))
        )
)


; Prófunartilvik:  
; (lessthan '(1 5 3 2 4) 3)  
; => '(1 2)  


; b. (6%) `duplicate`  
; Skrifið fallið `duplicate` sem tvítekur sérhvert stak í  
; viðfangslistanum. Fyrir gefinn lista `(a1 a2 ... an)` skilar fallið listanum `(a1 a1 a2 a2 ... an an)`.  

(define (duplicate lis)
  (cond ((null? lis) '())
        (else (cons (car lis) (cons (car lis) (duplicate (cdr lis)))))
        )
)


; Prófunartilvik:  
; (duplicate '(1 2 3 4))  
; => '(1 1 2 2 3 3 4 4)  


; c. (6%) `delete`  
; Skrifið fallið `delete` sem tekur lista `lis` og heiltölu `i` sem viðföng  
; og skilar afriti af listanum `lis` en þó án `i`-ta staksins (fyrsta stakið er `i=1`).  
; Ef lengdin á `lis` er minni en `i`, þá skal skila `lis`. Þið megið nota  
; innbyggða fallið `length` í lausnina ykkar.  

(define (delete lis i)
  (cond ((null? lis) '())
        ((= i 1) (cdr lis))
        (else (cons (car lis) (delete (cdr lis) (- i 1))))
        )
)

; Prófunartilvik:  
; (delete '(2 5) 3)  
; => '(2 5)  

; (delete '(2 5 1 3 4) 3)  
; => '(2 5 3 4)  


; d. (6%) `comp`  
; Skilgreinið fallið `comp` á eftirfarandi hátt:  
; (define (comp f g) (lambda (x) (f (g x))))  

; Skilgreinið síðan fallið `dupl_square` sem kallar á fallið `comp` með  
; `f=duplicate` og `g=` lambda segð sem stendur fyrir fall sem setur sérhvert  
; stak í inntakslista í annað veldi.  

(define (comp f g) (lambda (x) (f (g x))))

(define dupl_square (comp duplicate (lambda (x) (map (lambda (y) (* y y)) x))))


; Prófunartilvik:  
; (dupl_square '(1 2 3 4))  
; => '(1 1 4 4 9 9 16 16)  


; e. (6%) `sequence`  
; Skrifið fallið `sequence` sem tekur heiltölu `n` sem viðfang og skilar  
; listanum `(1 2 ... n-1 n)`. Þið þurfið á hjálparfalli að halda.  

(define (helper current n)
    (if (> current n) '() (cons current (helper (+ current 1) n))))

(define (sequence n)
  (if (<= n 0) '() (helper 1 n)))


; Prófunartilvik:  
; (sequence 6)  
; => '(1 2 3 4 5 6)  

; (sequence 0)  
; => '()  


; ---  


; 2. (30%) Mengi / Sets  

; Í þessum hluta megið þið nota innbyggðu föllin `member`, `append` og `sort`  
; (og auðvitað grunnföllin).  

; a. (6%) `make_set`  
; Skrifið fallið `make_set` sem tekur lista `lis` sem viðfang og skilar  
; lista sem stendur fyrir raðað mengi (í hækkandi röð) af stökum úr `lis`.  

(define (remove-duplicates lis)
  (cond ((null? lis) '())
        ; checking if the first element exists in the rest of the list using member
        ; if it is, skip the first element and process the rest of the list
        ((member (car lis) (cdr lis)) (remove-duplicates (cdr lis)))
        ; if not, keep the first element and process the rest of the list
        (else (cons (car lis) (remove-duplicates (cdr lis))))
  )
)

(define (make_set lis)
  (sort (remove-duplicates lis) <)
)

; Prófunartilvik:  
; (make_set '(1 4 6 2 4 1 5 7 6 2))  
; => '(1 2 4 5 6 7)  


; b. (6%) `union`  
; Skrifið fallið `union` sem tekur röðuð mengi `set1` og `set2` sem  
; viðföng og skilar röðuðu sammengi þeirra.  

(define (union set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((< (car set1) (car set2)) (cons (car set1) (union (cdr set1) set2)))
        ((= (car set1) (car set2)) (cons (car set1) (union (cdr set1) (cdr set2))))
        (else (cons (car set2) (union set1 (cdr set2))))
  )
)

; Prófunartilvik:  
; (union '(1 2 4 5 6 ) '(3 4 5 7 8))  
; => '(1 2 3 4 5 6 7 8)


; c. (6%) `intersection`  
; Skrifið fallið `intersection` sem tekur röðuð mengi `set1` og  
; `set2` sem viðföng og skilar röðuðu sniðmengi þeirra.  

(define (intersection set1 set2)
  (cond ((null? set1) '())
        ((null? set2) '())
        ((= (car set1) (car set2)) (cons (car set1) (intersection (cdr set1) (cdr set2))))
        ((< (car set1) (car set2)) (intersection (cdr set1) set2))
        (else (intersection set1 (cdr set2))
        )
  )
)


; Prófunartilvik:  
; (intersection '(1 2 4 5 6 ) '(3 4 5 7 8))  
; => '(4 5)  


; d. (6%) `difference`  
; Skrifið fallið `difference` sem tekur röðuð mengi `set1` og `set2`  
; sem viðföng og skilar röðuðu mengi af stökum í `set1` sem eru ekki í `set2`.  

(define (difference set1 set2)
  (cond ((null? set1) '())
        ((null? set2) set1)
        ((< (car set1) (car set2)) (cons (car set1) (difference (cdr set1) set2)))
        ((= (car set1) (car set2)) (difference (cdr set1) (cdr set2)))
        (else (difference set1 (cdr set2)))     
  )
)

; Prófunartilvik:  
; (difference '(1 2 4 5 6 ) '(3 4 5 7 8))
; => '(1 2 6)


; e. (6%) `subset?`  
; Skrifið fallið `subset?` sem tekur röðuð mengi `set1` og `set2` sem  
; viðföng og skilar `true` ef `set1` er hlutmengi í `set2`.  

(define (subset? set1 set2)
  (null? (difference set1 set2)))


; Prófunartilvik:  
; (subset? '(2 3 4) '(1 2 3 4 5))  
; => #true  

; (subset? '(2 3 4) '(1 2 3 5))
; => #false  


; ---  


; 3. (20%) Shorten  

; a. (10%) `shorten`  
; Skrifið fallið `shorten` sem tekur fall `f` og lista `lis` `(y1 y2 ... ym)`, `m≥1`,  
; sem viðföng og skilar tölu `y`, þannig að:  
; y = (f y1 (f y2 ( f ... (f yn-1 yn)...)))  

(define (shorten f lis)
  (cond ((null? lis) 0)
  ((null? (cdr lis)) (car lis))
  (else (f (car lis) (shorten f (cdr lis))))
  )
)


; Prófunartilvik:  
; (shorten * '(2 4 1 3))  
; => 24  

; (shorten + '(2 4 1 3))  
; => 10  

; (shorten max '(2 4 1 3))  
; => 4  


; b. (10%) `shorten_all`  
; Skrifið fallið `shorten_all` sem tekur fall `f` og lista af listum `lis`  
; sem viðföng. Fallið beitir `shorten` fallinu á sérhvern hlutlista í `lis` og  
; skilar niðurstöðunni í lista.  

(define (shorten_all f lis)
  (map (lambda (lst) (shorten f lst)) lis)
)


; Prófunartilvik:  
; (shorten_all * '((1 3 4 2) (2 4 5 3) (3 5 6 4) (4 6 7 5)))  
; => '(24 120 360 840)  

; (shorten_all + '((1 3 4 2) (2 4 5 3) (3 5 6 4) (4 6 7 5)))  
; => '(10 14 18 22)  

; (shorten_all max '((1 3 4 2) (2 4 5 3) (3 5 6 4) (4 6 7 5)))  
; => '(4 5 6 7)  


; ---  


; 4. (20%) Insertion sort  

; a. (10%) `insert`  
; Skrifið fallið `insert` sem setur viðfangið `elem` inn á réttan stað í  
; raðaða viðfangslistanum `lis` (hækkandi röð).  

(define (insert elem lis)
  (cond ((null? lis) (list elem))
        ((> (car lis) elem) (cons elem lis))
        (else (cons (car lis) (insert elem (cdr lis))))
  )
)

; Prófunartilvik:  
; (insert 1 '())  
; => '(1)  

; (insert 3 '(1 2 4))  
; => '(1 2 3 4)  


; b. (10%) `insert_sort`  
; Skrifið fallið `insert_sort` sem tekur inn lista `lis` og skilar  
; nýjum lista, raðaðri útgáfu af `lis` (í hækkandi röð). Fallið skal nota  
; `insert` fallið úr a).  

(define (insert_sort lis)
  (cond ((null? lis) '())
        (else (insert (car lis) (insert_sort (cdr lis))))
  )
)


; Prófunartilvik:  
; (insert_sort '(2 5 1 7 3))
; => '(1 2 3 5 7)
(declare-rel fail ())
(declare-rel print (Bool Bool Int Int Bool))
(declare-rel loop (Bool Bool Int Int (Array Int Int) (Array Int Int) Bool))
(declare-rel main (Bool Bool (Array Int Int) (Array Int Int) Bool))
(declare-rel requirement (Bool Bool Int Int (Array Int Int) (Array Int Int)))

(declare-var ok Bool)
(declare-var ok_i Bool)
(declare-var p1 Bool)
(declare-var val1 Int)
(declare-var i1 Int)
(declare-var x1 Int)
(declare-var i1_i Int)
(declare-var l1 Bool)
(declare-var t1 Bool)
(declare-var f1 Bool)
(declare-var a1 (Array Int Int))
(declare-var p2 Bool)
(declare-var val2 Int)
(declare-var i2 Int)
(declare-var x2 Int)
(declare-var i2_i Int)
(declare-var l2 Bool)
(declare-var t2 Bool)
(declare-var f2 Bool)
(declare-var a2 (Array Int Int))

;(rule (=>
;  (= ok (and (=> (and p1 p2) (= val1 val2)) (and p1 p2)))
;  (print p1 p2 val1 val2 ok)))

; requirement predicate is here because
; of inability to express the precondition
; and have it parse
(rule (=> (and
  (or (and p1 (< i1 4)) (and p2 (< i2 4)))
  (= l1 (and p1 (< i1 4)))
  (= l2 (and p2 (< i2 4)))
  (=> (and l1 l2) (= (= (select a1 i1) 0) (= (select a2 i2) 0)))
  (requirement l1 l2 (+ i1 1) (+ i2 1) a1 a2))
  (requirement p1 p2 i1 i2 a1 a2)))

(rule (=>
  (not (or (and p1 (< i1 4)) (and p2 (< i2 4))))
  (requirement p1 p2 i1 i2 a1 a2)))

(rule (=> (and
  (or (and p1 (< i1 4)) (and p2 (< i2 4)))
  (= l1 (and p1 (< i1 4)))
  (= l2 (and p2 (< i2 4)))
  (=> l1 (= x1 (select a1 i1)))
  (=> l2 (= x2 (select a2 i2)))
  (= t1 (and l1 (= x1 0)))
  (= t2 (and l2 (= x2 0)))
  (= f1 (and l1 (not (= x1 0))))
  (= f2 (and l2 (not (= x2 0))))
  (or t1 t2)
  ;(print t1 t2 i1 i2 ok)
  (= ok (and (=> (and t1 t2) (= i1 i2)) (and t1 t2)))
  (=> l1 (= i1_i (+ i1 1)))
  (=> l2 (= i2_i (+ i2 1)))
  (loop p1 p2 i1_i i2_i a1 a2 ok_i))
  (loop p1 p2 i1 i2 a1 a2 (and ok ok_i))))

(rule (=>
  (not (or (and p1 (< i1 4)) (and p2 (< i2 4))))
  (loop p1 p2 i1 i2 a1 a2 true)))

(rule (=> (and
  (requirement p1 p2 0 0 a1 a2)
  (=> p1 (= i1 0))
  (=> p2 (= i2 0))
  (loop p1 p2 i1 i2 a1 a2 ok))
  (main p1 p2 a1 a2 ok)))

(rule (=> (and
  (main p1 p2 a1 a2 ok)
  (not (=> (and p1 p2) ok)))
  fail))

(query fail)

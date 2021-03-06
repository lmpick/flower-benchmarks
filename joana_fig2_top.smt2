(declare-rel fail ())
(declare-rel print (Bool Bool Int Int Bool))
(declare-rel main (Bool Bool Int Int Bool))

(declare-var p1 Bool)
(declare-var t1 Bool)
(declare-var f1 Bool)
(declare-var val1 Int)
(declare-var h1 Int)
(declare-var l1 Int)
(declare-var l1_i Int)
(declare-var p2 Bool)
(declare-var t2 Bool)
(declare-var f2 Bool)
(declare-var val2 Int)
(declare-var h2 Int)
(declare-var l2 Int)
(declare-var l2_i Int)
(declare-var ok Bool)

(rule (=>
  (= ok (and (=> (and p1 p2) (= val1 val2)) (= p1 p2)))
  (print p1 p2 val1 val2 ok)))

(rule (=> (and
  (= t1 (and p1 (= h1 l1)))
  (= t2 (and p2 (= h2 l2)))
  (= f1 (and p1 (not (= h1 l1))))
  (= f2 (and p2 (not (= h2 l2))))
  (=> t1 (= l1 42))
  (=> t2 (= l2 42))
  (=> f1 (= l1 17))
  (=> f2 (= l2 17))
  (=> p1 (= l1_i 0))
  (=> p2 (= l2_i 0))
  (print p1 p2 l1_i l2_i ok))
  (main p1 p2 h1 h2 ok)))

(rule (=> (and
  (= p1 p2)
  (main p1 p2 h1 h2 ok)
  (not ok))
  fail))

(query fail)

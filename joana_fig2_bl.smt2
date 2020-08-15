(declare-rel fail ())
(declare-rel print (Bool Bool Int Int Bool))
(declare-rel f (Bool Bool Int Int Int Int))
(declare-rel main (Bool Bool Int Int Bool))

(declare-var ok Bool)
(declare-var p1 Bool)
(declare-var x1 Int)
(declare-var y1 Int)
(declare-var h1 Int)
(declare-var l1 Int)
(declare-var val1 Int)
(declare-var res1 Int)
(declare-var res1_i Int)
(declare-var p2 Bool)
(declare-var x2 Int)
(declare-var y2 Int)
(declare-var h2 Int)
(declare-var l2 Int)
(declare-var val2 Int)
(declare-var res2 Int)
(declare-var res2_i Int)

(rule (=> 
  (= ok (and (=> (and p1 p2) (= val1 val2)) (and p1 p2)))
  (print p1 p2 val1 val2 ok)))

(rule (=> (and
  (=> p1 (= res1 (+ x1 42)))
  (=> p2 (= res2 (+ x2 42))))
  (f p1 p2 x1 x2 res1 res2)))

(rule (=> (and
  (=> p1 (= l1 2))
  (=> p2 (= l2 2))
  (or p1 p2)
  (f p1 p2 h1 h2 res1 res2)
  (=> p1 (= x1 res1))
  (=> p2 (= x2 res2))
  (f p1 p2 l1 l2 res1_i res2_i)
  (=> p1 (= y1 res1_i))
  (=> p2 (= y2 res2_i))
  (print p1 p2 y1 y2 ok))
  (main p1 p2 h1 h2 ok)))

(rule (=> (and
  (= p1 p2)
  (main p1 p2 h1 h2 ok)
  (not ok))
  fail))

(query fail)

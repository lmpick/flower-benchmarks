(declare-rel fail ())
(declare-rel inputPin (Bool Bool Int Int))
(declare-rel print (Bool Bool Int Int Bool))
(declare-rel main_p1 (Bool Bool Int Int Bool))
(declare-rel main (Bool Bool Bool))

(declare-var p1 Bool)
(declare-var res1 Int)
(declare-var val1 Int)
(declare-var t1 Bool)
(declare-var f1 Bool)
(declare-var x1 Int)
(declare-var y1 Int)
(declare-var p2 Bool)
(declare-var res2 Int)
(declare-var val2 Int)
(declare-var t2 Bool)
(declare-var f2 Bool)
(declare-var x2 Int)
(declare-var y2 Int)
(declare-var ok Bool)
(declare-var ok_i Bool)

(rule (inputPin p1 p2 res1 res2))

(rule (=> 
  (= ok (and (=> (and p1 p2) (= val1 val2)) (= p1 p2)))
  (print p1 p2 val1 val2 ok)))

(rule (=> (and
  (or p1 p2)
  (inputPin p1 p2 x1 x2)
  (=> (and p1 p2) (= (< x1 1234) (< x2 1234))) ; declassify x < 1234
  (= t1 (and p1 (< x1 1234)))
  (= t2 (and p2 (< x2 1234)))
  (= f1 (and p1 (not (< x1 1234))))
  (= f2 (and p2 (not (< x2 1234))))
  (or t1 t2)
  (print t1 t2 0 0 ok))
  (main_p1 p1 p2 x1 x2 ok)))

(rule (=> (and
  (main_p1 p1 p2 x1 x2 ok)
  (=> p1 (= y1 x1))
  (=> p2 (= y2 x2))
  (=> (and p1 p2) (= x1 x2)) ; declassify x
  (print p1 p2 y1 y2 ok_i))
  (main p1 p2 (and ok_i ok))))

(rule (=> (and
  (= p1 p2)
  (main_p1 p1 p2 x1 x2 ok)
  (not ok))
  fail))

(rule (=> (and
  (= p1 p2)
  (main p1 p2 ok)
  (not ok))
  fail))

(query fail)

(declare-rel fail ())
(declare-rel loop (Bool Bool Int Int Int Int Int Int Int Int Int Int))
(declare-rel main (Bool Bool Int Int Int Int Int Int))
(declare-var p1 Bool)
(declare-var lp1 Bool)
(declare-var f1_1 Int)
(declare-var f2_1 Int)
(declare-var f1_1_i Int)
(declare-var f2_1_i Int)
(declare-var f1_1_ii Int)
(declare-var f2_1_ii Int)
(declare-var c1 Int)
(declare-var c1_i Int)
(declare-var n1 Int)
(declare-var k1 Int)
(declare-var l1 Int)
(declare-var t1 Bool)
(declare-var f1 Bool)
(declare-var p2 Bool)
(declare-var lp2 Bool)
(declare-var f1_2 Int)
(declare-var f2_2 Int)
(declare-var f1_2_i Int)
(declare-var f2_2_i Int)
(declare-var f1_2_ii Int)
(declare-var f2_2_ii Int)
(declare-var c2 Int)
(declare-var c2_i Int)
(declare-var n2 Int)
(declare-var k2 Int)
(declare-var l2 Int)
(declare-var t2 Bool)
(declare-var f2 Bool)

(rule (=> (and
  (or (and p1 (> c1 0)) (and p2 (> c2 0)))
  (= lp1 (and p1 (> c1 0)))
  (= lp2 (and p2 (> c2 0)))
  (=> lp1 (= f1_1_i (+ f1_1 f2_1)))
  (=> lp2 (= f1_2_i (+ f1_2 f2_2)))
  (=> lp1 (= f2_1_i (- f1_1 f2_1)))
  (=> lp2 (= f2_2_i (- f1_2 f2_2)))
  (=> lp1 (= c1_i (- c1 1)))
  (=> lp2 (= c2_i (- c2 1)))
  (or lp1 lp2)
  (loop lp1 lp2 f1_1_i f1_2_i f2_1_i f2_2_i c1_i c2_i f1_1_ii f1_2_ii f2_1_ii f2_2_ii))
  (loop p1 p2 f1_1 f1_2 f2_1 f2_2 c1 c2 f1_1_ii f1_2_ii f2_1_ii f2_2_ii)))

(rule (=> (not (or (and p1 (> c1 0)) (and p2 (> c2 0))))
  (loop p1 p2 f1_1 f1_2 f2_1 f2_2 c1 c2 f1_1 f1_2 f2_1 f2_2)))

(rule (=> (and
  (=> p1 (= c1 n1))
  (=> p2 (= c2 n2))
  (=> p1 (= f1_1 1))
  (=> p2 (= f1_2 1))
  (=> p1 (= f2_1 0))
  (=> p2 (= f2_2 0))
  (loop p1 p2 f1_1 f1_2 f2_1 f2_2 c1 c2 f1_1_i f1_2_i f2_1_i f2_2_i)
  (= t1 (and p1 (> f1_1_i k1)))
  (= t2 (and p2 (> f1_2_i k2)))
  (= f1 (and p1 (not (> f1_1_i k1))))
  (= f2 (and p2 (not (> f1_2_i k2))))
  (=> t1 (= l1 1))
  (=> t2 (= l2 1))
  (=> f1 (= l1 0))
  (=> f2 (= l2 0)))
  (main p1 p2 n1 n2 k1 k2 l1 l2)))
  
(rule (=> (and
  (>= n1 0) (>= n2 0)
  (=> (and p1 p2) (and (= n1 n2) (= k1 k2)))
  (main p1 p2 n1 n2 k1 k2 l1 l2)
  (not (=> (and p1 p2) (= l1 l2))))
  fail))
   
(query fail) 
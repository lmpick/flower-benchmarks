(declare-rel fail ())
(declare-rel writeBalance (Bool Bool (Array Int Int) (Array Int Int) Int Int (Array Int Int) (Array Int Int)))

(declare-var p1 Bool)
(declare-var amount1 Int)
(declare-var t1 Bool)
(declare-var f1 Bool)
(declare-var account1 (Array Int Int))
(declare-var account1_i (Array Int Int))
(declare-var account1_ii (Array Int Int))
(declare-var p2 Bool)
(declare-var amount2 Int)
(declare-var t2 Bool)
(declare-var f2 Bool)
(declare-var account2 (Array Int Int))
(declare-var account2_i (Array Int Int))
(declare-var account2_ii (Array Int Int))

(rule (=> (and
  (=> (and p1 p2) (= (>= amount1 10000) (>= amount2 10000))) ; declassify amount >= 10000
  (= t1 (and p1 (>= amount1 10000)))
  (= t2 (and p2 (>= amount2 10000)))
  (= f1 (and p1 (not (>= amount1 10000))))
  (= f2 (and p2 (not (>= amount2 10000))))
  (=> t1 (= account1_i (store account1 1 1)))
  (=> t2 (= account2_i (store account2 1 1)))
  (=> f1 (= account1_i (store account1 1 0)))
  (=> f2 (= account2_i (store account2 1 0)))
  (=> p1 (= account1_ii (store account1_i 0 amount1)))
  (=> p2 (= account2_ii (store account2_i 0 amount1))))
  (writeBalance p1 p2 account1 account2 amount1 amount2 account1_ii account2_ii)))

(rule (=> (and
  (=> (and p1 p2) (= (select account1 1) (select account2 1)))
  (writeBalance p1 p2 account1 account2 amount1 amount2 account1_i account2_i)
  (not (=> (and p1 p2) (= (select account1_i 1) (select account2_i 1)))))
  fail))

(query fail)

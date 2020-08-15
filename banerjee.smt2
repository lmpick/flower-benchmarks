; encode name and hiv as Ints in an array
(declare-rel fail ())
(declare-rel getName (Bool Bool (Array Int Int) (Array Int Int) (Array Int Int) (Array Int Int) Int Int))
(declare-rel setName (Bool Bool (Array Int Int) (Array Int Int) Int Int (Array Int Int) (Array Int Int)))
(declare-rel getHiv (Bool Bool (Array Int Int) (Array Int Int) (Array Int Int) (Array Int Int) Int Int))
(declare-rel setHiv (Bool Bool (Array Int Int) (Array Int Int) Int Int (Array Int Int) (Array Int Int)))
(declare-rel readFile (Bool Bool (Array Int Int) (Array Int Int)))
(declare-rel readFromTrustedChan (Bool Bool Int Int))
(declare-rel main (Bool Bool (Array Int Int) (Array Int Int)))
(declare-rel exp (Bool Bool (Array Int Int) (Array Int Int)))

(declare-var p1 Bool)
(declare-var patient1 (Array Int Int))
(declare-var patient1_i (Array Int Int))
(declare-var n1 Int)
(declare-var s1 Int)
(declare-var res1 Int)
(declare-var res1_i Int)
(declare-var res1_ii Int)
(declare-var lbuf1 Int)
(declare-var hbuf1 Int)
(declare-var hbuf1_i Int)
(declare-var xp1 (Array Int Int))
(declare-var xp1_i (Array Int Int))
(declare-var xp1_ii (Array Int Int))
(declare-var xp1_iii (Array Int Int))
(declare-var lp1 (Array Int Int))
(declare-var lp1_i (Array Int Int))
(declare-var lp1_ii (Array Int Int))
(declare-var lp1_iii (Array Int Int))
(declare-var tmpHiv1 Int)
(declare-var p2 Bool)
(declare-var patient2 (Array Int Int))
(declare-var patient2_i (Array Int Int))
(declare-var n2 Int)
(declare-var s2 Int)
(declare-var res2 Int)
(declare-var res2_i Int)
(declare-var res2_ii Int)
(declare-var lbuf2 Int)
(declare-var hbuf2 Int)
(declare-var hbuf2_i Int)
(declare-var xp2 (Array Int Int))
(declare-var xp2_i (Array Int Int))
(declare-var xp2_ii (Array Int Int))
(declare-var xp2_iii (Array Int Int))
(declare-var lp2 (Array Int Int))
(declare-var lp2_i (Array Int Int))
(declare-var lp2_ii (Array Int Int))
(declare-var lp2_iii (Array Int Int))
(declare-var tmpHiv2 Int)

(rule (=> (and
  (=> p1 (= res1 (select patient1 0)))
  (=> p2 (= res2 (select patient2 0))))
  (getName p1 p2 patient1 patient2 patient1 patient2 res1 res2)))

(rule (=> (and
  (=> p1 (= patient1_i (store patient1 0 n1)))
  (=> p2 (= patient2_i (store patient2 0 n2))))
  (setName p1 p2 patient1 patient2 n1 n2 patient1_i patient2_i)))

(rule (=> (and
  (=> p1 (= res1 (select patient1 1)))
  (=> p2 (= res2 (select patient2 1))))
  (getHiv p1 p2 patient1 patient2 patient1 patient2 res1 res2)))

(rule (=> (and
  (=> p1 (= patient1_i (store patient1 1 s1)))
  (=> p2 (= patient2_i (store patient2 1 s2))))
  (setHiv p1 p2 patient1 patient2 s1 s2 patient1_i patient2_i)))

; can't talk about references here
(rule (=>
  (=> (and p1 p2) (= (select patient1 0) (select patient2 0)))
  (readFile p1 p2 patient1 patient2)))

(rule (readFromTrustedChan p1 p2 n1 n2))

(rule (=> (and
  (or p1 p2)
  (readFile p1 p2 patient1 patient2)
  (=> p1 (= lp1 patient1_i))
  (=> p2 (= lp2 patient2_i))
  (getName p1 p2 lp1 lp2 lp1_i lp2_i res1 res2)
  (=> p1 (= lbuf1 res1))
  (=> p2 (= lbuf2 res2))
  (getName p1 p2 lp1_i lp2_i lp1_ii lp2_ii res1_i res2_i)
  (=> p1 (= hbuf1 res1_i))
  (=> p2 (= hbuf2 res2_i))
  (setName p1 p2 xp1 xp2 lbuf1 lbuf2 xp1_i xp2_i)
  (readFromTrustedChan p1 p2 n1 n2)
  (=> p1 (= hbuf1_i n1)) 
  (=> p2 (= hbuf2_i n2)) 
  (setHiv p1 p2 xp1_i xp2_i hbuf1_i hbuf2_i xp1_ii xp2_ii)
  (getHiv p1 p2 xp1_ii xp2_ii xp1_iii xp2_iii res1_ii res2_ii)
  (=> p1 (= tmpHiv1 res1_i))
  (=> p2 (= tmpHiv2 res2_i))
  (=> (and p1 p2) (= tmpHiv1 tmpHiv2)) ; declassify tmpHiv
  (setName p1 p2 lp1_ii lp2_ii tmpHiv1 tmpHiv2 lp1_iii lp2_iii))
  (main p1 p2 lp1_iii lp2_iii)))

(rule (=> (and
  (not (or p1 p2))
  (=> p1 (= lp1 patient1))
  (=> p2 (= lp2 patient2))
  (=> p1 (= lbuf1 res1))
  (=> p2 (= lbuf2 res2))
  (=> p1 (= hbuf1 res1_i))
  (=> p2 (= hbuf2 res2_i))
  (=> p1 (= hbuf1_i n1)) 
  (=> p2 (= hbuf2_i n2)) 
  (=> p1 (= tmpHiv1 res1_ii))
  (=> p2 (= tmpHiv2 res2_ii))
  (=> (and p1 p2) (= tmpHiv1 tmpHiv2))) ; declassify tmpHiv
  (main p1 p2 lp1_iii lp2_iii)))

; check property not in Viper example, since Viper example checks against
; specs we don't have here
; the property here is that the low-security name field (stored at index 0)
; is still low after main is run
(rule (=> (and
 (main p1 p2 patient1 patient2)
 (not (=> (and p1 p2) (= (select patient1 0) (select patient2 0)))))
 fail))

(query fail)

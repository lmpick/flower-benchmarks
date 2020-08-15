(declare-rel fail ())
(declare-rel modExp (Bool Bool Int Int Int Int Int Int Int Int Int Int Int Int))
(declare-rel loop (Bool Bool Int Int Int Int Int Int Int Int Int Int Int Int Int Int Int Int))

(declare-var p1 Bool)
(declare-var t1 Int)
(declare-var a1 Int)
(declare-var b1 Int)
(declare-var i1 Int)
(declare-var i1_i Int)
(declare-var m1 Int)
(declare-var m1_i Int)
(declare-var m1_ii Int)
(declare-var n1 Int)
(declare-var len1 Int)
(declare-var pp1 Int)
(declare-var l1 Bool)
(declare-var lt1 Bool)
(declare-var lf1 Bool)
(declare-var time1 Int)
(declare-var time1_i Int)
(declare-var time1_ii Int)
(declare-var time1_iii Int)
(declare-var time1_iv Int)
(declare-var p2 Bool)
(declare-var t2 Int)
(declare-var a2 Int)
(declare-var b2 Int)
(declare-var i2 Int)
(declare-var i2_i Int)
(declare-var m2 Int)
(declare-var m2_i Int)
(declare-var m2_ii Int)
(declare-var n2 Int)
(declare-var len2 Int)
(declare-var pp2 Int)
(declare-var l2 Bool)
(declare-var lt2 Bool)
(declare-var lf2 Bool)
(declare-var time2 Int)
(declare-var time2_i Int)
(declare-var time2_ii Int)
(declare-var time2_iii Int)
(declare-var time2_iv Int)

;    public int modular_exponentiation_safe(BigInteger a, BigInteger b, BigInteger p) {
;        int time = 0;
;        time++;
;        BigInteger m = BigInteger.valueOf(1);
;        time++;
;        int n = b.bitLength();
;        time++; // for i < n check
;        for(int i = 0; i < n; i++, time++) {
;            time += 2;
;            m = m.multiply(m).mod(p);
;            time += 2;
;            BigInteger t = m.multiply(a).mod(p);
;            time++;
;            if(b.testBit(i)) {
;                time++;
;                m = t;
;            }
;            time++; // for i < n check
;        }
;        return time;
;    }

(rule (=> (and
   (or (and p1 (< i1 n1)) (and p2 (< i2 n2)))
   (=> p1 (= time1_i (+ time1 1)))
   (=> p2 (= time2_i (+ time2 1)))
   (= l1 (and p1 (< i1 n1)))
   (= l2 (and p2 (< i2 n2)))
   (=> l1 (= m1_i (mod (* m1 m1) pp1)))
   (=> l2 (= m2_i (mod (* m2 m2) pp2)))
   (=> l1 (= t1 (mod (* m1 a1) pp1)))
   (=> l2 (= t2 (mod (* m2 a2) pp2)))
   (=> l1 (= lt1 (= 0 (mod (+ b1 i1) 2))))
   (=> l2 (= lt2 (= 0 (mod (+ b2 i2) 2))))
   (=> l1 (= lf1 (not (= 0 (mod (+ b1 i1) 2)))))
   (=> l2 (= lf2 (not (= 0 (mod (+ b2 i2) 2)))))
   (=> l1 (= time1_ii (+ time1_i 6)))
   (=> l2 (= time2_ii (+ time2_i 6)))
   (=> lt1 (= m1_ii t1))
   (=> lt2 (= m2_ii t2))
   (=> lt1 (= time1_iii (+ time1_ii 1)))
   (=> lt2 (= time2_iii (+ time2_ii 1)))
   (=> lf1 (= m1_ii m1_i))
   (=> lf2 (= m2_ii m2_i))
   (=> lf1 (= time1_iii time1_ii))
   (=> lf2 (= time2_iii time2_ii))
   (=> l1 (= i1_i (+ i1 1)))
   (=> l2 (= i2_i (+ i2 1)))
   (loop l1 l2 i1_i i2_i n1 n2 m1_ii m2_ii a1 a2 b1 b2 pp1 pp2 time1_iii time2_iii time1_iv time2_iv))
   (loop p1 p2 i1 i2 n1 n2 m1 m2 a1 a2 b1 b2 pp1 pp2 time1 time2 time1_iv time2_iv)))

(rule (=> (and 
   (not (or (and p1 (< i1 n1)) (and p2 (< i2 n2))))
   (=> p1 (= time1_i (+ time1 1)))
   (=> p2 (= time2_i (+ time2 1))))
   (loop p1 p2 i1 i2 n1 n2 m1 m2 a1 a2 b1 b2 pp1 pp2 time1 time2 time1_i time2_i)))

(rule (=> (and
  (or p1 p2)
  (=> p1 (= m1 1))
  (=> p2 (= m2 1))
  (=> p1 (= n1 len1))
  (=> p2 (= n2 len2))
  (=> p1 (= i1 0))
  (=> p2 (= i2 0))
  (=> p1 (= time1_i (+ time1 3)))
  (=> p2 (= time2_i (+ time2 3)))
  (loop p1 p2 i1 i2 n1 n2 m1 m2 a1 a2 b1 b2 pp1 pp2 time1_i time2_i time1_ii time2_ii))
  (modExp p1 p2 a1 a2 b1 b2 pp1 pp2 len1 len2 time1 time2 time1_ii time2_ii)))

(rule (=> (and
  (not (or p1 p2))
  (=> p1 (= m1 1))
  (=> p2 (= m2 1))
  (=> p1 (= n1 len1))
  (=> p2 (= n2 len2))
  (=> p1 (= i1 0))
  (=> p2 (= i2 0))
  (=> p1 (= time1_i (+ time1 3)))
  (=> p2 (= time2_i (+ time2 3))))
  (modExp p1 p2 a1 a2 b1 b2 pp1 pp2 len1 len2 time1 time2 time1_ii time2_ii)))

(rule (=> (and
 (=> (and p1 p2) (and (= b1 b2) (= pp1 pp2) (= len1 len2) (= time1 time2)))
 (modExp p1 p2 a1 a2 b1 b2 pp1 pp2 len1 len2 time1 time2 time1_i time2_i)
 (not (=> (and p1 p2) (= time1_i time2_i))))
 fail))

(query fail)

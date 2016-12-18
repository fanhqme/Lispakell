module UData where

data BNum = BInt Int | BFloat Double deriving Show
data BBinaryArith = BAdd | BSub | BMul | BDiv | BMod deriving Show
data BArith = BArith2 BBinaryArith BNum | BToInt | BToFloat deriving Show
data BFunc = BArithFunc BArith | BArith2Func BBinaryArith  deriving Show
data BValue = BNumVal BNum | BFuncVal BFunc | BIntList [Int]  deriving Show
data BResult = BClean BValue | BException [Char] deriving Show

numToBResult :: BNum -> BResult
numToBResult a = BClean (BNumVal a)

data BCompType = BLe | BGe | BNLe | BNGe | BEq | BNEq deriving Show

applyBVal :: BValue -> BValue -> BResult
applyBVal (BFuncVal b) (BNumVal v) = applyBFunc b v
applyBVal (BFuncVal b) _ = BException ("cannot apply non-numeric argument to builtin function "++(show b))
applyBVal (BIntList args) (BNumVal (BInt v)) = BClean (BIntList (v:args))
applyBVal (BIntList args) _ = BException "cannot append non-integer number in IntList"
applyBVal _ _ = BException "cannot use numeric value as function"

applyBFunc :: BFunc -> BNum -> BResult
applyBFunc (BArith2Func a) d = BClean (BFuncVal (BArithFunc (BArith2 a d)))
applyBFunc (BArithFunc a) v = applyBArith a v

applyBArith :: BArith -> BNum -> BResult
applyBArith (BArith2 a b) c = applyBBinaryArith a b c
applyBArith BToInt (BInt a) = numToBResult (BInt a)
applyBArith BToInt (BFloat a) = numToBResult (BInt (floor a))
applyBArith BToFloat (BFloat a) = numToBResult (BFloat a)
applyBArith BToFloat (BInt a) = numToBResult (BFloat (fromIntegral a))

applyBBinaryArith :: BBinaryArith -> BNum -> BNum -> BResult
applyBBinaryArith BAdd (BInt a) (BInt b) = numToBResult (BInt (a+b))
applyBBinaryArith BAdd (BFloat a) (BInt b) = numToBResult (BFloat (a+(fromIntegral b)))
applyBBinaryArith BAdd (BInt a) (BFloat b) = numToBResult (BFloat ((fromIntegral a)+b))
applyBBinaryArith BAdd (BFloat a) (BFloat b) = numToBResult (BFloat (a+b))
applyBBinaryArith BSub (BInt a) (BInt b) = numToBResult (BInt (a-b))
applyBBinaryArith BSub (BFloat a) (BInt b) = numToBResult (BFloat (a-(fromIntegral b)))
applyBBinaryArith BSub (BInt a) (BFloat b) = numToBResult (BFloat ((fromIntegral a)-b))
applyBBinaryArith BSub (BFloat a) (BFloat b) = numToBResult (BFloat (a-b))
applyBBinaryArith BMul (BInt a) (BInt b) = numToBResult (BInt (a*b))
applyBBinaryArith BMul (BFloat a) (BInt b) = numToBResult (BFloat (a*(fromIntegral b)))
applyBBinaryArith BMul (BInt a) (BFloat b) = numToBResult (BFloat ((fromIntegral a)*b))
applyBBinaryArith BMul (BFloat a) (BFloat b) = numToBResult (BFloat (a*b))
applyBBinaryArith BDiv _ (BInt 0) = BException "divided by zero"
applyBBinaryArith BDiv (BInt a) (BInt b) = numToBResult (BInt (a `div`b))
applyBBinaryArith BDiv (BFloat a) (BInt b) = numToBResult (BFloat (a/(fromIntegral b)))
applyBBinaryArith BDiv (BInt a) (BFloat b) = numToBResult (BFloat ((fromIntegral a)/b))
applyBBinaryArith BDiv (BFloat a) (BFloat b) = numToBResult (BFloat (a/b))
applyBBinaryArith BMod _ (BInt 0) = BException "mod by zero"
applyBBinaryArith BMod (BInt a) (BInt b) = numToBResult (BInt (a `div`b))
applyBBinaryArith BMod _ _ = BException "cannot use non-integer value in mod"

compBNum :: BCompType -> BNum -> BNum -> Bool
compBNum BLe (BInt a) (BInt b) = (a<b)
compBNum BLe (BInt a) (BFloat b) = ((fromIntegral a)<b)
compBNum BLe (BFloat a) (BInt b) = (a<(fromIntegral b))
compBNum BLe (BFloat a) (BFloat b) = (a<b)
compBNum BNLe (BInt a) (BInt b) = (a>=b)
compBNum BNLe (BInt a) (BFloat b) = ((fromIntegral a)>=b)
compBNum BNLe (BFloat a) (BInt b) = (a>=(fromIntegral b))
compBNum BNLe (BFloat a) (BFloat b) = (a>=b)
compBNum BGe (BInt a) (BInt b) = (a>b)
compBNum BGe (BInt a) (BFloat b) = ((fromIntegral a)>b)
compBNum BGe (BFloat a) (BInt b) = (a>(fromIntegral b))
compBNum BGe (BFloat a) (BFloat b) = (a>b)
compBNum BNGe (BInt a) (BInt b) = (a<=b)
compBNum BNGe (BInt a) (BFloat b) = ((fromIntegral a)<=b)
compBNum BNGe (BFloat a) (BInt b) = (a<=(fromIntegral b))
compBNum BNGe (BFloat a) (BFloat b) = (a<=b)
compBNum BEq (BInt a) (BInt b) = (a==b)
compBNum BEq (BInt a) (BFloat b) = ((fromIntegral a)==b)
compBNum BEq (BFloat a) (BInt b) = (a==(fromIntegral b))
compBNum BEq (BFloat a) (BFloat b) = (a==b)
compBNum BNEq (BInt a) (BInt b) = (a/=b)
compBNum BNEq (BInt a) (BFloat b) = ((fromIntegral a)/=b)
compBNum BNEq (BFloat a) (BInt b) = (a/=(fromIntegral b))
compBNum BNEq (BFloat a) (BFloat b) = (a/=b)

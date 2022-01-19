module Part2.Tasks where

import Util(notImplementedYet)

data BinaryOp = Plus | Minus | Times deriving (Show, Eq)

data Term = IntConstant { intValue :: Int }          -- числовая константа
          | Variable    { varName :: String }        -- переменная
          | BinaryTerm  { op :: BinaryOp, lhv :: Term, rhv :: Term } -- бинарная операция
             deriving(Show,Eq)

-- Для бинарных операций необходима не только реализация, но и адекватные
-- ассоциативность и приоритет
(|+|) :: Term -> Term -> Term
(|+|) = BinaryTerm Plus
infixl 1 |+|
(|-|) :: Term -> Term -> Term
(|-|) = BinaryTerm Minus
infixl 1 |-|
(|*|) :: Term -> Term -> Term
(|*|) = BinaryTerm Times
infixl 2 |*|

-- Заменить переменную `varName` на `replacement`
-- во всём выражении `expression`
replaceVar :: String -> Term -> Term -> Term
replaceVar varName replacement expression =
   case expression of
       Variable var -> if var == varName then replacement else expression
       BinaryTerm op lhv rhv -> BinaryTerm op (replaceVar varName replacement lhv) (replaceVar varName replacement rhv)
       _ -> expression

-- Посчитать значение выражения `Term`
-- если оно состоит только из констант
evaluate :: Term -> Term
evaluate term =
   case term of
      (BinaryTerm op lhv rhv) ->
         case (op, evaluate lhv, evaluate rhv) of
            (Plus, IntConstant t1,  IntConstant t2) -> IntConstant (t1 + t2)
            (Minus, IntConstant t1, IntConstant t2) -> IntConstant (t1 - t2)
            (Times, IntConstant t1, IntConstant t2) -> IntConstant (t1 * t2)
            _ -> term
      _ -> term

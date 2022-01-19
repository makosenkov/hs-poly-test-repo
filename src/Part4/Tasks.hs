module Part4.Tasks where

import Util(notImplementedYet)

-- Перевёрнутый связный список -- хранит ссылку не на последующию, а на предыдущую ячейку
data ReverseList a = REmpty | (ReverseList a) :< a
infixl 5 :<

lastReverse :: ReverseList a -> a
lastReverse (init :< last) = last

initReverse :: ReverseList a -> ReverseList a
initReverse (init :< last) = init

-- Функция-пример, делает из перевёрнутого списка обычный список
-- Использовать rlistToList в реализации классов запрещено =)
rlistToList :: ReverseList a -> [a]
rlistToList lst =
    reverse (reversed lst)
    where reversed REmpty = []
          reversed (init :< last) = last : reversed init

-- Реализуйте обратное преобразование
listToRlist :: [a] -> ReverseList a
listToRlist = foldl (:<) REmpty

-- Реализуйте все представленные ниже классы (см. тесты)
instance (Show a) => Show (ReverseList a) where
    showsPrec = notImplementedYet
    show lst = "[" ++ showReverseList lst ++ "]"
        where
            showReverseList lst = case lst of
                REmpty -> ""
                REmpty :< last -> show last
                init :< last -> showReverseList init ++ "," ++ show last

instance (Eq a) => Eq (ReverseList a) where
    (==) REmpty REmpty = True
    (==) REmpty (i:<l) = False
    (==) (i:<l) REmpty = False
    (==) lst1 lst2
        | lastReverse lst1 == lastReverse lst2 = initReverse lst1 == initReverse lst2
        | otherwise = False

instance Semigroup (ReverseList a) where
    (<>) REmpty REmpty = REmpty
    (<>) REmpty lst2 = lst2
    (<>) lst1 REmpty = lst1
    (<>) lst1 (lst2Init :< lst2Last) = lst1 <> lst2Init :< lst2Last
instance Monoid (ReverseList a) where
    mempty = REmpty
    mappend = (<>)
    mconcat = foldr mappend mempty
instance Functor ReverseList where
    fmap f REmpty = REmpty
    fmap f (init :< last) = fmap f init :< f last
instance Applicative ReverseList where
    pure a = REmpty :< a
    (<*>) _ REmpty = REmpty
    (<*>) REmpty lst = REmpty
    (<*>) (init1 :< last1) lst2 = (init1 <*> lst2) <> fmap last1 lst2
instance Monad ReverseList where
    (>>=) REmpty _ = REmpty
    (>>=) (init :< last) f = (init >>= f) <> f last
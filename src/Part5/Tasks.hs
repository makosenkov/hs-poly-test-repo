module Part5.Tasks where

import Util(notImplementedYet)

-- Реализуйте левую свёртку
myFoldl :: (b -> a -> b) -> b -> [a] -> b
myFoldl f acc [] = acc
myFoldl f acc (h:t) = myFoldl f (f acc h) t

-- Реализуйте правую свёртку
myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f acc [] = acc
myFoldr f acc (h:t) = f h $ myFoldr f acc t

-- Используя реализации свёрток выше, реализуйте все остальные функции в данном файле

myMap :: (a -> b) -> [a] -> [b]
myMap f = myFoldr ((:).f) []   

myConcatMap :: (a -> [b]) -> [a] -> [b]
myConcatMap f = myFoldr ((++).f) []

myConcat :: [[a]] -> [a]
myConcat = myFoldl (++) []

myReverse :: [a] -> [a]
myReverse = myFoldl (\acc el -> [el] ++ acc) []

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter p = myFoldl (\acc el -> if p el then acc ++ [el] else acc) []

myPartition :: (a -> Bool) -> [a] -> ([a], [a])
myPartition p = myFoldl (\acc el -> if p el then addToFst acc el else addToSnd acc el) ([], [])
                where
                    addToFst acc el = ((fst acc) ++ [el], snd acc)
                    addToSnd acc el = (fst acc, (snd acc) ++ [el])


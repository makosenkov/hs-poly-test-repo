module Part1.Tasks where

import Util(notImplementedYet)
import Data.List

factorial :: Double -> Double
factorial 0 = 1
factorial 1 = 1
factorial n = n * factorial (n - 1)

-- синус числа (формула Тейлора)
mySin :: Double -> Double
mySin x = sinTaylor x 0
        where
            sinTaylor :: Double -> Double -> Double
            sinTaylor x n
                | n == 20   = (-1) ** n * x ** (2 * n + 1) / factorial (2 * n + 1)
                | otherwise = (-1) ** n * x ** (2 * n + 1) / factorial (2 * n + 1) + sinTaylor x (n + 1)

-- косинус числа (формула Тейлора)
myCos :: Double -> Double
myCos x = cosTaylor x 0
        where
            cosTaylor :: Double -> Double -> Double
            cosTaylor x n
                | n == 19   = (-1) ** n * x ** (2 * n) / factorial (2 * n)
                | otherwise = (-1) ** n * x ** (2 * n) / factorial (2 * n) + cosTaylor x (n + 1)

-- наибольший общий делитель двух чисел
myGCD :: Integer -> Integer -> Integer
myGCD 0 n = abs n
myGCD m 0 = abs m
myGCD 1 n = 1
myGCD m 1 = 1
myGCD m n
    | n == m = abs m
    | isEven m && isEven n = 2 * myGCD (div m 2) (div n 2)
    | isEven m && not (isEven n) = myGCD (div m 2) n
    | not (isEven m) && isEven n = myGCD m (div n 2)
    | not (isEven m) && not (isEven n) = myGCD n (abs (m - n))
    where
        isEven :: Integer -> Bool
        isEven n = even n

-- является ли дата корректной с учётом количества дней в месяце и
-- високосных годов?
isDateCorrect :: Integer -> Integer -> Integer -> Bool
isDateCorrect d m y
    | d <= 0 = False
    | d > 31 = False
    | m == 2 && isLeap y && d <= 29 = True
    | m == 2 && not (isLeap y) && d < 29 = True
    | elem m [4, 6, 9, 11] && d <= 30 = True
    | elem m [1, 3, 5, 7, 8, 10, 12] && d <= 31 = True
    | otherwise = False
    where
        isLeap :: Integer -> Bool
        isLeap year
            | mod year 4 == 0 && mod year 100 /= 0 = True
            | mod year 100 == 0 && mod year 400 == 0 = True
            | otherwise = False

-- возведение числа в степень, duh
-- готовые функции и плавающую арифметику использовать нельзя
myPow :: Integer -> Integer -> Integer
myPow x 0 = 1
myPow x 1 = x
myPow x n = x * myPow x (n - 1)

-- является ли данное число простым?
isPrime :: Integer -> Bool
isPrime x = dividing x 2
    where
        dividing :: Integer -> Integer -> Bool
        dividing x n
            | n == x = True
            | mod x n == 0 = False
            | otherwise = dividing x (n + 1)

type Point2D = (Double, Double)

-- рассчитайте площадь многоугольника по формуле Гаусса
-- многоугольник задан списком координат
shapeArea :: [Point2D] -> Double
shapeArea points
    | null points = 0
    | null (tail points) = 0
    | null (tail (tail points)) = 0
    | otherwise =
        let
            xs = map fst points
            ys = map snd points
            a = last xs * head ys
            b = head xs * last ys
            list1 = zipWith (*) (init xs) (tail ys)
            list2 = zipWith (*) (tail xs) (init ys)
        in
            abs (sum list1 + a - sum list2 - b) / 2

-- треугольник задан длиной трёх своих сторон.
-- функция должна вернуть
--  0, если он тупоугольный
--  1, если он остроугольный
--  2, если он прямоугольный
--  -1, если это не треугольник
triangleKind :: Double -> Double -> Double -> Integer
triangleKind a b c
    | head sorted > sum (tail sorted) = -1
    | squareOfLongest sorted == sumOfOthersSquares sorted = 2
    | squareOfLongest sorted < sumOfOthersSquares sorted = 1
    | squareOfLongest sorted > sumOfOthersSquares sorted = 0
    | otherwise = -1
        where 
            sorted = reverse $ sort [a, b, c]
            squareOfLongest sorted = (head sorted) ** 2
            sumOfOthersSquares lst = sum $ map (\x -> x**2) (tail lst)


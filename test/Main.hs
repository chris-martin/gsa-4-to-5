module Main where

import Test.Framework (defaultMain, Test)

import qualified GSA.FourToFive.Sprites.Options.Test

main :: IO ()
main = defaultMain tests

tests :: [Test]
tests = GSA.FourToFive.Sprites.Options.Test.tests

module GSA.FourToFive.Sprites.Options.Test where

import Test.HUnit ((@?=), assertBool, Assertion)
import Test.Framework (testGroup, Test)
import Test.Framework.Providers.HUnit

import GSA.FourToFive.Sprites.Options

tests :: [Test]
tests =
  [ testGroup "Sprites.Options"
    [ testCase "no args" $ parseArgs [] @?=
      Right Options { optHelp = False, optDirs = [] }
    , testCase "help" $ parseArgs ["-h"] @?=
      Right Options { optHelp = True, optDirs = [] }
    , testCase "/tmp" $ parseArgs ["/tmp"] @?=
      Right Options { optHelp = False, optDirs = ["/tmp"] }
    , testCase "-x" $ assertPredicate isLeft $ parseArgs ["-x"]
    ]
  ]


assertPredicate :: (Show a) => (a -> Bool) -> a -> Assertion
assertPredicate f x = assertBool (show x) (f x)

isLeft :: Either a b -> Bool
isLeft (Left _) = True
isLeft (Right _) = False

module GSA.FourToFive.Sprites.Options
  ( Options(..)
  , getOptions
  , parseArgs
  ) where

import System.Console.GetOpt
import System.Environment
import System.Exit
import System.IO

data Options = Options
  { optHelp :: Bool
  , optDirs :: [FilePath]
  } deriving (Show, Eq)

defaultOptions :: Options
defaultOptions = Options { optHelp = False, optDirs = [] }

options :: [OptDescr (Options -> Options)]
options =
  [ Option ['h'] ["help"] (NoArg $ setOptHelp True) "Print this help message"
  , Option ['d'] ["dir"] (ReqArg addOptDir "DIR") "Source directory"
  ]

setOptHelp :: Bool -> Options -> Options
setOptHelp x opts = opts { optHelp = x }

addOptDir:: FilePath -> Options -> Options
addOptDir dir opts = opts { optDirs = optDirs opts ++ [dir] }

-- Parse command-line args or fail with a list of errors
parseArgs :: [String] -> Either [String] Options
parseArgs argv = case getOpt (ReturnInOrder addOptDir) options argv of
    (o, _, []) -> Right $ foldl (flip id) defaultOptions o
    (_, _, errs) -> Left errs

help :: String
help = "Usage: gsa4to5 [-h] [dir ...]"

-- Get the options, exiting if options are invalid or include -h
getOptions :: IO Options
getOptions = do
    a <- getArgs
    let x = parseArgs a
    case x of
        Left errs -> do
            hPutStrLn stderr (concat errs ++ usageInfo help options)
            exitFailure
        Right opts ->
            if optHelp opts
                then do hPutStrLn stderr (usageInfo help options)
                        exitSuccess
                else return opts

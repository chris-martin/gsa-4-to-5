module GSA.FourToFive.Sprites.Main (main) where

import Control.Monad
import Data.Functor
import System.Directory

import GSA.FourToFive.Sprites.Options

main :: IO ()
main = do
    opts <- getOptions
    putStrLn $ show opts
    forM (optDirs opts) $ \d -> do
        xs <- getDirectoryContents d
        let ys = map ("* " ++) xs
        mapM_ putStrLn ys
    return ()

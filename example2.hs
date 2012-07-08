{-#LANGUAGE ScopedTypeVariables#-}

{-
  First example: inspirational by https://github.com/Gabriel439/Haskell-Pipes-Library/issues/6 
  and http://hackage.haskell.org/packages/archive/pipes/2.0.0/doc/html/Control-Pipe-Common.html
-}

import Control.Pipe
import Control.Monad
-- import Control.Monad.IO.Class
import Network.CGI
import Control.Monad.Trans
import Control.Applicative

check :: (Show a) => Pipe a a IO r
check = forever $ do
     x <- await
     lift $ putStrLn $ "Can '" ++ (show x) ++ "' pass?"
     ok <- read <$> lift getLine
     when ok (yield x)
--
testRunPipe :: IO ()
testRunPipe = runPipe $ forever await <+< check <+< mapM_ yield [1..]
--
-- *Main> testRunPipe 
-- Can '1' pass?
-- True
-- Can '2' pass?
--

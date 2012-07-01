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

--pipeline :: Pipeline IO ()
--pipeline = take' 3
--pipeline = printer <+< take' 3 <+< fromList [1..]

take' :: Int -> Pipe a a IO ()
take' n =
   do
     replicateM_ n $ do
         x <- await
         yield x
     lift $ putStrLn "You shall not pass!"
         --putStrLn ">..."
--
testRunPipe :: IO ()
testRunPipe = runPipe $ forever await <+< take' 3
--
--

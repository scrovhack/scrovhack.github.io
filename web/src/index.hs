import Data.Time

main :: IO ()
main = do
  time <- getCurrentTime
  putStrLn $ "{ \"runtime\": \"Haskell\", \"time\": \"" ++ show time ++ "\" }"

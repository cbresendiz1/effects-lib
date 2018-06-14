import Effects2

import Effect2.State
import Effect2.StdIO

hello : Eff () [STATE Int, STDIO]
hello = do putStr "Name? "
           putStrLn ("Hello " ++ trim !getStr ++ "!")
           update (+1)
           putStrLn ("I've said hello to: " ++ show !get ++ " people")
           hello

data Stater : Effect where
    Get : { a }    Stater a
    Put : b ->  { a ==> b } Stater ()

STATE2 : Type -> EFFECT
STATE2 t = MkEff t Stater

Handler Stater m where
    handle st Get k = k st st
    handle st (Put n) k = k () n

get : Eff x [STATE2 x]
get = call Get

put : x -> Eff () [STATE2 x]
put n = call (Put n)

putM : y -> Eff () [STATE2 x] [STATE2 y]
putM val = call (Put val)

roger : List Int -> Eff (List Int) [STATE2 (List Int)]
roger t = do put t
             x <- get
             pure x

main : IO ()
--main = putStrLn $ show $ runPure (roger [2])
main = run hello

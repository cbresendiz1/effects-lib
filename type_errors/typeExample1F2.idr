module Effects2

import Language.Reflection
--import public Effect2.Default
import Data.Vect
import public Data.List

--- Effectful computations are described as algebraic data types that
--- explain how an effect is interpreted in some underlying context.

%access export
-- ----------------------------------------------------------------- [ Effects ]
||| The Effect type describes effectful computations.
|||
||| This type is parameterised by:
||| + The return type of the computation.
||| + The input resource.
||| + The computation to run on the resource given the return value.

public export
Effect : Type
--Effect = (x : Type) -> (Type -> Type) -> (Type -> x -> Type) -> Type
Effect = (x : Type) -> Type -> (x -> Type) -> Type

public export
interface Handler (e : Effect) (m : Type -> Type) (a : Type) where
  ||| How to handle the effect.
  |||
  ||| @ r The resource being handled.
  ||| @ eff The effect to be applied.
  ||| @ k The continuation to pass the result of the effect
  covering handle : (r : (the (Type -> Type) res) a) -> 
                    (eff : e 
                           t 
                           ((the (Type -> Type) res) a)
                           ((the (Type -> t -> Type) resk) a)) -> 
                    (k : ((x : t) -> resk a x -> m a)) -> m a

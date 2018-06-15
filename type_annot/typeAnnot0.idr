module Effects2

import Language.Reflection
import public Effect2.Default
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

--  ||| The `EFFECT` Data type describes how to promote the Effect
--  ||| description into a concrete effect.
--  public export
--  %error_reverse
--data EFFECT : Type where
--     MkEff : Type -> Effect -> EFFECT
--  
--  -- 'sig' gives the signature for an effect. There are four versions
--  -- depending on whether there is no resource needed,
--  -- no state change, a non-dependent change,
--  -- or a dependent change. These are easily disambiguated by type.
--  
--  namespace NoResourceEffect
--    public export
--    sig : Effect -> Type -> Type
--    sig e r = e r () (\v => ())
--  
--  namespace NoUpdateEffect
--    public export
--    sig : Effect -> (ret : Type) -> (resource : Type) -> Type
--    sig e r e_in = e r e_in (\v => e_in)
--  
--  namespace UpdateEffect
--    public export
--    sig : Effect -> (ret : Type) -> (res_in : Type) -> (res_out : Type) -> Type
--    sig e r e_in e_out = e r e_in (\v => e_out)
--  
--  namespace DepUpdateEffect
--    public export
--    sig : Effect ->
--          (ret : Type) -> (res_in : Type) -> (res_out : ret -> Type) -> Type
--    sig e r e_in e_out = e r e_in e_out
--  
--  
--  ||| Handler interfaces describe how an effect `e` is translated to the
--  ||| underlying computation context `m` for execution.


-- Annotated effects handler
public export
interface Handler (e : Effect) (m : Type -> Type) (a : Type) where
  ||| How to handle the effect.
  |||
  ||| @ r The resource being handled.
  ||| @ eff The effect to be applied.
  ||| @ k The continuation to pass the result of the effect
  covering handle : (r : res) -> (eff : e t (the Type res) (the (t -> Type) resk)) ->
                    (k : ((x : t) -> (the (t -> Type) resk) x -> m a)) -> m a

--  
--  ||| Get the resource type (handy at the REPL to find out about an effect)
--  resourceType : EFFECT -> Type
--  resourceType (MkEff t e) = t
--  
--  -- --------------------------------------------------------- [ Syntactic Sugar ]
--  
--  -- A bit of syntactic sugar ('syntax' is not very flexible so we only go
--  -- up to a small number of parameters...)
--  
--  -- No state transition
--  syntax "{" [inst] "}" [eff] = eff inst (\result => inst)
--  
--  -- The state transition is dependent on a result `b`, a bound variable.
--  syntax "{" [inst] "==>" "{" {b} "}" [outst] "}" [eff]
--         = eff inst (\b => outst)
--  
--  --- A simple state transition
--  syntax "{" [inst] "==>" [outst] "}" [eff] = eff inst (\result => outst)
--  

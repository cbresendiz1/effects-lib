# Guide through the examples in this directory :

## In trying to type check effect handlers there were a couple problem with provided type signature.

### In typeExample0F1.idr and typeExample0F2.idr : 
  - the type error comes from inferring that res is a defined variable
  - found in error0.log and error1.log

### In typeExample1F1.idr and typeExample1F2.idr
  - both sources have the same effect handler, but different effect type signature
  - in this case, the type signature is annotated, but the (res a) evaluates to the wrong type for the effect
despite being the same type as the res in the resource type field

#### Two things come up :
  - If res is declared in the handler, they have to have the same type signature, showing up in the "the" type signature
  - the evaluated expression of the type signature needs to match the effect type signature

### In typeExample1F3.idr and typeExample1F4.idr
  - in this section, res is changed to correct the type issuse from typeExample1F{1,2}.idr with (res a) and res
  - resk encounters type mismatches with effects, similar to typeExample1F{1,2}.idr

### in typeExample1F5.idr 
  - In this example, the code is adjusted with res and resk, but the effect type signature is left as
    the original type signature (x : Type) -> Type -> (x -> Type) -> Type

### In typeExample1W4.idr
  - This typechecks because the res satisfies both constraints of the new effect types with res and resk
  - Also res and resk take an "a" at the correct moment in the effect type signature as per the effect handler.

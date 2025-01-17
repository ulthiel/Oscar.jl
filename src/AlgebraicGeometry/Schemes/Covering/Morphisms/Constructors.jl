########################################################################
# Constructors for CoveringMorphism                                    #
########################################################################

@doc raw"""
    identity_map(C::Covering) -> CoveringMorphism

Given a covering `C`, return the covering morphism given as the identity
on each patch of `C`.

# Examples
```jldoctest
julia> P, (x, y, z) = graded_polynomial_ring(QQ, [:x, :y, :z]);

julia> Y = variety(ideal([x^3-y^2*z]));

julia> Ycov = covered_scheme(Y);

julia> C = default_covering(Ycov)
Covering
  described by patches
    1: V(-(y//x)^2*(z//x) + 1)
    2: V((x//y)^3 - (z//y))
    3: V((x//z)^3 - (y//z)^2)
  in the coordinate(s)
    1: [(y//x), (z//x)]
    2: [(x//y), (z//y)]
    3: [(x//z), (y//z)]

julia> identity_map(C)
Covering morphism
  from covering with 3 patches
    1a: [(y//x), (z//x)]   V(-(y//x)^2*(z//x) + 1)
    2a: [(x//y), (z//y)]   V((x//y)^3 - (z//y))
    3a: [(x//z), (y//z)]   V((x//z)^3 - (y//z)^2)
  to covering with 3 patches
    1b: [(y//x), (z//x)]   V(-(y//x)^2*(z//x) + 1)
    2b: [(x//y), (z//y)]   V((x//y)^3 - (z//y))
    3b: [(x//z), (y//z)]   V((x//z)^3 - (y//z)^2)
given by the pullback functions
  1a -> 1b
    (y//x) -> (y//x)
    (z//x) -> (z//x)
  ----------------------------------------
  2a -> 2b
    (x//y) -> (x//y)
    (z//y) -> (z//y)
  ----------------------------------------
  3a -> 3b
    (x//z) -> (x//z)
    (y//z) -> (y//z)
```
"""
function identity_map(C::Covering)
  map_dict = IdDict{AbsSpec, AbsSpecMor}()
  for U in patches(C)
    map_dict[U] = identity_map(U)
  end
  return CoveringMorphism(C, C, map_dict, check=false)
end



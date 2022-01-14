@doc Markdown.doc"""
    iscartier(td::ToricDivisor)

Checks if the divisor `td` is Cartier.

# Examples
```jldoctest
julia> H = hirzebruch_surface(4)
A normal, non-affine, smooth, projective, gorenstein, q-gorenstein, non-fano, 2-dimensional toric variety without torusfactor

julia> td = ToricDivisor(H, [1,0,0,0])
A torus-invariant, prime divisor on a normal toric variety

julia> iscartier(td)
true
```
"""
function iscartier(td::ToricDivisor)
    return get_attribute!(td, :iscartier) do
        return pm_tdivisor(td).CARTIER
    end::Bool
end
export iscartier


@doc Markdown.doc"""
    isprincipal(td::ToricDivisor) 

Determine whether the toric divisor `td` is principal.
# Examples
```jldoctest
julia> H = hirzebruch_surface(4)
A normal, non-affine, smooth, projective, gorenstein, q-gorenstein, non-fano, 2-dimensional toric variety without torusfactor

julia> td = ToricDivisor(H, [1,0,0,0])
A torus-invariant, prime divisor on a normal toric variety

julia> isprincipal(td)
false
```
"""
function isprincipal(td::ToricDivisor)
    return get_attribute!(td, :isprincipal) do
        return pm_tdivisor(td).PRINCIPAL
    end::Bool
end
export isprincipal


@doc Markdown.doc"""
    isbasepoint_free(td::ToricDivisor) 

Determine whether the toric divisor `td` is basepoint free.
# Examples
```jldoctest
julia> H = hirzebruch_surface(4)
A normal, non-affine, smooth, projective, gorenstein, q-gorenstein, non-fano, 2-dimensional toric variety without torusfactor

julia> td = ToricDivisor(H, [1,0,0,0])
A torus-invariant, prime divisor on a normal toric variety

julia> isbasepoint_free(td)
true
```
"""
function isbasepoint_free(td::ToricDivisor)
    return get_attribute!(td, :isbasepoint_free) do
        return pm_tdivisor(td).BASEPOINT_FREE
    end::Bool
end
export isbasepoint_free


@doc Markdown.doc"""
    iseffective(td::ToricDivisor) 

Determine whether the toric divisor `td` is effective.
# Examples
```jldoctest
julia> H = hirzebruch_surface(4)
A normal, non-affine, smooth, projective, gorenstein, q-gorenstein, non-fano, 2-dimensional toric variety without torusfactor

julia> td = ToricDivisor(H, [1,0,0,0])
A torus-invariant, prime divisor on a normal toric variety

julia> iseffective(td)
true
```
"""
function iseffective(td::ToricDivisor)
    return get_attribute!(td, :iseffective) do
        return pm_tdivisor(td).EFFECTIVE
    end::Bool
end
export iseffective


@doc Markdown.doc"""
    isintegral(td::ToricDivisor) 

Determine whether the toric divisor `td` is integral.
# Examples
```jldoctest
julia> H = hirzebruch_surface(4)
A normal, non-affine, smooth, projective, gorenstein, q-gorenstein, non-fano, 2-dimensional toric variety without torusfactor

julia> td = ToricDivisor(H, [1,0,0,0])
A torus-invariant, prime divisor on a normal toric variety

julia> isintegral(td)
true
```
"""
function isintegral(td::ToricDivisor)
    return get_attribute!(td, :isintegral) do
        return pm_tdivisor(td).INTEGRAL
    end::Bool
end
export isintegral


@doc Markdown.doc"""
    isample(td::ToricDivisor) 

Determine whether the toric divisor `td` is ample.
# Examples
```jldoctest
julia> H = hirzebruch_surface(4)
A normal, non-affine, smooth, projective, gorenstein, q-gorenstein, non-fano, 2-dimensional toric variety without torusfactor

julia> td = ToricDivisor(H, [1,0,0,0])
A torus-invariant, prime divisor on a normal toric variety

julia> isample(td)
false
```
"""
function isample(td::ToricDivisor)
    return get_attribute!(td, :isample) do
        return pm_tdivisor(td).AMPLE
    end::Bool
end
export isample


@doc Markdown.doc"""
    isvery_ample(td::ToricDivisor) 

Determine whether the toric divisor `td` is very ample.
# Examples
```jldoctest
julia> H = hirzebruch_surface(4)
A normal, non-affine, smooth, projective, gorenstein, q-gorenstein, non-fano, 2-dimensional toric variety without torusfactor

julia> td = ToricDivisor(H, [1,0,0,0])
A torus-invariant, prime divisor on a normal toric variety

julia> isvery_ample(td)
false
```
"""
function isvery_ample(td::ToricDivisor)
    return get_attribute!(td, :isvery_ample) do
        return pm_tdivisor(td).VERY_AMPLE
    end::Bool
end
export isvery_ample


@doc Markdown.doc"""
    isnef(td::ToricDivisor) 

Determine whether the toric divisor `td` is nef.
# Examples
```jldoctest
julia> H = hirzebruch_surface(4)
A normal, non-affine, smooth, projective, gorenstein, q-gorenstein, non-fano, 2-dimensional toric variety without torusfactor

julia> td = ToricDivisor(H, [1,0,0,0])
A torus-invariant, prime divisor on a normal toric variety

julia> isnef(td)
true
```
"""
function isnef(td::ToricDivisor)
    return get_attribute!(td, :isnef) do
        return pm_tdivisor(td).NEF
    end::Bool
end
export isnef


@doc Markdown.doc"""
    isq_cartier(td::ToricDivisor) 

Determine whether the toric divisor `td` is Q-Cartier.
# Examples
```jldoctest
julia> H = hirzebruch_surface(4)
A normal, non-affine, smooth, projective, gorenstein, q-gorenstein, non-fano, 2-dimensional toric variety without torusfactor

julia> td = ToricDivisor(H, [1,0,0,0])
A torus-invariant, prime divisor on a normal toric variety

julia> isq_cartier(td)
true
```
"""
function isq_cartier(td::ToricDivisor)
    return get_attribute!(td, :isq_cartier) do
        return pm_tdivisor(td).Q_CARTIER
    end::Bool
end
export isq_cartier


@doc Markdown.doc"""
    isprime_divisor(td::ToricDivisor) 

Determine whether the toric divisor `td` is a prime divisor.

# Examples
```jldoctest
julia> H = hirzebruch_surface(4)
A normal, non-affine, smooth, projective, gorenstein, q-gorenstein, non-fano, 2-dimensional toric variety without torusfactor

julia> td = ToricDivisor(H, [1,0,0,0])
A torus-invariant, prime divisor on a normal toric variety

julia> isprime_divisor(td)
true
```
"""
function isprime_divisor(td::ToricDivisor)
    return get_attribute!(td, :isprime_divisor) do    
        if sum(coefficients(td)) != 1
            return false
        else
            return all(y -> (y == 1 || y == 0), coefficients(td))
        end
    end::Bool
end
export isprime_divisor
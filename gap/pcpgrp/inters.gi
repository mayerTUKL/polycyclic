#############################################################################
##
#W  grpint.gi                  Polycyc                           Bettina Eick
##

#############################################################################
##
#F NormalIntersection( N, U ) . . . . . . . . . . . . . . . . . . .  U \cap N
##
## The core idea here is that the intersection U \cap N equals the kernel of
## the natural homomorphism \phi : U \to UN/N ; see also section 8.8.1 of
## the "Handbook of computational group theory".
## So we can apply the methods for computing kernels of homomorphisms, but we
## need the group UN for this as well, at least implicitly.
##
## The resulting algorithm is quite similar to the Zassenhaus algorithm for
## simultaneously computing the intersection and sum of two vector spaces.
InstallMethod( NormalIntersection, "for pcp groups",
               IsIdenticalObj, [IsPcpGroup, IsPcpGroup],
function( N, U )
    local UN,phi,Ugens,im,phi2;
    UN := ClosureGroup(U,N);
    phi := NaturalHomomorphism(UN,N);
    Ugens := GeneratorsOfGroup(U);
    im := List(Ugens,x -> Image(phi,x));
    phi2 := GroupHomomorphismByImagesNC(U,Range(phi),Ugens,im);
    return Kernel(phi2);
end );

#############################################################################
##
#M Intersection( N, U )
##
InstallMethod( Intersection2, "for pcp groups",
               IsIdenticalObj, [IsPcpGroup, IsPcpGroup],
function( U, V )
    # check for trivial cases
    if IsInt(Size(U)) and IsInt(Size(V)) then
        if IsInt(Size(V)/Size(U)) and ForAll(Igs(U), x -> x in V ) then
            return U;
        elif Size(V)<Size(U) and IsInt(Size(U)/Size(V))
             and ForAll( Igs(V), x -> x in U ) then
            return V;
        fi;
    fi;

    # test if one the groups is known to be normal
    if IsNormal( V, U ) then
        return NormalIntersection( U, V );
    elif IsNormal( U, V ) then
        return NormalIntersection( V, U );
    fi;

    Error("sorry: intersection for non-normal groups not yet installed");
end );

#############################################################################
##
#W  grpint.gi                  Polycyc                Bettina Eick, Max Mayer
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

BindGlobal("intersectV2", function(U,H)
    local G, series, I, nat_maps, i, j, l, U_neu, hom, K, A, L, pcp, pcpK, mats, pcpmodA, k, exp, h, a, orders, vec, stab_gens, subs, pcpS, freeStab, nmap, affineAction;
    # First determine a linear abelian series
    G := Parent(U);
    series := ShortEfaSeries(G);
    
    # Setting up the factor group maps
    nat_maps := List(series,x -> NaturalHomomorphismByNormalSubgroup(G,x));
    I := Range(nat_maps[1]);
    # iterating over the linear abelian series
    for i in [1..Length(series)-1] do
        # First set up the homomorphism iota : U G_{i+1} / G_{i+1} -> U G_i / G_i \subset G/G_i, uG_{i+1} \mapsto uG_i

        # catch trivial case
        if IsTrivial(Range(nat_maps[i])) then
            K := Image(nat_maps[i+1],U);
        else
            U_neu := GeneratorsOfPcp(Pcp(U,series[i+1]));
            hom := GroupHomomorphismByImages(Image(nat_maps[i+1],U), Range(nat_maps[i]),List(U_neu,x-> Image(nat_maps[i+1],x)), List(U_neu,x-> Image(nat_maps[i],x)));
            K := PreImage(hom,I);
        fi;
        
        # Compute the intersection G_i/G_{i+1} \cap H G_{i+1} / G_{i+1} (A \cap H)
        A := Image(nat_maps[i+1],series[i]);
        L := Intersection(A, Image(nat_maps[i+1],H));
        # map to A / A \cap H
        pcp := Pcp(A,L,"snf");
        nmap := NaturalHomomorphism(A,L);
        orders := RelativeOrdersOfPcp(pcp);
        
        # Construct the derivation map \delta as an affine action \psi and use the implemented functions
        # First catch trivial case
        if Length(pcp) = 0 or IsTrivial(K) then
            I := K;
        # the case when A/L is a non trivial abelian group
        else
            # Compute the Torsion Subgroup / the corresponding quotient group
            subs := Filtered( [1..Length(pcp)], x -> orders[x] = 0 ); # indices of infinite cyclic factors
            pcpK := Pcp(K);
            if Length(subs) >0 then
                # compute matrix corresponding to the affine actions of K
                mats := [];
                for l in [1..Length(pcpK)] do
                    mats[l] := [];
                    # Compute the conjugates with the generators of K
                    for j in [1..Length(subs)] do
                        mats[l][j] := ExponentsByPcp(pcp, pcp[subs[j]]^pcpK[l]){subs}; 
                        mats[l][j][Length(subs)+1] := 0;
                    od;
                od;

                # Second step: Compute the images \delta(k) for the generators k of K
                # Decompose k into k=ha, h \in H, a \in A

                # Compute each generator k of K mod A (hence in HA/A \simeq H / (A \cap H)
                pcpmodA := Pcp(Image(nat_maps[i+1],H),A);
                # Catch trivial case, where HA \subset A
                if Length(pcpmodA) = 0 then
                    for l in [1..Length(pcpK)] do
                        mats[l][Length(subs)+1] := ExponentsByPcp(pcp,pcpK[l]){subs};
                        mats[l][Length(subs)+1][Length(subs)+1] := 1;
                    od;
                else
                    for l in [1..Length(pcpK)] do
                        k := pcpK[l];
                        exp := ExponentsByPcp(pcpmodA, k); # exp vector mod A

                        # lift back into G/G_{i+1}, here h = k mod A
                        h:= MappedVector(exp,pcpmodA);
                        a := h^-1*k; # a in A and k = h* a
                        # Write this a in the last line of the affine operation
                        mats[l][Length(subs)+1] := ExponentsByPcp(pcp,a){subs};
                        mats[l][Length(subs)+1][Length(subs)+1] := 1;
                    od;
                fi;
                
                # now compute the stabiliser of the free quotient.
                vec := ZeroMutable(subs);
                vec[Length(subs)+1] := 1;
                freeStab := StabilizerIntegralAction(K, mats,vec);
            else
                freeStab := K;
            fi;
            pcpS := Pcp(freeStab);
            # second step, let this stabiliser operate on the entire group A/L
            # compute the affine action
            mats := [];
            pcpmodA := Pcp(Image(nat_maps[i+1],H),A);
            # Catch trivial case, where HA \subset A
            if Length(pcpmodA) = 0 then
                for l in [1..Length(pcpS)] do
                    mats[l] := [pcpS[l], pcpS[l]];
                od;
            else
                for l in [1..Length(pcpS)] do
                    k := pcpS[l];
                    exp := ExponentsByPcp(pcpmodA, k); # exp vector mod A

                    # lift back into G/G_{i+1}, here h = k mod A
                    h:= MappedVector(exp,pcpmodA);
                    a := h^-1*k; # a in A and k = h* a
                    mats[l] := [pcpS[l],a];
                od;
            fi;
            
            affineAction := function( pnt, mat )
                return Image( nmap, PreImagesRepresentative( nmap, pnt )^mat[1] *mat[2]);
            end;
            
            stab_gens := PcpOrbitStabilizer( Image(nmap,OneOfPcp(pcp)), pcpS, mats, affineAction ).stab;
            I := Subgroup(K,stab_gens);
            
        fi;
    od;
    return PreImage(nat_maps[Length(series)],I);
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

    return intersectV2(U,V);
end );

#############################################################################
##
#M Intersection( U, N )
##
InstallGlobalFunction( PcpZassenhausIntersection, function(N,U)
    local Ugens,Ngens,G,GG,coll,P,L,res,ind,n,gens,i,k;
    
    G := Parent(U);
    coll := Collector(U);
    n := NumberOfGenerators(coll);
    P:=PartitionOfCollector(coll);
    k:=Length(P);
    Append(P,List(P{[2..Length(P)]}, x -> [x[1]+n,x[2]+n]));
    P[k][2] := P[1][2] + n;
    
    GG := DirectProduct(G,G);
    L:=[];
    
    #choose generator set
    Ugens := GeneratorsOfGroup(U);
    Ngens := GeneratorsOfGroup(N);
    
    for i in [1..Length(Ugens)] do
    Add(L,Image(Embedding(GG,1),Ugens[i])*Image(Embedding(GG,2),Ugens[i]));
    od;
    for i in [1..Length(Ngens)] do
    Add(L,Image(Embedding(GG,1),Ngens[i]));
    od;
    
    res := NewCgs(L,P);
    
    # filter the result
    gens := Filtered(res,x-> Depth(x)>n);
    # project to G
    gens := List(gens, x-> PcpElementByExponents(coll,Exponents(x){[n+1..2*n]}));
    
    return Subgroup(G,gens);

end );


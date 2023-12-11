gap> START_TEST("newIgs.tst");

# This example was sent to us by Heiko Dietrich. It formerly was very slow to
# compute and suffered from exponent size explosion.
# See also <https://github.com/gap-packages/polycyclic/issues/17>.
#
gap> ftl := FromTheLeftCollector( 26 );;
gap> SetRelativeOrder( ftl, 1, 5 );
gap> SetPower( ftl, 1, [ 2, 1, 3, 1, 4, 1, 5, 1, 6, 1 ] );
gap> SetRelativeOrder( ftl, 2, 5 );
gap> SetPower( ftl, 2, [] );
gap> SetRelativeOrder( ftl, 3, 5 );
gap> SetPower( ftl, 3, [] );
gap> SetRelativeOrder( ftl, 4, 5 );
gap> SetPower( ftl, 4, [] );
gap> SetRelativeOrder( ftl, 5, 5 );
gap> SetPower( ftl, 5, [] );
gap> SetRelativeOrder( ftl, 6, 5 );
gap> SetPower( ftl, 6, [] );
gap> SetConjugate( ftl, 2, 1, [ 6, 1 ] );
gap> SetConjugate( ftl, 3, 1, [ 2, 1 ] );
gap> SetConjugate( ftl, 4, 1, [ 3, 1 ] );
gap> SetConjugate( ftl, 5, 1, [ 4, 1 ] );
gap> SetConjugate( ftl, 6, 1, [ 5, 1 ] );
gap> SetConjugate( ftl, 7, 1, [ 26, -1 ] );
gap> SetConjugate( ftl, 7, 6, [ 22, -1 ] );
gap> SetConjugate( ftl, 8, 1, [ 7, 1 ] );
gap> SetConjugate( ftl, 8, 2, [ 23, -1 ] );
gap> SetConjugate( ftl, 9, 1, [ 8, 1 ] );
gap> SetConjugate( ftl, 9, 3, [ 24, -1 ] );
gap> SetConjugate( ftl, 10, 1, [ 9, 1 ] );
gap> SetConjugate( ftl, 10, 4, [ 25, -1 ] );
gap> SetConjugate( ftl, 11, 1, [ 10, 1 ] );
gap> SetConjugate( ftl, 11, 5, [ 26, -1 ] );
gap> SetConjugate( ftl, 12, 1, [ 11, 1, 26, -1 ] );
gap> SetConjugate( ftl, 12, 6, [ 7, 1, 22, -1 ] );
gap> SetConjugate( ftl, 13, 1, [ 12, 1 ] );
gap> SetConjugate( ftl, 13, 2, [ 8, 1, 23, -1 ] );
gap> SetConjugate( ftl, 14, 1, [ 13, 1 ] );
gap> SetConjugate( ftl, 14, 3, [ 9, 1, 24, -1 ] );
gap> SetConjugate( ftl, 15, 1, [ 14, 1 ] );
gap> SetConjugate( ftl, 15, 4, [ 10, 1, 25, -1 ] );
gap> SetConjugate( ftl, 16, 1, [ 15, 1 ] );
gap> SetConjugate( ftl, 16, 5, [ 11, 1, 26, -1 ] );
gap> SetConjugate( ftl, 17, 1, [ 16, 1, 26, -1 ] );
gap> SetConjugate( ftl, 17, 6, [ 12, 1, 22, -1 ] );
gap> SetConjugate( ftl, 18, 1, [ 17, 1 ] );
gap> SetConjugate( ftl, 18, 2, [ 13, 1, 23, -1 ] );
gap> SetConjugate( ftl, 19, 1, [ 18, 1 ] );
gap> SetConjugate( ftl, 19, 3, [ 14, 1, 24, -1 ] );
gap> SetConjugate( ftl, 20, 1, [ 19, 1 ] );
gap> SetConjugate( ftl, 20, 4, [ 15, 1, 25, -1 ] );
gap> SetConjugate( ftl, 21, 1, [ 20, 1 ] );
gap> SetConjugate( ftl, 21, 5, [ 16, 1, 26, -1 ] );
gap> SetConjugate( ftl, 22, 1, [ 21, 1, 26, -1 ] );
gap> SetConjugate( ftl, 22, 6, [ 17, 1, 22, -1 ] );
gap> SetConjugate( ftl, 23, 1, [ 22, 1 ] );
gap> SetConjugate( ftl, 23, 2, [ 18, 1, 23, -1 ] );
gap> SetConjugate( ftl, 24, 1, [ 23, 1 ] );
gap> SetConjugate( ftl, 24, 3, [ 19, 1, 24, -1 ] );
gap> SetConjugate( ftl, 25, 1, [ 24, 1 ] );
gap> SetConjugate( ftl, 25, 4, [ 20, 1, 25, -1 ] );
gap> SetConjugate( ftl, 26, 1, [ 25, 1 ] );
gap> SetConjugate( ftl, 26, 5, [ 21, 1, 26, -1 ] );
gap> SetConjugate( ftl, -7, 1, [ 26, 1 ] );
gap> SetConjugate( ftl, -7, 6, [ 22, 1 ] );
gap> SetConjugate( ftl, -8, 1, [ 7, -1 ] );
gap> SetConjugate( ftl, -8, 2, [ 23, 1 ] );
gap> SetConjugate( ftl, -9, 1, [ 8, -1 ] );
gap> SetConjugate( ftl, -9, 3, [ 24, 1 ] );
gap> SetConjugate( ftl, -10, 1, [ 9, -1 ] );
gap> SetConjugate( ftl, -10, 4, [ 25, 1 ] );
gap> SetConjugate( ftl, -11, 1, [ 10, -1 ] );
gap> SetConjugate( ftl, -11, 5, [ 26, 1 ] );
gap> SetConjugate( ftl, -12, 1, [ 11, -1, 26, 1 ] );
gap> SetConjugate( ftl, -12, 6, [ 7, -1, 22, 1 ] );
gap> SetConjugate( ftl, -13, 1, [ 12, -1 ] );
gap> SetConjugate( ftl, -13, 2, [ 8, -1, 23, 1 ] );
gap> SetConjugate( ftl, -14, 1, [ 13, -1 ] );
gap> SetConjugate( ftl, -14, 3, [ 9, -1, 24, 1 ] );
gap> SetConjugate( ftl, -15, 1, [ 14, -1 ] );
gap> SetConjugate( ftl, -15, 4, [ 10, -1, 25, 1 ] );
gap> SetConjugate( ftl, -16, 1, [ 15, -1 ] );
gap> SetConjugate( ftl, -16, 5, [ 11, -1, 26, 1 ] );
gap> SetConjugate( ftl, -17, 1, [ 16, -1, 26, 1 ] );
gap> SetConjugate( ftl, -17, 6, [ 12, -1, 22, 1 ] );
gap> SetConjugate( ftl, -18, 1, [ 17, -1 ] );
gap> SetConjugate( ftl, -18, 2, [ 13, -1, 23, 1 ] );
gap> SetConjugate( ftl, -19, 1, [ 18, -1 ] );
gap> SetConjugate( ftl, -19, 3, [ 14, -1, 24, 1 ] );
gap> SetConjugate( ftl, -20, 1, [ 19, -1 ] );
gap> SetConjugate( ftl, -20, 4, [ 15, -1, 25, 1 ] );
gap> SetConjugate( ftl, -21, 1, [ 20, -1 ] );
gap> SetConjugate( ftl, -21, 5, [ 16, -1, 26, 1 ] );
gap> SetConjugate( ftl, -22, 1, [ 21, -1, 26, 1 ] );
gap> SetConjugate( ftl, -22, 6, [ 17, -1, 22, 1 ] );
gap> SetConjugate( ftl, -23, 1, [ 22, -1 ] );
gap> SetConjugate( ftl, -23, 2, [ 18, -1, 23, 1 ] );
gap> SetConjugate( ftl, -24, 1, [ 23, -1 ] );
gap> SetConjugate( ftl, -24, 3, [ 19, -1, 24, 1 ] );
gap> SetConjugate( ftl, -25, 1, [ 24, -1 ] );
gap> SetConjugate( ftl, -25, 4, [ 20, -1, 25, 1 ] );
gap> SetConjugate( ftl, -26, 1, [ 25, -1 ] );
gap> SetConjugate( ftl, -26, 5, [ 21, -1, 26, 1 ] );

#
gap> g := PcpGroupByCollector(ftl);
Pcp-group with orders [ 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0, 0 ]
gap> gen:=[ g.1, g.1^4*g.2^4*g.3^4*g.4^4*g.6*g.7*g.25^-1*g.26^2 ];;
gap> U := Subgroup(g,gen);
Pcp-group with orders [ 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0, 0 ]
gap> NewCgs(gen,PartitionOfCollector(ftl));
[ g1, g2*g22^3*g23*g24^2*g25*g26^3, g3*g22^3*g23^3*g24*g25^2*g26, 
  g4*g22*g23^3*g24^3*g25*g26^2, g5*g22^2*g23*g24^3*g25^3*g26, 
  g6*g22*g23^2*g24*g25^3*g26^3, g7*g22, g8*g23, g9*g24, g10*g25, g11*g26, 
  g12*g22^2, g13*g23^2, g14*g24^2, g15*g25^2, g16*g26^2, g17*g22^3, 
  g18*g23^3, g19*g24^3, g20*g25^3, g21*g26^3, g22^5, g23^5, g24^5, g25^5, 
  g26^5 ]

#
#######################################
#
# Heisenberg group example where the revised version IgsByGens at <http://www.iaa.tu-bs.de/beick/soft/igs.gi> had an error because not all commutators have been added
# It returned g11^19 as last generator instead of g11 itself
#
gap> G1:=HeisenbergPcpGroup(5);;
gap> coll1 := Collector(G1);;
gap> U3:=[PcpElementByExponents(coll1,[ 3, -1, -1, -2, -1, 2, 4, 6, -2, -3, 1 ]), PcpElementByExponents(coll1,[ 0, 3, -6, 0, 2, -2, 0, -1, 3, 1, -3 ]), PcpElementByExponents(coll1,[ 0, 1, 4, -3, 0, -2, 2, 6, 3, -1, 2 ])];;
gap> P:= PartitionOfCollector(coll1);;
gap> NewCgs(U3,P);
[ g1^3*g3^3*g4^-5*g5^-1*g7^6*g8^12*g9*g10^-4, 
  g2*g3^4*g4^-3*g6^-2*g7^2*g8^6*g9^3*g10^-1, g3^18*g4^-9*g5^-2*g6^-4*g7^6*g8^
    19*g9^6*g10^-4, g11 ]
gap> Comm(U3[2],U3[3])*Comm(U3[1],U3[2]);
g11

#
#######################################
#
# Performance example - even the wrong old version of Igs() would not terminate in meaningful time
#
gap> G2 := HeisenbergPcpGroup(10);;
gap> coll2 := Collector(G2);;
gap> U2 := [PcpElementByExponents(coll2,[ -2, 1, 4, 1, -2, 4, 2, 0, -2, 1, 2, 2, -2, -3, 2, -2, -4, -1, -1, -3, 3 ]), PcpElementByExponents(coll2,[ -1, -1, -2, -1, 2, 4, 6, -2, -3, 1, 0, 3, -6, 0, 2, -2, 0, -1, 3, 1, -3 ]), PcpElementByExponents(coll2,[ 0, 1, 4, -3, 0, -2, 2, 6, 3, -1, 2, -2, 0, -3, 0, -3, 1, 2, -2, 6, -3 ]), PcpElementByExponents(coll2,[ 2, -1, 4, 0, 0, -1, -3, 1, 0, 5, -3, 3, -2, 3, -4, 1, 2, 0, 0, -1, -5 ]), PcpElementByExponents(coll2,[ -4, -6, 2, 2, 0, -1, -3, 0, 3, 2, 1, 7, -2, 2, -1, 1, 0, -2, -1, 3, 1 ]), PcpElementByExponents(coll2,[ 3, 1, -1, -1, -1, -3, 1, -2, 1, -1, 2, -3, -4, 3, 2, 0, 2, 0, 3, 1, 3 ]), PcpElementByExponents(coll2,[ 0, 0, -6, 3, 0, -1, -3, -1, 2, 3, 1, 3, -2, -2, 1, 2, -1, -4, 0, 0, -1 ]), PcpElementByExponents(coll2,[ 2, -4, -3, -2, 0, 1, 0, 0, -3, -1, 1, -1, 2, 1, 0, -2, 3, 4, 3, -2, 1 ]), PcpElementByExponents(coll2,[ 1, -2, 2, -2, -1, -2, 2, -2, -4, -4, 2, 2, 1, 2, -4, 2, 0, -1, 3, 1, 3 ]), PcpElementByExponents(coll2,[ -1, -2, 2, 3, 0, 2, 1, -4, -2, 1, 2, 4, 0, -1, -1, -4, 0, 1, -3, 2, 1 ]), PcpElementByExponents(coll2,[ -2, 0, -2, -1, -4, -4, 0, 1, 1, 0, 1, 1, -2, 0, 1, 1, 1, -1, -1, 1, 2 ]), PcpElementByExponents(coll2,[ 1, 1, 0, -2, 0, -1, 0, -1, -2, 5, 0, -6, 1, -2, 1, 2, 0, 4, 2, 2, 0 ]), PcpElementByExponents(coll2,[ 1, -2, 2, 2, -3, 6, 3, 5, 3, 1, -2, 0, 0, -2, 0, 2, -3, -2, 2, 1, -4 ]), PcpElementByExponents(coll2,[ -2, -3, -1, 1, -5, 0, 1, 0, 2, -2, 2, 0, 1, 1, 2, 0, 0, 0, 4, 3, 6 ]), PcpElementByExponents(coll2,[ -1, 2, 0, -5, 0, -3, -3, 0, 1, -1, -1, 4, 2, -1, 3, 0, -1, 4, 5, -3, -2 ]), PcpElementByExponents(coll2,[ 1, -1, 2, 1, -4, -3, 3, 0, 0, 3, 2, -2, 0, -2, 1, 0, 5, 1, 1, 0, -1 ]), PcpElementByExponents(coll2,[ -1, -1, 6, -1, 0, 2, -2, 1, 0, 1, -4, -4, -2, -4, 1, -3, -1, 3, 0, 3, 0 ]), PcpElementByExponents(coll2,[ 0, -2, 0, -1, 0, -3, 5, -2, -2, -3, -1, -1, 3, 3, 2, -1, 1, 0, 0, -1, 0 ]), PcpElementByExponents(coll2,[ -3, 2, -4, 1, 1, 0, 0, -3, 2, -2, -4, -2, 1, -2, 1, -2, -3, -2, 2, -2, -1 ]), PcpElementByExponents(coll2,[ -3, -3, -2, 1, 5, 1, 0, -1, 1, 3, -2, -1, 1, 0, -2, -1, 3, 4, -3, 3, -1 ]), PcpElementByExponents(coll2,[ 0, 2, 5, -3, 1, -2, -2, 0, 1, -4, -3, -1, 3, 0, 2, -1, -4, 3, -3, -4, 3 ]), PcpElementByExponents(coll2,[ -1, -1, -1, -1, 0, 1, -3, -3, -3, -1, 0, -2, -2, 3, 3, 1, -2, 1, -2, -1, 2 ]), PcpElementByExponents(coll2,[ 7, 5, -1, -2, -4, 4, 0, 2, -1, -2, 0, 0, 4, -1, -1, 0, 1, 2, 2, -1, -3 ]), PcpElementByExponents(coll2,[ 2, 0, -2, -1, 0, 0, 3, -1, 2, 0, -2, -3, -3, 1, 2, 0, -1, -1, -3, -4, 0 ]), PcpElementByExponents(coll2,[ 0, -2, -1, -1, 2, 0, 0, 0, 1, 2, -1, 0, -3, 2, -2, 3, 1, 2, 0, 0, -1 ]), PcpElementByExponents(coll2,[ 2, 1, 0, -1, -1, 0, -4, 0, 8, -1, -2, -4, -2, 0, -2, -1, -2, 3, -2, -1, 0 ]), PcpElementByExponents(coll2,[ 2, 0, 1, 0, 3, -2, 0, -1, 5, 3, 0, -2, 1, 2, 1, -2, 0, -3, -3, -1, 0 ]), PcpElementByExponents(coll2,[ -1, 0, -2, 3, 2, -5, -4, 4, 1, 1, -3, 0, -5, 1, -6, 2, 2, 1, -3, 2, 0 ]), PcpElementByExponents(coll2,[ 0, -1, 3, 0, -3, -4, 1, -2, 0, 0, -1, 4, 1, 0, 4, -1, 2, -2, -1, -3, -3 ]), PcpElementByExponents(coll2,[ 2, -1, 0, -2, 3, 2, -1, 0, -3, 4, 0, 0, -1, 0, -2, 3, 3, -5, 0, -6, 0 ])];;

#
gap> NewCgs(U2,PartitionOfCollector(coll2));
[ g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12, g13, g14, g15, g16, g17, 
  g18, g19, g20, g21 ]

#
#######################################
#
# This example involves a pc group with mostly infinite quotients. It involved some issues with the partition used when handling the finite quotient.
#
gap> coll := FromTheLeftCollector( 8 );;
gap> SetRelativeOrder( coll, 5, 2 );
gap> SetPower( coll, 5, [ 6, 1 ] );
gap> SetConjugate( coll, 2, 1, [ 2, 1, 4, 1, 7, -1 ] );
gap> SetConjugate( coll, 3, 1, [ 3, -1, 4, 1, 6, 1 ] );
gap> SetConjugate( coll, 3, 2, [ 3, 1, 4, -1, 7, 1, 8, -1 ] );
gap> SetConjugate( coll, 4, 2, [ 4, -1 ] );
gap> SetConjugate( coll, 5, 1, [ 5, 1, 7, 1 ] );
gap> SetConjugate( coll, 5, 2, [ 5, 1, 7, 1 ] );
gap> SetConjugate( coll, 5, 3, [ 5, 1, 7, 1, 8, 1 ] );
gap> SetConjugate( coll, 7, 1, [ 7, -1 ] );
gap> SetConjugate( coll, 7, 3, [ 7, -1 ] );
gap> SetConjugate( coll, 7, 5, [ 7, -1 ] );
gap> SetConjugate( coll, 8, 2, [ 8, -1 ] );
gap> SetConjugate( coll, 8, 3, [ 8, -1 ] );
gap> SetConjugate( coll, 8, 5, [ 8, -1 ] );
gap> SetConjugate( coll, 2, -1, [ 2, 1, 4, -1, 7, -1 ] );
gap> SetConjugate( coll, 3, -1, [ 3, -1, 4, 1, 6, 1 ] );
gap> SetConjugate( coll, 3, -2, [ 3, 1, 4, -1, 7, -1, 8, -1 ] );
gap> SetConjugate( coll, 4, -2, [ 4, -1 ] );
gap> SetConjugate( coll, 5, -1, [ 5, 1, 7, 1 ] );
gap> SetConjugate( coll, 5, -2, [ 5, 1, 7, -1 ] );
gap> SetConjugate( coll, 5, -3, [ 5, 1, 7, 1, 8, 1 ] );
gap> SetConjugate( coll, 7, -1, [ 7, -1 ] );
gap> SetConjugate( coll, 7, -3, [ 7, -1 ] );
gap> SetConjugate( coll, 7, -5, [ 7, -1 ] );
gap> SetConjugate( coll, 8, -2, [ 8, -1 ] );
gap> SetConjugate( coll, 8, -3, [ 8, -1 ] );
gap> SetConjugate( coll, 8, -5, [ 8, -1 ] );
gap> SetConjugate( coll, -2, 1, [ 2, -1, 4, 1, 7, 1 ] );
gap> SetConjugate( coll, -3, 1, [ 3, 1, 4, -1, 6, -1 ] );
gap> SetConjugate( coll, -3, 2, [ 3, -1, 4, 1, 7, 1, 8, -1 ] );
gap> SetConjugate( coll, -4, 2, [ 4, 1 ] );
gap> SetConjugate( coll, -7, 1, [ 7, 1 ] );
gap> SetConjugate( coll, -7, 3, [ 7, 1 ] );
gap> SetConjugate( coll, -7, 5, [ 7, 1 ] );
gap> SetConjugate( coll, -8, 2, [ 8, 1 ] );
gap> SetConjugate( coll, -8, 3, [ 8, 1 ] );
gap> SetConjugate( coll, -8, 5, [ 8, 1 ] );
gap> SetConjugate( coll, -2, -1, [ 2, -1, 4, -1, 7, 1 ] );
gap> SetConjugate( coll, -3, -1, [ 3, 1, 4, -1, 6, -1 ] );
gap> SetConjugate( coll, -3, -2, [ 3, -1, 4, 1, 7, -1, 8, -1 ] );
gap> SetConjugate( coll, -4, -2, [ 4, 1 ] );
gap> SetConjugate( coll, -7, -1, [ 7, 1 ] );
gap> SetConjugate( coll, -7, -3, [ 7, 1 ] );
gap> SetConjugate( coll, -7, -5, [ 7, 1 ] );
gap> SetConjugate( coll, -8, -2, [ 8, 1 ] );
gap> SetConjugate( coll, -8, -3, [ 8, 1 ] );
gap> SetConjugate( coll, -8, -5, [ 8, 1 ] );

#
gap> G:=PcpGroupByCollector(coll);;
gap> gensU:= [ G.3^2*G.6^-1, G.3*G.5*G.6^-1, G.4, G.7, G.8 ];
[ g3^2*g6^-1, g3*g5*g6^-1, g4, g7, g8 ]
gap> P:= PartitionOfCollector(coll);;
gap> NewCgs(gensU,P);
[ g3*g5*g6^-1, g4, g7, g8 ]

#
#######################################
#
# Finite non-nilpotent group as an example
#
gap> coll := FromTheLeftCollector( 4 );;
gap> SetRelativeOrder( coll, 1, 2 );
gap> SetRelativeOrder( coll, 2, 3 );
gap> SetRelativeOrder( coll, 3, 2 );
gap> SetRelativeOrder( coll, 4, 2 );
gap> SetPower( coll, 1, [] );
gap> SetPower( coll, 2, [] );
gap> SetPower( coll, 3, [] );
gap> SetPower( coll, 4, [] );
gap> SetConjugate( coll, 3, 2, [ 4, 1 ] );
gap> SetConjugate( coll, 3, -2, [ 3 , 1 , 4, 1 ] );
gap> SetConjugate( coll, 4, 2, [ 3 , 1 , 4, 1 ] );
gap> G := PcpGroupByCollector(coll);;
gap> U1 := [G.1*G.3*G.4,G.1*G.3];;
gap> U2 := [G.1*G.3*G.4,G.2*G.4];;
gap> P := PartitionOfCollector(coll);;
gap> NewCgs(U1,P);
[ g1*g3, g4 ]
gap> NewCgs(U2,P);
[ g1, g2, g3, g4 ]

#
#######################################
#
# Example for relevant different termination criterion
#
gap> coll := FromTheLeftCollector(3);;
gap> SetConjugate(coll,3,1,[3,-1]);;
gap> SetConjugate(coll,3,-1,[3,-1]);;
gap> G:=PcpGroupByCollector(coll);;
gap> U:=[G.1,G.2*G.3^2,G.3^4,G.2*G.3^-2];;
gap> NewCgs(U,PartitionOfCollector(coll));
[ g1, g2*g3^2, g3^4 ]

#
#######################################
#
# There was a bug with the finite exponent relations where this just loop for ever
#
gap> g:= ExamplesOfSomePcpGroups(14);;
gap> G := g;;
gap> coll := Collector(g);;
gap> P:= PartitionOfCollector(coll);;
gap> U := [ g.1^-2*g.2*g.3*g.4^3*g.5*g.7^4*g.11^3*g.15^3*g.16^2*g.17^2*g.18^3*g.19^3*g.20^2*g.22*g.23^2, g.1*g.2*g.3*g.4^-2*g.5*g.6^-1*g.7*g.8^-4*g.9^-1*g.10^-1*g.11*g.12*g.13*g.14*g.15^4*g.16^2*g.17^2*g.18^4*g.19^4*g.20^3*g.22^-2, g.1^-2*g.3*g.4^3*g.5*g.6*g.7^3*g.8^-1*g.9*g.10^-1*g.11*g.13^2*g.14*g.15^2*g.17*g.18^2*g.19^4*g.20^3*g.21^2*g.23*g.24^3 ];;
gap> NewCgs(U,P);
[ g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12, g13, g14, g15, g16, g17, 
  g18, g19, g20, g21, g22, g23, g24 ]

#
#######################################
#
# The previous example had an unordinary long runtime when using the "better" permutation than this one.
#
gap> Q:=[ [ 1, 1 ], [ 2, 6 ], [ 7, 10 ], [ 11, 11 ], [ 12, 12 ], [ 13, 13 ], [ 14, 14 ], [ 15, 15 ], [ 16, 16 ], [ 17, 17 ], [ 18, 18 ], [ 19, 19 ], [ 20, 20 ], [ 21, 21 ], [ 22, 22 ], [ 23, 23 ], [ 24, 24 ] ];;
gap> NewCgs(U,Q);
[ g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12, g13, g14, g15, g16, g17, 
  g18, g19, g20, g21, g22, g23, g24 ]  

#
gap> STOP_TEST( "newIgs.tst", 1);


LoadPackage("EDIM");

# This function returns the depth of the commutator [g_i,g_j] where i < j by looking at the conjugate relations.
DepthOfCommutator := function(coll,i,j)
	local l,n;
	l := GetConjugate(coll,j,i);
	n := NumberOfGenerators(coll);

	# if the right hand side has depth > j => comm has depth j
	if l[1] > j then
		return j;

	# if the right hand side has depth < j => comm has the same depth
	elif l[1] < j then
		return l[1];

	else
		if l[2] <> 1 then
			return j;
		else
			if Length(l) = 2 then
				return n+1;
			else
				return l[3];
			fi;
		fi;
	fi;
end;


# This function partitions the set of generators of the collector coll into sets [i,j] such that G_i / G_{j+1} is abelian.
# A greedy algorithm is used bottom up.
PartitionBottomUp := function(coll)
	local i, j, k, n, commDepths, foo, result, orders;
	
	# Compute the minimal depths of the commutators with each generator g_1,...,g_{n-1}
	n := NumberOfGenerators(coll);
	commDepths := [];
	for i in [1..n-1] do
		foo := x -> DepthOfCommutator(coll,i,x);
		commDepths[i] := Minimum(List([i+1..n],foo));
	od;
	orders := RelativeOrders(coll);
	
	j := n;
	i := n-1;
	k := 0;
	result := [];
	# Given g_j find the minimal g_i, such that all g_k, g_l with i<= k < l <= j commute mod G_{j+1} 
	while i > 0 do
		if commDepths[i] < j+1 then
			k := k + 1;
			result[k] := [i+1,j];
			j := i;
		fi;
		i := i - 1;
	od;
	k := k+1;
	result[k] := [1,j];
	return Reversed(result);
end;

# This function partitions the set of generators of the collector coll into sets [i,j] such that G_i / G_{j+1} is abelian.
# A greedy algorithm is used top down.
PartitionTopDown := function(coll)
	local i, j, k, n, b, commDepths, foo, result, endlich;
	
	# Compute the minimal depths of the commutators with each generator g_1,...,g_{n-1}
	n := NumberOfGenerators(coll);
	commDepths := [];
	for i in [1..n-1] do
		foo := x -> DepthOfCommutator(coll,i,x);
		commDepths[i] := Minimum(List([i+1..n],foo));
	od;
	i := 1;
	k := 0;
	result := [];
	# given the generator g_i find the max j s.th. all g_k, g_l with i<= k < l <= j commute mod G_{j+1} 
	while i < n do
		b := Minimum(commDepths[i],n);
		j := Minimum(commDepths{[i..b-1]})-1;
		k:=k+1;
		result[k] := [i,j];
		i:=j+1;
	od;
	
	if i = n then
		k:= k+1;
		result[k] := [n,n];
	fi;
	return result;
end;

# chooses a pre defined partition algorithm
PartitionOfCollector := function(coll)
	return PartitionBottomUp(coll);
end;

# There is probably a function already for this and I am too dumb to find it...
div := function(a,b)
	return (a- (a mod b)) / b;
end;

# Finds the last index i in L for which Depth(L[i]) <= x by binary search. Returns 0 if there is no such entry.
SearchSortedLastByDepth := function(L,x)
	local len,lo,hi,mid;
	
	len := Length(L);
	lo := 1;
	hi := len;
	
	# the search
	while hi>lo+1 do
		mid := lo + div(hi-lo,2);
		if Depth(L[mid]) <= x then
			lo := mid;
		else
			hi := mid;
		fi;
	od;
	
	# finally checks which bound is the correct answer
	if Depth(L[hi]) <= x then
		return hi;
	elif Depth(L[lo]) <= x then
		return lo;
	else
		return 0;
	fi;
end;


# help function, returns the finite exponent relations as row vectors in a list correspondig to the partition
# g_i ^ e_i = g_{i+1}^e_{i+1} * ... * g_t^e_t will result in the row (0,...,0, -e_i , e_{i+1},  ... , e_t) where s \le i \le t for an interval [s,t] in the partition
FiniteRelationsAsMatrixPartition := function(coll, P)
	local n, i, k, pInt, mat, orders, c, result;
	
	n := NumberOfGenerators(coll);
	orders := RelativeOrders(coll);
	result := [];
	# iterate over the partition sets
	for k in [1..Length(P)] do
		pInt:= P[k];
		mat := [];
		# fill in the relation
		c := 0;
		for i in [pInt[1]..pInt[2]] do
			if orders[i] <> 0 then
				c := c + 1;
				mat[c] := ExponentsByObj(coll, GetPower(coll,i)){[pInt[1]..pInt[2]]};
				mat[c][i-pInt[1]+1] := - orders[i];
			fi;
		od;
		result[k] := mat;
	od;
	
	return result;
end;

# help function which reduces the diagonal of an echolon form
ReduceEcholon := function(V)
	local m,i,j,k,d,a,b,r,q;
	
	m := Length(V);
	for k in [1..m-1] do
		i := m-k;
		for j in [i+1..m] do
			d := Depth(V[j]);
			a := Exponents(V[i])[d];
			b := Exponents(V[j])[d];
			r := a mod b;
			q := div(a-r,b);
			if q <> 0 then
				V[i] := V[i]* V[j]^-q;
			fi;
		od;
	od;
	return V;
end;

# Given a set of generators U of some subgroup and a partition P of the corresponding collector computes a new set of generators result such that Depth(result[i]) < Depth(result[j]) for all i < j
# CAUTION: Changes the input variable U!
Echolon := function(U,P)
	local n,l,coll,result,result_inv,pos,t,j,i,lastpos,S,H,V,r,r2,neutral,exponents,e,expRels,elm,pivotIndex,orders,v;
	
	# keeping U sorted makes search easier
	SortBy(U,Depth);
	neutral := U[1]^0;
	coll := Collector(U[1]);
	n := NumberOfGenerators(coll);
	l := Length(P);
	result :=[];
	result_inv :=[];
	pos :=1;
	expRels := FiniteRelationsAsMatrixPartition(coll,P);
	orders := RelativeOrders(coll);
	
	# Iterate over the blocks given by the partition
	for t in [1..l] do
		# find the relevant generators, i. e. of depth at most P[t][2]
		lastpos := SearchSortedLastByDepth(U,P[t][2]);
		if lastpos <> 0 then
			if t <> l then
				# form the corresponding integer submatrix of the exponents and compute an HNF with its LLL reduced transform
				S := [];
				for i in [1..lastpos] do
					exponents := Exponents(U[i]);
					S[i] := exponents{[P[t][1]..P[t][2]]};
				od;
				# glue the exponent relations right after that
				Append(S,expRels[t]);
				# compute HNF
				H := HermiteIntMatLLLTrans(S);
				r := Rank(H[1]);
				r2 := r;
				V := H[2];

				# apply the transformation to compute the new generators corresponding to the pivots
				for j in [1..r] do
					# first check whether the given pivot corresponds to one of the finite exponent relations
					pivotIndex := PositionNonZero(H[1][j]);
					if H[1][j][pivotIndex] <> orders[pivotIndex + P[t][1]-1] then

						elm := neutral;
						for i in [1..lastpos] do
							if V[j,i] <> 0 then
								elm := elm * U[i]^V[j,i];
							fi;
						od;
						result[pos] := elm;
						# also store the inverses TODO: this could be returned as well as they are needed later to compute the commutators again
						result_inv[pos] := Inverse(result[pos]);
						pos := pos + 1;
					else
						# neutral element found, actual rank is smaller
						r2 := r2 - 1;
					fi;
				od;
			
			# if this wasn't the last iteration we need to reduce the lines in U as preparation for the next computation step
				for i in [1..lastpos] do
					
					# reduce all entries with the new generators
					for j in [1..r2] do
						exponents := Exponents(U[i]);
						e := exponents[Depth(result[pos-r2-1+j])];
						if e <> 0 then
							U[i] := U[i] * result_inv[pos-r2-1+j]^(div(e,LeadingExponent(result[pos-r2-1+j])));
						fi;
					od;
				od;
				SortBy(U,Depth);
			else
			# last iteration step does not need an integer transformation matrix and lifting
			# form the corresponding integer submatrix of the exponents and compute an HNF without its LLL reduced transform
				S := [];
				for i in [1..lastpos] do
					exponents := Exponents(U[i]);
					S[i] := exponents{[P[t][1]..P[t][2]]};
				od;
				# glue the exponent relations right after that
				Append(S,expRels[t]);
				H := NormalFormIntMat(S,6);
				r := H.rank;

				# generate the corresponding elements and put them into result
				for i in [1..H.rank] do
					v := H.normal[i];
					pivotIndex := PositionNonZero(v);
						if v[pivotIndex] <> orders[pivotIndex + P[t][1]-1] then

							elm := PcpElementByExponents(coll,Concatenation(ListWithIdenticalEntries(P[t][1]-1,0),v));
							result[pos] := elm;
							# also store the inverses TODO: this could be returned as well as they are needed later to compute the commutators again
							result_inv[pos] := Inverse(result[pos]);
							pos := pos + 1;
						fi;
				od;
			fi;
		fi;
		
	od;
	return result;
end;

# normalizes the input g
NormalizePcElement := function(g)
	local e,d,o,ggt;

	e := LeadingExponent(g);
	d := Depth(g);
	o := RelativeOrders(Collector(g))[d];
	if o = 0 then
		if e < 0 then
			g := g^-1;
		fi;
	else
		ggt := Gcdex(e,o);
		g := g^ggt.coeff1;
	fi;
	return g;
end;

# checks whether the input element g is already normalized
IsNormalizedPcElement := function(g)
	local d,e,o,rorder;
	
	d:= Depth(g);
	e := LeadingExponent(g);
	o := RelativeOrder(g);
	rorder := RelativeOrders(Collector(g))[d];
	if (o=0 and e>0) or (o > 0 and rorder mod e = 0) then
		return true;
	fi;
	return false;
end;

# Probably exists already. Just checks whether the input is the neutral element
# TODO: Is this one still neccessary? Can't I just check for equality where it is used, s.th. I don't have to compute g^0 all the time?
myisone := function(g)
	if g = g^0 then
		return true;
	else
		return false;
	fi;
end;

# Computes an induced generating set for the subgroup generated by inU. P is a partition into "abelian segments" of the corresponding collector
NewIgs := function(inU,P)
	local U,n,S,coll,m,curr,d,b,order,x,exp_elem,changed,i,j,newT,l,a,comm;
	
	# echolon will change the input so make a copy first
	U := StructuralCopy(inU);
	coll := Collector(U[1]);
	n := NumberOfGenerators(coll);
	
	# First round of echolon computation to get at most one generator per depth
	S := Echolon(U,P);
	m := Length(S);
	curr := 1;
	
	# Iterate over the generators starting with the smallest depth first -> only entries with higher depth will change
	while curr < m do
		# First handle normalization and the finite exponent relation
		d := Depth(S[curr]);
		b := m+1;
		order := RelativeOrder(S[curr]);
		
		# if we have a finite order we need to normalize + add the generator corresponding to the exponent relation
		if order <> 0 then
			# normalization
			if not IsNormalizedPcElement(S[curr]) then
				x := NormalizePcElement(S[curr]);
				S[b] := x^(-div(LeadingExponent(S[curr]),LeadingExponent(x)))*S[curr];
				S[curr] := x;
				b := b+1;
			fi;
			# exponent relation
			exp_elem := S[curr]^order;
			if not myisone(exp_elem) then
				S[b] := exp_elem;
				b := b+1;
			fi;
		else
			# infinite order => might only have to flip the sign
			if LeadingExponent(S[curr]) < 0 then
				S[curr] := S[curr]^-1;
			fi;
		fi;
		changed := true;
		
		# we add the commutators and compute an echolon form, repeat until nothing changes anymore
		while changed do
			# add commutators
			for i in [curr+1..m] do
				comm := Comm(S[curr],S[i]);
				if not myisone(comm) then
					S[b] := comm;
					b := b+1;
				fi;
			od;

			if b <> m+1 then
				# compute new echolon form newT
				newT := Echolon(S{[curr+1..b-1]},P);
				# if there are more generators than before something has changed
				l:= Length(newT);
				a := l - (m-curr);
				if a > 0 then
					changed := true;
					m := m + a;
					for i in [1..m-curr] do
						S[curr+i] := newT[i];
					od;

				# if the number is still the same we need to check whether we just switched generators without changing the induced subgroup
				else
					changed := false;
					for i in [1..l] do
						# if the lead is still the same, the induced subgroup hasn't changed on this depth
						if LeadingExponent(S[curr+i]) <> LeadingExponent(newT[i]) then
							changed := true;
							for j in [i..l] do
								S[curr+j] := newT[j];
							od;
							break;
						fi;
					od;
				fi;
				b := m+1;
			else
				# no changes were made => this generator / depth is final. continue with the next one
				changed := false;
			fi;
		od;
		curr := curr + 1;
	od;
	return S{[1..m]};
end;


# computes the canonical induced generator set for the subgroup generated by U using a partition P into "abelian segments" of the corresponding collector
NewCgs := function(U,P)
	local V,m,i,j,k,d,a,b,r,q;

	# First compute a regular induced generator set
	V := NewIgs(U,P);

	# reduce of the entries above the diagonal
	V := ReduceEcholon(V);
	return V;
end;


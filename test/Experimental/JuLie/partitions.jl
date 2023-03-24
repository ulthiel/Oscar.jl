@testset "Experimental/JuLie/partitions.jl" begin

	################################################################################
	# Partition constructor
	################################################################################
	@test Partition{Int8}(2,2,1) == Partition(Int8[2,2,1])
	@test typeof(Partition{Int8}(2,2,1)) == typeof(Partition(Int8[2,2,1]))
	@test Partition{Int8}(1) == Partition(Int8[1])
	@test typeof(Partition{Int8}(1)) == typeof(Partition(Int8[1]))
	@test Partition{Int8}() == Partition(Int8[])
	@test typeof(Partition{Int8}()) == typeof(Partition(Int8[]))

	@test Partition(2,2,1) == Partition([2,2,1])
	@test Partition(1) == Partition([1])
	@test Partition() == Partition([])

	################################################################################
	# num_partitions(n)
	################################################################################

	# From https://oeis.org/A000041
	@test [ num_partitions(i) for i in 0:49 ] == 
		ZZRingElem[ 1, 1, 2, 3, 5, 7, 11, 15, 22, 30, 42, 56, 77, 101, 135, 176, 231, 
		297, 385, 490, 627, 792, 1002, 1255, 1575, 1958, 2436, 3010, 3718, 4565, 
		5604, 6842, 8349, 10143, 12310, 14883, 17977, 21637, 26015, 31185, 37338, 
		44583, 53174, 63261, 75175, 89134, 105558, 124754, 147273, 173525 ]


	# For some random large numbers, checked with Sage
	# Partitions(991).cardinality()
	@test num_partitions(991) == ZZ(16839773100833956878604913215477)

	################################################################################
	# partitions(n)
	################################################################################
	check = true
	for n=0:20
		P = partitions(n)

		# Check that the number of partitions is correct
		# Note that num_partitions(n) is computed independently of partitions(n)
		if length(P) != num_partitions(n)
			check = false
			break
		end

		# Check that all partitions are distinct
		if P != unique(P)
			check = false
			break
		end

		# Check that partitions are really partitions of n
		for lambda in P
			if sum(lambda) != n
				check = false
				break
			end
		end
	end
	@test check==true

	################################################################################
	# ascending_partitions(n)
	################################################################################
	check = true
	for n in 0:20
		# go through all algorithms
		for a in [ "ks", "m" ]
			P = ascending_partitions(n,alg=a)
			# check that number of partitions is correct
			if length(P) != num_partitions(n)
				check = false
				break
			end
			# check that all partitions are distinct
			if P != unique(P)
				check = false
				break
			end
			# check that partitions are really partitions of n
			for lambda in P
				if sum(lambda) != n
					check = false
					break
				end
			end
		end
		if check==false
			break
		end
	end
	@test check==true

	################################################################################
	# num_partitions(n,k)
	################################################################################
	@test num_partitions(0,0) == 1
	@test num_partitions(1,0) == 0
	@test num_partitions(1,1) == 1
	@test num_partitions(0,1) == 0
	@test num_partitions(2,3) == 0

	# From https://oeis.org/A008284
	@test [ num_partitions(n,k) for n in 1:14 for k in 1:n ] == 
		ZZRingElem[ 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 2, 2, 1, 1, 1, 3, 3, 2, 1, 1, 
		1, 3, 4, 3, 2, 1, 1, 1, 4, 5, 5, 3, 2, 1, 1, 1, 4, 7, 6, 5, 3, 2, 1, 1, 1, 
		5, 8, 9, 7, 5, 3, 2, 1, 1, 1, 5, 10, 11, 10, 7, 5, 3, 2, 1, 1, 1, 6, 12, 15, 
		13, 11, 7, 5, 3, 2, 1, 1, 1, 6, 14, 18, 18, 14, 11, 7, 5, 3, 2, 1, 1, 1, 7, 
		16, 23, 23, 20, 15, 11, 7, 5, 3, 2, 1, 1 ]

	# For some random large numbers, checked with Sage
	# Partitions(1991,length=170).cardinality()
	@test num_partitions(1991,170) == ZZ(22381599503916828837298114953756766080813312)
	@test num_partitions(1991,1000) == ZZ(16839773100833956878604913215477)
	@test num_partitions(1991,670) == ZZ(3329965216307826492368402165868892548)
	@test num_partitions(1991,1991) == ZZ(1)
	@test num_partitions(1991,1) == ZZ(1)

	# From Knuth (2011), p. 25.
	@test sum([num_partitions(30, i) for i in 0:10]) == 3590
	
	################################################################################
	# partitions(n,k)
	################################################################################
	check = true
	for n in 0:20
		for k = 0:n+1
			P = partitions(n,k)

			# Create the same by filtering all partitions
			Q = partitions(n)
			filter!( Q->length(Q) == k, Q)

			# Check that P and Q coincide (up to reordering)
			if length(P) != length(Q) || Set(P) != Set(Q)
				check = false
				break
			end

			# Compare length with num_partitions(n,k)
			if length(P) != num_partitions(n,k)
				check = false
				break
			end

		end
		if check==false
			break
		end
	end
	@test check==true


	################################################################################
	# partitions(n,k,l1,l2)
	################################################################################
	check = true
	for n in 0:20
		for k = 0:n+1
			for l1 = 0:n
				for l2 = l1:n
					P = partitions(n,k,l1,l2)

					# Create the same by filtering all partitions
					Q = partitions(n,k)
					filter!( Q->all(>=(l1),Q), Q)
					filter!( Q->all(<=(l2),Q), Q)
					
					# Check that P and Q coincide (up to reordering)
					if length(P) != length(Q) || Set(P) != Set(Q)
						check = false
						break
					end
				end
			end
		end
		if check==false
			break
		end
	end
	@test check==true

	################################################################################
	# partitions(n,k,l1,l2; only_distinct_parts=true)
	################################################################################
	check = true
	for n in 0:20
		for k = 0:n+1
			for l1 = 0:n
				for l2 = l1:n
					P = partitions(n,k,l1,l2; only_distinct_parts=true)

					# Create the same by filtering all partitions
					Q = partitions(n,k, l1, l2)
					filter!( Q->Q==unique(Q), Q )
					
					# Check that P and Q coincide (up to reordering)
					if length(P) != length(Q) || Set(P) != Set(Q)
						check = false
						break
					end
				end
			end
		end
		if check==false
			break
		end
	end
	@test check==true

	################################################################################
	# partitions(m,n,v,mu)
	################################################################################

	# Check argument errors
	@test_throws ArgumentError partitions(5,2, [1,2], [1,2,3])
	@test_throws ArgumentError partitions(-1,2, [1,2,3], [1,2,3])
	@test_throws ArgumentError partitions(5,0,[1,2,3], [1,2])
	@test_throws ArgumentError partitions(6,3,[3,2,1],[1,2,3]) #req v strictly increasing
	@test_throws ArgumentError partitions(6,3,[3,2,1],[0,2,3]) #mu > 0
	@test_throws ArgumentError partitions(6,3,[0,2,1],[1,2,3]) #v > 0

	# Issues from https://github.com/oscar-system/Oscar.jl/issues/2043
	@test length(partitions(17, 3, [1,4], [1,4])) == 0
	@test partitions(17, 5, [1,4], [1,4]) == [ Partition(4,4,4,4,1) ]
	@test length(partitions(17,6,[1,2], [1,7])) == 0
	@test length(partitions(20,5,[1,2,3],[1,3,6])) == 0

	# Special cases
	check = true
	for n=0:20
		for k=0:n+1
			P = partitions(n,k, [i for i in 1:n], [n for i in 1:n])
			Q = partitions(n,k)
			if length(P) != length(Q) || Set(P) != Set(Q)
				check = false
				break
			end

			P = partitions(n,k, [i for i in 1:n], [1 for i in 1:n])
			Q = partitions(n,k,1,n;only_distinct_parts=true)
			if length(P) != length(Q) || Set(P) != Set(Q)
				check = false
				break
			end

		end
	end
	@test check==true

	# From https://www.maa.org/frank-morgans-math-chat-293-ways-to-make-change-for-a-dollar
	@test length(partitions(100, [1,5,10,25,50])) == 292
	@test length(partitions(200, [1,5,10,25,50,100])) == 2728

	# From https://oeis.org/A000008
	@test [ length(partitions(n, [1,2,5,10])) for n in 0:60 ] == 
		[ 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 11, 12, 15, 16, 19, 22, 25, 28, 31, 34, 40, 
		43, 49, 52, 58, 64, 70, 76, 82, 88, 98, 104, 114, 120, 130, 140, 150, 160, 
		170, 180, 195, 205, 220, 230, 245, 260, 275, 290, 305, 320, 341, 356, 377, 
		392, 413, 434, 455, 476, 497, 518, 546 ]


	################################################################################
	# dominates(P)
	###############################################################################
	@test dominates(Partition([4,2]), Partition([3,2,1])) == true
	@test dominates(Partition([4,1,1]), Partition([3,3])) == false
	@test dominates(Partition([3,3]), Partition([4,1,1])) == false
	@test dominates(Partition([5]), Partition([2,2,2])) == false

	################################################################################
	# conjugate(P)
	###############################################################################
	@test conjugate(Partition([6,4,3,1])) == Partition([4, 3, 3, 2, 1, 1])
	@test conjugate(Partition([5,4,1])) == Partition([3, 2, 2, 2, 1])
	@test conjugate(Partition([])) == Partition([])
	check = true
	for p in partitions(10)
		if conjugate(conjugate(p)) != p
			check = false
			break
		end
	end
	@test check==true

end

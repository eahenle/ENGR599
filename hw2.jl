### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ 437c0f11-0653-4357-bde5-afb078ad7153
using DataFrames, PlutoUI

# ╔═╡ cf652126-2b97-11ec-2841-37a3a45b0cc1
md"""
# ENGR 599 Homework 2

### Adrian Henle
"""

# ╔═╡ 905d3d96-f8af-4239-a48a-ca62d775a7a9
md"""
## Data
"""

# ╔═╡ 85aa526d-2cfb-45ea-95dd-eeef52465dda
md"""
#### Table 3.1
"""

# ╔═╡ a859b470-16cd-4e4f-a982-477000ecb33a
begin
	# transcribed data from Table 3.1
	local table3_1_raw ="40 60 40 60
A A B B
57 92 55 66
61 88 53 70
59 90 54 68"
	
	# split by line
	local table3_1_data = split(table3_1_raw, "\n")
	
	table3_1 = DataFrame(
		:temperature => [parse(Float64, x) for x in split(table3_1_data[1])],
		:catalyst => split(table3_1_data[2]),
		:yield1 => [parse(Float64, x) for x in split(table3_1_data[3])],
		:yield2 => [parse(Float64, x) for x in split(table3_1_data[4])],
		:avg_yield => [parse(Float64, x) for x in split(table3_1_data[5])]
	)
end

# ╔═╡ b4e1384f-d57a-49ba-bb52-e2880d1c62f2
md"""
#### Table 3.2
"""

# ╔═╡ e3f7ac7b-afdc-488b-b818-420a15aacd19
table3_2 = Dict(
	:grand_average_μ => 67.75,
	:grand_average_σ => 0.9,
	:effect_T_μ => 22.5,
	:effect_T_σ => 1.8,
	:effect_C_μ => -13.5,
	:effect_C_σ => 1.8,
	:effect_TC_μ => -8.5,
	:effect_TC_σ => 1.8
)

# ╔═╡ 5cfc7d0f-fe05-40ac-9354-bce90594ffb0
md"""
#### Table 3.3
"""

# ╔═╡ be01664b-b1a6-43c7-b27f-cf9de91f480d
begin
	local factors = Dict(
		1 => Dict(:- => 40., :+ => 60.),
		2 => Dict(:- => "A", :+ => "B"),
		3 => Dict(:- => 1.0, :+ => 1.5)
	)
	
	local runs = DataFrame(
		:factor1 => [:-, :+, :-, :+, :-, :+, :-, :+],
		:factor2 => [:-, :-, :+, :+, :-, :-, :+, :+],
		:factor3 => [:-, :-, :-, :-, :+, :+, :+, :+],
		:yield1 => [56., 85., 49., 64., 65., 92., .57, .70],
		:yield2 => [52., 88., 47., 62., 61., 95., 60., 74.],
		:avg_yield => [54., 86.5, 48., 63., 63., 93.5, 58.5, 72.]
	)
	
	table3_3 = Dict(
		:factors => factors,
		:runs => runs
	)
end

# ╔═╡ dda25c43-701d-4dfd-8f74-339d9144a463
md"""
#### Table 3.8
"""

# ╔═╡ 93fdd16a-dae3-48a4-a34e-fe247d750472
table3_8 = Dict(
	:average => 67.188,
	1 => 22.875,
	2 => -14.125,
	3 => 8.875,
	4 => 0.875,
	12 => -8.625,
	13 => -0.625,
	14 => 0.875,
	23 => -0.625,
	24 => 0.875,
	34 => 0.375,
	123 => 0.875,
	124 => -0.125,
	134 => -0.625,
	234 => 0.375,
	1234 => 0.375
)

# ╔═╡ c7e03a1c-896c-4db4-8e76-3c299c05b14c
md"""
## Exercises

#### Exercise 3.1

*Think of an experiment, preferably in your area of research interest, with a qualitative response. Which factors would you like to examine, in order to determine their possible influences on the response? Which factors could be confounding? Which factors could contribute to noise—that is, random fluctuations — in the response?*
"""

# ╔═╡ ef0dee97-07d2-4cf8-91c0-c41af2d3c434
md"""
!!! note
	boring
"""

# ╔═╡ 9c619ca0-8d2c-4c07-acc1-156792ea86cf
md"""
#### Exercise 3.2

*Besides the temperature and catalyst, at the levels described above, our chemist would like to study the effect of pressure at three levels: 1, 5 and 10 atm at the same time using a full factorial design. What is the minimum number of runs that must be carried out?*
"""

# ╔═╡ 6e8fe1d7-b24a-4f15-95da-29754be3b076
md"""
$2^2 * 3 = 12$
"""

# ╔═╡ 3d9f6a75-f2b4-445d-a0bc-56358e8688f9
md"""
#### Exercise 3.3

*We have calculated a measure of the interaction between the T and C factors using the difference in the temperature effects. It might be asked why we did this instead of calculating the difference between the catalyst effects at the two different temperature levels. Use algebraic arguments to show that these two measures are identical. Remember that, with the sign convention we adopted, the calculation that you should make is ((Catalyst effect at 60 1C)–(Catalyst effect at 40 1C)), and not the contrary.*
"""

# ╔═╡ fe8a0eee-c7c6-42cc-8bfc-66966d792f6b
md"""
$T = \frac{\bar y_2+\bar y_4}{2} - \frac{\bar y_1+\bar y_3}{2}$

$C=\frac{\bar y_3+\bar y_4}{2}-\frac{\bar y_1+\bar y_2}{2}$

!!! note
	??? think have to show TC from above is same as TC from another formulation for T and C...
"""

# ╔═╡ dd411de7-0b7a-4267-bcec-df024a92bc9f
md"""
#### Exercise 3.4

*Demonstrate that for any pair of numerical values $s^2=d^2/2$; where $d$ is the difference between the two values. Use this result and show that for a set of n duplicate runs (i.e., each run repeated only once, as in Table 3.1) the pooled estimate of the variance is $s^2=\sum \frac{d^2_i}{2n}$*
"""

# ╔═╡ d824f3e4-972c-4dcc-935c-56204e20a3ba
md"""
!!! note
	???
"""

# ╔═╡ 8e437aec-1383-4e61-bf61-dbf2af843ec9
md"""
#### Exercise 3.5

*According to Table 3.2, the standard error of the grand average is half the standard error of the effects. Use Eq. (2.15) to show that this has to be true.*
"""

# ╔═╡ bfcbe20f-7100-4dc7-b44c-999573b506cf
md"""
$\sigma_{\bar x}^2=\sum_i\frac{1}{n^2}\sigma^2=\frac{\sigma^2}{n}$

!!! note
	???
"""

# ╔═╡ 96041c6f-2777-4d07-a93e-ce9fa6e788c5
md"""
#### Exercise 3.6

*The observations listed below were recorded in genuine replicates of the different runs. Calculate a pooled estimate of the experimental error associated with these observations. How many degrees of freedom does this estimate have?*
"""

# ╔═╡ 19671a0f-158e-4da5-8ab6-04092fc670fe
md"""
!!! note
	???
"""

# ╔═╡ f8a25f7f-c40c-43d0-86e2-6ade66754b80
md"""
#### Exercise 3.7

*The data below were obtained in a study of the influence of two factors on the initial curing time of plaster of Paris, that is, the time when the plaster of Paris starts to harden after the powder is mixed with water (M.F. Pimentel and B.B. Neto, Anais do XXXI Congresso Brasileiro de Quimica, Recife, 1991). The runs were carried out in duplicate and in random order. Calculate all effects and their standard errors. Interpret the results.*
"""

# ╔═╡ d8509256-352d-4484-8053-eefa2a6f5f26
begin
	local table3_7 = DataFrame(
		:factor1 => [:-, :+, :-, :+],
		:factor2 => [:-, :-, :+, :+],
		:response1 => [12.33, 10.52, 10.33, 9.],
		:response2 => [13., 10.57, 9.75, 8.92],
		:μ => [12.67, 10.55, 10.04, 8.96],
		:σ² => [0.224, 0.0013, 0.168, 0.0032]
	)
	
	md"""
	!!! note
		???
	"""
end

# ╔═╡ daf716cf-a6fe-4887-bb75-f40d0ecebe5e
md"""
#### Exercise 3.8

*If we include the divisors, the matrix for calculating the effects becomes:*
"""

# ╔═╡ 5363e1c6-69d5-4cbb-a224-df02a1cba6c4
LocalResource("e3_8.png")

# ╔═╡ 09db9d48-f471-4b4b-9e95-11ac0a0444ac
md"""
*where $e$ is a column vector containing the grand average and the original effects before they are divided by $2$. Multiplying this vector on the left by the inverse of $A$, we get back our original observations, that is, the $y$ vector $A^{−1}e=A^{−1}Ay=I_4y=y$ where $I_4$ is the identity matrix of order 4. Determine $A^{−1}$ (recall that the rows of the matrix of contrast coefficients are orthogonal and use your good sense; the calculation is in fact very simple) and show that the $A^{−1}e$  product is identical to the $Xb$ product of Eq. (3.12). To understand why this is so, compare the $A^{−1}$ and $X$ matrices and the $b$ and $e$ vectors.*
"""

# ╔═╡ 831a91db-447d-4145-b0fe-c2e122bf9f60
begin
	local A = [
		.25 .25 .25 .25;
		-.5 .5 -.5 .5;
		-.5 -.5 .5 .5;
		.5 -.5 -.5 .5
	]
	
	local e = [67.75, 22.5, -13.5, -8.5]
	
	A⁻¹ = inv(A)
	
	A⁻¹e = A⁻¹*e
end;

# ╔═╡ 6937f320-4a6b-4cfb-85bb-ffed207a769e
A⁻¹

# ╔═╡ 7d9a75a4-34cb-464c-a779-fa24279a3387
A⁻¹e

# ╔═╡ 3daece08-754d-4e54-b8a0-62f95f8bb170
md"""
!!! note
	X and b?
"""

# ╔═╡ 571e7966-3c7a-443d-be5d-8d3b398c4984
md"""
#### Exercise 3.9

*For each of the two levels of variable 3 there is a complete 22 factorial in variables 1 and 2. Calculate, from the values in Table 3.3, the 12 interaction at both levels of variable 3. Take the difference between these two values, divide by 2, and call the result the interaction of factor 3 with the 12 interaction. Repeat the whole process, starting from the values of the 23 interactions at the two levels of factor 1. You will then have the interaction of factor 1 with the 23 interaction. Compare the results obtained in these two calculations with the value of the 123 interaction given in the text.*
"""

# ╔═╡ 9af51599-56c4-42cb-bd27-d81423b285ab


# ╔═╡ 1862ece6-a162-4dd9-a711-cd0976d956dd
md"""
#### Exercise 3.10

*Use Eq. (2.15) to calculate the variance of the effects of a 23 factorial design without replicates, starting from Eq. (3.2).*
"""

# ╔═╡ 6232ed69-a202-4780-9ddb-2e0697f27295


# ╔═╡ a158541c-4455-4a4b-bc78-45cf28517672
md"""
#### Exercise 3.11

*As an exercise in a chemometrics course, M.R. Vallim and V.F. Juliano analyzed data obtained by a research worker in a series of experiments involving the synthesis of polypyrrole in an EPDM matrix. Three factors were studied: reaction time (t), oxidant concentration (C) and particle size (P). The response observed was the reaction yield. Using the data presented below, calculate the values of the effects and their standard errors. Before doing this, however, carefully examine the set of response values, taking into account the signs of the design matrix. Is it possible to anticipate which variable has the largest influence on the yield?*
"""

# ╔═╡ c03f212f-3f06-4815-8969-d52f1f990a3e


# ╔═╡ cd63ec55-4385-49a5-8593-4ce40683a572
md"""
#### Exercise 3.12

*What conclusions can you draw from Fig. 3.5?*
"""

# ╔═╡ 143da4e1-08cb-44a1-8967-fa3b35a7cb8a


# ╔═╡ 68bb4e2b-e52e-414d-bfd3-d2158a8c0fb6
md"""
#### Exercise 3.13

*What is the geometric interpretation of the 123 interaction in the 2^3 factorial design?*
"""

# ╔═╡ 821d8f0c-a99a-4385-b59c-55ae3d7d6471


# ╔═╡ f759d31a-775e-4b51-bb86-f1b4e2ab88ee
md"""
#### Exercise 3.14

*Our analysis of the results of the 2^3 factorial design indicates that the interactions 13, 23 and 123 can be neglected. Exclude the terms corresponding to these interactions from Eq. (3.15) and then estimate the yields for the eight runs. Calculate the differences between the estimated and observed values, and compare these differences — which are the residuals of the simplified model — with the observed average values.*
"""

# ╔═╡ 2fcf0c1e-b6e8-42bc-950c-87c488f660c1


# ╔═╡ c2104f2c-daa7-4c7a-9cfb-e9cbe316cc17
md"""
#### Exercise 3.15

*Write the full equation of the statistical model corresponding to the 2^4 factorial design.*
"""

# ╔═╡ 30bc3a77-0876-46ea-a884-0aa90f088a43


# ╔═╡ 41417e32-16f0-437e-b004-29c8267a6f25
md"""
#### Exercise 3.16

*Interpret the values in Table 3.8, in the light of the error estimates we have just made.*
"""

# ╔═╡ 284df92b-5419-48c6-bf3b-1cdccff61352


# ╔═╡ 64a303a9-a7b2-4ebe-b7d0-fd9bf87497a0
md"""
#### Exercise 3.17

*Suppose that x is a normalized standard variable. What are the cumulative probabilities corresponding to:*
"""

# ╔═╡ e0e4ab49-92ab-466b-94e0-fc7325c6ca08
md"""
*(a) $x_1 = 0$*
"""

# ╔═╡ 671543fd-e413-4ed7-b486-a34b7b063f94
0.5 # value is the mean

# ╔═╡ f05bda77-c563-45bf-b5e6-fb3b268e34c0
md"""
*(b) $x_1 = 1$*
"""

# ╔═╡ efedf029-8791-4f50-85a4-ad6098bb41a0
0.68 + (1 - 0.68)/2

# ╔═╡ 73b283ea-5c6f-47ab-a18d-bcc55ac39c32
md"""
*(c) $x_1 = 1.96$*
"""

# ╔═╡ ff876fc5-97b5-45d8-9a30-2a916b65837f


# ╔═╡ 1f2619fe-108b-45ca-9590-0fb4d6e4d841
md"""
#### Exercise 3.18

*Use the values of all the effects that fall on the line in Fig. 3.10 to calculate an estimate of the variance of an effect with 11 degrees of freedom. Use an F test to show that this estimate and the estimate obtained from the ternary and quaternary effects (with 5 degrees of freedom) can be considered as belonging to the same population.*
"""

# ╔═╡ 5567831d-1afe-4fb8-b984-1b2e7eb063e1


# ╔═╡ d2520730-6ebb-47c0-9a94-707614756d3b
md"""
#### Exercise 3.19

*Suppose that the 123 interaction effect does not really exist for the experiment we are discussing, even though its numerical value is found to be relatively high. How can we interpret this value?*
"""

# ╔═╡ c38ec110-760e-4a3d-8ffa-18810f022cd1


# ╔═╡ e3c67134-a4fb-4b70-9232-e363d1320a88
md"""
#### Exercise 3.20

*A 2^3 factorial was performed in two blocks. The runs of the second block were executed one month after those of the first one, and contain a contribution, h, caused by systematic errors that were absent from the response values of the first block. Show that the presence of this systematic difference in the second block does not affect the value calculated for the 23 interaction effect.*
"""

# ╔═╡ 3ecc0c3a-27d3-4786-bb57-ab37181841f9


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
DataFrames = "~1.2.2"
PlutoUI = "~0.7.16"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "31d0151f5716b655421d9d75b7fa74cc4e744df2"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.39.0"

[[Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "d785f42445b63fc86caa08bb9a9351008be9b765"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.2.2"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
git-tree-sha1 = "f6532909bf3d40b308a0f360b6a0e626c0e263a8"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.1"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "a8709b968a1ea6abc2dc1967cb1db6ac9a00dfb6"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.5"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlutoUI]]
deps = ["Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "4c8a7d080daca18545c56f1cac28710c362478f3"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.16"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a193d6ad9c45ada72c14b731a318bedd3c2f00cf"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.3.0"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "69fd065725ee69950f3f58eceb6d144ce32d627d"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.2.2"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "fed34d0e71b91734bf0a7e10eb1bb05296ddbcd0"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.6.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─cf652126-2b97-11ec-2841-37a3a45b0cc1
# ╠═437c0f11-0653-4357-bde5-afb078ad7153
# ╟─905d3d96-f8af-4239-a48a-ca62d775a7a9
# ╟─85aa526d-2cfb-45ea-95dd-eeef52465dda
# ╠═a859b470-16cd-4e4f-a982-477000ecb33a
# ╟─b4e1384f-d57a-49ba-bb52-e2880d1c62f2
# ╠═e3f7ac7b-afdc-488b-b818-420a15aacd19
# ╟─5cfc7d0f-fe05-40ac-9354-bce90594ffb0
# ╠═be01664b-b1a6-43c7-b27f-cf9de91f480d
# ╟─dda25c43-701d-4dfd-8f74-339d9144a463
# ╠═93fdd16a-dae3-48a4-a34e-fe247d750472
# ╟─c7e03a1c-896c-4db4-8e76-3c299c05b14c
# ╠═ef0dee97-07d2-4cf8-91c0-c41af2d3c434
# ╟─9c619ca0-8d2c-4c07-acc1-156792ea86cf
# ╟─6e8fe1d7-b24a-4f15-95da-29754be3b076
# ╟─3d9f6a75-f2b4-445d-a0bc-56358e8688f9
# ╠═fe8a0eee-c7c6-42cc-8bfc-66966d792f6b
# ╟─dd411de7-0b7a-4267-bcec-df024a92bc9f
# ╠═d824f3e4-972c-4dcc-935c-56204e20a3ba
# ╟─8e437aec-1383-4e61-bf61-dbf2af843ec9
# ╠═bfcbe20f-7100-4dc7-b44c-999573b506cf
# ╟─96041c6f-2777-4d07-a93e-ce9fa6e788c5
# ╠═19671a0f-158e-4da5-8ab6-04092fc670fe
# ╟─f8a25f7f-c40c-43d0-86e2-6ade66754b80
# ╠═d8509256-352d-4484-8053-eefa2a6f5f26
# ╟─daf716cf-a6fe-4887-bb75-f40d0ecebe5e
# ╟─5363e1c6-69d5-4cbb-a224-df02a1cba6c4
# ╟─09db9d48-f471-4b4b-9e95-11ac0a0444ac
# ╠═831a91db-447d-4145-b0fe-c2e122bf9f60
# ╠═6937f320-4a6b-4cfb-85bb-ffed207a769e
# ╠═7d9a75a4-34cb-464c-a779-fa24279a3387
# ╠═3daece08-754d-4e54-b8a0-62f95f8bb170
# ╟─571e7966-3c7a-443d-be5d-8d3b398c4984
# ╠═9af51599-56c4-42cb-bd27-d81423b285ab
# ╟─1862ece6-a162-4dd9-a711-cd0976d956dd
# ╠═6232ed69-a202-4780-9ddb-2e0697f27295
# ╟─a158541c-4455-4a4b-bc78-45cf28517672
# ╠═c03f212f-3f06-4815-8969-d52f1f990a3e
# ╟─cd63ec55-4385-49a5-8593-4ce40683a572
# ╠═143da4e1-08cb-44a1-8967-fa3b35a7cb8a
# ╟─68bb4e2b-e52e-414d-bfd3-d2158a8c0fb6
# ╠═821d8f0c-a99a-4385-b59c-55ae3d7d6471
# ╟─f759d31a-775e-4b51-bb86-f1b4e2ab88ee
# ╠═2fcf0c1e-b6e8-42bc-950c-87c488f660c1
# ╟─c2104f2c-daa7-4c7a-9cfb-e9cbe316cc17
# ╠═30bc3a77-0876-46ea-a884-0aa90f088a43
# ╟─41417e32-16f0-437e-b004-29c8267a6f25
# ╠═284df92b-5419-48c6-bf3b-1cdccff61352
# ╟─64a303a9-a7b2-4ebe-b7d0-fd9bf87497a0
# ╟─e0e4ab49-92ab-466b-94e0-fc7325c6ca08
# ╠═671543fd-e413-4ed7-b486-a34b7b063f94
# ╟─f05bda77-c563-45bf-b5e6-fb3b268e34c0
# ╠═efedf029-8791-4f50-85a4-ad6098bb41a0
# ╟─73b283ea-5c6f-47ab-a18d-bcc55ac39c32
# ╠═ff876fc5-97b5-45d8-9a30-2a916b65837f
# ╟─1f2619fe-108b-45ca-9590-0fb4d6e4d841
# ╠═5567831d-1afe-4fb8-b984-1b2e7eb063e1
# ╟─d2520730-6ebb-47c0-9a94-707614756d3b
# ╠═c38ec110-760e-4a3d-8ffa-18810f022cd1
# ╟─e3c67134-a4fb-4b70-9232-e363d1320a88
# ╠═3ecc0c3a-27d3-4786-bb57-ab37181841f9
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

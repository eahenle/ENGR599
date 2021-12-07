### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ ead69dcb-4ed2-49ea-a1f5-a85efba77c2c
using DataFrames, PlutoUI

# ╔═╡ 18d2cfd4-4132-11ec-1ce1-b5220be5b00f
md"""
# ENGR 599 Homework 4
### Adrian Henle
"""

# ╔═╡ eb3633d5-0d06-486a-a98f-ae9c19bd12d4
md"""
### Exercise 5.2
Show that 
$\mathbf{X}^{T}\mathbf{X}=\begin{bmatrix}
n & \sum\mathbf{X}_i \\
\sum\mathbf{X}_i & \sum\mathbf{X}_i^2
\end{bmatrix}$
and
$\mathbf{X}^T\mathbf{y}=\begin{bmatrix}
\sum y_i \\
\sum Xiy_i
\end{bmatrix}$
"""

# ╔═╡ 45d0c7d9-34d1-49f7-8dfa-474313bc7a3b
md"""
The matrix $\mathbf{X}$ is
$\mathbf{X}=\begin{bmatrix}
1 & 1 & ... & 1 \\
X_1 & X_2 & ... & X_n
\end{bmatrix}$

$\mathbf{X}^T\mathbf{X}=
\begin{bmatrix}
1 & 1 & ... & 1 \\
X_1 & X_2 & ... & X_n
\end{bmatrix}
\times
\begin{bmatrix}
1 & X_1 \\
1 & X_2 \\
\vdots & \vdots \\
1 & X_n
\end{bmatrix}$

 $\mathbf{X}^T\mathbf{X}_{1,1}$ is the sum of the element-wise product of two $n$-dimensional unit vectors, so it equals $n$.

The off-diagonal elements are the sum of the element-wise product of an $n$-dimensional unit vector and the vector of values $X$, which is $X$ itself.

 $\mathbf{X}^T\mathbf{X}_{2,2}$ is the element-wise product of the vector of values $X$ with itself.

$\mathbf{X}^T\mathbf{y}=\begin{bmatrix}
1 & 1 & ... & 1 \\
X_1 & X_2 & ... & X_n
\end{bmatrix}
\times
\begin{bmatrix}
y_1 \\ y_2 \\ \vdots \\ y_n
\end{bmatrix}$

The first term of $\mathbf{X}^T\mathbf{y}$ is the sum of $\mathbf{y}$, and the second term is the sum of the element-wise product of $\mathbf{X}$ and $\mathbf{y}$.
"""

# ╔═╡ b84839a5-cce1-43b3-a4ff-5345ae4afe01
md"""
### Exercise 5.4
Distinguish the models that are linear from those that are not.
"""

# ╔═╡ 8fa90662-08ab-4c0c-8bef-e25c043ce7a4
md"""
*(a)* $y=b_o\sin X+b_1\cos(b_2X)$

nonlinear

*(b)* $pV=constant$

linear

*(c)* $\frac{\bar{V}}{RT}=1+B^\prime P+C^\prime P^2+D^\prime P^3 + ...$

linear

*(d)* $2^k$ factorial design model

linear

*(e)* $[A]=[A]_0 e^{-kt}$

nonlinear
"""

# ╔═╡ dfc9ffdb-bef8-461a-9d54-23b053b2e380
md"""
### Exercise 5.6
The fit of a statistical model to the results of a factorial design can also be done by the least-squares method, solving $\mathbf{b}=(\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{y}$.

With $y=\begin{bmatrix}
59 \\ 90 \\ 54 \\ 68
\end{bmatrix}$ and $\mathbf{X}=\begin{bmatrix}
1 & -1 & -1 & 1 \\
1 & 1 & -1 & -1 \\
1 & -1 & 1 & -1 \\
1 & 1 & 1 & 1
\end{bmatrix}$, we can solve for $\mathbf{b}$:
"""

# ╔═╡ c0edf073-bb88-4e86-ba4e-6a549c0ab82e
begin
	y = [59; 90; 54; 68]
	X = [1 -1 -1 1; 1 1 -1 -1; 1 -1 1 -1; 1 1 1 1]
	b = inv(X' * X) * X' * y
end

# ╔═╡ 815f4123-38cc-4aaf-b662-6597f66c8626
md"""
### Exercise 5.8
Start from **Eq. 5.9** and show that $b_1=\frac{\sum(X_i-\bar{X})y_i}{S_{xx}}$
"""

# ╔═╡ b75c0262-1dfa-45cb-9d65-7c1ca66c8614
md"""
**Eq. 5.9**:

$b_1=\frac{\sum(X_i-\bar{X})(y_i-\bar{y})}{\sum(X_i-\bar{X})^2}$

$= \frac{\sum(X_i-\bar X)y_i-\bar y\sum(X_i-\bar X)}{\sum(X_i-\bar X)^2} = \frac{\sum(X_i-\bar X)y_i}{\sum(X_i-\bar X)^2}$

$S_{xx} = \sum(X_i-\bar X)^2$

$b_1=\frac{\sum(X_i-\bar{X})y_i}{S_{xx}}\therefore$
"""

# ╔═╡ c869d304-cbb0-4de7-ac57-e008ac9685ed
md"""
### Exercise 5.10
Complete this table and verify if the linear model is satisfactory:
"""

# ╔═╡ 938dee5b-4aa5-4250-9c52-cd0d6bcbbd3e
LocalResource("e5_10.png")

# ╔═╡ 5d079e8b-81a8-4bbb-9534-d4a7237e020b
DataFrame(
	"Source of variation" => ["Regression", "Residual", "Lack of fit", "Pure error"],
	"Sum of squares" => [0.295145, 2.79e-4, 1.7e-4, 1.09355e-4],
	"Degree of freedom" => [1, 10, 4, 6],
	"Mean square" => [0.295146, 2.8e-5, 4.3e-5, 1.8e-5]
)

# ╔═╡ 1555b3f1-ef6c-4dae-9611-d7f342069ab1
explained_variation = 99.906

# ╔═╡ 4cf4f2b0-0d82-4de3-b614-4a3179934fa6
max_explainable_variance = 99.963

# ╔═╡ 64a62b4d-87db-4fa4-b766-de59f04198ca
md"There is no lack of fit. It is a good model."

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
DataFrames = "~1.3.0"
PlutoUI = "~0.7.21"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "abb72771fd8895a7ebd83d5632dc4b989b022b5b"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.2"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "dce3e3fea680869eaa0b774b2e8343e9ff442313"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.40.0"

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
git-tree-sha1 = "2e993336a3f68216be91eb8ee4625ebbaba19147"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.0"

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
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

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
git-tree-sha1 = "ae4bbcadb2906ccc085cf52ac286dc1377dceccc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.2"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "b68904528fd538f1cb6a3fbc44d2abdc498f9e8e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.21"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "db3a23166af8aebf4db5ef87ac5b00d36eb771e2"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.0"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "d940010be611ee9d67064fe559edbb305f8cc0eb"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.2.3"

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
# ╟─18d2cfd4-4132-11ec-1ce1-b5220be5b00f
# ╠═ead69dcb-4ed2-49ea-a1f5-a85efba77c2c
# ╟─eb3633d5-0d06-486a-a98f-ae9c19bd12d4
# ╟─45d0c7d9-34d1-49f7-8dfa-474313bc7a3b
# ╟─b84839a5-cce1-43b3-a4ff-5345ae4afe01
# ╟─8fa90662-08ab-4c0c-8bef-e25c043ce7a4
# ╟─dfc9ffdb-bef8-461a-9d54-23b053b2e380
# ╠═c0edf073-bb88-4e86-ba4e-6a549c0ab82e
# ╟─815f4123-38cc-4aaf-b662-6597f66c8626
# ╟─b75c0262-1dfa-45cb-9d65-7c1ca66c8614
# ╟─c869d304-cbb0-4de7-ac57-e008ac9685ed
# ╟─938dee5b-4aa5-4250-9c52-cd0d6bcbbd3e
# ╠═5d079e8b-81a8-4bbb-9534-d4a7237e020b
# ╠═1555b3f1-ef6c-4dae-9611-d7f342069ab1
# ╠═4cf4f2b0-0d82-4de3-b614-4a3179934fa6
# ╟─64a62b4d-87db-4fa4-b766-de59f04198ca
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

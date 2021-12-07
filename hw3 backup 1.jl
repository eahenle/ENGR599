### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 40ff2323-3fa1-40fe-9dac-8a892597438c
using PlutoUI

# ╔═╡ 14f86e56-3120-11ec-22e9-35bcbd81563e
md"""
# ENGR 599 Homework 3
### Adrian Henle
"""

# ╔═╡ d3354963-13ce-484a-b43a-35d2038ff47a
md"""
### Exercise 4.1. 
Use the data in **Table 4.2** to confirm that the significant effect values in this design are really the same as those appearing in **Table 4.3**.
"""

# ╔═╡ 344eb54b-3de7-4d8d-9eb1-87887f3d30ec
LocalResource("e4-1.png")

# ╔═╡ 13b254b0-ebb7-43b6-b4a7-479772a7f8a6
begin
	levels = zeros(16, 4)
	for i ∈ 1:4
		levels[:, i] = 
		repeat([repeat([-1], 2^(i-1))..., repeat([1], 2^(i-1))...], Int(8/(2^(i-1))))
	end
	levels
end

# ╔═╡ 77755d3c-0783-41ec-8d11-0e4410a085a6
responses = vec([52 61 124 113 85 66 185 192 98 86 201 194 122 139 289 286])

# ╔═╡ e709c7b8-0504-4ef6-8025-2fef87490c86
LocalResource("e4-1-1.png")

# ╔═╡ c14f59ec-b33b-454e-a2d4-0b8ffe696896
factors_table4_3 = [-2.38, 109.38, 54.38, 67.13]

# ╔═╡ bc50a608-8c1a-46aa-8b25-39590d146539
factors_calc = [2 * sum(levels[:, i] .* responses) / length(responses) for i in 1:4]

# ╔═╡ 284f201b-a6f7-4c60-b74d-386dffb52c53
all(isapprox.(factors_table4_3, factors_calc, rtol=0.0025))

# ╔═╡ 56be45ae-c43a-4827-8940-99aad4086e62
md"
The factors $\mathbf{1}$, $\mathbf{2}$, $\mathbf{3}$, and $\mathbf{4}$ in **Table 4.3** are identical to those calculated from **Table 4.2** to within $0.25\%$
"

# ╔═╡ cb2a11c8-922f-44fa-b69b-9be657cea228
md"""
### Exercise 4.3. 
How many experimental runs are there in a 2^(8–4) fractional factorial?
"""

# ╔═╡ 5de35dfc-6a02-4055-b4ae-00b169a19e33
md"""
$$2^{8-4}=16$$
"""

# ╔═╡ ee642f72-4afa-4c21-a632-b0a248ea9be7
md"""
### Exercise 4.5.
All contrasts in **Table 4.5** represent the sum of two effects except $\mathbf{l_I}$, which estimates the overall average plus half of the $\mathbf{1234}$ interaction. Why half?
"""

# ╔═╡ 5783a64b-c6ad-4f61-9a70-1c00abdc898d
LocalResource("e4-5.png")

# ╔═╡ 5427266b-864d-4109-82b6-65723161b708
md"""
The values are contrasts between two halves of the set of $16$ responses, except for $\mathbf{M}$, which is calculated on all $16$; so, $\mathbf{1234}$ must be scaled.
"""

# ╔═╡ 8b3fb77d-ea00-45e6-a80f-01a8de3e8f0e
md"""
### Exercise 4.7.
How would you combine the values of the contrasts to obtain the $\mathbf{1234}$ interaction effect? Do the corresponding calculations and compare the result with the value given in **Table 4.3**.
"""

# ╔═╡ 6f649e28-ff2f-4b0f-ac91-4a70dd89f47c
md"""
$$\mathbf{1234}=l_{1234}-l_{1234}^*$$

$$l_{1234}=\mathbf{M}+\frac{1}{2}\mathbf{1234}$$

$$l_{1234}^*=\mathbf{M}-\frac{1}{2}\mathbf{1234}$$
"""

# ╔═╡ 98d2333f-aca4-409a-8abb-b521e799344e
md"""
### Exercise 4.9.
In a half-fractional factorial design of resolution VI, the main effects are confounded with what other effects? And the two-factor interactions?
"""

# ╔═╡ f44e84a7-d85c-42a4-9c2e-897d7c487f18
md"""
### Exercise 4.11.
Construct a 2^(5–1) fractional design using 5 = 124. Determine, for this fraction, the relations between the contrasts involving one or two factors and the effects calculated from a complete factorial. Can you imagine a situation in which this design would be preferable, instead of a fraction of maximum resolution?
"""

# ╔═╡ 9f43d5c9-3184-485a-9e3a-d125b8c9e5d8
md"""
### Exercise 4.13.
Use the data of Table 4.10 to calculate the value of the contrast corresponding to the main effect of the side of the tennis court.
"""

# ╔═╡ ecc474c0-25e9-4207-8845-e7c0f9844f39
md"""
### Exercise 4.15.
Each run in Tables 4.10 and 4.12 correspond to performing serves under the experimental conditions specified by the signs of the respective design matrices. Describe the experiment represented by run 4 in Table 4.10. In practice, what is the difference between this run and run 4 in Table 4.12?
"""

# ╔═╡ 92a87a40-95b4-4ed6-a70d-648b6945e0d1
md"""
### Exercise 4.17.
Use the generating relations given in Table 4.15 and find the three-factor interactions confounded with factor 1.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.18"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "0ec322186e078db08ea3e7da5b8b2885c099b393"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.0"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

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

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

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
git-tree-sha1 = "57312c7ecad39566319ccf5aa717a20788eb8c1f"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.18"

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

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

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
# ╟─14f86e56-3120-11ec-22e9-35bcbd81563e
# ╟─40ff2323-3fa1-40fe-9dac-8a892597438c
# ╟─d3354963-13ce-484a-b43a-35d2038ff47a
# ╟─344eb54b-3de7-4d8d-9eb1-87887f3d30ec
# ╠═13b254b0-ebb7-43b6-b4a7-479772a7f8a6
# ╠═77755d3c-0783-41ec-8d11-0e4410a085a6
# ╟─e709c7b8-0504-4ef6-8025-2fef87490c86
# ╠═c14f59ec-b33b-454e-a2d4-0b8ffe696896
# ╠═bc50a608-8c1a-46aa-8b25-39590d146539
# ╠═284f201b-a6f7-4c60-b74d-386dffb52c53
# ╟─56be45ae-c43a-4827-8940-99aad4086e62
# ╟─cb2a11c8-922f-44fa-b69b-9be657cea228
# ╟─5de35dfc-6a02-4055-b4ae-00b169a19e33
# ╟─ee642f72-4afa-4c21-a632-b0a248ea9be7
# ╟─5783a64b-c6ad-4f61-9a70-1c00abdc898d
# ╟─5427266b-864d-4109-82b6-65723161b708
# ╟─8b3fb77d-ea00-45e6-a80f-01a8de3e8f0e
# ╠═6f649e28-ff2f-4b0f-ac91-4a70dd89f47c
# ╠═98d2333f-aca4-409a-8abb-b521e799344e
# ╠═f44e84a7-d85c-42a4-9c2e-897d7c487f18
# ╠═9f43d5c9-3184-485a-9e3a-d125b8c9e5d8
# ╠═ecc474c0-25e9-4207-8845-e7c0f9844f39
# ╠═92a87a40-95b4-4ed6-a70d-648b6945e0d1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

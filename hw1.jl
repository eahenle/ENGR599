### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ 8fc4acdb-7091-4aaf-b65f-9172f7951cec
using DataFrames, PyPlot, QuadGK, Statistics, StatsBase

# ╔═╡ 1836732b-96a3-4f45-84ba-21dad63c73dc
md"""
# CHE 599 Homework #1

### Adrian Henle
"""

# ╔═╡ 2dc418ba-2094-4918-96e2-cf65aaab23b6
md"""

## Setup and Import Data Tables

#### Load Libraries
"""

# ╔═╡ 585504d5-7e58-45fa-92f6-fbc68972a85b
md"""
#### Table 2.1
"""

# ╔═╡ d8e8cad0-6176-4e0d-893f-fa1f92e534ff
begin
	# copy/pasted data from Table 2.1
	table2_1_raw = """1
2
3
4
5
6
7
8
9
10 3.91
4.01
3.61
3.83
3.75
3.91
3.82
3.70
3.50
3.77 11
12
13
14
15
16
17
18
19
20 3.96
3.85
3.67
3.83
3.77
3.51
3.85
4.04
3.74
3.97"""
	
	# parse entries
	table2_1 = [parse(Float64, x) for x in split(table2_1_raw)]
	
	# drop the "titration no." values
	table2_1 = table2_1[[11:20..., 31:40...]]
end

# ╔═╡ 70085383-f942-4af9-812e-13e51f639154
md"""
#### Table 2.2
"""

# ╔═╡ cbab2cf6-6ec2-4556-b652-e81eb57aee8a
begin
	# copy/pasted data from Table 2.2
	local table2_2_data_raw = """0.1188 0.2673 0.1795 0.2369 0.1826 0.1860 0.2045
0.1795 0.1910 0.1409 0.1733 0.2146 0.1965 0.2326
0.2382 0.2091 0.2660 0.2126 0.2048 0.2058 0.1666
0.2505 0.1823 0.1590 0.1722 0.1462 0.1985 0.1769
0.1810 0.2126 0.1596 0.2504 0.2285 0.3043 0.1683
0.2833 0.2380 0.1930 0.1980 0.1402 0.2060 0.2097
0.2309 0.2458 0.1496 0.1865 0.2087 0.2335 0.2173
0.1746 0.1677 0.2456 0.1828 0.1663 0.1971 0.2341
0.2327 0.2137 0.1793 0.2423 0.2012 0.1968 0.2433
0.2311 0.1902 0.1970 0.1644 0.1935 0.1421 0.1202
0.2459 0.2098 0.1817 0.1736 0.2296 0.2200 0.2025
0.1996 0.1995 0.1732 0.1987 0.2482 0.1708 0.2465
0.2096 0.2054 0.1561 0.1766 0.2620 0.1642 0.2507
0.1814 0.1340 0.2051 0.2455 0.2008 0.1740 0.2089
0.2595 0.1470 0.2674 0.1701 0.2055 0.2215 0.2080
0.1848 0.2184 0.2254 0.1573 0.1696 0.2262 0.1950
0.1965 0.1773 0.1340 0.2237 0.1996 0.1463 0.1917
0.2593 0.1799 0.2585 0.2153 0.2365 0.1629 0.1875
0.2657 0.2666 0.2535 0.1874 0.1869 0.2266 0.2143
0.1399 0.2790 0.1988 0.1904 0.1911 0.2186 0.1606"""
	
	# convert to vector of numbers
	table2_2 = [parse(Float64, datum) for datum in split(table2_2_data_raw)]
end

# ╔═╡ 8520f9b1-2e9d-4068-958c-03c71bbf80d5
md"""
#### Table 2.3
"""

# ╔═╡ 3d6c1725-e670-467f-87a7-3bc019ef06bc
begin
	# copy/pasted data from Table 2.3
	local table2_3_data_raw = """0.10–0.12 1 0.007
0.12–0.14 4 0.029
0.14–0.16 11 0.079
0.16–0.18 24 0.171
0.18–0.20 32 0.229
0.20–0.22 27 0.193
0.22–0.24 17 0.121
0.24–0.26 15 0.107
0.26–0.28 7 0.050
0.28–0.30 1 0.007
0.30–0.32 1 0.007"""
	
	# split into vector of vectors
	local table2_3_data = [split(row) for row in split(table2_3_data_raw, "\n")]
	
	# split the interval strings into two vectors (hi/lo ends)
	local intervals = [row[1] for row in table2_3_data]
	local int_lo = [parse(Float64, split(interval, "–")[1]) for interval in intervals]
	local int_hi = [parse(Float64, split(interval, "–")[2]) for interval in intervals]
	
	# format into DF
	table2_3 = DataFrame(
		:interval => intervals,
		:int_lo => int_lo,
		:int_hi => int_hi,
		:number => [parse(Int, row[2]) for row in table2_3_data],
		:frequency => [parse(Float64, row[3]) for row in table2_3_data]
	)
end

# ╔═╡ 8eac2260-c0a0-48f9-a960-8215f75ac157
md"""
## Exercises

#### Exercise 2.1

*Think of a simple experiment and identify some factors that would prevent us from obtaining its final result strictly without error.*

Determine the temperature of an office space over the course of a day.  The measurement devices (thermometers, clocks) and the manner in which they are used will affect the uncertainty of the data.  Placement of the thermometer may also affect the outcome.

#### Exercise 2.2

*Try to guess the number of black beans making up 1 kg. Of course, this is not the recommended way to solve this problem (unless you happen to be a psychic), but your guess can be used later in a statistical test.*

Assuming a mass of roughly 100 mg per bean, there would be approximately 10,000 beans per kg.

#### Exercise 2.3

*In the bean example, the population is finite: the total number of beans can be large but it is limited. The set of all concentrations that in principle can be obtained in the titration of a certain sample constitutes a finite or infinite population? (Note the expression ‘‘in principle’’. Imagine that it is possible to make as many titrations as you wish without running the risk of using up all the stocks of material and reagents.)*

In principle, concentration is a continuous variable, and so the number of unique results obtainable is infinite.  Placing a limit either on the number of titrations to perform or the number of digits to record in the result, however, would make the possible results a finite set.

#### Exercise 2.4

*Use the data in Table 2.3 to confirm that 54.3% of the beans have masses between 0.18 and 0.24 g.*
"""

# ╔═╡ 9794b0ae-d882-463b-beeb-2202f3680af4
begin
	# find bins for given range
	local bins = [row.int_lo ≥ 0.18 && row.int_hi ≤ 0.24 for row in eachrow(table2_3)]
	
	# find percentage of population in those bins
	local x = round(100 * sum(table2_3.number[bins]) / sum(table2_3.number), digits=1)
	
	md"""
	x = $x %
	"""
end

# ╔═╡ a41e5dd4-3e11-46a6-a258-7bc88ee59de7
md"""
#### Exercise 2.5

*Draw a histogram of the data in Table 2.1. The literature recommends that the number of rectangles be approximately equal to the square root of the total number of observations. Since the table has 20 values, your histogram should have 4 or 5 rectangles. Five is preferable because using an odd number of rectangles allows easier visualization of possible symmetries.*
"""

# ╔═╡ f7b2d68a-4e09-42c2-8232-0bba44d731b5
begin
	# plot the histogram
	figure()
	hist(table2_1, bins=5)
	title("Histogram of Titrations")
	xlabel("Concentration (%)")
	ylabel("Count")
	gcf()
end

# ╔═╡ 98e92069-6825-4be2-a4f7-4b616377ff42
md"""
#### Exercise 2.6

*Calculate the average and standard deviation of the first 10 values in Table 2.2 (from 0.1188 to 0.1409 g).*
"""

# ╔═╡ 7306ac4f-baf5-4232-8511-4efa910ed26d
begin
	local slice = table2_2[1:10]
	local μ = mean(slice)
	local σ = round(std(slice), digits=6)
	
	md"""
	Mean : $(μ)

	Standard Deviation: $(σ)
	"""
end

# ╔═╡ 9d75d5f4-0b6c-41eb-95a9-97525c08424d
md"""
#### Exercise 2.7

*The 20 titration results in Table 2.1 have an average and standard deviation of 3.80 and 0.1509, respectively. Use these values to standardize (in the statistical sense we have just seen) the result of a titration. What concentration would be obtained in a titration whose result was 2.5 standard deviations above the average?*
"""

# ╔═╡ 2aa49f10-4460-45a4-acce-8408f77006f8
begin
	local μ = 3.80
	local σ =0.1509
	
	local x = μ + 2.5σ
	
	md"""
	$μ+2.5σ=x$
	x = $(round(x, digits=2)) %
	"""
end

# ╔═╡ 99c25532-0270-4210-b546-b4da6344daa9
md"""
#### Exercise 2.8

**(a)** *What is the probability that a bean will weigh more than 0.18 g?* 
"""

# ╔═╡ 55fdeab0-f443-4c31-b28d-05cbf7b5674b
begin
	# assuming a normal distribution, the probability density function is:
	pdf(x) = exp(-x^2 / 2) / √(2π)
	
	# get z-score for 0.18
	local z = zscore([0.18], mean(table2_2), std(table2_2))[1] # = (x-μ)/σ
	
	# integrate over (z, Inf)
	local integral, err = quadgk(pdf, z, Inf)
	
	md"""
	x = $(round(integral, digits=2))
	"""
end

# ╔═╡ 465a8f29-a2e1-4528-8ff2-5c425ac42a16
md"""
**(b)** *Define the limiting masses for an interval containing 95% of the beans.* 
"""

# ╔═╡ 0edeaf3a-f271-475f-84b4-60b3ff71f2b1
begin
	# take mean and st.dev
	local μ = mean(table2_2)
	local σ = std(table2_2)
	
	# take lower bound of interval as 2 st.dev's below mean
	local int_lo = round(μ - 2σ, digits=4)
	
	# upper bound 2 st.dev's above
	local int_hi = round(μ + 2σ, digits=4)
	
	md"""
	Interval: ($int_lo, $int_hi)
	"""
end

# ╔═╡ 0fc32d6d-3ee7-45bd-b6d8-328609d53d91
md"""
**(c)** *Your answer to Exercise 2.2 can be transformed into an estimate for the average mass of a bean. Based on what we have seen so far, what are the chances of encountering a bean with a mass larger than or equal to this one?*
"""

# ╔═╡ ff0312ca-e463-42c7-a292-653a0a22d10c
begin
	# z-score for my estimate (100 mg)
	local z = zscore([0.1], mean(table2_2), std(table2_2))[1]
	
	# integrate over (z, Inf)
	local integral, err = quadgk(pdf, z, Inf)
	
	md"""
	Odds are $(100*round(integral, digits=3)) % (my estimate was pretty low!)
	"""
end

# ╔═╡ 9e01483a-86c5-4299-acbb-a73e76daabc3
md"""
#### Exercise 2.9

*The area of the tail to the left of a point in a probability density function is called the cumulative probability at that point, and represents the probability that the observed value of the variable will be equal to or less than the value defined by the point. Cumulative probabilities will be used in the next chapter, where we will perform analyses based on normal plots. Use Table A.1 to determine the cumulative probabilities of the following values in a normal population:*

**(a)** $−∞$
"""

# ╔═╡ 172dff63-1519-491f-a87e-f18d97c762ea
0 # no value is infinitely far from the mean

# ╔═╡ 5ffdd98a-15c4-4d21-8611-362cbad76693
md"""
**(b)** $μ$
"""

# ╔═╡ 08c22401-d184-41aa-9832-4a0da5f72cb0
0.5 # z = 0

# ╔═╡ 01a9c62e-91f3-425d-9cec-41ed622b641d
md"""
**(c)** $μ-σ$
"""

# ╔═╡ 28e22c73-f3b3-4732-92eb-e9fed63d1217
0.1587 # z = -1

# ╔═╡ 3ca4ba7c-0860-4134-90b4-47e3ad5889f1
md"""
**(d)** $μ+σ$
"""

# ╔═╡ 7a43bd14-2e67-4c60-8ab0-cdfddd5b2fb1
0.6587 # z = 1

# ╔═╡ e9d5a773-017c-493d-8bd6-1b75e5f59fe4
md"""
**(e)** $+∞$
"""

# ╔═╡ f0e17599-d2bc-4548-87ba-9086ad55623a
1 # no value is infinitely far from the mean

# ╔═╡ 73eca32c-7da0-4611-a88b-ee316f922fe5
md"""
**(f)** *What do you think the cumulative probability curve for a normal distribution would look like?*
"""

# ╔═╡ db48e93b-3830-45ec-b1fe-bce8ab890cef
begin
	# I think it's a sigmoid; let's see!
	figure()
	title("Normal Distribution")
	xlabel("Z-score")
	ylabel("Cumulative Probability")
	local X = -4:0.01:4
	local Y = [quadgk(pdf, -Inf, x)[1] for x in X]
	plot(X, Y)
	gcf()
end

# ╔═╡ c2249b22-74e8-4781-890c-997bc897adac
md"""
#### Exercise 2.10

*Calculate, from the mass of the second bean in Table 2.2, a 95% confidence interval for the total number of beans in 1 kg.*
"""

# ╔═╡ ce3d177f-4f17-4096-b118-9c80ff301a11
begin
	# get the mass of bean number 2
	local m = table2_2[2]
	
	# get population st.dev
	local σ = std(table2_2)
	
	# get interval bounds for average bean mass
	local int_lo = m - 2σ
	local int_hi = m + 2σ
	
	# convert avg bean mass to beans/kg
	local x_hi = Int(floor(1000/int_lo))
	local x_lo = Int(ceil(1000/int_hi))
	
	md"""
	95% Confidence Interval: ($x_lo, $x_hi)
	"""
end

# ╔═╡ b78ab138-242f-45d5-b5d7-a04e2b0fef36
md"""
#### Exercise 2.11

*Let y and x be two variables obeying the equation $y=x^2$ in the $[-a, +a]$ interval.*

**(a)** *What is the value of the correlation coefficient between y and x? (Do not perform any calculations; make a graph of the function and try to use geometric arguments.)* 
"""

# ╔═╡ 9229af97-de81-429a-a092-3020d2b481fa
begin
	local y(x) = x^2
	local X = -2:0.1:2
	
	figure()
	plot(X, y.(X), label=L"y=x^2")
	title(L"a=2")
	xlabel(L"x")
	ylabel(L"y")
	legend()
	gcf()
end

# ╔═╡ 476ce33a-cba4-4488-8f58-344fdcb1fd56
md"""
$r(x,y)=\frac{1}{n-1}\sum\left(\frac{x_i-\bar x}{s_x}\right)\left(\frac{y_i-\bar y}{s_y}\right)=\frac{1}{n-1}\sum\nu_{i}$

For the summation term $\nu_o$ corresponding to $(x=0, y=0)$, $\nu_o=\frac{-\bar y}{s_y}$.

For all other terms $\nu_j$ corresponding to $(x=h, y=h^2)$ there is a term $\nu_k$ corresponding to $(x=-h, y=(-h)^2)$.  For all such pairs of terms, the only difference in each term's calculation is the sign of $x$; so, $\nu_j+\nu_k=0$.

Therefore, the sum over all terms is simply $\nu_o$, and therefore:

$r(x,y)=\frac{-\bar y}{(n-1)s_y}$

Within the interval $[-a, a]$:

$\bar y=\frac{1}{2a}\int_{-a}^{a}{x^2dx}=\frac{1}{2a}\times\frac{1}{3}x^3|_{x=-a}^{a}$

$\bar y=\frac{1}{3}a^2$

$r(x,y)=\frac{a^2}{3(n-1)s_y}$
"""

# ╔═╡ bab91b9b-4de7-4e62-9258-d1a11dde88e6
md"""
**(b)** *Can you think of other functions that would give the same result?*

The same argument would apply to any function with symmetry about the x-axis, e.g. $y=|x|$ or $y=x^{2n}$ where $n\in\mathbb{Z}$.
"""

# ╔═╡ ca6adfe1-0aec-4c40-b66c-53a1c23f0401
md"""
#### Exercise 2.12

*The values below are volumes, in milliliters, of the beans whose masses appear in the first line of Table 2.2. Calculate the covariance and the correlation coefficient between the masses and volumes of these seven beans. 0.108, 0.214, 0.143, 0.195, 0.148, 0.144, 0.174.*
"""

# ╔═╡ e4c588ca-a9fa-4163-bc07-e56c064a7b8b
begin
	# copy/pasted data
	local volume = [0.108, 0.214, 0.143, 0.195, 0.148, 0.144, 0.174]
	
	# number of samples
	local n = length(volume)
	
	# get the corresponding masses
	local mass = table2_2[1:n]
	
	# calculate the means and st.devs
	local μ_mass = mean(mass)
	local μ_vol = mean(volume)
	local σ_mass = std(mass)
	local σ_vol = std(volume)
	
	# calculate the covariance
	local covariance = sum(
		[(mass[i] - μ_mass)*(volume[i] - μ_vol) for i in 1:n]) / (n-1)
	
	# calculate the correlation coefficient
	local corr_coeff = sum(
		[(mass[i] - μ_mass)*(volume[i] - μ_vol)/(σ_mass*σ_vol) for i in 1:n]) / (n-1)
	
	md"""
	Covariance: $(round(covariance, digits=4))
	
	Correlation Coefficient: $(round(corr_coeff, digits=3))
	"""
end

# ╔═╡ 7b1294e0-4754-4e4d-a8fb-0cb1129cce61
md"""
#### Exercise 2.13

*What is the variance of the distribution of $x_1-x_2$, where $x_1$ and $x_2$ are two standardized normal variables that are perfectly positively correlated, that is, have unit correlation coefficient?*
"""

# ╔═╡ 83b19541-d397-4b7a-9382-7ab480f80583
md"""
$r(x_1,x_2)=\frac{1}{n-1}\sum\left(\frac{x_{1i}-\bar x_1}{s_{x_1}}\right)\left(\frac{x_{2i}-\bar x_2}{s_{x_2}}\right)=1$

$\sum\left(\frac{x_{1i}-\bar x_1}{s_{x_1}}\right)\left(\frac{x_{2i}-\bar x_2}{s_{x_2}}\right)=n-1$

$V=\frac{1}{n-1}\sum(x_{1i}-x_{2i}-\hat\mu)^2$

Where $\hat\mu$ is the average value of $x_1-x_2$.  The average of the difference is equal to the difference of the averages, so:

$V=\frac{1}{n-1}\sum(x_{1i}-x_{2i}-\bar x_1+\bar x_2)^2$

$n-1=\frac{1}{V}\sum(x_{1i}-x_{2i}-\bar x_1+\bar x_2)^2$

$\sum\left(\frac{x_{1i}-\bar x_1}{s_{x_1}}\right)\left(\frac{x_{2i}-\bar x_2}{s_{x_2}}\right)=\frac{1}{V}\sum(x_{1i}-x_{2i}-\bar x_1+\bar x_2)^2$

$V=s_{x_1}s_{x_2}\sum\frac{(x_{1i}-x_{2i}-\bar x_1+\bar x_2)^2}{(x_{1i}-\bar x_1)(x_{2i}-\bar x_2)}$
"""

# ╔═╡ 3ff16f77-d5c3-4c1d-8e38-3b7d8d3ef5fc
md"""
*What if the correlation coefficient were zero?*
"""

# ╔═╡ bdfbd3f6-acd4-41f7-bafe-0a1790d6ae8b
md"""
$r(x_1,x_2)=\frac{1}{n-1}\sum\left(\frac{x_{1i}-\bar x_1}{s_{x_1}}\right)\left(\frac{x_{2i}-\bar x_2}{s_{x_2}}\right)=0$

$\sum(x_{1i}-\bar x_1)(x_{2i}-\bar x_2)=0$

$n-1+\sum(x_{1i}-\bar x_1)(x_{2i}-\bar x_2)=n-1$

$n-1=\frac{1}{V}\sum(x_{1i}-x_{2i}-\bar x_1+\bar x_2)^2$

$n-1+\sum(x_{1i}-\bar x_1)(x_{2i}-\bar x_2)=\frac{1}{V}\sum(x_{1i}-x_{2i}-\bar x_1+\bar x_2)^2$

$V=\frac{\sum(x_{1i}-x_{2i}-\bar x_1+\bar x_2)^2}{n-1+\sum(x_{1i}-\bar x_1)(x_{2i}-\bar x_2)}$
"""

# ╔═╡ 215895f0-cf55-41fe-968a-44286191c123
md"""
#### Exercise 2.14

*Consider the 140 values in Table 2.2 as a single random sample from a normal population. Assume that the standard deviation calculated from these values is identical to the population value. Now, how many beans are there in a 1-kg package?*
"""

# ╔═╡ afc55d5f-8160-45db-9628-cb38b29b9ab0
begin
	# sample mean and st.dev
	local μ = mean(table2_2)
	local σ = std(table2_2)
	
	# 95% confidence interval for mass/bean
	local mass_lo = μ - 2σ
	local mass_hi = μ + 2σ
	
	# calculate beans/kg
	local beans_lo, beans_hi = 1000 ./ [mass_hi, mass_lo]
	
	md"""
	The 95% confidence interval for the number of beans per kg is ($(Int(floor(beans_lo))), $(Int(ceil(beans_hi))))
	"""
end

# ╔═╡ 3105bcf3-a23c-4f90-8a4a-c51a27fc6841
md"""
#### Exercise 2.15

*Use the seven values in the last line of Table 2.2 and determine, at the 99% confidence level, the number of beans in a kilogram.*
"""

# ╔═╡ d5b74ba3-09fc-46ca-981c-bd411cc4fc12
begin
	# take data slice
	local n = length(table2_2)
	local slice = table2_2[n-7:n]
	
	# get mean and st.dev
	local μ = mean(slice)
	local σ = std(slice)
	
	# 99% confidence interval for mass/bean
	local mass_lo = μ - 3σ
	local mass_hi = μ + 3σ
	
	# calculate beans/kg
	local beans_lo, beans_hi = 1000 ./ [mass_hi, mass_lo]
	
	md"""
	The 99% confidence interval for the number of beans per kg is ($(Int(floor(beans_lo))), $(Int(ceil(beans_hi))))
	"""
end

# ╔═╡ fcccf32c-f280-470e-b962-3e99a3f16893
md"""
#### Exercise 2.16

*Repeat Exercise 2.14, this time using Student’s distribution. Assume that the number of degrees of freedom is 120 to obtain the t values from Table A.2. Compare your results with those of Exercise 2.14.*
"""

# ╔═╡ 202fb84c-58a6-4650-bde0-7ba92a518d64
begin
	# get sample mean and st.dev
	local μ = mean(table2_2)
	local σ = std(table2_2)
	local n = length(table2_2)
	
	# get t-point
	local t_120 = 1.658 # for 95% confidence level and 120 DoF
	
	# 95% confidence interval for mass/bean
	local mass_lo = μ - t_120 * σ / √n
	local mass_hi = μ + t_120 * σ / √n
	
	# calculate beans/kg
	local beans_lo, beans_hi = 1000 ./ [mass_hi, mass_lo]
	
	md"""
	The 95% confidence interval for the number of beans per kg is ($(Int(floor(beans_lo))), $(Int(ceil(beans_hi)))).  Much narrower than with the normal distribution!
	"""
end

# ╔═╡ 650f64e6-eb0e-4b11-b523-36c468839d94
md"""
#### Exercise 2.17

*How can we relate the numbers in the last line of Table A.2 to the values in Table A.1?*
"""

# ╔═╡ 852aa626-8401-43be-a1e5-6d55cc640cdb
md"""
$z=\frac{x-\mu}{\sigma}$

$t=\frac{\bar x-\mu}{\sigma}\sqrt n$

$\bar z=\frac{\bar x-\mu}{\sigma}$

$t=\bar z\sqrt n$
"""

# ╔═╡ da21b1c6-6d5e-46cd-adec-ce91a5281325
md"""
#### Exercise 2.18

*The two 95% confidence intervals for the mean mass calculated from the masses of single beans have the same width, as shown in Fig. 2.11. On the other hand, the intervals for the number of beans in 1 kg obtained from the same data have very different widths. For the bean weighing 0.1188 g the 95% confidence interval ranges from 5266 to 20,964 beans. For the one weighing 0.2673 g the limits are 2955 and 5098, giving the impression that this determination is more precise than the other. Is this true? Why?*
"""

# ╔═╡ e01871ad-c0ba-4685-bc51-a84dd1d509ea
md"""
No, this is simply a result of using different distributions.  Whichever distribution is more similar to the actual population data will be the more precise model.
"""

# ╔═╡ 0fb54915-53f5-4034-8e5f-02fa791c9b4c
md"""
#### Exercise 2.19

*Calculate, from the seven last values in Table 2.2, a 99% confidence interval for the standard deviation of the mass of one bean.*
"""

# ╔═╡ 62ee5509-f90c-47b8-9c8e-48512bde9da6
begin
	local data = table2_2[length(table2_2)-6:end] # last 7 values of Table 2.2
	local z = 3 # 99 % confidence level
	local σ = std(data) # sample st.dev
	local x̄ = mean(data) # sample mean
	local μ = mean(table2_2) # population mean
	local n = 7 # sample size
	
	# 99 % confidence interval for average mass
	local x̄_lo = x̄ - z*σ
	local x̄_hi = x̄ + z*σ
	
	# 99 % confidence interval for population st.dev
	local σ_lo = round((x̄_lo - μ)*√(n)/z, digits=2)
	local σ_hi = round((x̄_hi - μ)*√(n)/z, digits=2)
	
	md"""
	Calculated interval: ($σ_lo, $σ_hi)
	
	So, the standard deviation is between $0$ and $0.12$ g
	"""
end

# ╔═╡ e17f00ee-d5aa-409a-9dd0-e9671629a51d
md"""
#### Exercise 2.20

*Use the new reference mean for acetic acid, 4.45%, and repeat the test with the three last values of Table 2.1.*
"""

# ╔═╡ c70d5a68-42b8-4f7a-953c-11eda89a2ec6
md"""
!!! question
	I was unsure what this exercise wanted.
"""

# ╔═╡ 6c158952-cdf4-496a-878d-0bcc1a9aaec0
md"""
#### Exercise 2.21

*A chemist is testing a new method for assaying iron. Performing four analyses on a standard whose true concentration is 14.3%, she obtains 13.7, 14.0, 13.9, and 14.1% iron. How would you evaluate the accuracy of the new method, at the 95% confidence level? Do the four determinations come from a distribution with a mean of 14.3%?*
"""

# ╔═╡ e9c33fd1-5d88-4ed2-8be4-4e52d7414c14
begin
	local data = [13.7, 14.0, 13.9, 14.1] # concentration measurements
	
	local μ = mean(data) # mean of samples
	local σ = std(data) # sample st.dev
	
	# 95 % confidence interval
	local conf_int_lo = round(μ - 2σ, digits=2)
	local conf_int_hi = round(μ + 2σ, digits=2)
	
	md"""
	95 % confidence interval: $(conf_int_lo, conf_int_hi)
	
	14.3 % is outside the interval, so these data probably are not from a distribution with mean of 14.3 %.
	"""
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
PyPlot = "d330b81b-6aea-500a-939a-2ce795aea3ee"
QuadGK = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
DataFrames = "~1.2.2"
PyPlot = "~2.10.0"
QuadGK = "~2.4.2"
StatsBase = "~0.33.10"
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

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "31d0151f5716b655421d9d75b7fa74cc4e744df2"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.39.0"

[[Conda]]
deps = ["JSON", "VersionParsing"]
git-tree-sha1 = "299304989a5e6473d985212c28928899c74e9421"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.5.2"

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

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

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

[[LaTeXStrings]]
git-tree-sha1 = "c7f1c695e06c01b95a67f0cd1d34994f3e7db104"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.2.1"

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

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "5a5bc6bf062f0f95e62d0fe0a2d99699fed82dd9"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.8"

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

[[PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "169bb8ea6b1b143c5cf57df6d34d022a7b60c6db"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.92.3"

[[PyPlot]]
deps = ["Colors", "LaTeXStrings", "PyCall", "Sockets", "Test", "VersionParsing"]
git-tree-sha1 = "14c1b795b9d764e1784713941e787e1384268103"
uuid = "d330b81b-6aea-500a-939a-2ce795aea3ee"
version = "2.10.0"

[[QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "78aadffb3efd2155af139781b8a8df1ef279ea39"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.4.2"

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

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8cbbc098554648c84f79a463c9ff0fd277144b6c"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.10"

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

[[VersionParsing]]
git-tree-sha1 = "80229be1f670524750d905f8fc8148e5a8c4537f"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.2.0"

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
# ╟─1836732b-96a3-4f45-84ba-21dad63c73dc
# ╟─2dc418ba-2094-4918-96e2-cf65aaab23b6
# ╠═8fc4acdb-7091-4aaf-b65f-9172f7951cec
# ╟─585504d5-7e58-45fa-92f6-fbc68972a85b
# ╠═d8e8cad0-6176-4e0d-893f-fa1f92e534ff
# ╟─70085383-f942-4af9-812e-13e51f639154
# ╠═cbab2cf6-6ec2-4556-b652-e81eb57aee8a
# ╟─8520f9b1-2e9d-4068-958c-03c71bbf80d5
# ╠═3d6c1725-e670-467f-87a7-3bc019ef06bc
# ╟─8eac2260-c0a0-48f9-a960-8215f75ac157
# ╠═9794b0ae-d882-463b-beeb-2202f3680af4
# ╟─a41e5dd4-3e11-46a6-a258-7bc88ee59de7
# ╠═f7b2d68a-4e09-42c2-8232-0bba44d731b5
# ╟─98e92069-6825-4be2-a4f7-4b616377ff42
# ╠═7306ac4f-baf5-4232-8511-4efa910ed26d
# ╟─9d75d5f4-0b6c-41eb-95a9-97525c08424d
# ╠═2aa49f10-4460-45a4-acce-8408f77006f8
# ╟─99c25532-0270-4210-b546-b4da6344daa9
# ╠═55fdeab0-f443-4c31-b28d-05cbf7b5674b
# ╟─465a8f29-a2e1-4528-8ff2-5c425ac42a16
# ╠═0edeaf3a-f271-475f-84b4-60b3ff71f2b1
# ╟─0fc32d6d-3ee7-45bd-b6d8-328609d53d91
# ╠═ff0312ca-e463-42c7-a292-653a0a22d10c
# ╟─9e01483a-86c5-4299-acbb-a73e76daabc3
# ╠═172dff63-1519-491f-a87e-f18d97c762ea
# ╟─5ffdd98a-15c4-4d21-8611-362cbad76693
# ╠═08c22401-d184-41aa-9832-4a0da5f72cb0
# ╟─01a9c62e-91f3-425d-9cec-41ed622b641d
# ╠═28e22c73-f3b3-4732-92eb-e9fed63d1217
# ╟─3ca4ba7c-0860-4134-90b4-47e3ad5889f1
# ╠═7a43bd14-2e67-4c60-8ab0-cdfddd5b2fb1
# ╟─e9d5a773-017c-493d-8bd6-1b75e5f59fe4
# ╠═f0e17599-d2bc-4548-87ba-9086ad55623a
# ╟─73eca32c-7da0-4611-a88b-ee316f922fe5
# ╠═db48e93b-3830-45ec-b1fe-bce8ab890cef
# ╟─c2249b22-74e8-4781-890c-997bc897adac
# ╠═ce3d177f-4f17-4096-b118-9c80ff301a11
# ╟─b78ab138-242f-45d5-b5d7-a04e2b0fef36
# ╠═9229af97-de81-429a-a092-3020d2b481fa
# ╟─476ce33a-cba4-4488-8f58-344fdcb1fd56
# ╟─bab91b9b-4de7-4e62-9258-d1a11dde88e6
# ╟─ca6adfe1-0aec-4c40-b66c-53a1c23f0401
# ╠═e4c588ca-a9fa-4163-bc07-e56c064a7b8b
# ╟─7b1294e0-4754-4e4d-a8fb-0cb1129cce61
# ╟─83b19541-d397-4b7a-9382-7ab480f80583
# ╟─3ff16f77-d5c3-4c1d-8e38-3b7d8d3ef5fc
# ╟─bdfbd3f6-acd4-41f7-bafe-0a1790d6ae8b
# ╟─215895f0-cf55-41fe-968a-44286191c123
# ╠═afc55d5f-8160-45db-9628-cb38b29b9ab0
# ╟─3105bcf3-a23c-4f90-8a4a-c51a27fc6841
# ╠═d5b74ba3-09fc-46ca-981c-bd411cc4fc12
# ╟─fcccf32c-f280-470e-b962-3e99a3f16893
# ╠═202fb84c-58a6-4650-bde0-7ba92a518d64
# ╟─650f64e6-eb0e-4b11-b523-36c468839d94
# ╟─852aa626-8401-43be-a1e5-6d55cc640cdb
# ╟─da21b1c6-6d5e-46cd-adec-ce91a5281325
# ╟─e01871ad-c0ba-4685-bc51-a84dd1d509ea
# ╟─0fb54915-53f5-4034-8e5f-02fa791c9b4c
# ╠═62ee5509-f90c-47b8-9c8e-48512bde9da6
# ╟─e17f00ee-d5aa-409a-9dd0-e9671629a51d
# ╟─c70d5a68-42b8-4f7a-953c-11eda89a2ec6
# ╟─6c158952-cdf4-496a-878d-0bcc1a9aaec0
# ╠═e9c33fd1-5d88-4ed2-8be4-4e52d7414c14
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

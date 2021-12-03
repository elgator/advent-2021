### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 39040d1e-5426-11ec-3b00-d1dedb8c652f
parse_line(line) = split(line, "") .|> x-> ==(x, "1")

# ╔═╡ 116d7455-af61-4197-a35b-9ecdce8c8c75
report_test = readlines("./data/input3t.txt") .|> 
	parse_line |> 
	x -> foldl(hcat, x) |>
	permutedims

# ╔═╡ 1cabe137-bed9-42f1-a1e3-01d089e832dd
function bitarr_to_int(arr, val = 0)
    v = 2^(length(arr)-1)
    for i in eachindex(arr)
        val += v*arr[i]
        v >>= 1
    end
    return val
end

# ╔═╡ 0753bd5c-220c-4af1-b8d4-0ab2c694b1ef
function γ_ϵ(report)
	one_counts = sum(report, dims=1)
	zero_counts =  size(report)[1] .- one_counts
	most = .~ .~ [o>z for (o,z) in zip(one_counts, zero_counts)]
	least =  .~ .~ [o<z for (o,z) in zip(one_counts, zero_counts)]
	γ = bitarr_to_int(most)
	ϵ =  bitarr_to_int(least)
	return γ, ϵ
end

# ╔═╡ b9c275ce-44a7-4ca5-bbf6-76bcc1a73bd6
let
	γ, ϵ = γ_ϵ(report_test)
	@assert γ * ϵ == 198
end

# ╔═╡ 565baf5b-976a-47c2-945b-941cd8627b99
report = readlines("./data/input3.txt") .|> 
	parse_line |> 
	x -> foldl(hcat, x) |>
	permutedims

# ╔═╡ da6e91a8-c0e1-48b5-a96f-cdb6df599e6f
let
	γ, ϵ = γ_ϵ(report)
	ans1 = γ * ϵ
end

# ╔═╡ 402cec57-0992-4058-84e2-514975b3aa43
function ox_co2(report, mode)
	if !(mode in ["ox", "co2"])
		error("what gas?")
	end
	
	l = size(report)[1]
	rows = [x for x in 1:l]
	for j in 1:size(report)[2]
		one_count = sum(@view report[rows, j])
		zero_count =  length(rows) - one_count
		target = (one_count >= zero_count) * 1 # change here
		if mode == "co2"
			target = 1 - target
		end
		
		new_rows = []
		for r in rows
			if report[r, j] == target
				push!(new_rows, r)
			end
		end
		rows =  new_rows
		if length(rows) == 1 break end
	end
	return bitarr_to_int(report[rows, :])
end

# ╔═╡ 235f1db3-cfc3-425f-a4c1-9310fe0ac1f0
@assert ox_co2(report_test, "ox") * ox_co2(report_test, "co2") == 230

# ╔═╡ 18fd5405-d91f-4115-a8ad-61d7eb4ee4f0
let 
	ox = ox_co2(report, "ox")
	co2 = ox_co2(report, "co2")
	ans2 = ox * co2
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╠═39040d1e-5426-11ec-3b00-d1dedb8c652f
# ╠═116d7455-af61-4197-a35b-9ecdce8c8c75
# ╠═0753bd5c-220c-4af1-b8d4-0ab2c694b1ef
# ╠═1cabe137-bed9-42f1-a1e3-01d089e832dd
# ╠═b9c275ce-44a7-4ca5-bbf6-76bcc1a73bd6
# ╠═565baf5b-976a-47c2-945b-941cd8627b99
# ╠═da6e91a8-c0e1-48b5-a96f-cdb6df599e6f
# ╠═402cec57-0992-4058-84e2-514975b3aa43
# ╠═235f1db3-cfc3-425f-a4c1-9310fe0ac1f0
# ╠═18fd5405-d91f-4115-a8ad-61d7eb4ee4f0
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 8bb8ae60-528f-11ec-0334-4961c38343ae
sweeps_test =  [parse(Int, x) for x in readlines("./data/input1t.txt")]

# ╔═╡ 71f47595-2327-4b05-9ffe-4288cd315831
begin
	function rises(seq)
		pairs=zip(seq[1:end-1], seq[2:end])
		return sum((1 for x in pairs if x[2]-x[1]>0))
	end
	
	function rises3(seq)
		pairs=zip(seq[1:end-3], seq[4:end])
		return sum((1 for x in pairs if x[2]-x[1]>0))
	end
end

# ╔═╡ 0497385a-8487-4a93-80fb-8a59ab404869
@assert rises(sweeps_test)==7

# ╔═╡ 5f680e76-78a6-47a8-80be-a4a7f868fa67
sweeps = [parse(Int, x) for x in readlines("./data/input1.txt")]

# ╔═╡ fa67c27e-106a-421e-8143-b08560dfc570
ans1 = rises(sweeps)

# ╔═╡ e9629dc8-b5e0-469f-aeff-dcd7e6123192
@assert rises3(sweeps_test)==5

# ╔═╡ 4feb59f5-db93-433d-80a4-570bfeaa08c2
ans2 = rises3(sweeps)

# ╔═╡ Cell order:
# ╠═8bb8ae60-528f-11ec-0334-4961c38343ae
# ╠═71f47595-2327-4b05-9ffe-4288cd315831
# ╠═0497385a-8487-4a93-80fb-8a59ab404869
# ╠═5f680e76-78a6-47a8-80be-a4a7f868fa67
# ╠═fa67c27e-106a-421e-8143-b08560dfc570
# ╠═e9629dc8-b5e0-469f-aeff-dcd7e6123192
# ╠═4feb59f5-db93-433d-80a4-570bfeaa08c2

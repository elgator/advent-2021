### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ fa1ab0ea-e3e3-4cc2-9597-4a9924263bd1
begin
	mutable struct Submersible
		position::Int
		depth::Int
		aim::Int
		
		Submersible()=new(0, 0, 0)
	end

end

# ╔═╡ 0b902e8b-28b1-4f87-ae6c-4f5295b9f4d0
begin
	function exec_command!(s::Submersible, command::Tuple)
		comm = command[1]
		args = command[2:end]
		
		if comm == "nop"
			#
		elseif comm == "forward"
			s.position += args[1]
			s.depth += args[1] * s.aim
			if s.depth<0 error("Submarine is flying") end
		elseif comm == "down"
			s.aim += args[1]
		elseif comm == "up"
			s.aim -= args[1]
		else
			error("Unknown VM command")
		end
		
		return s
	end
	
	parse_line(line) = split(line) |> x -> (x[1], parse(Int, x[2]))
end

# ╔═╡ 6db02a52-e6b1-404d-955a-6d2c0bb100c4
prog_test = parse_line.(readlines("./data/input2t.txt"))

# ╔═╡ 0dade2ad-c45a-4fc3-906e-ecf090d3fc01
let s = Submersible()
	for c in prog_test
		exec_command!(s, c)
	end
	@assert s.position * s.depth == 900
end

# ╔═╡ f8266d19-0d27-4285-bc0b-22f00162f16d
prog = parse_line.(readlines("./data/input2.txt"))

# ╔═╡ 3d382e1c-99d9-4d64-9160-8eb5d44aa133
let s = Submersible()
	for c in prog
		exec_command!(s, c)
	end
	ans1 =  s.position * s.depth
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
# ╠═fa1ab0ea-e3e3-4cc2-9597-4a9924263bd1
# ╠═0b902e8b-28b1-4f87-ae6c-4f5295b9f4d0
# ╠═6db02a52-e6b1-404d-955a-6d2c0bb100c4
# ╠═0dade2ad-c45a-4fc3-906e-ecf090d3fc01
# ╠═f8266d19-0d27-4285-bc0b-22f00162f16d
# ╠═3d382e1c-99d9-4d64-9160-8eb5d44aa133
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

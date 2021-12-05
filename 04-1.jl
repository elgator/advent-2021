### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 3de758e0-5527-11ec-256e-d7a1a34d096f
test_bingo = read("./data/input4t.txt", String)

# ╔═╡ a074d217-2cf7-4c7f-8bcb-04ed2ee0e210
chunks_test = split(test_bingo, "\n\n")

# ╔═╡ c64dfcc6-5725-4c65-b951-a639c4439f35
bingo_seq_test =  first(chunks_test) |> x->split(x, ",") .|> x->parse(Int, x)

# ╔═╡ ff9a44a9-82fc-4e47-8587-acce37c69f74
parse_line(line) = split(line, " ", keepempty=false) .|> x->parse(Int, x)

# ╔═╡ bde0fd82-cb81-4276-9643-91447a421cbd
mutable struct Bingo
	addresses
	checked

	Bingo() = new(Dict(), BitArray(undef, 5, 5))
end

# ╔═╡ f27926a8-7029-43d0-89b5-3b311ac813de
function parse_chunk(chunk)
	lines = split(chunk, "\n") .|> parse_line
	b=Bingo()
	for i in 1:5
		line = lines[i]
		for j in 1:5
			b.addresses[line[j]] = (i,j)
		end
	end
	return b
end

# ╔═╡ 57097abd-14ec-4ec5-bb31-c2d57c19cb7d
boards_test = parse_chunk.(chunks_test[2:end])

# ╔═╡ 5901fac2-d48a-4c1f-ba7f-163cad92e2d4
function new_ball!(board::Bingo, ball)
	if !(ball in keys(board.addresses)) return false end
	addrs = board.addresses[ball]
	board.checked[addrs...] = true
	return sum(board.checked[addrs[1], :])==5 || sum(board.checked[:, addrs[2]])==5
end

# ╔═╡ 86eb9e34-7b31-46a9-8216-f3e4ca8b37bf
boards_test

# ╔═╡ 5ed2690c-b257-4a0d-9d29-f5e9d9e47f4e
function sum_of_unmarked(board::Bingo)
	s = 0
	for (k,addr) in board.addresses
		s += k * (1-board.checked[addr...])
	end
	return s
end

# ╔═╡ 1f563b1e-00a7-4ef5-b4c0-80494172de30
function part1(boards, ball_seq)
	wins = false
	winning_board = nothing
	winning_ball = nothing
	for ball in ball_seq
		for (i, board) in enumerate(boards)
			wins = new_ball!(board, ball)
			if wins
				winning_board = i
				winning_ball = ball
				break
			end
		end
		wins && break
	end
	return  sum_of_unmarked(boards[winning_board]) * winning_ball
end

# ╔═╡ 7e18b587-679d-4a79-ace5-90b1182608c7
part1(boards_test, bingo_seq_test)

# ╔═╡ 3d2b9a7b-b2d0-4502-b563-a730908dabb4
bingo = read("./data/input4.txt", String)

# ╔═╡ 7cdf9222-fe61-45b4-a348-08c978bc4a6b
chunks = split(bingo, "\n\n")

# ╔═╡ dd649bc4-4100-4fe1-b012-dcc7be0ce33e
bingo_seq =  first(chunks) |> x->split(x, ",") .|> x->parse(Int, x)

# ╔═╡ 6f86a0cd-65c2-4fb0-9490-f53141ef39d7
boards = parse_chunk.(chunks[2:end])

# ╔═╡ 91456e7b-89e3-4c1e-a2d7-539dea5684dc
ans1 = part1(boards, bingo_seq)

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
# ╠═3de758e0-5527-11ec-256e-d7a1a34d096f
# ╠═a074d217-2cf7-4c7f-8bcb-04ed2ee0e210
# ╠═c64dfcc6-5725-4c65-b951-a639c4439f35
# ╠═ff9a44a9-82fc-4e47-8587-acce37c69f74
# ╠═f27926a8-7029-43d0-89b5-3b311ac813de
# ╠═bde0fd82-cb81-4276-9643-91447a421cbd
# ╠═57097abd-14ec-4ec5-bb31-c2d57c19cb7d
# ╠═5901fac2-d48a-4c1f-ba7f-163cad92e2d4
# ╠═1f563b1e-00a7-4ef5-b4c0-80494172de30
# ╠═7e18b587-679d-4a79-ace5-90b1182608c7
# ╠═86eb9e34-7b31-46a9-8216-f3e4ca8b37bf
# ╠═5ed2690c-b257-4a0d-9d29-f5e9d9e47f4e
# ╠═3d2b9a7b-b2d0-4502-b563-a730908dabb4
# ╠═7cdf9222-fe61-45b4-a348-08c978bc4a6b
# ╠═dd649bc4-4100-4fe1-b012-dcc7be0ce33e
# ╠═6f86a0cd-65c2-4fb0-9490-f53141ef39d7
# ╠═91456e7b-89e3-4c1e-a2d7-539dea5684dc
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

local rec_ls
rec_ls = function()
	return sn(nil, {
		c(1, {
			t({""}),
			sn(nil, {t({"", "\t\\item "}), i(1), d(2, rec_ls, {})}),
		}),
	})
end


local function column_count_from_string(descr)
	return #(descr:gsub("[^clmrp]", ""))
end

local tab = function(args, snip)
	local cols = column_count_from_string(args[1][1])
	if not snip.rows then
		snip.rows = 1
	end
	local nodes = {}
	local ins_indx = 1
	for j = 1, snip.rows do
		table.insert(nodes, r(ins_indx, tostring(j).."x1", i(1)))
		ins_indx = ins_indx+1
		for k = 2, cols do
			table.insert(nodes, t" & ")
			table.insert(nodes, r(ins_indx, tostring(j).."x"..tostring(k), i(1)))
			ins_indx = ins_indx+1
		end
		table.insert(nodes, t{"\\\\", ""})
	end
	-- fix last node.
	nodes[#nodes] = t""
	return sn(nil, nodes)
end

local mat = function(_, snip)
	if not snip.rows then
		-- one not set -> both not set.
		snip.rows = 3
		snip.cols = 3
	end
	local nodes = {}
	local ins_indx = 1
	for j = 1, snip.rows do
		table.insert(nodes, r(ins_indx, tostring(j).."x1", i(1)))
		ins_indx = ins_indx+1
		for k = 2, snip.cols do
			table.insert(nodes, t" & ")
			table.insert(nodes, r(ins_indx, tostring(j).."x"..tostring(k), i(1)))
			ins_indx = ins_indx+1
		end
		table.insert(nodes, t{"\\\\", ""})
	end
	-- fix last node.
	nodes[#nodes] = t""
	return sn(nil, nodes)
end

local texpairs = {
	{"(", ")"},
	{"\\left(", "\\right)"},
	{"\\big(", "\\big)"},
	{"\\Big(", "\\Big)"},
	{"\\bigg(", "\\bigg)"},
	{"\\Bigg(", "\\Bigg)"},
}

local function choices_from_pairlist(ji, list)
	local choices = {}
	for _, pair in ipairs(list) do
		table.insert(choices, {
			t(pair[1]), r(1, "inside_pairs", dl(1, l.LS_SELECT_DEDENT)), t(pair[2])
		})
	end
	return c(ji, choices)
end

return {
    s("(", {
        choices_from_pairlist(1, texpairs)
    }),
	ls.parser.parse_snippet({trig = ";"}, "\\$$1\\$$0"),
	s({trig = "(s*)sec", wordTrig = true, regTrig = true}, {
		f(function(args, snip) return {"\\"..string.rep("sub", string.len(snip.captures[1]))} end, {}),
		t({"section{"}), i(1), t({"}", ""}), i(0)
	}),
	parse({trig = "beg", wordTrig = true}, "\\begin{$1}\n\t${2:$SELECT_DEDENT}\n\\end{$1}"),
	parse({trig = "beq", wordTrig = true}, "\\begin{equation*}\n\t${1:$SELECT_DEDENT}\n\\end{equation*}"),
	parse({trig = "bal", wordTrig = true}, "\\begin{aligned}\n\t${1:$SELECT_DEDENT}\n\\end{aligned}"),
	parse({trig = "bfr", wordTrig = true}, "\\begin{frame}\n\\frametitle{$1}\n$2\n\\end{frame}"),
	parse({trig = "ab", wordTrig = true}, "\\langle $1 \\rangle"),
	parse({trig = "lra", wordTrig = true}, "\\leftrightarrow"),
	parse({trig = "Lra", wordTrig = true}, "\\Leftrightarrow"),
	parse({trig = "fr", wordTrig = true}, "\\frac{$1}{$2}"),
	parse({trig = "tr", wordTrig = true}, "\\item $1"),
	parse({trig = "abs", wordTrig = true}, "\\lvert ${1:$SELECT_DEDENT} \\rvert"),
	parse({trig = "*", wordTrig = true}, "\\cdot "),
	parse({trig = "sum", wordTrig = true}, [[\sum^{$1}_{$2}]]),
	parse({trig = "sum", wordTrig = true}, [[\sum^{$1}_{$2}]]),
	parse({trig = "int", wordTrig = true}, [[\int_{${1:lower}}^{${2:upper}} $3 \\dx $4]]),
	s("ls", {
		t({"\\begin{"}), c(1, {
			t"itemize",
			t"enumerate",
			i(nil)
		}), t({"}", "\t\\item "}),
		i(2), d(3, rec_ls, {}),
		t({"", "\\end{"}), rep(1), t"}", i(0)
	}),
	s("tab", fmt([[
	\begin{{tabular}}{{{}}}
	{}
	\end{{tabular}}
	]], {i(1, "c"), d(2, tab, {1}, {
		user_args = {
			function(snip) snip.rows = snip.rows + 1 end,
			-- don't drop below one.
			function(snip) snip.rows = math.max(snip.rows - 1, 1) end
		}
	} )})),
	parse(",", [[\$$1\$]]),
	parse("it", [[\textit{$1}]]),
	parse("tx", [[\text{$1}]]),
	parse("abr", [[\langle $1 \rangle]]),
	parse("norm", [[\lVert ${1:$SELECT_DEDENT} \rVert]]),
	s("mat", fmt([[
	\begin{{{}}}
	{}
	\end{{{}}}
	]], {c(1, {t"matrix", t"pmatrix", t"bmatrix", t"Bmatrix", t"vmatrix", t"Vmatrix"}),
		d(2, mat, {}, {
			user_args = {
				function(snip) snip.rows = snip.rows + 1 end,
				-- don't drop below one.
				function(snip) snip.rows = math.max(snip.rows - 1, 1) end,
				function(snip) snip.cols = snip.cols + 1 end,
				-- don't drop below one.
				function(snip) snip.cols = math.max(snip.cols - 1, 1) end
			}
		}),
		rep(1)
	})),
}

local regex_status_ok, regex = pcall(require, "regexplainer")
if not regex_status_ok then
	return
end

regex.setup({
	-- 'narrative'
	mode = "narrative", -- TODO: 'ascii', 'graphical'
	-- automatically show the explainer when the cursor enters a regexp
	auto = true,
	-- filetypes (i.e. extensions) in which to run the autocommand
	filetypes = {
		"html",
		"js",
		"cjs",
		"mjs",
		"ts",
		"jsx",
		"tsx",
		"cjsx",
		"mjsx",
	},
	-- Whether to log debug messages
	debug = false,
	-- 'split', 'popup', 'pasteboard'
	display = "popup",
	mappings = {
		toggle = "gR",
		-- examples, not defaults:
		-- show = 'gS',
		-- hide = 'gH',
		-- show_split = 'gP',
		-- show_popup = 'gU',
	},
	narrative = {
		separator = "\n",
	},
})

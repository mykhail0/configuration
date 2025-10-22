return {
	"github/copilot.vim",
	config = function()
		local v = vim
		v.keymap.set("i", "<C-J>", 'copilot#Accept("")', {
			expr = true,
			replace_keycodes = false,
		})
		v.g.copilot_no_tab_map = true
	end,
}

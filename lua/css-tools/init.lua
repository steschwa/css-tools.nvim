local Path = require("css-tools.lib.path")

---@class css-tools.Config
---@field customDataUris string[]

---@class css-tools.SetupOpts
---@field customData string[]?

---@class css-tools.LspAttachArgs
---@field buf number
---@field data {client_id: number}

---@class css-tools.Instance
---@field config css-tools.Config
local M = {}

---@param opts css-tools.SetupOpts?
local function create_config(opts)
	opts = opts or {}

	local customData = opts.customData or {}
	vim.validate({
		customData = { customData, "table" },
	})
	for _, item in ipairs(customData) do
		vim.validate({
			item = { item, "string" },
		})
	end

	---@type css-tools.Config
	return {
		customDataUris = vim.tbl_map(Path.to_uri, customData),
	}
end

---@param opts css-tools.SetupOpts?
function M.setup(opts)
	M.config = create_config(opts)

	vim.api.nvim_create_autocmd("LspAttach", {
		---@param args css-tools.LspAttachArgs
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client then
				return
			end

			if client.name ~= "cssls" then
				return
			end

			client.notify("css/customDataChanged", {
				M.config.customDataUris,
			})
		end,
	})
end

return M

local Path = require("css-tools.lib.path")
local Url = require("css-tools.lib.url")

local DATA_DIR_PATH = Path.get_data_dir_path("css-tools")

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

---download the given `path` if it does not exist yet.
---does nothing if the path has already been downloaded.
---@param path string
---@return string
local function with_download(path)
	local hash = Path.hash(path)
	local downloaded_file_path = vim.fs.joinpath(DATA_DIR_PATH, hash)
	if Path.file_exists(downloaded_file_path) then
		return downloaded_file_path
	end

	vim.print(string.format("downloading %s", path))
	Url.download(path, downloaded_file_path)

	return downloaded_file_path
end

---@param opts css-tools.SetupOpts?
local function create_config(opts)
	opts = opts or {}

	---@type string[]
	local customDataUris = {}
	for _, path in ipairs(opts.customData or {}) do
		if Url.is_remote_url(path) then
			table.insert(customDataUris, Path.to_uri(with_download(path)))
		else
			table.insert(customDataUris, Path.to_uri(path))
		end
	end

	---@type css-tools.Config
	return {
		customDataUris = customDataUris,
	}
end

---@param opts css-tools.SetupOpts?
function M.setup(opts)
	pcall(vim.fn.mkdir, DATA_DIR_PATH)

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

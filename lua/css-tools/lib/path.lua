local Path = {}

---@param filepath string relative or absolute file path
---@return string
function Path.to_uri(filepath)
	filepath = vim.fs.normalize(filepath)

	local absolute_path = vim.fn.fnamemodify(filepath, ":p")
	return vim.uri_from_fname(absolute_path)
end

---@param uri string
---@return string
function Path.hash(uri)
	return vim.fn.sha256(uri)
end

---@param dir_name string
---@return string
function Path.get_data_dir_path(dir_name)
	local data_dir = vim.fn.stdpath("data") --[[@as string]]
	return vim.fs.joinpath(data_dir, dir_name)
end

return Path

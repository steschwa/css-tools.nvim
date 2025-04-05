local Path = {}

---@param filepath string relative or absolute file path
---@return string
function Path.to_uri(filepath)
	filepath = vim.fs.normalize(filepath)

	local absolute_path = vim.fn.fnamemodify(filepath, ":p")
	return vim.uri_from_fname(absolute_path)
end

return Path

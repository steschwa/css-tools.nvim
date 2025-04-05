local Url = {}

---@param url string
---@return boolean
function Url.is_remote_url(url)
	if vim.startswith(url, "https://") then
		return true
	end
	if vim.startswith(url, "http://") then
		return true
	end

	return false
end

---@param url string
---@param path string
function Url.download(url, path)
	if not Url.is_remote_url(url) then
		error("not a valid url to download")
	end

	vim.system({ "curl", "-L", "-o", path, url }):wait()
end

return Url

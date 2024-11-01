local augroup = vim.api.nvim_create_augroup("AutoSave", { clear = true })

local function save_if_modified()
	if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
		vim.cmd("silent write")
	end
end

local function debounce(func, ms)
	local timer = nil
	return function()
		if timer then
			vim.fn.timer_stop(timer)
		end
		timer = vim.fn.timer_start(ms, function()
			func()
			timer = nil
		end)
	end
end

local save_with_debounce = debounce(save_if_modified, 100)

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	group = augroup,
	pattern = "*",
	callback = function(event)
		-- Only save for normal buffers (not special buffers like quickfix, help, etc.)
		if vim.bo[event.buf].buftype == "" then
			save_with_debounce()
		end
	end,
})

vim.g.neovide_cursor_animation_length = 0.02
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 1
vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_transparency = 0.9
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_cursor_trail_size = 0.9
vim.g.neovide_cursor_vfx_opacity = 50.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.0
vim.g.neovide_cursor_vfx_particle_density = 50.0
vim.g.neovide_cursor_vfx_particle_phase = 15.0
vim.g.neovide_cursor_vfx_particle_speed = 100.0
vim.g.neovide_cursor_vfx_particle_curl = 2.0
-- vim.opt.guifont = { "Fira Code Regular", ":h12" }

vim.cmd [[ autocmd FocusGained,BufEnter,CursorHold * checktime ]]

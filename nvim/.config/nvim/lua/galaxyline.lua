-- Extracted from https://github.com/glepnir/galaxyline.nvim/blob/main/example/eviline.lua
-- Credits goes to its author (glepnir) :)
local gl = require('galaxyline')
--local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section

local hsl = require("lush.hsl")
local colors = {
    bg = '#3c3836',
    lightbg = "#a89984",
    --lightbg = "#282828",
    line_bg = '#3c3836',
    fg = '#858585',
    fg_green = '#98971a',
    yellow = '#fabd2f',
    cyan = "#22262C",
    darkblue = "#61afef",
    green = '#b8bb26',
    orange = '#fe8019',
    purple = "#252930",
    magenta = "#c678dd",
    blue = "#22262C",
    red = '#cc241d',
    nord = "#83a598",
    greenYel = "#EBCB8B"
}

gl.short_line_list = {'NvimTree','vista','dbui','packer'}

vim.fn.getbufvar(0, 'ts')
gls.left[1] = {
    leftRounded = {
        provider = function()
            return ""
        end,
        highlight = {colors.yellow, colors.bg}
    }
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            return "   "
        end,
        highlight = {colors.bg, colors.yellow},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.bg}
    }
}

gls.left[3] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg}
    }
}

gls.left[4] = {
    FileName = {
        provider = {"FileName", "FileSize"},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.bg}
    }
}

gls.left[6] = {
    teech = {
        provider = function()
            return ""
        end,
        separator = " ",
        highlight = {colors.lightbg, colors.bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

gls.left[6] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.greenYel, colors.line_bg}
    }
}

gls.left[7] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.orange, colors.line_bg}
    }
}

gls.left[8] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.red, colors.line_bg}
    }
}

gls.left[9] = {
    LeftEnd = {
        provider = function()
            return " "
        end,
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[10] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[11] = {
    Space = {
        provider = function()
            return " "
        end,
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[12] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.blue, colors.bg}
    }
}

gls.right[1] = {
    GitIcon = {
        provider = function()
            return "   "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.yellow, colors.line_bg}
    }
}

gls.right[2] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.yellow, colors.line_bg}
    }
}

gls.right[3] = {
    right_LeftRounded = {
        provider = function()
            return ""
        end,
        separator = " ",
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.bg, colors.bg}
    }
}
gls.right[4] = {
    PerCent = {
        provider = {"LineColumn", "LinePercent"},
        separator = " ",
        separator_highlight = {colors.fg, colors.fg},
        highlight = {colors.bg, colors.fg}
    }
}

gls.right[5] = {
    rightRounded = {
        provider = function()
            return ""
        end,
        highlight = {colors.fg, colors.bg}
    }
}

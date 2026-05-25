return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true, -- Transparencia base activa
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        -- Forzar transparencia absoluta en el fondo del editor
        hl.Normal = { bg = "none" }
        hl.NormalNC = { bg = "none" }
        hl.NormalFloat = { bg = "none" }
        hl.NeoTreeNormal = { bg = "none" }
        hl.NeoTreeNormalNC = { bg = "none" }

        -- ¡Aquí está la solución para la barra azul molesta!
        -- Quitamos el fondo sólido de la línea actual del cursor
        hl.CursorLine = { bg = "none" }
        hl.CursorLineNC = { bg = "none" }

        -- Intentar cargar el archivo generado por Matugen de forma segura
        local status, matugen = pcall(require, "matugen_colors")

        if status and matugen then
          -- Bordes y divisiones usando el acento de tu fondo de pantalla
          hl.FloatBorder = { bg = "none", fg = matugen.accent }
          hl.WinSeparator = { bg = "none", fg = matugen.accent }
          hl.NeoTreeWinSeparator = { bg = "none", fg = matugen.accent }

          -- El número de línea de la izquierda sí se iluminará con el color de Matugen
          hl.CursorLineNr = { fg = matugen.accent, bold = true }

          -- El resaltado de la selección de texto (Visual Mode)
          hl.Visual = { bg = matugen.accent, fg = matugen.bg }

          hl.LualineNormal = { bg = "none" }
        else
          -- Fallback tradicional
          hl.FloatBorder = { bg = "none", fg = c.orange }
          hl.WinSeparator = { bg = "none", fg = c.border_highlight }
          hl.CursorLineNr = { fg = c.orange, bold = true }
        end
      end,
    },
  },
}

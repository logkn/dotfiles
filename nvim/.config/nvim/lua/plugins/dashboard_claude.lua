local pokemon = "ho-oh"

local arch = [[
                  ▟█▙                  
                 ▟███▙                 
                ▟█████▙                
               ▟███████▙               
              ▂▔▀▜██████▙              
             ▟██▅▂▝▜█████▙             
            ▟█████████████▙            
           ▟███████████████▙           
          ▟█████████████████▙          
         ▟███████████████████▙         
        ▟█████████▛▀▀▜████████▙        
       ▟████████▛      ▜███████▙       
      ▟█████████        ████████▙      
     ▟██████████        █████▆▅▄▃▂     
    ▟██████████▛        ▜█████████▙    
   ▟██████▀▀▀              ▀▀██████▙   
  ▟███▀▘                       ▝▀███▙  
 ▟▛▀                               ▀▜▙ 
]]

local hyprvim = [[

██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║   ██║██║████╗ ████║
███████║ ╚████╔╝ ██████╔╝██████╔╝██║   ██║██║██╔████╔██║
██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
██║  ██║   ██║   ██║     ██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]]

local snacks_dashboard = {
  "folke/snacks.nvim",
  name = "dashboard",
  event = "VimEnter",
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons",
  },

  ---@type snacks.Config
  opts = {
    ---@class snacks.dashboard.Config
    ---@field enabled? boolean
    ---@field sections snacks.dashboard.Section
    ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
    dashboard = {
      enabled = true,
      preset = {
        header = hyprvim,
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        {
          section = "terminal",
          cmd = string.format("pokemon-colorscripts --no-title -n %s; sleep .1", pokemon),
          -- cmd = string.format("echo %s; sleep .1", get_frame()),
          random = 10,
          pane = 2,
          indent = 4,
          height = 30,
        },
      },
    },
  },
}

return snacks_dashboard

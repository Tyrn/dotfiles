-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  "AstroNvim/astrolsp",
  opts = {
    servers = {
      "shuck",
    },
    handlers = {
      bashls = false,
    },
  },
}

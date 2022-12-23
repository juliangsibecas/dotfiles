local lspconfig = require("lspconfig")

lspconfig.solidity.setup({
  settings = {
    solidity = { includePath = "", remapping = { ["@OpenZeppelin/"] = "OpenZeppelin/openzeppelin-contracts@4.6.0/" } },
  },
})

lspconfig.tsserver.setup({
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
})

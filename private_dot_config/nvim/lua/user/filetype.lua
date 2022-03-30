local status_ok, filetype = pcall(require, "filetype")
if not status_ok then
  require("notify").notify("Error loading filetype", "error")
  return
end

filetype.setup({
  overrides = {
    literal = {
      [".gitignore"] = "conf",
      [".chezmoiignore"] = "conf",
    },
    extensions = {
      tf = "terraform",
      tfvars = "terraform",
      hcl = "hcl",
      tfstate = "json",
    },
  },
})

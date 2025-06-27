-- this custom config should by writen before git setup.
th.git = th.git or {}
th.git.modified_sign = "M"
th.git.deleted_sign = "D"
th.git.added_sign = "A"
th.git.updated_sign = "U"
th.git.ignored_sign = "I"
th.git.untracked_sign = "?"

require("git"):setup()
require("full-border"):setup({})

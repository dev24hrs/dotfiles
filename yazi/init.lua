require("git"):setup()

th.git = th.git or {}
th.git.added_sign = "A"
th.git.modified_sign = "M"
th.git.deleted_sign = "D"
th.git.untracked_sign = "?"
th.git.updated_sign = "U"

require("full-border"):setup()

import catppuccin

# NOTE: To avoid flake8 and linting errors
# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

config.load_autoconfig()
catppuccin.setup(c, "mocha", True)

# Move tab left/right
config.unbind("J")
config.unbind("K")
config.bind("J", "tab-move +")
config.bind("K", "tab-move -")

# Esc <ctrl + c>
config.bind("<ctrl+c>", "mode-enter normal", mode="insert")

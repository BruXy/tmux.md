.PHONY: check_deps pdf clean

# Create PDF
pdf: check_deps tmux.pdf Makefile

tmux.pdf: tmux-text.ctex tmux.ctex
	context tmux.ctex

# Check is prerequsities are installed
check_deps:
	@pandoc --version > /dev/null || \
        { echo "Install 'pandoc' first!" 1>&2; exit 1; } && echo "OK: 'pandoc' found."
	@context --version > /dev/null || \
        { echo "Install 'context' first!" 1>&2; exit 1; } && echo "OK: 'context' found."

# Convert MD text into ConTeXt
tmux-text.ctex: tmux.md
	pandoc --from markdown --to context -o tmux-text.ctex tmux.md

context: check_deps tmux-text.md Makefile

# Clean repository
clean:
	rm -f tmux-text.ctex tmux.{log,tuc,pdf}


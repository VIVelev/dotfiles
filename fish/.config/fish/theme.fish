# Kanagawa Fish shell theme
# A template was taken and modified from Tokyonight:
# https://github.com/folke/tokyonight.nvim/blob/main/extras/fish_tokyonight_night.fish
set -l foreground DCD7BA
set -l selection 2D4F67
set -l comment 727169
set -l red C34043
set -l orange FF9E64
set -l yellow C0A36E
set -l green 76946A
set -l purple 957FB8
set -l cyan 7AA89F
set -l pink D27E99

# Syntax Highlighting Colors
set -U fish_color_normal $foreground
set -U fish_color_command $cyan
set -U fish_color_keyword $pink
set -U fish_color_quote $yellow
set -U fish_color_redirection $foreground
set -U fish_color_end $orange
set -U fish_color_error $red
set -U fish_color_param $purple
set -U fish_color_comment $comment
set -U fish_color_selection --background=$selection
set -U fish_color_search_match --background=$selection
set -U fish_color_operator $green
set -U fish_color_escape $pink
set -U fish_color_autosuggestion $comment

# Completion Pager Colors
set -U fish_pager_color_progress $comment
set -U fish_pager_color_prefix $cyan
set -U fish_pager_color_completion $foreground
set -U fish_pager_color_description $comment

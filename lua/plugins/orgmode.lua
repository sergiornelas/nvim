-- nyoonm
local present, orgmode = pcall(require, "orgmode")

if present then
  orgmode.setup({ "*" }, {
    org_highlight_latex_and_related = "entities",
    org_agenda_files = "~/org/*",
    org_default_notes_file = "~/org/notes.org",
    org_hide_leading_stars = true,
    org_hide_emphasis_markers = true,
  })
end


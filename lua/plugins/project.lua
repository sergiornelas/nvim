-- Interpret as a project if there is a .git/package.json file

require('project_nvim').setup()
require('telescope').load_extension('projects')


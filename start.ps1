param([string]$Workspace = (Get-Location).Path)
node "$PSScriptRoot/bin/belentani.mjs" doctor --workspace $Workspace

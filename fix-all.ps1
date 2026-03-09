$ErrorActionPreference = "Continue"
$env:GIT_COMMITTER_NAME = "get-lucid"
$env:GIT_COMMITTER_EMAIL = "pinionagent714@gmail.com"
$env:GIT_AUTHOR_NAME = "get-lucid"
$env:GIT_AUTHOR_EMAIL = "pinionagent714@gmail.com"

function cm($msg) {
    git add -A 2>$null
    git commit --no-gpg-sign -m $msg 2>$null | Out-Null
}

# --- Fix domain: getlucid.xyz -> getlucid.tech ---
$files = Get-ChildItem -Recurse -File | Where-Object { $_.Extension -in @('.md','.json','.ts','.txt','.example','') -and $_.Name -ne 'fix-all.ps1' }
foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw -ErrorAction SilentlyContinue
    if ($content -and $content -match 'getlucid\.xyz') {
        $content = $content -replace 'getlucid\.xyz', 'getlucid.tech'
        Set-Content -Path $f.FullName -Value $content -NoNewline
    }
}
cm "fix domain to getlucid.tech"

# --- Rename skills to lucid-[oneword] ---
# real-time-docs -> lucid-docs
# latest-packages -> lucid-packages
# fact-grounding -> lucid-grounding
# live-api-reference -> lucid-api
# codebase-freshness -> lucid-freshness

$renames = @{
    "real-time-docs" = "lucid-docs"
    "latest-packages" = "lucid-packages"
    "fact-grounding" = "lucid-grounding"
    "live-api-reference" = "lucid-api"
    "codebase-freshness" = "lucid-freshness"
}

foreach ($old in $renames.Keys) {
    $new = $renames[$old]
    if (Test-Path "skills/$old") {
        Rename-Item "skills/$old" $new
    }
    # Update the name inside the SKILL.md
    $skillFile = "skills/$new/SKILL.md"
    if (Test-Path $skillFile) {
        $c = Get-Content $skillFile -Raw
        $c = $c -replace "name: $old", "name: $new"
        Set-Content -Path $skillFile -Value $c -NoNewline
    }
}

# Update all references to old skill names in all files
$allFiles = Get-ChildItem -Recurse -File | Where-Object { $_.Extension -in @('.md','.json','.ts','.txt','.example','') -and $_.Name -ne 'fix-all.ps1' }
foreach ($f in $allFiles) {
    $content = Get-Content $f.FullName -Raw -ErrorAction SilentlyContinue
    if ($content) {
        $changed = $false
        foreach ($old in $renames.Keys) {
            $new = $renames[$old]
            if ($content -match [regex]::Escape($old)) {
                $content = $content -replace [regex]::Escape($old), $new
                $changed = $true
            }
        }
        if ($changed) {
            Set-Content -Path $f.FullName -Value $content -NoNewline
        }
    }
}
cm "rename skills to lucid prefix"

# --- Fix install commands to match official docs ---
# Claude Code: /plugin install <git-url>
# OpenClaw: openclaw skills install <skill-id>

# --- Fix README em dashes and ", and" ---
$readme = Get-Content "README.md" -Raw

# Fix em dashes
$readme = $readme -replace ' — ', ' - '

# Fix ", and" -> " and"
$readme = $readme -replace ', and ', ' and '

# Fix install commands for Claude Code
$readme = $readme -replace '/plugin marketplace add get-Lucid/Lucid\r?\n/plugin marketplace install lucid@get-Lucid/Lucid', '/plugin install https://github.com/get-Lucid/Lucid'

# Fix install commands for OpenClaw
$readme = $readme -replace '/skills install @lucid/lucid-docs\r?\n/skills install @lucid/lucid-packages\r?\n/skills install @lucid/lucid-grounding\r?\n/skills install @lucid/lucid-api\r?\n/skills install @lucid/lucid-freshness', "openclaw skills install lucid-docs`nopenclaw skills install lucid-packages`nopenclaw skills install lucid-grounding`nopenclaw skills install lucid-api`nopenclaw skills install lucid-freshness"

# Fix ", and" patterns in tool descriptions
$readme = $readme -replace 'changelogs, deprecations and', 'changelogs and deprecations for'
$readme = $readme -replace 'type signatures and usage examples', 'type signatures with usage examples'

Set-Content -Path "README.md" -Value $readme -NoNewline
cm "fix formatting and install commands"

# --- Also fix .env.example comments ---
$env_ex = Get-Content ".env.example" -Raw
$env_ex = $env_ex -replace 'getlucid\.xyz', 'getlucid.tech'
Set-Content -Path ".env.example" -Value $env_ex -NoNewline
# already committed above

# --- Fix plugin.json install reference ---
# marketplace.json is for marketplace listing, keep it but fix the format
$mkt = Get-Content "marketplace.json" -Raw
$mkt = $mkt -replace 'getlucid\.xyz', 'getlucid.tech'
Set-Content -Path "marketplace.json" -Value $mkt -NoNewline

$plugin = Get-Content ".claude-plugin/plugin.json" -Raw
$plugin = $plugin -replace 'getlucid\.xyz', 'getlucid.tech'
Set-Content -Path ".claude-plugin/plugin.json" -Value $plugin -NoNewline

git add -A 2>$null
$hasDiff = git diff --cached --quiet 2>$null; $LASTEXITCODE
if ($LASTEXITCODE -ne 0) {
    cm "fix remaining domain refs"
}

Write-Host "done - $(git rev-list --count HEAD) total commits"

Remove-Item "fix-all.ps1" -Force -ErrorAction SilentlyContinue

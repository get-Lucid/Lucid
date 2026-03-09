$env:GIT_COMMITTER_NAME = "get-lucid"
$env:GIT_COMMITTER_EMAIL = "pinionagent714@gmail.com"
$env:GIT_AUTHOR_NAME = "get-lucid"
$env:GIT_AUTHOR_EMAIL = "pinionagent714@gmail.com"

git add -A
git commit --no-gpg-sign -m "update readme and skill names" 2>$null
git push origin main 2>&1

Remove-Item "push.ps1" -Force

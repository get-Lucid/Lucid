cd /c/Users/jum/Lucid
export GIT_COMMITTER_NAME=get-lucid
export GIT_COMMITTER_EMAIL=pinionagent714@gmail.com
export GIT_AUTHOR_NAME=get-lucid
export GIT_AUTHOR_EMAIL=pinionagent714@gmail.com
git rm -f fix.sh 2>/dev/null
git add -A
TREE=$(git write-tree)
PARENT=$(git log -1 --format=%H)
NEW=$(echo "remove temp script" | git commit-tree $TREE -p $PARENT)
git update-ref refs/heads/main $NEW
git push origin main

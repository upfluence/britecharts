echo beginning dist push

# mark all dist files to tracked
while read file; do
    git update-index --no-assume-unchanged $file
done <<<`find ./dist -type f`

# clear cache to make sure git is synced
git rm --cached -q -r dist
git add -f dist

while read version; do
    git commit -m "Bumping Dist to version $version"
done <<< `cat package.json | grep version | awk '{print $2}' | tr -d "\"\,"`

git push origin master

# mark all dist files to untracked
while read file; do
    git update-index --assume-unchanged $file
done <<< `find ./dist -type f`

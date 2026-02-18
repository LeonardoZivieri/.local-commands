FILENAME=$1
BASE_BRANCH=${2:-homologacao}
echo "Branches containing changes to $FILENAME not merged into $BASE_BRANCH:"
git log --all --format=%H $FILENAME | while read f; do git branch --no-merged $BASE_BRANCH --contains $f; done | sort -u
TOOLS_DIR=$(dirname $0)
COMMIT_HOOK=$TOOLS_DIR/hooks/commit-msg
GIT_DIR=$TOOLS_DIR/../.git
echo "Copying $COMMIT_HOOK to $GIT_DIR/hooks"
cp $COMMIT_HOOK $GIT_DIR/hooks

#!/bin/bash
# Author: VKing34


### global vars
repos=(
    "repo-link-here"
)   
since="2021-01-01"
totalRepos=0
totalCommits=0
totalCodeLines=0


### funcs
function cloneRepos() {
    echo "Starting to clone repos..."
    for repo in ${repos[@]}; do
        echo "Starting to clone: $repo"
        git clone $repo
    done
}

function collectStatisticsFromAll() {
echo "Starting to collect statistics..."
for repoDir in */ ; do
    cd $repoDir
    echo "=============================================="
    echo "Repo: $repoDir"
    collectStatisticsFromOne
    let "totalRepos += 1"
    cd ..
done
}

function collectStatisticsFromOne() {
    checkoutBranch
    collectStatistics
}

function collectStatistics() {
    # code lines
    firstCommit=$(git log --pretty="%h" --since=$since | tail -1)
    echo "First commit: $firstCommit"
    # lastCommitInLastYear=$(git log --format="%h" -n 1 ${firstCommit}~)
    codeLines=$(git diff --shortstat $firstCommit HEAD | tr '\n' ' ' | sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g' | tr -s ' ' | sed 's/ /\n/g' | sed -n 2p)
    echo "Number of code lines: $codeLines"
    let "totalCodeLines += $codeLines"

    # commits
    commitNo=$(git log --pretty="%h" --since=$since | wc -l)
    echo "Number of commits: $commitNo"
    let "totalCommits += $commitNo"
}

function checkoutBranch() {
    prefix="origin/"
    remoteTargetBranch=$(git branch -r --sort=-committerdate | head -n 1 | xargs)
    targetBranch=${remoteTargetBranch#"$prefix"}
    git checkout $targetBranch
    echo "Checked out to: $targetBranch"

    # targetBranchs=(
    #     "qc"
    #     "uat"
    #     "uat-cloud"
    #     "release.dfs"
    #     "release"
    #     "develope"
    #     "master"
    # )
    # targetBranch=""
    # branches=$(git branch -r)
    # # echo "$branches"
    # for branch in ${targetBranchs[@]}; do
    #     if grep -q "origin/$branch" <<< $branches ; then
    #         targetBranch=$branch
    #         break
    #     fi
    # done

    # # echo "branch: $targetBranch"
    # if [ -z "$targetBranch" ]
    # then
    #     echo "!!! No target branch"
    # else
    #     git checkout $targetBranch
    #     echo "Checked out to: $targetBranch"
    # fi
}

function showStatistics() {
    echo "===================RESULT======================="
    echo "Total number of repos: $totalRepos"
    echo "Total number of code lines: $totalCodeLines"
    echo "Total number of commits: $totalCommits"
}


### main
cloneRepos
collectStatisticsFromAll
showStatistics

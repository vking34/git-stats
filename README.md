# Git Statistics

- In the end of the year, i am assigned to a task to collect statistics of coding:
    - Number of active repos
    - Number of code lines
    - Number of commits

- There are a lot of repos in my company and there is no tool in the market satisfied the requirements so I have to write a tool in bash script by myself

## How to run

- Edit `git-stats.sh`:
    - Copy repo git links to array `repos`
    - Modify logic in function `checkoutBranch()` up to your case

- Run:
```
./git-stats.sh
```

## Notes
- Some following notes how to collect statistics and work with bash shell:

## Git commits between two dates
```
git log <branch-name> --pretty="%h %an %ad" --since=2021-01-01 --until=2022-01-14

git log <branch-name> --pretty="%h" --since=2021-01-01
```

## The last commit
```
git log <branch-name> -n1 --format="%h"
```

## The first commit since a date
```
git log <branch-name> --pretty="%h" --since=2021-01-01 | tail -1
```


## Show inserted/deleted lines of code betweeen 2 commits
```
git diff --shortstat <c1> <c2>
```

## Show number of commits between 2 commits
```
git log <c1>..<c2> --pretty=oneline | wc -l

git log <branch-name> --pretty="%h" --since=2021-01-01 | wc -l
```


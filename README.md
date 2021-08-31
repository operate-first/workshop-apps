# Workshop apps

Repository of ArgoCD application for different workshops.

These applications are auto-deployed via ArgoCD into MOC clusters.

## Adding a new application as a participant

1. Run `./devconf-us-2021.sh` script with your GitHub username as parameter

    ```sh
    $ ./devconf-us-2021.sh USERNAME
    Generating 'apps/devconf-us-2021/USERNAME.yaml'
    ```

2. Commit your changes and create a PR against this repo

    ```sh
    $ git status
    On branch add-USERNAME
    Untracked files:
    (use "git add <file>..." to include in what will be committed)
            apps/devconf-us-2021/USERNAME.yaml

    nothing added to commit but untracked files present (use "git add" to track)

    $ git add .

    $ git commit -m "feat: Add devconf-us-2021 application for USERNAME"
    Tabs remover.............................................................Passed
    Trim Trailing Whitespace.................................................Passed
    Check for merge conflicts................................................Passed
    Fix End of Files.........................................................Passed
    Check for added large files..............................................Passed
    Check for case conflicts.................................................Passed
    Check JSON...........................................(no files to check)Skipped
    Check for broken symlinks............................(no files to check)Skipped
    Detect Private Key.......................................................Passed
    Fix End of Files.........................................................Passed
    Trim Trailing Whitespace.................................................Passed
    yamllint.................................................................Passed
    OPA fmt..............................................(no files to check)Skipped
    Conftest test............................................................Passed
    Conftest verify..........................................................Passed
    [use-files 42c09a8] feat: Add devconf-us-2021 application for USERNAME
    1 file changed, 19 insertions(+)
    create mode 100644 apps/devconf-us-2021/USERNAME.yaml

    $ git push
    Enumerating objects: 19, done.
    Counting objects: 100% (19/19), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (11/11), done.
    Writing objects: 100% (15/15), 3.50 KiB | 895.00 KiB/s, done.
    Total 15 (delta 3), reused 0 (delta 0), pack-reused 0
    remote: Resolving deltas: 100% (3/3), completed with 1 local object.
    remote:
    remote: Create a pull request for 'main' on GitHub by visiting:
    remote:      https://github.com/USERNAME/workshop-apps/pull/new/use-files
    remote:
    To github.com:USERNAME/workshop-apps.git
    * [new branch]      main -> main
    ```

Commit and push to your fork of this repo and create a PR.

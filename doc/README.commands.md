
# README.commands.md

Because Dev0 uses an unordered parameter scheme, names of suites, repositories,
branches, tags, commits,  worktrees, IDE workspaces,
builds and build types must either be unique, or must be specified
using a option flag.

 Each command will attempt to categorize parameters not preceded by an option
 flag.  If the type of parameter cannot be determined, uniquely, the
 command will respond with an error message indicating which value
 must have an option flag.

- -s --suite
- -r --repository
- -b --branch
- -bb --base-branch
- -t --tag
- -c --commit
- -wt --worktree
- -ws --workspace
- -B  --build
- --cmake-build-type

## DEV0 - Types of Commands

- Add/Remove
- Native
- Project

### Add/Remove Commands

Add Remove commands are used to maintain the directory structure symbolic links

The basic procedure is:

- create a new suite with dev0 add suite
- add repositories with   dev0 add repository
- add worktrees with      dev0 add worktree or dev0 add build-worktree
- dev0 add|remove suite|repository|worktree|build|build-worktree|VSCode-workspace
- dev0  a |  r      s  |    r     |   w        b       bw            ws

Legend:

- repo-name: two-part name  owner-component: eg, callahanp-simgear (a fork of flightgear-simgear)
- repo-folder: repo-name.git
- git-reference-id: git reference with "/" translated to "."
- build-id:  git-reference-id.cmake-build-type
- worktree-id: repo-name.git-reference-id in other words owner-component.git-reference
- code-workspace-id: git-reference-id | $suiteName.git-reference-id |anything-else
- code-workspace: code-workspace-id.code-workspace
- workspace: code-workspace
- worktree-symlink-name: component (part of repo-name)|something else needed by
  your build and run scripts

Forms:

    dev0 add suite $suiteName
    dev0 add repository git-url (upstream-git-URL) local-git-repo-name
    dev0 add worktree local-repo-name new-branch| detach git-reference pull|rebase
    dev0 add build build-id (worktree-symlink-name)
    dev0 add build build-id worktree-id (worktree-symlink-name)
    dev0 add VsCode-workspace code-workspace-id worktree-id \[ worktree-id\]...
    dev0 remove suite fg
    dev0 remove repository local-git-repo-name
    dev0 remove worktree local-repo-name.git-reference
    dev0 remove build build-id \[worktree-symlink-name\]
    dev0 remove build build-id \[worktree-id\] | \[worktree-symlink-name\]
    dev0 remove VsCode-workspace code-workspace-id  \[ worktree-id\]...
    dev0 update worktree-id

## DEV0/Native Commands

- i | ide $suiteName git-reference
- b | build $suiteName git-reference cmake-build-type
- r | run $suiteName git-reference cmake-build-type

Dev0-Native command ide will start visual studio code by default.
Dev0-project ide commands are not supported.
Dev0-Native build and run commands establish the context of the build or run
and then call DEV0-Project commands, which are found
in the application's project directory.
The user-written DEV0-Project commands build
and run may be written to do a build or to pass call another script to do the build.

Substitution: cmake build types Debug, RelWithDebInfo, Release, and MinSizeRel
can be abbreviated as d rd r and m. The full name can be provided as lowercase,
and the correct mixed case value will be substituted.

Persistence:  if any of the commands are given argument values,
the values are saved
for use when a command is given without parameters.
The values are stored, $suiteName in $DEV_SUITES_PATH,
git-reference and cmake-build-type in $DEV_SUITES_PATH/$suiteName.

Brevity:

- Frequently used commands can be aliased to a single letter if desired.
- Dev0 does this for editing, building and running executables
- Context information, suite, git-reference and cMakeBuildType are saved
- and will be used if a command is entered without them.

Parameter Pass Through:

- DEV0/native commands process command-line parameters
- to the end of the command line or the first --
- All parameters are passed to DEV0-Project scripts regardless of "--""
- A Dev0/Application interface script such as run or build
  may use anything the Dev/Native script passed to it via environment variables,
  parameters or the setting of the current directory

Limitation: the sets of suite names and git-reference names must be chosen
so they do not overlap.

Having a suite name the same as a git-reference name would cause problems.

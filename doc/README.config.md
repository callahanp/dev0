# Dev0 Configuration

$DEV_DOC_PATH/README.config.md


The whole of configuration for your complete set of suites
can be in a single file, or can be distributed across
files in subdirectories.  It's similar to the way CMake is configured.

- $DEV_SUITES_PATH/dev0.config
- $DEV_REPOSITORIES_PATH/dev0.repositories.config
- $DEV_WORKTREES_PATH/dev0.worktrees.config
- $DEV_SUITES_PATH/$suiteName/project/$suiteName.config

## Repositories

    repository localRepoName
      [ origin originGitUrl [nopush] ]
      [ upstream upstreamURL [nopush]  ]
      [ keep-branch branchName] ...
      [ keep-tag    tagName] ...
      [ keep-commit-id  commit-id] ...

## Worktrees

    worktree localRepoName [localRepoName...]
      upstream|origin|remoteName|local
        keep-branches|git-reference* [git-reference...]
        git-pull [--rebase]

      * git branch, tag or commit

## Workspaces

    workspace localRepoName.git-reference* ...
              [cMakeBuildTypes [d] [rd] [r] [m]]
              [valuesets valuesetLevel valuesetName [valuesetlevel valuesetName...]]

## Value Sets

    valueset valuesetName value [value ...]

## Example - $DEV_SUITES_PATH/fg/project/fg.config

    suite fg

    repository flightgear
      origin git://callahanpa@git.code.sf.net/u/callahanpa/flightgear
      upstream https://git.code.sf.net/p/flightgear/flightgear nopush
      keep-branch next release/2024.1 release/2020.3 release/2018.1
      keep-tag    none
      keep-commit-id none

    repository simgear
      origin git://callahanpa@git.code.sf.net/u/callahanpa/simgear
      upstream https://git.code.sf.net/p/flightgear/simgear nopush
      keep-branch next release/2024.1 release/2020.3 release/2018.1
      keep-tag    none
      keep-commit-id none

    repository fgmeta
      origin git://callahanpa@git.code.sf.net/u/callahanpa/fgmeta
      upstream https://git.code.sf.net/p/flightgear/fgmeta  nopush
      keep-branch next release/2024.1 release/2020.3 release/2018.1
      keep-tag    none
      keep-commit-id none

    repository openscenegraph
      upstream https://gitlab.com/flightgear/openscenegraph.git nopush
      keep-branch fgfs-osg-36-2 OpenSceneGraph-3.6 OpenSceneGraph-3.4
      keep-tag    none
      keep-commit-id none

    worktree flightgear
      upstream keep-branches  git-pull --rebase
      local tickets/2890 git-pull --rebase upstream next
    worktree simgear
      upstream keep-branches  git-pull --rebase
    worktree fgmeta
      upstream keep-branches  git-pull --rebase
    worktree openscenegraph
      upstream keep-branches  git-pull --rebase

    workspace flightgear.next simgear.next fgmeta.next openscenegraph.fgfs-osg-36-2
      cmake-build-types d rd r m
    workspace flightgear.latest simgear.release/2024.1 fgmeta.release/2024.1 openscenegraph.fgfs-osg-36-2
      cmake-build-types d rd
    workspace flightgear.lts simgear.release/2020.3 fgmeta.release/2020.3 openscenegraph.fgfs-osg-36-2
      cmake-build-types d rd
    workspace flightgear.oldlts simgear.release/2018.1 fgmeta.release/2018.1 openscenegraph.fgfs-osg-36-2
      cmake-build-types d rd




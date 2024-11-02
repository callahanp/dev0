# DEV0 - A simple development environment

README.md

## Overview

Dev0 provides a common structure and workflow for the most common developer tasks
when creating or maintaining applications. Its purpose is to manage source materials
seamlessly so a developer can instantly switch between tasks.

Dev0 supports development in simple situations with one cloned repository
to large application suites with multiple executables, repositories,
libraries, and tools.

## Dev0 Features

- Maintains a set of git repositories and worktrees
- Produces builds with choices of
  - CMake Build Types
  - Build Features
  - Supporting Libraries
- Runs Executables with sets of Environment Variables, Command Line Options and Parameters
- Generated VSCode workspace and launch configurations
- Updates repositories and worktrees with pull or rebase
- Easily change context between applications or branches
-
## Dev0 Concepts

- Suites of Related Applications, Libraries or Tools
- Repository Hosts (Gitlab, Github, SourceForge and Local)
- Repository Providers (Hosted and Local)
- Remotes: Official Repositories and Forks
- Branch, Tag or Commit
- Updating Local Branches from Remotes
- Worktrees (Git Clones and Bare Clones)
- Workspace (VSCode Editing, Building and Running Executables)
- Setting Sets (Environment Variables, Command Line Options and Parameters)
- Flexible Configuration

Dev0 is currently based on git and VisualStudioCode, but can be adapted to use SVN  and any other IDE.

## Dev0 core elements

***
**Repository:**
: An "official" git repository stored on one of Sourceforge, GitLab, GitHub, or locally

**Fork**
: A bare git copy of an official repository stored on Sourceforge, GitLab, or GitHub under a user's account
***
**Directory names**
: Directory names in Dev0 are formed from combinations of names: suite, clone, CMake Build Type, or Git Branch, tag or commit-id.  Special characters are limited to hyphens and periods.  Periods are used in place of / to keep the directory hierarchy as flat as possible. Hyphens are kept when creating worktrees from another user's fork.  Othewise they are avoided.

Several environment variables are required for DEV0 in .bashrc 

examples:

- $DEV_SUITES_PATH/\<suite-name>
- $DEV_REPOSITORIES_PATH/dev0.git
- $DEV_WORKTREES_PATH/dev0.next

- $DEV_SUITES_PATH/\<suite-name>/project
- $DEV_SUITES_PATH/\<suite-name>/workspace.next
- $DEV_SUITES_PATH/\<suite-name>/workspace.\<branch-name>
- $DEV_SUITES_PATH/\<suite-name>/workspace.\<branch-name>/build.\<cmakeBuildType>.\<build-parameter-set-name>
- 
***
**Suite**

A suite is any set of software you want to work on as a unit.  A suite can have one or more repositories.

Suite names are lower case and contain no special characters.  Short abbreviations are recommended.

Directory: **$DEV0_SUITES_PATH**
***
**Project**
: A directory for storing materials supporting the use of Dev0 for a suite

The project directory contains contains DEV0 configuration files and build scripts.

Directory: **\$DEV0\_SUITES\_PATH/\$suiteName/project**
***
**Clone**
:Bare clones of repositories or forks stored locally.

Clones of official repositories are created using -origin=upstream.  Forks are treated as remotes and are not usually needed as separate clones.

Directory: **\$DEV0\_CLONES\_PATH**

**origin**
: in a clone, a git remote pointing to your personal fork.  Forks of other users may also be added as git remotes with any name you choose, customarily username-reponame

**upstream**
: in a clone, a git remote pointing to an official repository

***
**commit-ish or \$commitIsh**
: a git branch, tag or commit-id
***
**Worktree**
: A directory containing a git worktree specific to a branch, tag or commit

Directory: **\$DEV0\_WORKTREES\_PATH**

***

**Workspace**
: A directory for working with a specific set of one or more worktrees

Directory **\$DEV0\_SUITES\_PATH\/$suiteName\/workspace.\$commitIsh**
***

**Build** 
: a Directory within a workspace for building with a specific set of one or more worktrees and a single named Build Type

**Build Type**
: A named set of characteristics or parameter values that differentiate builds based on the same worktrees, using different combinations of parameters. 

The content of the parameters depends on the needs of your build script in the 

Directory: **\$DEV0\_SUITES\_PATH\/$suiteName\/build.\$commitIsh**
***

**.bashrc**
: a good place to define the environment variables Dev0 uses and to call devrc

- DEV0_INSTALL_PATH=
- DEV0_SUITES_PATH=
- DEV0_CLONES_PATH=
- DEV0_WORKTREES_PATH=
- $DEV0_INSTALL_PATH/devrc
***
***
# Dev0 working commands

**ide or i**

Start default ide with $suiteName and $workspaceName

i [suite-name] [workspace-name]

**build or b**
: run build script found in the project directory 

b [suite-name] [workspace-name] [cmakeBuildType] [build-type]

**run or r**
: execute the run script in thye project directory with $suiteName and $workspaceName and $buildType
r [suite-name] [workspace-name] [cmake-build-type] [build-parameter-set-name] [run-parameter-set-name]

Parameters for ide, build and run are optional once used in a suite.  
Special value: "none" can be used for [buld-parameter-set-name] and [run-parameter-set-name] ls

- if a suitename is a parameter is not given and the current path includes a suite, that suite will be used.  If not, the previous suite used for the command will be used provided it has been set.
- if a workspace name  or build type is not given, the previous value for the suite will be used if it has been set.

## dev0 maintenance commands

**clone \<repository-url> \<local-repository-name> [origin origin-url] \<commit-ish...>**

- Create a bare clone a specific repository from SourceForge, GitHub or GitLab as upstream
- Retain only specified branches and tags
- Optionally set origin to a SourceForge, Github or Gitlab personal fork. 
  
Worktrees are created for the retained branches and tags, and for any specified individual commits.

**worktree \<local-repository-name,commit-ish>...**

create a git worktree from a repository for a branch, tag or commit 

**workspace \<workspace-name> [\<clone-name | clone-name,commit-ish>]...**

Create a workspace for specific combinations of worktrees

- suitable workspace names include git branch names, git tag names, git commit id's and other words.
- note that there can be only one worktree per branch, tag or commit id, but many workspaces can use the worktree.
  
**buildParameterSet [\<workspace-name>] \<build-parameter>...**

The buildParameterSet command is only needed if additional parameters beyond the CmakeBuildType are required for special builds.

The buildParameterSet command creates a file in the project directory containing a named set of parameters used for builds.  When build is run and the command names a buildParameterSet, these parameters will be forwarded to project's build script.

**runParameterSet [\<workspace-name>] \<run-parameter-set-name>...**

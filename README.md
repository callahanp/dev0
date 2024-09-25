# DEV0 - A simple development environment

## Overview

Dev0 provides a common structure and workflow for the most common developer tasks when creating or maintaining applications. Its purpose is to manage build scenarios seamlessly so a developer can instantly switch to a different build scenario. Dev0 does not provide a complete development environment.  Its purpose is to provide an interface to developers' daily tasks using scripts you probably already have.

Dev0 supports
- Multiple Standalone Applications with a single cloned repository
- Multiple Application Suites with numerous components
- Clones of multiple application, library, and toolchain repositories in a project
- Official repositories and personal forks of multiple individuals
- 
The workflow supported by DEV0 is simple:

- setup Application or Application Suite
- setup individual working environments for specific build scenaria related to releases, maintenance, refactoring, bug fixing etc.
- edit & run under debug in VSCode
- scripted build using any build technology, including the Gnu Toolchain, CMake, and Ninja Build.
- multiple build types including Debug, RelWithDebInfo, Release and MinSizeRel
- scripted run for executables from any build scenario.


## A Real-World Example:

I want to work on changes for tickets/4890, tickets/4887 and "main" at the same time.

- There are three repositories: App, AppLib and OtherLib
- Any build uses all three
- There are some circumstances where the system's installed OtherLib is needed and others where a customized branch of the OtherLib repository from our fork is appropriate.
- There are circumstances where an un-released version of a toolchain item is needed. (In our situation it was CMake for about six months.  We're back on the released version)
  
- Debug, Release, RelWithDebInfo, and MinSizeRel versions as needed
  
- Tickets/4890 is a branch on one repository: App
- Tickets/4887 is a branch on two repositories: App and AppLib
- OtherBranch is our branch on a fork of OtherLib; OtherLib's latest release is installed system-wide.
  
- I keep App and AppLib's  main branch updated from upstream and push the changes to my forks
- Other members of my team maintain a specialized branch on a fork of OtherLib
- I am doing the initial work on 4890 and final testing on 4887.
- I build Debug, Release, RelWithDebInfo, and MinSizeRel versions with either the system's OtherLib or a build of the customized branch of OtherLib.

Does that sound like a lot?  It is. And Dev0 helps manage the situation. Dev0 commands switch between build scenarios without using git stash. A terse entry is made on the command line, and the switch is done.
## DEV0 - Types of Commands

- Add/Remove
- Native
- Project

### Add/Remove Commands

Add Remove commands are used to maintain the directory structure symbolic links and IDE files making up an application or suite under Dev0

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
- code-workspace-id: git-reference-id | suite-name.git-reference-id |anything-else
- code-workspace: code-workspace-id.code-workspace
- workspace: code-workspace
- worktree-symlink-name: component (part of repo-name)|something else needed by your build and run scripts

Forms:

    dev0 add suite suite-name
    dev0 add repository git-url (upstream-git-URL) local-git-repo-name
    dev0 add worktree local-repo-name git-reference
    dev0 add build build-id (worktree-symlink-name) 
    dev0 add build build-id worktree-id (worktree-symlink-name)
    dev0 add VsCode-workspace code-workspace-id worktree-id \[ worktree-id\]...
    dev0 remove suite fg
    dev0 remove repository local-git-repo-name
    dev0 remove worktree local-repo-name.git-reference
    dev0 remove build build-id \[worktree-symlink-name\]
    dev0 remove build build-id \[worktree-id\] | \[worktree-symlink-name\]
    dev0 remove VsCode-workspace code-workspace-id  \[ worktree-id\]...
    dev0 git-pull worktree-id
    dev0 git-rebase target-worktree-id 


## DEV0/Native Commands

- i | ide suite-name git-reference
- b | build suite-name git-reference cmake-build-type
- r | run suite-name git-reference cmake-build-type

Dev0-Native command ide will start visual studio code by default.  Dev0-project ide commands are not supported.
Dev0-Native build and run commands establish the context of the build or run and then call DEV0-Project commands, which are found in the application's project directory.  The user-written DEV0-Project commands build and run may be written to do a build or to pass call another script to do the build.

Substitution: cmake build types Debug, RelWithDebInfo, Release, and MinSizeRel can be abbreviated as d rd r and m. The full name can be provided as lowercase, and the correct mixed case value will be substituted.

Persistence:  if any of the commands are given argument values, the values are saved
for use when a command is given without parameters.  The values are stored, suite-name in $DEV_SUITES_DIR and git-reference and cmake-build-type in $DEV_SUITES_DIR/suite-name.

Brevity:  

- Frequently used commands can be aliased to a single letter if desired. Dev0 does this for editing, building and running executables
- Context information, suite, git-reference and cMakeBuildType are saved and will be used if a command is entered without them.
  
Parameter Pass Through:
- DEV0/native commands process command-line parameters to the end of the command line or the first --
- All parameters are passed to DEV0-Project scripts regardless of --
- A Dev0/Application interface script such as run or build may use anything the Dev/Native script passed to it via environment variables, parameters or the setting of the current directory 


Limitation: the sets of suite names and git-reference names must be chosen so they do not overlap.

Having a suite name the same as a git-reference name would cause problems.

## Environment Variables and devrc

in ~/bashrc, add definitions for

- DEV_SUITES_DIR=/work/suites a directory named suites, placed
wherever you will have space for the repositories, worktrees and sources,
builds and data you will be working with. (think big)
- DEV_APP_DIR= the app folder in DEV0
elements
- $DEV_APP_DIR/devrc # execute the dev rc file to define aliases for ide, build and run

## DEV0 Directories

To make things regular between projects, DEV0 enforces a set of directory names for common development artifacts: repositories, worktrees, builds etc.

### directory: $DEV_SUITES_DIR/suite-name

Suites are composed of one or more related applications,
libraries plug-ins, or other material, commonly built as a group
or used together.

Examples include

- Flightgear with it's related project simgear and a specific
  version of one of the libraries it uses.
- LibreOffice with its various components would be another.

Each of the directories below is in $DEV_SUITES_DIR/suite-name/

### directory: $DEV_SUITES_DIR/suite-name/project

Dev0's development model does not take full charge of your builds.  It merely sets several
variables you can use in your own build and run scripts, called by the build and run scripts in DEV0

These bash variables are:

- $suite
- $gitReference
- $cMakeBuildType

You are required to provide two
scripts that set the stage for using your usual build and run scripts and then call them.
Your version of project/run and project/build should use the values of $suite, $gitReference and $cMakeBuildType to ensure that the desired build directory is used to build in, or to run.
What is built and how it is done is up to you.

### directory: repositories

Bare git clones of upstream and personal forks from GitHub, GitLab,
SourceForge or local bare repositories for new suites of applications.

Only Git repositories are supported at this time.

### directory: worktrees

Git worktrees for specific git references: branches, tags or specific commits.

### directory: builds

/builds contains a directory of builds for specific git-references and Cmake Build Types.
The names of the directories have a specific format:

- git-reference.cmake-build-type

Each one contains symbolic links to actual worktrees needed for the build.  DEV0 assumes the cmake build and install directories are in the same directory alongside the links to the source trees.
in addition, DEV0 places a builds ld directory.

Here's a typical example with a bit of complexity.

    builds
    ├── next.Release
    │   ├── fgmeta -> /work/suites/fg/worktrees/flightgear-fgmeta.next
    │   ├── flightgear -> /work/suites/fg/worktrees/flightgear-flightgear.next
    │   └── simgear -> /work/suites/fg/worktrees/flightgear-simgear.next
    │   ├── build
    │   ├── install
    │   │   ├── flightgear
    │   │       └── fgdata ->/work/suites/fg/worktrees/flightgear-fgdata.next
    ├── tickets.2895.Debug
    │   ├── fgmeta -> /work/suites/fg/worktrees/callahanpa-fgmeta.tickets.2895
    │   ├── flightgear -> /work/suites/fg/worktrees/flightgear-flightgear.next
    │   ├── simgear -> /work/suites/fg/worktrees/flightgear-simgear.next
    │   ├── build
    │   │   ├── flightgear
    |   |       └── ... (build files)
    │   │   └── simgear
    |   |       └── ... (build files)
    │   ├── install
    │   │   ├── flightgear
    │   │       └── fgdata ->/work/suites/fg/worktrees/flightgear-fgdata.next
    |   |    (additional files and directories required for run are either
    |   |     in place here, or are created by the build process)
    ├── tickets.2895.Release
    │   ├── ...

### directory: $DEV_SUITES_DIR/suite-name/edits

- anything necessary to start VSCode or another editor.

For vscode, this is a set of multi root .code-workspace files, one per git-reference
and optionally others for special situations.


The following material needs to be rewritten and restructured.

You might need separate workspaces for activities like these:

## Environment Variables and devrc

in ~/bashrc, add definitions for

- DEV_SUITES_PATH=/work/suites a directory named suites, placed
wherever you will have space for the repositories, worktrees and sources,
builds and data you will be working with. (think big)
- DEV_APP_PATH= the app folder in DEV0
- $DEV_APP_PATH/devrc # execute the dev rc file to define aliases for ide,
  build and run

## DEV0 Directories

To make things regular between projects, DEV0 enforces a set of directory names
for common development artifacts: repositories, worktrees, builds etc.

### directory: $DEV_SUITES_PATH/$suiteName

Suites are composed of one or more related applications,
libraries plug-ins, or other material, commonly built as a group
or used together.

Examples include

- Flightgear with it's related project simgear and a specific
  version of one of the libraries it uses.
- LibreOffice with its various components would be another.

Each of the directories below is in $DEV_SUITES_PATH/$suiteName/

### directory: $DEV_SUITES_PATH/$suiteName/project

Dev0's development model does not take full charge of your builds.
It merely sets several variables you can use in your own build and run scripts,
called by the build and run scripts in DEV0

These bash variables are:

- $suite
- $gitReference
- $cMakeBuildType

You are required to provide two scripts that set the stage f
or using your usual build and run scripts
and then call them.
Your version of project/run and project/build should use the values of $suite,
$gitReference and $cMakeBuildType to ensure that the desired build directory
is used to build in, or to run.
What is built and how it is done is up to you.

### directory: $DEV_SUITES_PATH/repositories

Bare git clones of upstream a forks from GitHub, GitLab,
SourceForge or local bare repositories for new suites of applications.

Only Git repositories are supported at this time.

### directory: $DEV_SUITES_PATH/worktrees

Git worktrees for specific git references: branches, tags or specific commits.

### directory: $DEV_SUITES_PATH/$suiteName/builds

/builds contains a directory of builds for specific git-references
and Cmake Build Types.
The names of the directories have a specific format:

- git-reference.cmake-build-type

Each one contains symbolic links to actual worktrees needed for the build.
DEV0 assumes the cmake build and install directories are in the same directory
alongside the links to the source trees.
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
    │   │       └── fgdata ->/work/suites/fg/worktrees/fgdata.next
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
    │   │       └── fgdata ->/work/suites/fg/worktrees/fgdata.next
    |   |    (additional files and directories required for run are either
    |   |     in place here, or are created by the build process)
    ├── tickets.2895.Release
    │   ├── ...

### directory: $DEV_SUITES_PATH/$suiteName/edits

- anything necessary to start VSCode or another editor.

For vscode, this is a set of multi root .code-workspace files, one per git-reference
and optionally others for special situations.

Dev0 manages

- Repositories
- Worktrees
- Starting an ide or code editor
- Build scripts
- Execution scripts

Dev0 organizes work as "Suites" of applications.

A suite can be a small as a single app or library or development tool.
Other suites will cover a single application with multiple separate libraries
and toolchains.
Each Suite will require at least one set of source materials.
Some suites will use a single repository, some more than one.

Notes: the current version of Dev0 supports only

- Git repositories.
- Visual Studio Code editing and debugging

Separate README files cover the initialization, maintenance and usage of Dev0

- doc/README.initialization.md
- doc/README.maintenance.md
- doc/README.usage.md

# DEV0 - A simple development environment

Dev0 provides a common structure and workflow for the most common developer tasks when creating or maintaining applications.

Dev0 supports
- Standalone Applications with a single cloned repository
- Application Suites with multiple components
- Clones of multiple application, library, and toolchain repositories
- Official repositories and personal forks of multiple individuals
- 
# The workflow supported by DEV0 is simple:
- setup Application or Application Suite
- setup individual working environments for specific tasks related to releases, maintenance, refactoring, bug fixing
- edit & run under debug in VSCode
- scripted build using any build technology, including the Gnu Toolchain, CMake, and Ninja Build.
- scripted run of executables

While it is possible to demonstrate building and running CMake and Gnu Toolchain projects within VScode, Dev0 does not directly support this in the current version.


## DEV0 Commands

- i | ide suite-name git-reference
- b | build suite-name git-reference cmake-build-type
- r | run suite-name git-reference cmake-build-type

Substitution:  cmake build types Debug, RelWithDebInfo, Release and MinSizeRel can be abbreviated as d rd r and m.  the full name can be provided as lowercase, and the correct value will be substitued.

Persistence:  if any of the commands are given argument values, the values are saved
for use when a command is given without parameters.  The values are stored, suite-name in $DEV_SUITES_DIR and git-reference and cmake-build-type in $DEV_SUITES_DIR/suite-name.


for example:

b fg next d
i
r

b fg next d
will build the debug version for the next branch of fg (flightgear)
i will start the ide for next
r will run the executable provided by the build.

The arguments fg, next and d can be provided in any order, and if any are provided the value given will override the persisted value.

so after setting the persistence values you can do
i fg next
b m
b d
b rd
b r

r
r d
r rd
r r

Four instances of the project run command will each run the different build types.

same for r.

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

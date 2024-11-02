# Dev0 Concepts:


## Suites

A suite is a container with everything you need to organize your development work
for a specific project

Suites

- Use but do not contain clones of repositories and worktrees*.
- Contain workspaces for
  - IDE or Code Editor configurations
  - Builds
  - Custom install directories.

  \* Repository clones and worktrees are stored in separate directories

A Suite can Cover one or more:

- Applications
- Libraries
- Data Sets
- Tools

Examples include:  Open Office, Flightgear, Cmake, glib.
A suite can contain a lot, or a little.

An example:

A suite such as FlightGear might include everything related to the
Flightgear Open Source Flight Simulator project,
including a specialized version ofOpenSceneGraph
and a pre-release version of a system wide installed tool such as CMake.

- flightgear - the applicaiton
- simgear - flightgear's separate low level library
- fgmeta - flightgear's internal toolchain
- WS3.0 - flightgear's latest build environment for World Scenery
- WS2.0 - flightgear's previous build environment for World Scenery
- openscenegraph - a customized version of
- library simgear, it's toolchain fgmeta, it's data, fgdata a customized Open Scene Graph
- C172P - An Aircraft Model
- CMake - A release candidate for CMake, which was used for Flightgear for several months until it was released.

Suites are placed in $DEV_SUITES_PATH

## Repository Hosts (Gitlab, Github, SourceForge and Local)

Dev0 uses bare git clones of repositories from any code hosting provider.


## Locally Hosted Repositories

Dev0 can create and host a local bare repository in its repositories directory.

Dev0 does not currently support providing a git server on the local machine.
For sharing, a local repository could be to uploaded to a git hosting provider.


## Local Clones of Hosted Repositories

Dev0 can clone an official repository from the hosting providers using either un-authenticated https access or an ssh login.

Dev0 supports local bare repository clones with git worktrees.
On first download, all branches and tags are removed from the clone.

Remote branches, tags and commits of interest to the user are fetched
and set as remote tracking branches.

### Repository Directory

Bare clones of hosted repositories and local bare repositories  are placed in a single directory.
Set Environment Variable DEV_REPOSITORIES_PATH in .bashrc

## Remotes: Official Repositories and Forks

Dev0 uses git upstream remotes for official repositories and git origin remotes
for the user's fork of the official repository.  It can also define additional
remotes for another user's forks as needed.

## Branch, Tag or Commit

Dev0 limits the number of git branches and tags on local clones to those you
select. All other branches or tags are removed, reducing clutter locally.

New branches for fixes and new features are configured and created locally.
Branches can be configured to push to any fork for which you have write
permissions. Branches can be configured to use git pull --rebase or git pull
to update manually or automatically.

## Worktrees

Worktrees are created for existing tracking branches
from official upstream repositories,
from a user's origin fork
or from a remote pointing to any other user's fork.

Worktrees are accessed using IDE configuration files,
VSCode multi-root workspaces, or through symbolic links
for building and running

Worktrees of are placed in a single directory.
Set Environment Variable DEV_WORKTREES_PATH in .bashrc

Individual worktrees should be named using the repository name and a git reference.
A git reference is a branch, tag or commit-id.

For example $DEV_WORKTREES_PATH/flightgear.next would be a worktree with
a checkout of FlightGear's next branch

Remember that you can only have one worktree for a specific
branch, tag or commit-id, but you can have many symbolic links
pointing to the worktree.

## Updating Local Branches from Remotes

Local branches can be updated individually, for an entire suite, or for all suites.
The update may be configured for git pull, git pull --rebase, or no-update.
git pull and git pull --rebase
can be run manually for any worktree.

## Workspaces
Dev0 workspaces are configured to work on

- a release branch or tag
- a bug-fix or feature
- experiments
- git bisect operations
- any other purpose rerelated to one or more worktrees

Dev0 workspaces support editing, building and running executables with or without debug.

## Workspace - Editing

Dev0 automatically creates a vsCode multi-root code-workspace file for each workspace from the workspace configuration.

## Workspace - Building

Dev0 provides multiple variant build and install directories for each workspace.
Variants are based on options such as the desired list of CMake build types.
Optional features of an application are supported using Setting Sets.
Examples of variants include building with feature-x enabled,
CMakeBuildTypes Debug, Release, RelWithDebInfo and MinSizeRel Builds
can be configured to run for combinations of features and CmakeBuildTypes,
yielding a large number of independent built versions if desired.
The usual practice is to build just one during development
and all of the allowed combinations to test the build process itself.


## Workspace - Running

Running built programs should run an executable with the items produced
by a specific variant build.
The user will have to provide a script which does this
for any desired combination of features and cmake build type.
Value sets are one way to make this work.

## Value Sets (Environment Variables, Command Line Options and Parameters)

Value sets are named sets of environment variable values, option choices
and parameter values used in ide, build and run commands.
They are imported by the commands and modify the behavior of the given command.
Examples include providing additional cmake options for builds, and providing
a set of command line options and parameters to an exectuable.
Value sets may be created by hand, orgenerated by a custom script.

## Flexible Configuration

The whole of configuration for your complete set of suites
can be in a single file, dev0.config or can be distributed across
files in subdirectories.  It's similar to the way CMake is configured.

$DEV_SUITES_PATH/dev0.config
$DEV_REPOSITORIES_PATH/dev0.repositories.config
$DEV_WORKTREES_PATH/dev0.worktrees.config
$DEV_SUITES_PATH/$suiteName/project/repositories.config
$DEV_SUITES_PATH/$suiteName/project/workspaces.config
$DEV_SUITES_PATH/$suiteName/workspaces/workspace.name.config

Further details on the contents and placement of these files can be found in $DEV_DOC_PATH/README.config.md
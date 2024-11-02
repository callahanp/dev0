# DEV0 Initialization

Initialization commands start with "dev add".
Dev writes the native commands it executes on the console.
If the results of a command are already in place, the command is listed,
along with a comment indicating the command was not executed
and the resource it would have created is in place.

A fully initialized suite includes

- clones of official repositories or local repositories
- worktrees for specific git references in repositories required for any suite
- a project directory
- a configuration file specifying ide, code-editor, build and run configurations
and the repositories and worktrees needed for editing, building and running.

## .bashrc

Example:

    export DEV_SUITES_PATH=/work/suites
    export DEV_WORKTREES_PATH="$DEV_WORKTREES_PATH"
    export DEV_REPOSITORIES_PATH_PATH=/work/suites/repositories
    export DEVRC=$DEV_WORKTREES_PATH/dev0.next/app/devrc
    if [[ -e $DEVRC ]]; then
      source $DEVRC
      echo DEVRC: $DEVRC finished
    else
      echo "*******************************************"
      echo "DEVRC: $DEVRC not found"
      echo "*******************************************"
    fi

## Suite Directory

Dev0 needs a place to put Suite materials.
A dedicated directory $DEV_SUITES_PATH is defined in your .bashrc

Creating a new suite is as simple as

    mkdir -p $DEV_SUITES_PATH/suiteName/project
    or
    dev0 add suite [suite-name]

So far so good, but that's just an initial directory structure

    /work/suites
        └──repositories
        └──worktrees
        └──suiteName
            └── project

2 directories, 0 files

## Repositories

Repositories for all suites are stored in $DEV_REPOSITORIES_PATH/

Individual suites refer to these repositories in their configuration files.

Let's add a repository

<pre><code>
    <b>dev0 add git [git-url] local-repo-name</b>
    &#x2610; Test To Be Written
    &#x2610; Unimplemented
</code></pre>

This adds a bare git repository in $DEV_REPOSITORIES_PATH/local-repo-name.git
that is either

- A clone if the git-url starts with http://, https://, or git://
- A new git repository named local-repo-name.git containing an empty README.md file

    /work/suites
        └──repositories
           local-repo-name.git
        └──suiteName
            └── project

## Worktrees

Worktrees for all suites are stored in $DEV_WORKTREES_PATH/

Worktrees are stored in directories with names formed from repository names
and git reference names.

Individual suites refer to these worktrees in their configuration files.

Git reference names include git branches, tags and commit ids
Let's add a worktree

Let's add a worktree for an existing branch

  <pre><code>

    <b>dev0 add worktree local-repo-name branch-name</b>>
    &#x2610; Test To Be Written
    &#x2610; Unimplemented

    /work/suites
        └──repositories
           └──local-repo-name.git
        └──worktrees
           └──local-repo-name.branch-name
        └──suiteName
            └── project
</code></pre>
Let's add a worktree for an new branch based on an existing branch

  <pre><code>
    <b>dev0 add worktree local-repo-name new-branch-name existing-branch-name</b>>
    &#x2610; Test To Be Written
    &#x2610; Unimplemented
    /work/suites
        └──repositories
           └──local-repo-name.git
        └──worktrees
           └──local-repo-name.branch-name
           └──local-repo-name.new-branch-name.existing-branch-name
        └──suiteName
            └── project
</code></pre>
Let's add a detached and orphan worktrees based on a branch, tag or commit
<pre><code>
    <b>dev0 add worktree local-repo-name git-reference --detach</b>
    <b>dev0 add worktree local-repo-name git-reference --orphan</b>
    &#x2610; Test To Be Written
    &#x2610; Unimplemented
    /work/suites
        └──repositories
           └──local-repo-name.git
        └──worktrees
           └──local-repo-name.branch-name
           └──local-repo-name.new-branch-name.existing-branch-name
           └──local-repo-name.git-reference.detach
           └──local-repo-name.git-reference.orphan
        └──suiteName
            └── project
    <b>Question:  Can you create a detached or orphaned worktree if you have
               already created a worktree for the same git reference?</b>

      &#x2610; Unanswered</b>
</code></pre>

## project directory

Each suite has a project directory containing:

- configure.json - a specification in json for recreating, extending
  or modifying the suite
- the IDE configuration files for IDEs or code editor for example) suite-name.git-reference.code-workspace
- an optional build script a script capable of building
  one or more of the configured builds
- an option run script capable of using the result of any chosen build

## builds directory

A Suite may have an optional builds directory supporting the builds
specified in configure.json

## configure.json

    &#x2610; Test To Be Written
    &#x2610; Unimplemented
    {
      "suiteName": "suite-name",
        "repositories": [ local-repository-name,... ],
        "worktrees":  [ local-repository-name.git-reference, ... ],
        "builds":
          [ {"git-reference": {git-reference},
                  "cmakeBuildTypes": [ d, rd, r, m],
                  "worktrees":  [ local-repository-name.git-reference, ... ]}
        ]

    }
    Note: if builds are specified,
    the top level repositories and worktrees need not be specified.

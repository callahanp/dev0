#!/usr/bin/env bats
#  SPDX-FileName: matchGitWorktrees.bats
#  SPDX-FileComment: Template bash script
#  SPDX-FileCopyrightText: Copyright (C) 2024 Patrick Callahan
#  SPDX-License-Identifier: GPL-2.0-or-later

# Usage
# cd testing;  bats test_bashScript.bats

#bats_require_minimum_version 1.5.0
setup_file() {
    export DEV_APP_DIR=../app
}

@test "1. can run our script" {
      export DEV_SUITES_DIR=../test_data
    run ../app/matchGitWorktrees
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
   [ "${#lines[@]}" > 0 ]
  echo "# output:">&3
  echo "$output" >&3

}

@test "2. Run With Test Data " {
    export DEV_SUITES_DIR=../test_data

    run ../app/matchGitWorktrees
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output:">&3
  echo "$output" >&3

    [ ${#lines[@]} -eq 4 ]
    [ "${lines[0]#*test_data}" == "/wwww/worktrees/wwww.next" ]
    [ "${lines[1]#*test_data}" == "/wxyz/worktrees/wxyz.next" ]
    [ "${lines[2]#*test_data}" == "/wxyz/worktrees/yyyy.tickets.1234" ]
    [ "${lines[3]#*test_data}" == "/yyyy/worktrees/yyyy.next" ]

}

@test "3. Run With Suite Named wxy " {
    export DEV_SUITES_DIR=../test_data
    export TEST_TEST_TEST="This was set in the test script before run"
    run ../app/matchGitWorktrees wxy
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output:">&3
  echo "$output" >&3

        [ ${#lines[@]} -eq 1 ]
  [ "${lines[0]#*test_data}" == "/wxyz/worktrees/wxyz.next" ]
}
@test "3a. Run With Suite Named yyyy " {
    export DEV_SUITES_DIR=../test_data
    export TEST_TEST_TEST="This was set in the test script before run"
    run ../app/matchGitWorktrees yyyy
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output:">&3
  echo "$output" >&3

        [ ${#lines[@]} -eq 2 ]
  [ "${lines[0]#*test_data}" == "/wxyz/worktrees/yyyy.tickets.1234" ]
  [ "${lines[1]#*test_data}" == "/yyyy/worktrees/yyyy.next"
/work/suites/dev0/worktrees/dev0.next/test_data/wxyz/worktrees/yyyy.tickets.1234
}
@test "4. Run With Suite Abbreviation  x " {
    export DEV_SUITES_DIR=../test_data

    run ../app/matchGitWorktrees x
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output:">&3
  echo "$output" >&3

        [ ${#lines[@]} -eq 2 ]
        [ "${lines[0]#*test_data}" == "test_data/wxyz/worktrees/wxyz.next" ]
        [ "${lines[1]#*test_data}" == "test_data/wxyz/worktrees/yyyy.next" ]

}

@test "5. Run With Suite Abbreviation  wxyz " {
    export DEV_SUITES_DIR=../test_data
    run ../app/matchGitWorktrees wxyz
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output:">&3
  echo "$output" >&3

        [ "${lines[0]#*test_data}" == "test_data/wxyz/worktrees/wxyz.next" ]
        [ "${lines[1]#*test_data}" == "test_data/wxyz/worktrees/yyyy.next" ]

}
@test "6. Run With Unknown Suite Abbreviation  zzzz " {
    export DEV_SUITES_DIR=../test_data

    run ../app/matchGitWorktrees zzzz
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output:">&3
  echo "$output" >&3

      [ ${#lines[1]} -eq 0 ]

}

@test "7. one specific git: wxyz.git wxyz wxyz " {
    export DEV_SUITES_DIR=../test_data

    run ../app/matchGitWorktrees  wxyz yyyy
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output:">&3
  echo "$output" >&3

     [ ${#lines[@]} -eq 1 ]
        [ "${lines[0]#*test_data}" == "test_data/wxyz/worktrees/yyyy.next" ]
}


@test "8. non-existent git: wxyz.git wxyz zzzz " {
    export DEV_SUITES_DIR=../test_data

    run ../app/matchGitWorktrees  wxyz zzzz
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output:">&3
  echo "$output" >&3

     [ ${#lines[@]} -eq 0 ]

}
@test "9. Suite blank, git reference only" {
  export DEV_SUITES_DIR=../test_data
  run ../app/matchGitWorktrees ""  next
  i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo "${lines[$i]}"
    ((i=i+1))
  done
  echo "# output:">&3
  echo "$output" >&3

     [ ${#lines[@]} -eq 4 ]
     [ "${lines[0]#*test_data}" == "/wwww/worktrees/wwww.next" ]
     [ "${lines[1]#*test_data}" == "/wxyz/worktrees/wxyz.next" ]
     [ "${lines[2]#*test_data}" == "/wxyz/worktrees/yyyy.tickets.1234" ]
     [ "${lines[3]#*test_data}" == "/yyyy/worktrees/yyyy.next" ]
}
#!/usr/bin/env bats
#  SPDX-FileName: test_matchGitRepositories.bats
#  SPDX-FileComment: Template bash script
#  SPDX-FileCopyrightText: Copyright (C) 2024 Patrick Callahan
#  SPDX-License-Identifier: GPL-2.0-or-later

# Usage
# cd testing;  bats test_bashScript.bats

#bats_require_minimum_version 1.5.0
setup_file() {
Fake=""
}

@test "1. can run our script" {
    run ../app/matchGitRepositories
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
   [ "${#lines[@]}" > 0 ]
  echo "# output: $output" >&3
}

@test "2. Run With Test Data " {
    export DEV_SUITES_PATH=../test_data
    run ../app/matchGitRepositories
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
          [ ${#lines[@]} -eq 4 ]
    [ "${lines[0]}" == "../test_data/wwww/repositories/wwww.git" ]
    [ "${lines[1]}" == "../test_data/wxyz/repositories/wxyz.git" ]
    [ "${lines[2]}" == "../test_data/wxyz/repositories/yyyy.git" ]
    [ "${lines[3]}" == "../test_data/yyyy/repositories/yyyy.git" ]
}



@test "3. Run With Suite Named wxy " {
    export DEV_SUITES_PATH=../test_data
    export TEST_TEST_TEST="This was set in the test script before run"
    run ../app/matchGitRepositories wxy
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
        [ ${#lines[@]} -eq 2 ]
        [ "${lines[0]}" == "../test_data/wxyz/repositories/wxyz.git" ]
        [ "${lines[1]}" == "../test_data/wxyz/repositories/yyyy.git" ]
}
@test "4. Run With Suite Abbreviation  x " {
    export DEV_SUITES_PATH=../test_data

    run ../app/matchGitRepositories x
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
        [ ${#lines[@]} -eq 2 ]
        [ "${lines[0]}" == "../test_data/wxyz/repositories/wxyz.git" ]
        [ "${lines[1]}" == "../test_data/wxyz/repositories/yyyy.git" ]

}
@test "5. Run With Suite Abbreviation  wxyz " {
    export DEV_SUITES_PATH=../test_data
    run ../app/matchGitRepositories wxyz
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
        [ "${lines[0]}" == "../test_data/wxyz/repositories/wxyz.git" ]
        [ "${lines[1]}" == "../test_data/wxyz/repositories/yyyy.git" ]

}
@test "6. Run With Unknown Suite Abbreviation  zzzz " {
    export DEV_SUITES_PATH=../test_data

    run ../app/matchGitRepositories zzzz
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
      [ ${#lines[1]} -eq 0 ]

}

@test "7. one specific git: wxyz.git wxyz wxyz " {
    export DEV_SUITES_PATH=../test_data

    run ../app/matchGitRepositories  wxyz yyyy
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
     [ ${#lines[@]} -eq 1 ]
        [ "${lines[0]}" == "../test_data/wxyz/repositories/yyyy.git" ]
}


@test "8. non-existent git: wxyz.git wxyz zzzz " {
    export DEV_SUITES_PATH=../test_data

    run ../app/matchGitRepositories  wxyz zzzz
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
     [ ${#lines[@]} -eq 0 ]

}
@test "9. git name only" {
    export DEV_SUITES_PATH=../test_data

    run ../app/matchGitRepositories ""  yyyy
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3

     [ ${#lines[@]} -eq 2 ]
     [ "${lines[0]}" == "../test_data/wxyz/repositories/yyyy.git" ]
     [ "${lines[1]}" == "../test_data/yyyy/repositories/yyyy.git" ]
}
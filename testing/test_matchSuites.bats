#!/usr/bin/env bats
#  SPDX-FileName: test_matchSuites.bats
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
    run ../app/matchSuites
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
   [ "${#lines[0]}" > 0 ]
  echo "# output: $output" >&3

}


@test "2. test env var " {

    export TEST_TEST_TEST="This was set in the test script before run"
    run ../app/matchSuites
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
     [ "${lines[0]}" == "/work/suites/bashTemplate" ]

}


@test "3. Run With Test Data " {
    export DEV_SUITES_DIR=../test_data
    export TEST_TEST_TEST="This was set in the test script before run"
    run ../app/matchSuites
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
     [ "${lines[0]}" == "../test_data/dev0" ]

}



@test "4. Run With Suite Named w " {
    export DEV_SUITES_DIR=../test_data
    export TEST_TEST_TEST="This was set in the test script before run"
    run ../app/matchSuites w
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
     [ "${lines[0]}" == "../test_data/wwww" ]
     [ "${lines[1]}" == "../test_data/wxyz" ]

}
@test "4. Run With Suite Abbreviation  x " {
    export DEV_SUITES_DIR=../test_data
    export TEST_TEST_TEST="This was set in the test script before run"
    run ../app/matchSuites x
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
     [ "${lines[0]}" == "../test_data/wxyz" ]

}
@test "5. Run With Suite Abbreviation  wxyz " {
    export DEV_SUITES_DIR=../test_data
    export TEST_TEST_TEST="This was set in the test script before run"
    run ../app/matchSuites wxyz
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
     [ "${lines[0]}" == "../test_data/wxyz" ]

}
@test "6. Run With Unknown Suite Abbreviation  zzzz " {
    export DEV_SUITES_DIR=../test_data
    export TEST_TEST_TEST="This was set in the test script before run"
    run ../app/matchSuites zzzz
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
     [ ${#lines[0]} -eq 0 ]

}
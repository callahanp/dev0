#!/usr/bin/env bats
#  SPDX-FileName: bashScript
#  SPDX-FileComment: Template bash script
#  SPDX-FileCopyrightText: Copyright (C) 2024 Patrick Callahan
#  SPDX-License-Identifier: GPL-2.0-or-later

# Usage
# cd testing;  bats test_bashScript.bats

#bats_require_minimum_version 1.5.0
setup_file() {
echo "in setup_file"
}

@test "1. can run our script" {
    run ../app/bashScript
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
   [ "${lines[0]}" == 'Environment variable $TEST_TEST_TEST:' ]
  echo "# output: $output" >&3

}


@test "2. test env var " {

    export TEST_TEST_TEST="This was set in the test script before run"
    run ../app/bashScript
      i=0
  while [ $i -lt ${#lines[@]} ]; do
    echo --${lines[$i]}--
    ((i=i+1))
  done
  echo "# output: $output" >&3
     [ "${lines[0]}" == 'Environment variable $TEST_TEST_TEST: This was set in the test script before run' ]

}


BATS
=
To copy the translated, or preprocessed, test file (save a copy)

    teardown() {
      dbg_save_source './bats-test.src'
    }

Globals:

    BATS_TEST_SOURCE

Arguments:

    $1 - [=./bats.$$.src] destination file/directory

Returns:

    #   none
    dbg_save_source() {
      local -r dest="${1:-.}"
      # --reflink is not a valid argument on macOS
      cp --reflink=auto "$BATS_TEST_SOURCE" "$dest"
    }

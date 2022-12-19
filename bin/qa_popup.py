# append the text "foo" to the file specified by the first argument
import sys

with open(sys.argv[1], "a") as f:
    f.write("foo")

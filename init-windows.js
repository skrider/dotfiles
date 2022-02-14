const {symlink_dir_contents} = require("./utils");
const {join} = require("path");

const HOME = process.cwd();

symlink_dir_contents(join(process.cwd(), "windows-home"), HOME);

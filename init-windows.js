const {symlink_dir_contents} = require("./utils");
const {join} = require("path");
const os = require("os");

const HOME = os.homedir();

symlink_dir_contents(join(process.cwd(), "shared"), HOME);
symlink_dir_contents(join(process.cwd(), "windows"), HOME);

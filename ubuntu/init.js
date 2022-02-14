const {symlink_dir_contents} = require("../utils")
const {join, resolve} = require("path")
const os = require("os");

const HOME = os.homedir();

symlink_dir_contents(join(process.cwd(), "config"), HOME);
symlink_dir_contents(resolve(process.cwd(), "..", "shared", "config"), HOME);

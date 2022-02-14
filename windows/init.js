const {symlink_dir_contents, symlink_dir_or_file} = require("../utils");
const {join, resolve} = require("path");
const os = require("os");

const HOME = os.homedir();

symlink_dir_contents(resolve(process.cwd(), "..", "shared", "config"), HOME);
symlink_dir_contents(join(process.cwd(), "config"), HOME);
symlink_dir_or_file(join(process.cwd(), "bin"), "C:\\Users\\steph\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\Startup", "startup.cmd");
symlink_dir_or_file(join(process.cwd(), "bin"), "C:\\Users\\steph\\Documents\\WindowsPowerShell", "Microsoft.PowerShell_profile.ps1");

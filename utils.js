const {symlinkSync, statSync, rmSync, rmdirSync} = require("fs");
const {opendir} = require('fs/promises');
const {join} = require('path');

const symlink_dir_contents = async (from, to) => {
  try {
    const dir = await opendir(from);
    for await (const dirent of dir) {
      const to_path = join(to, dirent.name);
      const from_path = join(dir.path, dirent.name);
      
      if (dirent.isFile()) {
        try {
          rmSync(to_path);
          console.log(`updating file ${to_path}`);
        } catch (e) {
          console.log(`creating file ${to_path}`);
        }
        symlinkSync(from_path, to_path, "file");
      } else if (dirent.isDirectory()) {
        try {
          rmdirSync(to_path);
          console.log(`updating dir ${to_path}`);
        } catch (e) {
          console.log(`creating dir ${to_path}`);
        }
        symlinkSync(from_path, to_path, "dir");
      }
    }
  } catch (err) {
    console.error(err);
  }
}

module.exports = {
  symlink_dir_contents
}

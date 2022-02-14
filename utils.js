const {opendirSync, symlinkSync, rmSync, rmdirSync} = require("fs");
const {join} = require('path');
const os = require('os');

const symlink_dir_contents = async (from, to, mode = "windows") => {
  try {
    const dir = opendirSync(from);
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
              if (mode == "windows") {
                  rmdirSync(to_path);
              } else {
                  rmSync(to_path);
              }
          console.log(`updating dir ${to_path}`);
        } catch (e) {
          console.log(`creating dir ${to_path}`);
        }
          try {
              symlinkSync(from_path, to_path, "dir");
          } catch (e) {
              console.log(`failed to create dir ${to_path}`);
          }
      }
    }
  } catch (err) {
    console.error(err);
  }
}

module.exports = {
  symlink_dir_contents
}

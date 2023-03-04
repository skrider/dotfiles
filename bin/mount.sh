#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

# this script decrypts a tar archive, mounts it to a temporary file system, allows the user
# to make some changes, and then saves and re-encrypts the file.

# if ARCHIVE_FILE does not end with EXT, exit with error and show help
if [[ ! $1 =~ .tar.gz.gpg$ ]]; then
  echo "Usage: $1 <archive file>"
  exit 1
fi

archive_file=$1
archive_file_name=$(basename $archive_file .tar.gz.gpg)

# make a backup of the archive file
cp $archive_file /tmp/$archive_file_name.tar.gz.gpg.bak

# read in the user's password
# read -s -p "Enter password: " PASSWORD

mount_point=/tmp/$archive_file_name
sudo mkdir -p $mount_point
# mount a temporary file system
sudo mount -t tmpfs -o size=1024m $archive_file_name /tmp/$archive_file_name
sudo chmod 777 $mount_point

# decrypt and extract archive
gpg --decrypt "$archive_file" \
  | sudo tar --verbose --extract --gunzip --file - -C $mount_point

# start an interactive bash session in a pandoc/latex docker container with the mount point as working directory
docker run --rm -it \
  -v $mount_point:/$archive_file_name \
  -w /$archive_file_name \
  --entrypoint /bin/bash \
  pandoc/latex:latest-ubuntu

# save the changes to the archive and re-encrypt
tar --verbose --create --gzip --overwrite --file - --directory $mount_point . \
  | gpg --symmetric --output $archive_file --cipher-algo AES256 $archive_file_name.tar.gz

# unmount the temporary file system
sudo umount $mount_point

# remove the mount point
sudo rmdir $mount_point

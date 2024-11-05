$ = normal user
# = root user

whoami = it gives current user name

command1;command2  `;` type more than one command on a single line

date = gives current date

file hello.txt displays what type of file it is

cat hello.txt  viewing content of files

head,tail,wc

tab completion

continuinng log command in another line \

history command line history

!number command expands to the command matching the number specified.

!! repeat the previous command

!string command expands to the most recent command that begins with the string specified.

`editing command line`

^+a = jump to beginning of the command
^+e = jump to end of the command
^+u = Clear from the cursor to the beginning of the command line
^+k = Clear from the cursor to the end of the command line
^+< = Jump to the beginning of the previous word on the command line
^+> = Jump to the end of the next word on the command line
^+r = Search the history list of commands for a pattern

`LFS`
In Linux files was orgnized in fs structure

\      = root of the file system
\home  = home directory of normal user
\boot  = Files needed in order to start the boot process.
\root  = home directory of root user
\etc   = Configuration files specific to this system
\bin   = normal user commands
\sbin  = root user commands
\var   = log files of the system
\usr   = user related executables
\tmp   = temporary files[only avialble for session means system reboot all the data in /tmp gone]
\dev   = Contains special device files that are used by the system to access hardware


pwd,ls,cd,cd-,cd~,mkdir,cp,mv,rm,rmdir,mkdir -p

An **inode** (Index Node) is a data structure in a Unix-like file system that stores metadata about a file or directory. Each file and directory has an associated inode.


### Key Points About Inodes
1. **Stored Information**: An inode contains metadata about a file, such as:
   - File type (e.g., regular file, directory, symbolic link)
   - File size
   - Owner (user ID) and group (group ID)
   - Permissions (read, write, execute)
   - Timestamps (created, modified, accessed)
   - Number of hard links
   - Location of data blocks on the disk

2. **Does Not Store**: An inode does **not** contain the file name or the data/content of the file. The file name is stored in a directory structure that maps the file name to the corresponding inode number.

3. **Inode Number**: Each inode has a unique number within a file system. The file system uses this number to keep track of files and directories.

4. **Link Between Names and Inodes**: When you list a directory (using `ls -i`), you can see the inode number associated with each file. The file system uses the directory structure to map file names to inode numbers.

### Example
To view the inode number of a file:
```bash
ls -i filename
```

### Why Inodes Are Important
1. **File System Operations**: Inodes are fundamental to how the file system manages and locates files. Operations like reading, writing, and modifying files rely on inodes.
2. **Hard Links**: Hard links point directly to an inode, meaning multiple filenames can refer to the same underlying data blocks using the same inode.
3. **Inode Limit**: Every file system has a limited number of inodes. If you run out of inodes, you cannot create new files, even if there is available disk space.

It is possible to create multiple names that point to the same file. There are two ways to do this: by
creating a hard link to the file, or by creating a soft link

`HardLink`
- Every file comes with one hard link
- When you create new hardlink to original file even it acts as original file
  ln <name> <originalfile>

- Both link file and original reference same inode in the fs
- even if you delete it won't effect on link file

- Hard links are only used for regular files
- You can't hard links across the partitions

`SoftLink`

- You can create soft link for folders and existing file
- Soft link is a not a regular file it is special type of file

- original file or folder and soft link have different inodes

- If original file or folder or deleted there is not use of softlink

- Able to create soft links across the fs

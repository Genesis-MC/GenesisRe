# Genesis Re

## Prerequisits

Since this project is using beet/bolt, you need to install a few things:
1. Download and install [python](https://www.python.org)
2. Open any terminal, to do this you can press `windows key` + `r` and type `cmd`
    - In the terminal type the following to install the required packages:
    ```
    pip install --upgrade beet mecha bolt ps_beet_bolt
    ```

## Set up the project

1. Create a new Minecraft world, remember the name
2. Clone this repository (The following will explain one way to do that, feel free to use your prefered way)
    - Click the green `[<> Code ▼]` button above the files
    - Make sure to be on the `HTTP` section and press the copy button next to the url
    - Open a terminal an navigate to any folder where this repository should be in (`C:/Users/username/git` is commonly used)
    - Type `git clone <url>` where `<url>` is the url you just copied and press enter
3. Move into the repository you just cloned using `cd GenesisReDatapack`
4. Type `beet link "<world name>"` where `<world name>` is the name of the Minecraft world you created earlier

## Build the project

1. Open the project in VSCode (preferably)
2. Open a terminal if none is open yet (`Terminal` > `New Terminal`)
3. Run `beet`

If you make any changes in the code, save and run `beet` in the terminal again, then `/reload` or `F3 + T` in your minecraft world, depending on what you changed.

## Publish your changes

When opening the project, it's best to get all changes that others uploaded:
1. If you have any local changes, stash them using `git stash`
2. Pull remote changes using `git pull`
3. If you stashed any local changes, you can apply them again using `git stash apply`

If you have changed anything and want to upload it, you generally follow these steps:
1. Check all changed files using `git status`
2. Add all changes using `git add .` (Instead of `.` you can also write parts of or full paths to only add specific files)
3. Commit the changes using `git commit -m "<message>"` where `<message>` is a short message describing the change you made
4. Push using `git push`
    - If pushing fails, make sure you have all remote changes using `git pull`

Generally it's better to commit/push often so merge conflicts (multiple people modfying the same file) is less common.

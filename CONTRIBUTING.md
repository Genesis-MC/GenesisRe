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

## (Naming-) Conventions

- Choose a longer name if it's more descriptive:
    - :white_check_mark: `genesis.crafter`, `.entity_is_found`
    - :x: `gen.crftr`, `.bool`
- Namespace: `genesis`
    - Anything related to genesis uses the `genesis` namespace
    - The `minecraft` namespace is only used when necessary (`#minecraft:load`)
    - Other namespaces may be used by libraries
- Load/tick functions: `genesis:load`,`genesis:tick`
    - If you want to add something to the load function (like a new objective), use the following in your module:
        ```mcfunction
        append function genesis:load:
            scoreboard objectives add ...
        ```
    - Same with the 20hz tick function:
        ```mcfunction
        append function genesis:tick:
            as @e[type=...,tag=...] function genesis:<module>/tick
        ```
- Scoreboards: `genesis.<module>.<name>`
    - ex. `genesis.stat.attack_speed.mainhand`, `genesis.mana.current`
    - Temporary scores can use `genesis`
- Fake Players: `.<name>` or `#<name>`
    - ex. `.cooldown`, `.new`, `#denominator`
    - Use `#` to prefix temporary scores, like when calculating
    - Constants use `constant(<constant>)` from `genesis:utils` module
        ```mcfunction
        from genesis:utils import constant
        scoreboard players operation @s scoreboard /= constant(123) genesis
        ```
- Tags: `genesis.<module>.<name>`
    - ex. `genesis.crafter`
- Language Keys: `<category>.genesis.<name>`
    - ex. `category_modifier.genesis.void`, `item.genesis.ethereal_chestplate.steadfast.0`
    - For translations that don't really have a category, use `text` as the category
    - If language keys are directly linked to each other, simply extend them:
        - `<category>.genesis.<name>.<passive_name>.<line>` -> `item.genesis.ethereal_chestplate.steadfast.0`
- Source Files: `src/[data|assets]/<genesis>/<file_type>/<module>`
    - ex. `src/data/function/right_click_ability.mcfunction`, `src/data/function/stat.mcfunction`
    - Use `src/data/modules/<module>.bolt` for stuff that is mostly python
    - Use `src/data/function/<module>.mcfunction` for stuff that is mostly actual functions
    - If you need more than a single file per module, create a subfolder
- Generated Files: `build/...`
    - Every generated file has an explicit, descriptive name
        - :white_check_mark: `as @a if score x y matches 12 function ~/../score_matches_12:`
        - :x: `as @a if score x y matches 12:`
    - If this is not explicitly done, bolt generates names like `nested_execute_0`
    - To make sure, just look at the `build` folder from time to time

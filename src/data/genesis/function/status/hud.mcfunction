from genesis:player import PerPlayerStorage


function ~/update_icons:
    with PerPlayerStorage():
        execute function ~/../update_icons_wrapped:
            # return early if no icon is to be displayed
            unless entity @s[tag=genesis.status.category.has_icon] return run data modify storage genesis:player self.hud[1] set value [""]
            # set up storage
            data modify storage genesis:player self.hud[1] set value [[{
                text: "+",
                font: "genesis:hud/status",
                shadow_color: 0,
            }],[],[],["-"]]
            # add icon for each applied status
            function ~/../update_icons_for_each


#! add cooldown hud part

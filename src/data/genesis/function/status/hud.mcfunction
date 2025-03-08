from genesis:player import PerPlayerStorage


function ~/update_icons:
    with PerPlayerStorage():
        execute function ~/../update_icons_wrapped:
            # return early if no icon is to be displayed
            unless score @s genesis.status.has_icon matches 1.. return run data modify storage genesis:player self.hud[1] set value [""]
            # set up storage
            data modify storage genesis:player self.hud[1] set value [[{
                text: "+",
                font: "genesis:hud/status",
                shadow_color: 0,
            }],[],[],["-"]]
            # add icon for each applied status
            function ~/../update_icons_for_each


function ~/update_cooldown:
    with PerPlayerStorage():
        execute function ~/../update_cooldown_wrapped:
            # return early if no cooldown is to be displayed
            unless score @s genesis.status.has_visual_cooldown matches 1.. data modify storage genesis:player self.hud[2] set value [""]
            unless score @s genesis.status.has_visual_cooldown matches 1.. return run scoreboard players reset @s genesis.status.has_visual_cooldown
            # set up storage
            data modify storage genesis:player self.hud[2] set value [[{
                text: "+",
                font: "genesis:hud/status",
                shadow_color: 0,
            }],[],[],["-"]]
            # add icon for each applied status
            function ~/../update_cooldown_for_each

append function genesis:tick:
    as @a[scores={genesis.status.has_visual_cooldown=0..}] function genesis:status/hud/update_cooldown

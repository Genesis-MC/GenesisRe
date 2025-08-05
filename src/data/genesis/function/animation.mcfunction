from genesis:utils import constant
from ps_beet_bolt.bolt_item import event_decorator


def baked_animation(ticks: int, loop: bool = False, on_end_kill: bool = False):
    def decorator(func):
        this_tag = f'genesis.animation.{func.__name__}'
        this_path = f'genesis:animation/baked/{func.__name__}/_root'
        this_stop = f'genesis:animation/baked/{func.__name__}/_stop'

        tag @s add genesis.animation
        tag @s add (this_tag)
        scoreboard players set @s genesis.animation.time -1

        append function genesis:animation/tick:
            if entity @s[tag=(this_tag)] function (this_path)

        function (this_path):
            if loop:
                scoreboard players operation @s genesis.animation.time %= constant(ticks) genesis
            else:
                if score @s genesis.animation.time matches (ticks, None) return run function (this_stop)
            for t in range(ticks):
                if score @s genesis.animation.time matches (t) return run function ~/../frame_{t}:
                    func(t, this_stop)

        function (this_stop):
            if on_end_kill:
                kill @s
            else:
                tag @s remove genesis.animation
                tag @s remove (this_tag)
                scoreboard players reset @s genesis.animation.time

        return func
    return decorator


append function genesis:tick:
    as @e[type=#genesis:animation,tag=genesis.animation] at @s function genesis:animation/tick:
        scoreboard players add @s genesis.animation.time 1


append function genesis:load:
    scoreboard objectives add genesis.animation.time dummy


entity_type_tag genesis:animation {
    "values": [
        "marker",
        "item_display",
    ]
}


append function genesis:load:
    scoreboard objectives add genesis.animation.using_item dummy
    scoreboard objectives add genesis.animation.using_item_last dummy

append function genesis:player/tick:
    if score @s genesis.animation.using_item matches 1.. scoreboard players add @s genesis.animation.using_item_last 1
    if score @s genesis.animation.using_item matches 1.. unless score @s genesis.animation.using_item = @s genesis.animation.using_item_last function genesis:animation/using_item/reset:
        scoreboard players reset @s genesis.animation.using_item
        scoreboard players reset @s genesis.animation.using_item_last

def using_item_baked_animation(ticks: int, loop: bool = False):
    @event_decorator
    def decorator(func, item):
        adv_path = f'genesis:bolt-item/item/{item.id}/using_item_baked_animation/{func.__name__}'
        advancement adv_path {
            "criteria": { "criteria": {
                "trigger": "minecraft:using_item",
                "conditions": { "item": {
                    "items": item.base_item,
                    "predicates": { "minecraft:custom_data": { "bolt-item": { "id": f'genesis:{item.id}' }}}
                    }
                }}
            },
            "rewards": { "function": adv_path }
        }

        function adv_path:
            advancement revoke @s only ~/
            if loop:
                scoreboard players operation @s genesis.animation.time %= constant(ticks) genesis
            scoreboard players add @s genesis.animation.using_item 1
            for t in range(ticks):
                if score @s genesis.animation.using_item matches (t+1) return run function ~/frame_{t}: # -1 so the baked animation starts at 0
                    func(t)

        return func
    return decorator

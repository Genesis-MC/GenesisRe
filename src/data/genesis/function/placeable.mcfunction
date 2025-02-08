from ps_beet_bolt.bolt_item import event_decorator


@event_decorator
def on_place(func, item):
    path = f'{item.namespace}:bolt-item/item/{item.id}/on_place/{func.__name__}'
    item.merge(
        "custom_data",
        {"genesis": {"placeable": {"command": f'function {path}'}}}
    )
    function path:
        func()


advancement ~/place {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:item_used_on_block",
            "conditions": {
                "location": [
                    {
                        "condition": "minecraft:match_tool",
                        "predicate": {
                            "items": "minecraft:player_head",
                            "predicates": {
                                "minecraft:custom_data": {
                                    "genesis": {
                                        "placeable": {}
                                    }
                                }
                            }
                        }
                    }
                ]
            }
        }
    },
    "rewards": {
        "function": "genesis:placeable/place"
    }
}

function ~/place:
    advancement revoke @s only ~/

    for dx in range(-7, 8):
        for dy in range(-5, 8):
            for dz in range(-7, 8):
                positioned ~dx ~dy ~dz if block ~ ~ ~ #genesis:player_head if data block ~ ~ ~ components.minecraft:custom_data.genesis.placeable align xyz positioned ~.5 ~ ~.5 return run function ~/../place_here_macro with block ~ ~ ~ components.minecraft:custom_data.genesis.placeable

function ~/place_here_macro:
    $$(command)

block_tag genesis:player_head {
    "values": [
        "minecraft:player_head",
        "minecraft:player_wall_head",
    ]
}

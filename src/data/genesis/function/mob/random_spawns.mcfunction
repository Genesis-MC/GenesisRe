from genesis:mob/test import Pirate, Angel, VerdantZombie, UndeadMiner
from genesis:utils import chance_predicate


def custom_spawn(type: str, chance: float, entries: list[tuple[type,int,list[str]]]):
    append function genesis:tick:
        as @e[type=(type),tag=!genesis.mob.checked,tag=!smithed.entity,tag=!smithed.ignore] at @s function f'genesis:mob/random_spawns/{type}/check':
            tag @s add genesis.mob.checked
            unless predicate chance_predicate(chance) return fail

            scoreboard players set #total_weight genesis 0
            for mob, weight, conditions in entries:
                entry_path = f'genesis:mob/random_spawns/{type}/include/{mob.id}'
                command = 'execute '
                for condition in conditions:
                    if not condition.startswith('unless ') and not condition.startswith('if '):
                        condition = 'if ' + condition
                    command += condition
                command += ' run function ' + entry_path
                raw (command)

                function entry_path:
                    tag @s add f'genesis.mob.include.{mob.id}'
                    scoreboard players add #total_weight genesis (weight)

            store result storage genesis:temp 'mob'.random_spawns.rng.max int 1 scoreboard players get #total_weight genesis
            execute function ~/../rng_macro with storage genesis:temp 'mob'.random_spawns.rng:
                $execute store result score #rng genesis run random value 1..$(max)

            for mob, weight, conditions in entries:
                if entity @s[tag=f'genesis.mob.include.{mob.id}'] if score #rng genesis matches (null, weight) return run function ~/../spawn/{mob.id}:
                    if ('minecraft:' + mob.base_entity.replace('minecraft:','')) == ('minecraft:' + type.replace('minecraft:','')):
                        data merge entity @s (mob.entity_data)
                    else:
                        tp ~ -1000 ~
                        kill @s
                        summon (mob.base_entity) ~ ~ ~ (mob.entity_data)
                if entity @s[tag=f'genesis.mob.include.{mob.id}'] scoreboard players remove #rng genesis (weight)
            data modify entity @s Tags set value ['genesis.mob.checked']


custom_spawn('zombie', 0.9, [
    (UndeadMiner, 500, ['block ~ ~ ~ snow']),
    (Pirate, 100, ['block ~ ~ ~ snow']),
])

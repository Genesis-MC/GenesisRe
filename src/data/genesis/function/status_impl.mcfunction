
from genesis:status import GenesisStatus, on_apply_status, on_remove_status, before_value_change_status, after_value_change_status, synced_tick_status, scheduled_tick_status
from genesis:mana import reduce_mana_or_return


class Frostbite(GenesisStatus):
    icon = 'genesis:font/status/frostbite'

    @after_value_change_status
    def try_frostbite_trigger(cls):
        if score @s (cls.value) matches 10.. at @s function ~/frostbite_trigger:
            playsound block.glass.break player @a ~ ~ ~ 1 1
            playsound entity.player.hurt_freeze player @a ~ ~ ~ 1 1
            execute anchored eyes run particle minecraft:block{block_state:"minecraft:ice"} ^ ^ ^ 0.6 0.5 0.6 0 40
            summon item_display ~ ~ ~ {Tags:["genesis.ability.persist_sec"],Rotation:[0F,90F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.2f,1.2f,0.01f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"genesis:ability/frostbite"}}}
            damage @s 8 minecraft:generic # by @a[tag=genesis.caster,limit=1] #! THIS IS POSSIBLE BUT NOT IMPLEMENTED (generate argon id, store that)
            effect give @s minecraft:slowness 2 4 true
            cls.remove()


class PolarVortex(GenesisStatus):
    icon = 'genesis:font/status/polar_vortex'
    permanent = True

    @scheduled_tick_status(10)
    def polar_vortex_proc(cls):
        unless function ~/activate:
            cls.remove()
        function ~/activate:
            reduce_mana_or_return(amount = 2000)

            positioned ~ ~0.1 ~ function genesis:utils/particles/circle_rad6 {particle:"snowflake", ydirection:1, speed:0.3} #! Probably bake particle animations for performance
            summon area_effect_cloud ~ ~-2 ~ {Tags:["genesis.ability.polar_vortex_particle"],custom_particle:{type:"block_crumble",block_state:"minecraft:ice"},Radius:2f,Duration:40}
            tag @s add genesis.caster
            as @e[distance=..6,tag=!genesis.caster,type=!#genesis:non_living] function ~/../polar_vortex_frostbite:
                if entity @s[tag=(Frostbite.tag)] function ~/../increase_frostbite:
                    Frostbite.modify_value('+=', 1)
                    Frostbite.modify_duration('=', 3 * 20)
                unless entity @s[tag=(Frostbite.tag)] function ~/../apply_frostbite:
                    Frostbite.apply(3 * 20, 1)

                anchored eyes particle minecraft:snowflake ^ ^ ^ 0.5 0.5 0.5 0 5
                effect give @s slowness 1 0 true
            tag @s remove genesis.caster
            execute return 1

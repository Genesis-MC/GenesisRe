
from genesis:status import GenesisStatus, on_apply_status, on_remove_status, before_value_change_status, after_value_change_status, synced_tick_status, scheduled_tick_status
from genesis:mana import reduce_mana_or_return


class Frostbite(GenesisStatus):
    icon = 'genesis:font/status/frostbite'
    initialized = []
    values = ['stacks', 'initiator']
    initiate_self = 'genesis:status/custom/frostbite/initiate_initiator_to_self'

    @after_value_change_status(['stacks'])
    def try_frostbite_trigger(Frostbite):
        unless score @s (Frostbite.stacks) matches 10.. at @s return 0

        playsound block.glass.break player @a ~ ~ ~ 1 1
        playsound entity.player.hurt_freeze player @a ~ ~ ~ 1 1
        execute anchored eyes run particle minecraft:block{block_state:"minecraft:ice"} ^ ^ ^ 0.6 0.5 0.6 0 40
        summon item_display ~ ~ ~ {Tags:["genesis.ability.persist_sec"],Rotation:[0F,90F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.2f,1.2f,0.01f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"genesis:ability/frostbite"}}}
        # If initiator is set -> damage as initiator : damage without source instead
        if score @s (Frostbite.initiator) matches -1 damage @s 8 minecraft:generic
        unless score @s (Frostbite.initiator) matches -1 scoreboard players operation #id argon.id = @s (Frostbite.initiator)
        unless score @s (Frostbite.initiator) matches -1 damage @s 8 minecraft:generic by @e[type=!#genesis:non_living,limit=1,predicate=argon:match_id]

        effect give @s minecraft:slowness 2 4 true
        Frostbite.remove()

    def add_stack(amount = 1):
        if amount not in Frostbite.initialized:
            Frostbite.initialized.append(amount)
            function f'genesis:status/custom/frostbite/apply_{amount}':
                if entity @s[tag=(Frostbite.tag)] return 0
                unless score #status.custom.frostbite.initiator genesis = #status.custom.frostbite.initiator genesis scoreboard players set #status.custom.frostbite.initiator genesis -1
                Frostbite.apply(5 * 20, stacks = amount, initiator = ('#status.custom.frostbite.initiator', 'genesis'))
                execute return 1
            function f'genesis:status/custom/frostbite/increase_{amount}':
                Frostbite.modify_duration('=', 5 * 20)
                Frostbite.modify_value('stacks', '+=', amount)
                if score #status.custom.frostbite.initiator genesis matches 1..65536 function ~/set_initiator:
                    Frostbite.modify_value('initiator', '=', ('#status.custom.frostbite.initiator', 'genesis'))
        # Try apply, if that fails increase.
        unless function f'genesis:status/custom/frostbite/apply_{amount}' function f'genesis:status/custom/frostbite/increase_{amount}'

    function genesis:status/custom/frostbite/initiate_initiator_to_self:
        # If @s doesn't have an argon id, give them one
        unless score @s argon.id = @s argon.id function argon:player_hurt_entity/setup/setup_id
        # set initiator to a temp variable
        scoreboard players operation #status.custom.frostbite.initiator genesis = @s argon.id


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
            function (Frostbite.initiate_self)
            as @e[distance=..6,tag=!genesis.caster,type=!#genesis:non_living] function ~/../polar_vortex_frostbite:
                Frostbite.add_stack()
                anchored eyes particle minecraft:snowflake ^ ^ ^ 0.5 0.5 0.5 0 5
                effect give @s slowness 1 0 true
            tag @s remove genesis.caster
            execute return 1

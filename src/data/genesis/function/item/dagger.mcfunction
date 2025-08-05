from genesis:utils import texture_path_to_item_model, constant
from genesis:right_click_ability import right_click_ability
from genesis:tungsten import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem
from genesis:mana import add_mana
from genesis:stat import modify_attribute_stat, remove_attribute_stat

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, Frostflake, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, FrozenWisp, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 
from genesis:status/main import Frostbite

# IronDagger
@add_custom_recipe([
    [None, None, "iron_ingot"],
    [None, "iron_ingot", None],
    ["stick", None, None],
])
class IronDagger(GenesisItem):
    item_name = ("Iron Dagger", {"color":"white"})
    rarity = "common"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":40,"attack_speed":175})

# Frostfang
@add_custom_recipe([
    [Frostflake, Frostflake, Frostflake],
    [Frostflake, WolfFang, Frostflake],
    [Frostflake, Frostflake, Frostflake],
])
class Frostfang(GenesisItem):
    item_name = ("Frostfang", {"color":"aqua"})
    rarity = "common"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":30,"attack_speed":175})
    passives = [{
            "name": "Frostbite",
            "description": "Striking an enemy grants them +1 Frostbite.",
        }]

    @on_attack(slot = 'mainhand')
    def frostbite():
        execute anchored eyes run particle minecraft:snowflake ^ ^ ^ 0.5 0.5 0.5 0 10
        on attacker function (Frostbite.initiate_self)
        Frostbite.add_stack()

# HarbingerOfWinter
@add_custom_recipe([
    [None, None, Frostfang],
    [None, Frostfang, None],
    [SteelHilt, None, None],
])
class HarbingerOfWinter(GenesisItem):
    item_name = ("Harbinger Of Winter", {"color":"aqua"})
    rarity = "uncommon"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":40,"attack_speed":200,"speed":30})
    passives = [{
            "name": "Frostbite",
            "description": "Striking an enemy grants them +1 Frostbite.",
        }]

    @on_attack(slot = 'mainhand')
    def frostbite():
        execute anchored eyes run particle minecraft:snowflake ^ ^ ^ 0.5 0.5 0.5 0 10
        on attacker function (Frostbite.initiate_self)
        Frostbite.add_stack()

# ShadedDagger
@add_custom_recipe([
    [ShadeFlux, ShadeFlux, ShadeFlux],
    [ShadeFlux, IronDagger, ShadeFlux],
    [ShadeFlux, ShadeFlux, ShadeFlux],
])
class ShadedDagger(GenesisItem):
    item_name = ("Shaded Dagger", {"color":"dark_purple"})
    rarity = "uncommon"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":50,"attack_speed":175,"speed":15})

# VoidRazor
@add_custom_recipe([
    [VoidedFragment, "crying_obsidian", VoidedFragment],
    [ShadedEnderPearl, ShadedDagger, ShadedEnderPearl],
    [VoidedFragment, "crying_obsidian", VoidedFragment],
])
class VoidRazor(GenesisItem):
    item_name = ("Void Razor", {"color":"dark_purple"})
    rarity = "rare"
    category = ["void", "dagger"]
    stats = ("mainhand", {"physical_power":57,"attack_speed":195,"speed":30})

# Vorpol
@add_custom_recipe([
    [ShardOfTheCrimsonAbyss, PyroclasticCore, ShardOfTheWarpedEmpyrean],
    [VoidedEnderPearl, VoidRazor, VoidedEnderPearl],
    [ShardOfTheWarpedEmpyrean, PyroclasticCore, ShardOfTheCrimsonAbyss],
])
class Vorpol(GenesisItem):
    item_name = ("Vorpol", {"color":"light_purple"})
    rarity = "legendary"
    category = ["void", "dagger"]
    stats = ("mainhand", {"physical_power":72,"attack_speed":175,"speed":100})
    passives = [{
        "name": "Time Dilation",
        "description": "Gain 35% of your Speed as Ability Haste.",
    }]

    @on_equip(slot = 'mainhand')
    def time_dilation_add():
        scoreboard players operation @s genesis.passive.time_dilation_statboost = @s genesis.stat.speed
        scoreboard players operation @s genesis.passive.time_dilation_statboost *= constant(35 * 2) genesis
        store result score #round genesis scoreboard players operation @s genesis.passive.time_dilation_statboost /= constant(100) genesis
        scoreboard players operation @s genesis.passive.time_dilation_statboost /= constant(2) genesis
        scoreboard players operation #round genesis %= constant(2) genesis
        scoreboard players operation @s genesis.passive.time_dilation_statboost += #round genesis
        scoreboard players operation @s genesis.stat.ability_haste += @s genesis.passive.time_dilation_statboost

    @on_unequip(slot = 'mainhand')
    def time_dilation_remove():
        scoreboard players operation @s genesis.stat.ability_haste -= @s genesis.passive.time_dilation_statboost
        scoreboard players reset @s genesis.passive.time_dilation_statboost

    @right_click_ability(
        name = "Voidslash",
        description = "Teleport up to 2 blocks ahead of you and deal 80 damage to the nearest enemy in a 5-block radius. Upon successfully hitting enemies with Voidslash 4 times, your next Voidslash will instead deal 80 damage to all enemies in a 5-block radius.",
        mana = 25,
        cooldown = 7,
    )
    def voidslash():
        tag @s add genesis.caster
        execute if score @s genesis.ability.voidslash_count matches 4.. run return run function ~/../voidslash_comboslash:
            function ~/../voidslash_tp
            execute at @s positioned ~ ~ ~-3 rotated 25 -50 run function genesis:utils/particles/line_len8 {particle:"witch", speed:0}
            execute at @s positioned ~4 ~4 ~-2 rotated 70 25 run function genesis:utils/particles/line_len8 {particle:"witch", speed:0}
            execute at @s positioned ~-5 ~4 ~3 rotated -90 30 run function genesis:utils/particles/line_len8 {particle:"witch", speed:0}
            execute at @s positioned ~-4 ~3 ~-3 rotated -45 20 run function genesis:utils/particles/line_len8 {particle:"witch", speed:0}
            execute at @s positioned ~3 ~5 ~4 rotated 160 40 run function genesis:utils/particles/line_len8 {particle:"witch", speed:0}
            execute as @e[distance=..5,tag=!genesis.player] run damage @s 8 minecraft:generic by @a[tag=genesis.caster,limit=1]
            scoreboard players reset @s genesis.ability.voidslash_count
        execute function ~/../voidslash_tp:
            execute anchored eyes if block ^ ^ ^2 #genesis:walk_through if block ^ ^ ^1 #genesis:walk_through run return run teleport @s ^ ^ ^2
            execute anchored eyes unless block ^ ^ ^2 #genesis:walk_through if block ^ ^ ^1 #genesis:walk_through run return run teleport @s ^ ^ ^1
        execute as @e[distance=..5,type=!#genesis:non_living,tag=!genesis.player,sort=nearest,limit=1] at @s function ~/../voidslash_hit:
            particle witch ^-1 ^ ^ 0 0 0 0 2
            particle witch ^-0.8 ^0.3 ^ 0 0 0 0 2
            particle witch ^-0.6 ^0.6 ^ 0 0 0 0 2
            particle witch ^-0.4 ^0.9 ^ 0 0 0 0 2
            particle witch ^-0.2 ^1.2 ^ 0 0 0 0 2
            particle witch ^ ^1.5 ^ 0 0 0 0 2
            particle witch ^0.2 ^1.8 ^ 0 0 0 0 2
            particle witch ^0.4 ^2.1 ^ 0 0 0 0 2
            particle witch ^0.6 ^2.4 ^ 0 0 0 0 2
            particle witch ^0.8 ^2.7 ^ 0 0 0 0 2
            particle witch ^1 ^3 ^ 0 0 0 0 2
            damage @s 8 minecraft:generic by @a[tag=genesis.caster,limit=1]
            execute on attacker run scoreboard players add @s genesis.ability.voidslash_count 1
        tag @s remove genesis.caster
        #playsound entity.generic.explode player @a ~ ~ ~ 1 1
        #playsound entity.ravager.hurt player @a ~ ~ ~ 1 0
        #execute anchored eyes function ~/../void_bellow_helper:
        #    particle minecraft:gust_emitter_small ^ ^-0.4 ^2 0.2 0.2 0.2 0 5
        #    particle minecraft:gust_emitter_small ^ ^-0.4 ^3.5 0.2 0.2 0.2 0 5
        #    particle minecraft:gust_emitter_small ^ ^-0.4 ^5 0.2 0.2 0.2 0 5
        #    particle minecraft:sonic_boom ^ ^-0.4 ^2 0.1 0.1 0.1 0 5
        #    particle minecraft:sonic_boom ^ ^-0.4 ^3.5 0.1 0.1 0.1 0 5
        #    particle minecraft:sonic_boom ^ ^-0.4 ^5 0.1 0.1 0.1 0 5
        #    particle minecraft:campfire_cosy_smoke ^ ^-1 ^3.5 0.3 0.3 0.3 0.3 10
        #    positioned ^ ^-0.5 ^1 as @e[distance=..1.5,tag=!genesis.player] run damage @s 8 minecraft:generic by @a[tag=genesis.caster,limit=1]
        #    positioned ^ ^-0.5 ^3 as @e[distance=..1.5,tag=!genesis.player] run damage @s 8 minecraft:generic by @a[tag=genesis.caster,limit=1]
        #    positioned ^ ^-0.5 ^5 as @e[distance=..1.5,tag=!genesis.player] run damage @s 8 minecraft:generic by @a[tag=genesis.caster,limit=1]


# Vescherum
@add_custom_recipe([
    [ShardOfTheCrimsonAbyss, LivingwoodCore, ShardOfTheCrimsonAbyss],
    [VoidedEnderPearl, VoidRazor, VoidedEnderPearl],
    [ShardOfTheCrimsonAbyss, LivingwoodCore, ShardOfTheCrimsonAbyss],
])
class Vescherum(GenesisItem):
    item_name = ("Vescherum", {"color":"light_purple"})
    rarity = "legendary"
    category = ["void", "dagger"]
    stats = ("mainhand", {"physical_power":50,"attack_speed":195,"armor_toughness":60,"speed":30})
    @right_click_ability(
        name = "Void Cage",
        description = "Summon a cage around you for 8 seconds which teleports enemies to its center when they walk beyond its area. When the cage expires, heal 1 heart for each enemy trapped inside.",
        mana = 60,
        cooldown = 20,
    )
    def void_cage():
        playsound entity.evoker.prepare_summon player @a ~ ~ ~ 1 0.5
        playsound block.portal.ambient player @a ~ ~ ~ 1 0
        summon interaction ~ ~ ~ {width:0f,height:0f,Tags:["genesis.ability.voidcage"],interaction:{player:[I;-470087286,1253655809,-1360091822,1632556642],timestamp:0L}}
        data modify entity @e[tag=genesis.ability.voidcage,sort=nearest,limit=1] interaction.player set from entity @s UUID
        summon item_display ~ ~0.5 ~5 {Tags:["genesis.ability.voidcage_flair"],Rotation:[0F,0F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/void_cage"}}}
        summon item_display ~-5 ~0.5 ~ {Tags:["genesis.ability.voidcage_flair"],Rotation:[90F,0F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/void_cage"}}}
        summon item_display ~ ~0.5 ~-5 {Tags:["genesis.ability.voidcage_flair"],Rotation:[180F,0F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/void_cage"}}}
        summon item_display ~5 ~0.5 ~ {Tags:["genesis.ability.voidcage_flair"],Rotation:[270F,0F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/void_cage"}}}
        summon item_display ~-3.53 ~0.5 ~3.53 {Tags:["genesis.ability.voidcage_flair"],Rotation:[45F,0F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/void_cage"}}}
        summon item_display ~-3.53 ~0.5 ~-3.53 {Tags:["genesis.ability.voidcage_flair"],Rotation:[135F,0F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/void_cage"}}}
        summon item_display ~3.53 ~0.5 ~-3.53 {Tags:["genesis.ability.voidcage_flair"],Rotation:[225F,0F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/void_cage"}}}
        summon item_display ~3.53 ~0.5 ~3.53 {Tags:["genesis.ability.voidcage_flair"],Rotation:[315F,0F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/void_cage"}}}
        

# Visharp
@add_custom_recipe([
    [ShardOfTheWarpedEmpyrean, EverfrostCore, ShardOfTheWarpedEmpyrean],
    [VoidedEnderPearl, VoidRazor, VoidedEnderPearl],
    [ShardOfTheWarpedEmpyrean, EverfrostCore, ShardOfTheWarpedEmpyrean],
])
class Visharp(GenesisItem):
    item_name = ("Visharp", {"color":"light_purple"})
    rarity = "legendary"
    category = ["void", "dagger"]
    stats = ("mainhand", {"physical_power":70,"attack_speed":195})
    @right_click_ability(
        name = "Voidrend",
        description = "Teleport up to 7 blocks ahead of you and deal 50% Physical Power to enemies in a 3-block radius from both your initial and landing position. Enemies hit will also be granted Slowness II for 2 seconds.",
        mana = 25,
        cooldown = 4,
    )
    def voidrend():
        tag @s add genesis.caster
        playsound entity.enderman.teleport player @a ~ ~ ~
        function genesis:utils/particles/transition_circle {particle:"reverse_portal", ydirection:0, speed:0.1}
        function genesis:utils/particles/transition_circle {particle:"reverse_portal", ydirection:0, speed:0.15}
        function genesis:utils/particles/transition_circle {particle:"reverse_portal", ydirection:0, speed:0.05}
        store result storage genesis:temp item.voidrend.damage float 0.05 scoreboard players get @s genesis.stat.physical_power
        # Damage @ starting position
        execute function ~/../voidrend_macro with storage genesis:temp item.voidrend:
            $execute as @e[distance=..3,tag=!genesis.player] run damage @s $(damage) minecraft:generic by @a[tag=genesis.caster,limit=1]
            execute as @e[distance=..3,tag=!genesis.player] run effect give @s slowness 2 1 true
        execute function ~/../voidrend_tp:
            execute anchored eyes if block ^ ^ ^7 #genesis:walk_through if block ^ ^ ^6 #genesis:walk_through if block ^ ^ ^5 #genesis:walk_through if block ^ ^ ^4 #genesis:walk_through if block ^ ^ ^3 #genesis:walk_through if block ^ ^ ^2 #genesis:walk_through if block ^ ^ ^1 #genesis:walk_through run return run teleport @s ^ ^ ^7
            execute anchored eyes unless block ^ ^ ^7 #genesis:walk_through if block ^ ^ ^6 #genesis:walk_through if block ^ ^ ^5 #genesis:walk_through if block ^ ^ ^4 #genesis:walk_through if block ^ ^ ^3 #genesis:walk_through if block ^ ^ ^2 #genesis:walk_through if block ^ ^ ^1 #genesis:walk_through run return run teleport @s ^ ^ ^6
            execute anchored eyes unless block ^ ^ ^6 #genesis:walk_through if block ^ ^ ^5 #genesis:walk_through if block ^ ^ ^4 #genesis:walk_through if block ^ ^ ^3 #genesis:walk_through if block ^ ^ ^2 #genesis:walk_through if block ^ ^ ^1 #genesis:walk_through run return run teleport @s ^ ^ ^5
            execute anchored eyes unless block ^ ^ ^5 #genesis:walk_through if block ^ ^ ^4 #genesis:walk_through if block ^ ^ ^3 #genesis:walk_through if block ^ ^ ^2 #genesis:walk_through if block ^ ^ ^1 #genesis:walk_through run return run teleport @s ^ ^ ^4
            execute anchored eyes unless block ^ ^ ^4 #genesis:walk_through if block ^ ^ ^3 #genesis:walk_through if block ^ ^ ^2 #genesis:walk_through if block ^ ^ ^1 #genesis:walk_through run return run teleport @s ^ ^ ^3
            execute anchored eyes unless block ^ ^ ^3 #genesis:walk_through if block ^ ^ ^2 #genesis:walk_through if block ^ ^ ^1 #genesis:walk_through run return run teleport @s ^ ^ ^2
            execute anchored eyes unless block ^ ^ ^2 #genesis:walk_through if block ^ ^ ^1 #genesis:walk_through run return run teleport @s ^ ^ ^1
        execute at @s positioned ~ ~-1 ~ function ~/../voidrend_land:
            function genesis:utils/particles/transition_circle {particle:"portal", ydirection:0, speed:1}
            function genesis:utils/particles/transition_circle {particle:"portal", ydirection:0, speed:1.2}
            function genesis:utils/particles/transition_circle {particle:"portal", ydirection:0, speed:0.8}
            # Damage @ landing position
            execute function ~/../voidrend_macro with storage genesis:temp item.voidrend
        tag @s remove genesis.caster

# Hook
class Hook(GenesisItem):
    item_name = ("Hook", {"color":"white"})
    rarity = "common"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":46,"attack_speed":195})
    item_model = "genesis:dagger/hook"

# GoldenHook
class GoldenHook(GenesisItem):
    item_name = ("Golden Hook", {"color":"gold"})
    rarity = "rare"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":30,"attack_speed":230})
    item_model = "genesis:dagger/golden_hook"

# VermillionGlove
class VermillionGlove(GenesisItem):
    item_name = ("Vermillion Glove", {"color":"dark_red"})
    rarity = "uncommon"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":50,"attack_speed":185})

# CrystalMoon
class CrystalMoon(GenesisItem):
    item_name = ("Crystal Moon", {"color":"white"})
    rarity = "rare"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":60,"attack_speed":175,"armor_toughness":-20,"mana_regen":50})

# PrismDagger
class PrismDagger(GenesisItem):
    item_name = ("Prism Dagger", {"color":"light_purple"})
    rarity = "epic"
    category = ["dagger"]
    stats = ("mainhand", {"physical_power":40,"attack_speed":175})
    passives = [{
        "name": "Arcane Edge",
        "description": "Gain 30% of your Magic Power as Physical Power.",
    }, {
        "name": "Manalust",
        "description": "Restore 3% of your max mana on hit.",
    }]

    @on_attack(slot = 'mainhand')
    def manalust():
        execute on attacker:
            scoreboard players set #denominator genesis 67
            execute store result score #mana genesis run scoreboard players get @s genesis.mana.max
            scoreboard players operation #mana genesis /= #denominator genesis
            add_mana(amount = ["#mana", "genesis"])

    @on_equip(slot = 'mainhand')
    def arcane_edge_add():
        scoreboard players operation @s genesis.passive.arcane_edge_statboost = @s genesis.stat.magic_power
        scoreboard players operation @s genesis.passive.arcane_edge_statboost *= constant(30 * 2) genesis
        store result score #round genesis scoreboard players operation @s genesis.passive.arcane_edge_statboost /= constant(100) genesis
        scoreboard players operation @s genesis.passive.arcane_edge_statboost /= constant(2) genesis
        scoreboard players operation #round genesis %= constant(2) genesis
        scoreboard players operation @s genesis.passive.arcane_edge_statboost += #round genesis
        modify_attribute_stat('physical_power', 'add_value', ('@s', 'genesis.passive.arcane_edge_statboost'), 'passive/arcane_edge_statboost')

    @on_unequip(slot = 'mainhand')
    def arcane_edge_remove():
        remove_attribute_stat('physical_power', 'passive/arcane_edge_statboost')

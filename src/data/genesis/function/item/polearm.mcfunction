from genesis:utils import texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from genesis:tungsten import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, Frostflake, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, FrozenWisp, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 

# IronSpear
@add_custom_recipe([
    [None, "iron_ingot", "iron_ingot"],
    [None, "stick", "iron_ingot"],
    ["stick", None, None],
])
class IronSpear(GenesisItem):
    item_name = ("Iron Spear", {"color":"white"})
    rarity = "common"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":65,"attack_speed":138})

# Glaive
@add_custom_recipe([
    [None, MetalAlloy, MetalAlloy],
    [None, SteelHilt, MetalAlloy],
    [SteelHilt, None, None],
])
class Glaive(GenesisItem):
    item_name = ("Glaive", {"color":"white"})
    rarity = "uncommon"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":75,"attack_speed":147})
    @right_click_ability(
        name = "stance_swap_onslaught",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def stance_swap_onslaught():
        say WIP

# Ice Pike
@add_custom_recipe([
    [None, CrystalScale, "diamond_block"],
    [CrystalScale, SteelHilt, CrystalScale],
    [SteelHilt, CrystalScale, None],
])
class IcePike(GenesisItem):
    item_name = ("Ice Pike", {"color":"aqua"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":75,"attack_speed":155})
    item_model = "genesis:polearm/ice_pike"
    passives = [{
            "name": "Cryorazor",
            "description": "Striking an enemy grants them +1 Frostbite. Once an enemy reaches 10 Frostbite, they take 8 damage and receive Slowness V for 2 seconds.",
        }]

    @on_attack(slot = 'mainhand')
    def cryorazor():
        tag @s add genesis.temp
        execute on attacker if entity @s[tag=!genesis.ability.cryorazor] at @e[tag=genesis.temp,limit=1] run summon item_display ~ ~1 ~ {Tags:["genesis.ability.cryorazor"],Rotation:[0F,90F],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,0.01f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"genesis:ability/frostbite"}}}
        tag @s remove genesis.temp
        # Limit player to only spawn 1 cryorazor each hit, immediately remove tag next tick
        execute on attacker run tag @s add genesis.ability.cryorazor 

    @right_click_ability(
        name = "Windcharmer",
        description = "to be decided",
        mana = 60,
        cooldown = 6,
    )
    def windcharmer():
        say temp

# Halycon
@add_custom_recipe([
    [None, CrystalScale, "diamond_block"],
    [CrystalScale, SteelHilt, CrystalScale],
    [SteelHilt, CrystalScale, None],
])
class Halycon(GenesisItem):
    item_name = ("Halycon", {"color":"aqua"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":75,"attack_speed":155,"speed":40})
    @right_click_ability(
        name = "Windcharmer",
        description = "If used while on the ground, summon a gust of wind which knocks up all enemies in a 3-block radius. If used while in the air, instead grant yourself slow-falling for 4 seconds.",
        mana = 60,
        cooldown = 6,
    )
    def windcharmer():
        execute if block ~ ~-1 ~ air function ~/../slowfall:
            effect give @s minecraft:slow_falling 4
            playsound minecraft:entity.breeze.slide player @a ~ ~ ~ 1 0
            function genesis:utils/particles/circle_rad2 {particle:"cloud", ydirection:-1, speed:0.3}
            function genesis:utils/particles/circle_rad3 {particle:"cloud", ydirection:-1, speed:0.3}
        execute unless block ~ ~-1 ~ air function ~/../knock_up:
            execute as @e[distance=..3,type=!#genesis:non_living,tag=!genesis.player] run data merge entity @s {Motion:[0d,1d,0d]}
            summon minecraft:wind_charge ~ ~ ~ {Motion:[0d,-0.1,0d]}
            function genesis:utils/particles/circle_rad2 {particle:"cloud", ydirection:1, speed:0.3}
            function genesis:utils/particles/circle_rad3 {particle:"cloud", ydirection:1, speed:0.6}

# HelixSpear
class HelixSpear(GenesisItem):
    item_name = ("Helix Spear", {"color":"white"})
    rarity = "uncommon"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":85,"magic_power":60,"attack_speed":120})
    item_model = "genesis:polearm/helix_spear"
    @right_click_ability(
        name = "Piercing Light",
        description = "Release a piercing ray of light in front of you, dealing 15% of your Magic Power to all hit enemies.",
        mana = 30,
        cooldown = 3.5,
    )
    def piercing_light():
        tag @s add genesis.caster
        playsound block.beacon.power_select player @a ~ ~ ~ 1 2
        playsound minecraft:block.amethyst_cluster.break player @a ~ ~ ~ 1 0
        execute store result storage genesis:temp item.piercing_light.damage float 0.15 run scoreboard players get @s genesis.stat.magic_power
        execute anchored eyes function ~/../piercing_light_helper:
            particle minecraft:end_rod ^ ^ ^2 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^3 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^4 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^5 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^6 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^7 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^8 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^9 0 0 0 0 3
            particle minecraft:firework ^ ^ ^1 0.2 0.2 0.2 0.2 10
            summon item_display ^ ^ ^1 {Tags:["genesis.ability.persist_sec","genesis.temp"],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,0.01f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/piercing_light_magic_circle"}}}
            rotate @e[tag=genesis.temp,limit=1] facing entity @s eyes 
            execute as @e[tag=genesis.temp] run tag @s remove genesis.temp
            execute function ~/../piercing_light_macro with storage genesis:temp item.piercing_light:
                $execute as @e[distance=..1,tag=!genesis.player] run damage @s $(damage) minecraft:generic by @a[tag=genesis.caster,limit=1]
            execute positioned ^ ^-0.5 ^1 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^2 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^3 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^4 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^5 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^6 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^7 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^8 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^9 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
        tag @s remove genesis.caster

# HeavensThorn
@add_custom_recipe([
    [None, "gold_block", None],
    [HelixSpear, "quartz", HelixSpear],
    [None, GildedHilt, None],
])
class HeavensThorn(GenesisItem):
    item_name = ("Heavens Thorn", {"color":"gold"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":90,"magic_power":90,"attack_speed":120,"mana_pool":30,"mana_regen":80})
    @right_click_ability(
        name = "Piercing Light",
        description = "Release a piercing ray of light in front of you, dealing 15% of your Magic Power to all hit enemies.",
        mana = 30,
        cooldown = 3.5,
    )
    def piercing_light():
        tag @s add genesis.caster
        playsound block.beacon.power_select player @a ~ ~ ~ 1 2
        playsound minecraft:block.amethyst_cluster.break player @a ~ ~ ~ 1 0
        execute store result storage genesis:temp item.piercing_light.damage float 0.15 run scoreboard players get @s genesis.stat.magic_power
        execute anchored eyes function ~/../piercing_light_helper:
            particle minecraft:end_rod ^ ^ ^2 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^3 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^4 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^5 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^6 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^7 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^8 0 0 0 0 3
            particle minecraft:end_rod ^ ^ ^9 0 0 0 0 3
            particle minecraft:firework ^ ^ ^1 0.2 0.2 0.2 0.2 10
            summon item_display ^ ^ ^1 {Tags:["genesis.ability.persist_sec","genesis.temp"],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,0.01f]},item:{id:"minecraft:dead_bush",count:1,components:{"minecraft:item_model":"genesis:ability/piercing_light_magic_circle"}}}
            rotate @e[tag=genesis.temp,limit=1] facing entity @s eyes 
            execute as @e[tag=genesis.temp] run tag @s remove genesis.temp
            execute function ~/../piercing_light_macro with storage genesis:temp item.piercing_light:
                $execute as @e[distance=..1,tag=!genesis.player] run damage @s $(damage) minecraft:generic by @a[tag=genesis.caster,limit=1]
            execute positioned ^ ^-0.5 ^1 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^2 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^3 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^4 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^5 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^6 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^7 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^8 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
            execute positioned ^ ^-0.5 ^9 run function ~/../piercing_light_macro with storage genesis:temp item.piercing_light
        tag @s remove genesis.caster

# VerdantStaff
@add_custom_recipe([
    [None, None, VerdantGem],
    [None, VerdantTwig, None],
    [VerdantTwig, None, None],
])
class VerdantStaff(GenesisItem):
    item_name = ("Verdant Staff", {"color":"green"})
    rarity = "common"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":50,"attack_speed":120})
    @right_click_ability(
        name = "Revitalize I",
        description = "Summon a small circle for 4 seconds which grants Regeneration I. If you are inside the circle when it expires, you will be healed for 30 health.",
        mana = 50,
        cooldown = 13,
    )
    def revitalize1():
        summon interaction ~ ~ ~ {width:0f,height:0f,Tags:["genesis.ability.revitalize","genesis.ability.revitalize1"],interaction:{player:[I;-470087286,1253655809,-1360091822,1632556642],timestamp:0L}}
        data modify entity @e[tag=genesis.ability.revitalize,sort=nearest,limit=1] interaction.player set from entity @s UUID
        summon area_effect_cloud ~ ~0.2 ~ {Tags:["genesis.ability.revitalize_particle"],custom_particle:{type:"totem_of_undying"},Radius:2f,Duration:80,potion_duration_scale:1f,potion_contents:{custom_effects:[{id:"minecraft:regeneration",amplifier:0,duration:60,show_particles:0b}]}}
        
# VerdantMasterstaff
@add_custom_recipe([
    [VerdantShard, VerdantShard, VerdantShard],
    [VerdantShard, VerdantStaff, VerdantShard],
    [VerdantShard, VerdantShard, VerdantShard],
])
class VerdantMasterstaff(GenesisItem):
    item_name = ("Verdant Masterstaff", {"color":"green"})
    rarity = "uncommon"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":55,"attack_speed":120})
    @right_click_ability(
        name = "Revitalize II",
        description = "Summon a medium circle for 4 seconds which grants Regeneration I. If you are inside the circle when it expires, you will be healed for 50 health.",
        mana = 60,
        cooldown = 15,
    )
    def revitalize2():
        summon interaction ~ ~ ~ {width:0f,height:0f,Tags:["genesis.ability.revitalize","genesis.ability.revitalize2"],interaction:{player:[I;-470087286,1253655809,-1360091822,1632556642],timestamp:0L}}
        data modify entity @e[tag=genesis.ability.revitalize,sort=nearest,limit=1] interaction.player set from entity @s UUID
        summon area_effect_cloud ~ ~0.2 ~ {Tags:["genesis.ability.revitalize_particle"],custom_particle:{type:"totem_of_undying"},Radius:3f,Duration:80,potion_duration_scale:1f,potion_contents:{custom_effects:[{id:"minecraft:regeneration",amplifier:0,duration:40,show_particles:0b}]}}

# VerdantSceptor
@add_custom_recipe([
    [CrystalScale, VerdantGem, CrystalScale],
    [VerdantGem, VerdantMasterstaff, VerdantGem],
    [CrystalScale, VerdantGem, CrystalScale],
])
class VerdantSceptor(GenesisItem):
    item_name = ("Verdant Sceptor", {"color":"green"})
    rarity = "rare"
    category = ["polearm"]
    stats = ("mainhand", {"physical_power":60,"attack_speed":120})
    @right_click_ability(
        name = "Revitalize III",
        description = "Summon a large circle for 4 seconds which grants Regeneration II. If you are inside the circle when it expires, you will be healed for 80 health.",
        mana = 70,
        cooldown = 18,
    )
    def revitalize3():
        summon interaction ~ ~ ~ {width:0f,height:0f,Tags:["genesis.ability.revitalize","genesis.ability.revitalize3"],interaction:{player:[I;-470087286,1253655809,-1360091822,1632556642],timestamp:0L}}
        data modify entity @e[tag=genesis.ability.revitalize,sort=nearest,limit=1] interaction.player set from entity @s UUID
        summon area_effect_cloud ~ ~0.2 ~ {Tags:["genesis.ability.revitalize_particle"],custom_particle:{type:"totem_of_undying"},Radius:4f,Duration:80,potion_duration_scale:1f,potion_contents:{custom_effects:[{id:"minecraft:regeneration",amplifier:1,duration:40,show_particles:0b}]}}
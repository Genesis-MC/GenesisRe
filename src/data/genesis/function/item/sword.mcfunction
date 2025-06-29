from genesis:utils import texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from genesis:tungsten import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, Frostflake, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, FrozenWisp, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 

# ObsidianBlade
@add_custom_recipe([
    [None, None, "obsidian"],
    [None, "obsidian", None],
    [SteelHilt, None, None],
])
class ObsidianBlade(GenesisItem):
    item_name = ("Obsidian Blade", {"color":"white"})
    rarity = "common"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":70,"attack_speed":140,"armor":-20})

# FadingDusk
@add_custom_recipe([
    [ShadeFlux, ShadeFlux, ShadeFlux],
    ["obsidian", ObsidianBlade, "obsidian"],
    [ShadeFlux, ShadeFlux, ShadeFlux],
])
class FadingDusk(GenesisItem):
    item_name = ("Fading Dusk", {"color":"white"})
    rarity = "uncommon"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":140,"armor":-20})
    passives = [{
        "name": "Nightfall",
        "description": "Gain Strength I at night.",
    }]

    @on_equip(slot = 'mainhand')
    def lifeline_add():
        tag @s add genesis.passive.nightfall

    @on_unequip(slot = 'mainhand')
    def lifeline_remove():
        tag @s remove genesis.passive.nightfall

# SaberCrimson
@add_custom_recipe([
    [None, None, CrimsonAlloy],
    [None, CrimsonAlloy, None],
    [BejeweledHilt, None, None],
])
class SaberCrimson(GenesisItem):
    item_name = ("Saber Crimson", {"color":"red"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":85,"attack_speed":165,"health":-40})

# SaberWarped
@add_custom_recipe([
    [None, None, WarpedAlloy],
    [None, WarpedAlloy, None],
    [BejeweledHilt, None, None],
])
class SaberWarped(GenesisItem):
    item_name = ("Saber Warped", {"color":"dark_aqua"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":85,"attack_speed":165,"mana_regen":-300})

# Katana
class Katana(GenesisItem):
    item_name = ("Katana", {"color":"white"})
    rarity = "uncommon"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":70,"attack_speed":160})
    item_model = "genesis:sword/katana"

# HailstoneBlade
class HailstoneBlade(GenesisItem):
    item_name = ("Hailstone Blade", {"color":"white"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":72,"attack_speed":170})
    passives = [{
            "name": "Frostbite",
            "description": "Striking an enemy grants them +1 Frostbite. Once an enemy reaches 10 Frostbite, they take 8 damage and receive Slowness V for 2 seconds.",
        }]

    @on_attack(slot = 'mainhand')
    def frostbite():
        scoreboard players add @s genesis.passive.frostbite 1
        execute anchored eyes run particle minecraft:snowflake ^ ^ ^ 0.5 0.5 0.5 0 10
        execute if score @s genesis.passive.frostbite matches 10.. run function genesis:bolt-item/item/frostfang/on_attack/frostbite_damage

    @right_click_ability(
        name = "Hailslash",
        description = "Slash all enemies in a 3-block radius, dealing 50% of your Physical Power and granting +4 Frostbite.",
        mana = 30,
        cooldown = 10,
    )
    def hailslash():
        tag @s add genesis.caster 
        playsound minecraft:entity.player.attack.sweep player @a ~ ~ ~ 1 0
        playsound minecraft:entity.player.hurt_freeze player @a ~ ~ ~ 1 0.5
        execute positioned ~ ~1 ~ run function genesis:utils/particles/transition_circle {particle:"snowflake", ydirection:0, speed:0.2}
        execute positioned ~ ~1 ~ run function genesis:utils/particles/circle_rad2 {particle:"sweep_attack", ydirection:0, speed:0}
        store result storage genesis:temp item.hailslash.damage float 0.05 scoreboard players get @s genesis.stat.physical_power
        execute function ~/../hailslash_macro with storage genesis:temp item.hailslash:
            $execute as @e[distance=..3,tag=!genesis.player] run damage @s $(damage) minecraft:generic by @a[tag=genesis.caster,limit=1]
            execute as @e[distance=..3,type=!#genesis:non_living,tag=!genesis.player] run scoreboard players add @s genesis.passive.frostbite 3
        tag @s remove genesis.caster

# Kopesh
class Kopesh(GenesisItem):
    item_name = ("Kopesh", {"color":"white"})
    rarity = "rare"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":150})
    @right_click_ability(
        name = "Cleave I",
        description = "Slash all enemies in a 4-block radius, dealing 50% of your Physical Power.",
        cooldown = 8,
    )
    def cleave1():
        tag @s add genesis.caster 
        summon marker ~ ~1 ~ {Tags:["genesis.ability.cleave_particle"]}
        store result storage genesis:temp item.cleave.damage float 0.05 scoreboard players get @s genesis.stat.physical_power
        execute function ~/../cleave_macro with storage genesis:temp item.cleave:
            $execute as @e[distance=..4,tag=!genesis.player] run damage @s $(damage) minecraft:generic by @a[tag=genesis.caster,limit=1]
        tag @s remove genesis.caster

# AcolyteBlade
class AcolyteBlade(GenesisItem):
    item_name = ("Acolyte Blade", {"color":"white"})
    rarity = "uncommon"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":140})

# Asophogheny
class Asophogeny(GenesisItem):
    item_name = ("Asophogeny", {"color":"dark_red"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":100,"magic_power":90,"attack_speed":140})
    @right_click_ability(
        name = "blood_root",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def blood_root():
        say WIP
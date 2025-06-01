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
    rarity = "uncommon"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":140,"armor":-10})

# FadingDusk
@add_custom_recipe([
    [ShadeFlux, ShadeFlux, ShadeFlux],
    ["obsidian", ObsidianBlade, "obsidian"],
    [ShadeFlux, ShadeFlux, ShadeFlux],
])
class FadingDusk(GenesisItem):
    item_name = ("Fading Dusk", {"color":"dark_purple"})
    rarity = "rare"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":140,"armor":-10})

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

# HailstoneBlade
class HailstoneBlade(GenesisItem):
    item_name = ("Hailstone Blade", {"color":"aqua"})
    rarity = "epic"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":75,"attack_speed":175})
    passives = [{
            "name": "Frostbite",
            "description": "Striking an enemy grants them 1 stack of Frostbite. Once an enemy reaches 10 stacks, they take 8 damage and receive Slowness V for 2 seconds.",
        }]

    @on_attack(slot = 'mainhand')
    def frostbite():
        scoreboard players add @s genesis.passive.frostbite 1
        execute anchored eyes run particle minecraft:snowflake ^ ^ ^ 0.5 0.5 0.5 0 10
        execute if score @s genesis.passive.frostbite matches 10..:
            playsound block.glass.break player @a ~ ~ ~ 1 1
            playsound entity.player.hurt_freeze player @a ~ ~ ~ 1 1
            execute anchored eyes positioned ^ ^ ^ run function genesis:utils/particles/transition_circle {particle:"snowflake", ydirection:-1, speed:0.05}
            execute anchored eyes run particle minecraft:block{block_state:"minecraft:ice"} ^ ^ ^ 0.5 0.5 0.5 0 20
            execute on attacker run tag @s add genesis.caster
            damage @s 8 minecraft:generic by @a[tag=genesis.caster,limit=1]
            effect give @s minecraft:slowness 2 4 true
            scoreboard players reset @s genesis.passive.frostbite
            execute on attacker run tag @s remove genesis.caster

    @right_click_ability(
        name = "Hailslash",
        description = "Slash all enemies in a 3-block radius, dealing 15% of your Physical Power and granting +4 Frostbite.",
        mana = 30,
        cooldown = 10,
    )
    def hailslash():
        say hailslash
        #tag @s add genesis.caster
        #store result storage genesis:temp item.hailslash.damage float 0.04 scoreboard players get @s genesis.stat.physical_power
        #execute function ~/../voidrend_macro with storage genesis:temp item.voidrend:
        #    $execute as @e[distance=..2,tag=!genesis.player] run damage @s $(damage) minecraft:generic by @a[tag=genesis.caster,limit=1]


# Kopesh
class Kopesh(GenesisItem):
    item_name = ("Kopesh", {"color":"dark_red"})
    rarity = "rare"
    category = ["sword"]
    stats = ("mainhand", {"physical_power":80,"attack_speed":150})
    @right_click_ability(
        name = "cleave1",
        description = "WIP",
        mana = 10,
        cooldown = 1,
    )
    def cleave1():
        say WIP

# AcolyteBlade
class AcolyteBlade(GenesisItem):
    item_name = ("Acolyte Blade", {"color":"dark_red"})
    rarity = "rare"
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
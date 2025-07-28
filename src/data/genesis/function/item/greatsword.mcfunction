from genesis:utils import texture_path_to_item_model, hitbox
from genesis:right_click_ability import right_click_ability
from genesis:tungsten import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

from genesis:item/ingredient import SteelHilt, GildedHilt, BejeweledHilt, CrimsonAlloy, WarpedAlloy, VerdantGem, VermillionGem, ShadedEnderPearl, VoidedEnderPearl, ShadeFlux, AncientGoldCoin, ArcaneCloth, Frostflake, BoarHide, Calimari, Cloth, CrystalDust, CrystalScale, Drumstick, FloralNectar, FrozenWisp, EverfrostCore, LivingwoodCore, PyroclasticCore, ManaCloth, MetalAlloy, MossyBark, MutatedFlesh, PrimeBeef, PureCrystalDust, ScrapscuttleEgg, ShardOfTheCrimsonAbyss, ShardOfTheDepths, ShardOfTheWarpedEmpyrean, TerraclodPearl, Truffle, VenomSac, VerdantShard, VerdantTwig, VermillionClay, VoidedFragment, WizardsTruffle, WolfFang 
from genesis:item/dagger import HarbingerOfWinter

from genesis:status_impl import Frostbite, PolarVortex, Lifeline
from genesis:animation import using_item_baked_animation, baked_animation
from genesis:relation import ensure_id, prepare_id_inline, prepare_id, match_id, prepare_team, set_prepared_team, prepare_team_inline, match_team
import math
import random

# IronGreatsword
@add_custom_recipe([
    [None, "iron_ingot", None],
    ["iron_ingot", "iron_ingot", "iron_ingot"],
    [None, "stick", None],
])
class IronGreatsword(GenesisItem):
    item_name = ("Iron Greatsword", {"color":"white"})
    rarity = "common"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":120,"attack_speed":65})

# VerdantGreatsword
@add_custom_recipe([
    [None, VerdantTwig, None],
    [VerdantTwig, "iron_block", VerdantTwig],
    [None, SteelHilt, None],
])
class VerdantGreatsword(GenesisItem):
    item_name = ("Verdant Greatsword", {"color":"white"})
    rarity = "uncommon"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":125,"attack_speed":67,"health":40})
    passives = [{
        "name": "Lifeline",
        "description": "Gain Regeneration I.",
    }]

    @on_equip(slot = 'mainhand')
    def lifeline_apply():
        Lifeline.apply()

    @on_unequip(slot = 'mainhand')
    def lifeline_remove():
        Lifeline.remove()

# Zweihander
@add_custom_recipe([
    [None, MetalAlloy, None],
    [MetalAlloy, MetalAlloy, MetalAlloy],
    [None, SteelHilt, None],
])
class Zweihander(GenesisItem):
    item_name = ("Zweihander", {"color":"white"})
    rarity = "uncommon"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":120,"attack_speed":75})
    @right_click_ability(
        name = "Stance Swap - Onslaught",
        description = "Toggles Onslaught Stance. While Onslaught Stance is active, gain +40 Speed, +10% Attack Speed but -20 Armor, -20 Armor Toughness.",
        cooldown = 5,
    )
    def stance_swap_onslaught():
        say swapping stance #! TODO: Implement

# EverfrostTitanblade
@add_custom_recipe([
    [HarbingerOfWinter, EverfrostCore, HarbingerOfWinter],
    [HarbingerOfWinter, EverfrostCore, HarbingerOfWinter],
    [None, BejeweledHilt, None],
])
class EverfrostTitanblade(GenesisItem):
    item_name = ("Everfrost Titanblade", {"color":"aqua"})
    rarity = "legendary"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":150,"attack_speed":50,"mana_pool":20,"mana_regen":50,"speed":-50})
    @right_click_ability(
        name = "Polar Vortex",
        description = "Summon a localized blizzard which follows you around. While this ability is active, 10 mana will be consumed every 0.5 seconds and all enemies in a 6-block radius will be granted +1 Frostbite and Slowness I. This ability can be toggled on and off, and will automatically end if you run out of mana.",
        mana = 0,
        cooldown = 1,
    )
    def polar_vortex():
        if entity @s[tag=(PolarVortex.tag)] return run function ~/remove:
            PolarVortex.remove()
        PolarVortex.apply()

# SwashbucklersGlory
class SwashbucklersGlory(GenesisItem):
    item_name = ("Swashbucklers Glory", {"color":"blue"})
    rarity = "epic"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":140,"attack_speed":60,"armor_toughness":30})
    @right_click_ability(
        name = "Cleave II",
        description = "Slash all enemies in a 4-block radius, dealing 75% of your Physical Power.",
        cooldown = 8,
    )
    def cleave2():
        tag @s add genesis.caster 
        summon marker ~ ~1 ~ {Tags:["genesis.ability.cleave_particle"]}
        store result storage genesis:temp item.cleave.damage float 0.075 scoreboard players get @s genesis.stat.physical_power
        execute function ~/../cleave_macro with storage genesis:temp item.cleave:
            $execute as @e[distance=..4,tag=!genesis.player] run damage @s $(damage) minecraft:generic by @a[tag=genesis.caster,limit=1]
        tag @s remove genesis.caster
    
# RoyalCleaver
class RoyalCleaver(GenesisItem):
    item_name = ("Royal Cleaver", {"color":"gold"})
    rarity = "epic"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":150,"attack_speed":67,"armor":30,"knockback_resistance":30,"mana_regen":-100,"speed":-25})

# Exetol
class Exetol(GenesisItem):
    item_name = ("Exetol", {"color":"red"})
    rarity = "legendary"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":180,"attack_speed":67})

# Sword of Untapped Power
class SwordOfUntappedPower(GenesisItem):
    item_name = ("Sword of Untapped Power", {"color":"dark_purple"})
    rarity = "transcendent"
    category = ["greatsword"]
    stats = ("mainhand", {"physical_power":140,"attack_speed":85})

    @right_click_ability(
        name = "Unleash",
        description = "Concentrate to unleash the full power entrapped in this weapon to create a giant explosion that encompasses all.",
        cooldown = 1, # 40,
        mana = 1, # 100,
        charge_time = 5,
        charge_animation = "block",
    )
    def unleash():
        with ensure_id():
            scoreboard players operation #caster genesis = @s argon.id
        prepare_team()
        execute summon item_display:
            tp @s ~ ~ ~ ~ 0
            scoreboard players operation @s genesis.relation.owner = #caster genesis
            set_prepared_team()
            item replace entity @s contents with paper[item_model='genesis:ability/unleash_halo']
            data modify entity @s teleport_duration set value 2
            data modify entity @s interpolation_duration set value 1
            data modify entity @s brightness set value {block:15,sky:15}
            data modify entity @s transformation.scale set value [0,1.5,0]

            @baked_animation(ticks=130,on_end_kill=True)
            def sword_of_untapped_power_unleash_explosion(t, stop):
                if t < 20: # 0-1 expand halo
                    sz = 2 + (t / 120)
                    h = 1.5
                elif t < 30: # 1-2 shrink halo to 0
                    sz = 2.16 - (((t - 20) / 6.2) ** 2)
                    h = 1.5
                elif t == 30: # 2 make sure halo is at 0
                    sz = 0
                    h = 1.5
                elif t < 60: # prepare for boom
                    sz = 0
                    h = 0.4
                else: # shockwave
                    sz = (t - 60)
                    h = 0.4

                if t == 0:
                    playsound genesis:ability.unleash.vocal player @a ~ ~1.8 ~ .1 .6
                    playsound genesis:ability.unleash.vocal player @a ~ ~1.8 ~ 2
                    particle dust{scale:1.3,color:[1,.2,.9]} ~ ~18 ~ 0 10 0 0 300
                if t == 20:
                    playsound genesis:ability.unleash.power_up player @a ~ ~1.8 ~ .4 1.6
                if t == 45:
                    playsound genesis:ability.unleash.ping player @a ~ ~1.8 ~
                if t == 55:
                    playsound genesis:ability.unleash.boom player @a ~ ~1.8 ~ 2 1.5
                if t <= 30 or t >= 60:
                    data modify entity @s transformation.scale set value [sz,h,sz]
                    rotate @s ~1 ~
                if t == 50:
                    particle flash ~ ~2.5 ~
                    for i in range(8):
                        x = math.cos(2*math.pi/8*i)
                        z = math.sin(2*math.pi/8*i)
                        particle end_rod ~x ~2.5 ~z x 0 z .5 0
                        particle dust{scale:1.3,color:[1,.2,.9]} ~x ~2.5 ~z
                if t > 61:
                    # shockwave hitboxes
                    d = sz - 1 # account for interpolation duration desync
                    r = d / 2
                    width = (3 / 32) * d
                    points = 32
                    prepare_team()
                    prepare_id('@s','genesis.relation.owner')
                    for i in range(points):
                        x2 = math.cos(2*math.pi/points*i)*r
                        z2 = math.sin(2*math.pi/points*i)*r
                        y2 = (width / 2) - 1
                        particle end_rod ~x2 ~.3 ~z2 (-x2) 10 (-z2) .1 0
                        positioned ~x2 ~y2 ~z2:
                            with hitbox(width, f'@e[predicate=!{match_team}]', overwrite_y=10):
                                damage @s 20 generic by @a[predicate=(match_id),limit=1]


random.seed('sword_of_untapped_power_unleash')
@using_item_baked_animation(item=SwordOfUntappedPower,ticks=99) # This would actually be 5 * 20 but consumable component triggers at that frame, so its 5 * 20 - 1
def charging_unleash(t):
    def particle_location(t, offset):
        y = t / 8
        spins = 999 / (t + 30)
        r = (10 / (y + 4)) - 0.5
        x = math.cos(math.pi*offset*2+2*math.pi/spins*t)*r
        z = math.sin(math.pi*offset*2+2*math.pi/spins*t)*r
        dy = ((t+1) / 8) - y
        dspins = (999 / (t + 31)) - spins
        dr = ((10 / (y + dy + 4)) - 0.5) - r
        dx = (math.cos(math.pi*offset*2+2*math.pi/(spins+dspins)*(t+1))*(r+dr)) - x
        dz = (math.sin(math.pi*offset*2+2*math.pi/(spins+dspins)*(t+1))*(r+dr)) - z
        return (x,y,z,dx,dy,dz)

    x, y, z, dx, dy, dz = particle_location(t, 0)
    particle end_rod ~x ~y ~z dx dz dz .1 0
    particle dust{scale:1.3,color:[1,.2,.9]} ~x ~y ~z

    if t >= 14:
        x, y, z, dx, dy, dz = particle_location(t-14, 0.7)
        particle end_rod ~x ~y ~z dx dy dz .1 0
        particle dust{scale:1.3,color:[1,.2,.9]} ~x ~y ~z

    if t >= 42:
        x, y, z, dx, dy, dz = particle_location(t-42, 0.2)
        particle end_rod ~x ~y ~z dx dy dz .1 0
        particle dust{scale:1.3,color:[1,.2,.9]} ~x ~y ~z

    if t >= 67:
        x, y, z, dx, dy, dz = particle_location(t-67, 0.5)
        particle end_rod ~x ~y ~z dx dy dz .1 0
        particle dust{scale:1.3,color:[1,.2,.9]} ~x ~y ~z

    r = 3
    alpha = 2 * math.pi * random.random()
    x = r * math.cos(alpha)
    z = r * math.sin(alpha)
    particle end_rod ~x ~.1 ~z 0 1 0 .5 0

    r = 3
    for i in range(30):
        alpha = 2 * math.pi * ((i / 30) + (t / 200))
        x = r * math.cos(alpha)
        z = r * math.sin(alpha)
        particle dust{scale:.7,color:[1,.2,.9]} ~x ~.1 ~z

    if t == 0:
        particle flash
        playsound block.beacon.activate player @a ~ ~ ~ 1 0.5

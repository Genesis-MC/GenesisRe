from genesis:utils import break_text_into_lines, texture_path_to_item_model
from genesis:right_click_ability import right_click_ability
from tungsten:decorators import on_equip, on_unequip
from bolt_item:decorators import on_consume, on_tick
from argon:decorators import on_attack, on_attacked
from genesis:crafter import add_custom_recipe
from genesis:item import GenesisItem

# Corn
class Corncob(GenesisItem):
    item_name = ("Corncob", {"color":"white"})
    rarity = "common"
    category = ["crop"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.corncob.lore",
        italic = True,
    )

class CornSeed(GenesisItem):
    item_name = ("Corn Seed", {"color":"white"})
    rarity = "common"
    category = ["seed"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.corn_seed.lore",
        italic = True,
    )

# Tomato
class Tomato(GenesisItem):
    item_name = ("Tomato", {"color":"white"})
    rarity = "common"
    category = ["crop"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.tomato.lore",
        italic = True,
    )

class TomatoSeed(GenesisItem):
    item_name = ("Tomato Seed", {"color":"white"})
    rarity = "common"
    category = ["seed"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.tomato_seed.lore",
        italic = True,
    )

# Violentil
class Violentil(GenesisItem):
    item_name = ("Violentil", {"color":"white"})
    rarity = "common"
    category = ["crop"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.violentil.lore",
        italic = True,
    )

class ViolentilSeed(GenesisItem):
    item_name = ("Violentil Seed", {"color":"white"})
    rarity = "common"
    category = ["seed"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.violentil_seed.lore",
        italic = True,
    )

# Heartbeet
class Heartbeet(GenesisItem):
    item_name = ("Heartbeet", {"color":"white"})
    rarity = "uncommon"
    category = ["crop"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.heartbeet.lore",
        italic = True,
    )

class HeartbeetSeed(GenesisItem):
    item_name = ("Heartbeet Seed", {"color":"white"})
    rarity = "uncommon"
    category = ["seed"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.heartbeet_seed.lore",
        italic = True,
    )

# Mana Bean
class Manabean(GenesisItem):
    item_name = ("Manabean", {"color":"aqua"})
    rarity = "rare"
    category = ["crop"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.mana_bean.lore",
        italic = True,
    )

class ManabeanSeed(GenesisItem):
    item_name = ("Manabean Seed", {"color":"white"})
    rarity = "rare"
    category = ["seed"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.mana_bean_seed.lore",
        italic = True,
    )

# Desert Cattleya
class DesertCattleya(GenesisItem):
    item_name = ("Desert Cattleya", {"color":"green"})
    rarity = "epic"
    category = ["crop"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.desert_cattleya.lore",
        italic = True,
    )

class DesertCattleyaSeed(GenesisItem):
    item_name = ("Desert Cattleya Seed", {"color":"white"})
    rarity = "epic"
    category = ["seed"]
    lore = [{"text":"","color":"red"}] + break_text_into_lines(
        "LORE",
        "item.genesis.desert_cattleya_seed.lore",
        italic = True,
    )
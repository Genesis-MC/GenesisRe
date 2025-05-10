from genesis:mapping import stat_names, stat_attribute_to_score, slots
from genesis:utils import constant, smart_scoreboard_operation


def modify_score_stat(stat_name: str, operation: str, value: int|tuple[str,str]):
    smart_scoreboard_operation('@s', f'genesis.stat.{stat_name}', operation, value)
    function f'#genesis:stat/update/{stat_name}'


def modify_attribute_stat(stat_name: str, add_type: str, value: float|tuple[str,str], id: str):
    attribute_ratio = stat_attribute_to_score[stat_name]

    if isinstance(value, tuple):
        raw (f'execute store result storage genesis:temp stat.modify.value double {1 / attribute_ratio["ratio"]} run scoreboard players get {value[0]} {value[1]}')
        data modify storage genesis:temp stat.modify.attribute set value (attribute_ratio['attribute'])
        data modify storage genesis:temp stat.modify.id set value f'genesis:stat/{stat_name}/{id}'
        data modify storage genesis:temp stat.modify.add_type set value (add_type)
        function genesis:stat/modify_attribute_stat_macro with storage genesis:temp stat.modify
    else:
        raw (f'attribute @s {attribute_ratio["attribute"]} modifier add genesis:stat/{stat_name}/{id} {value / attribute_ratio["ratio"]} {add_type}')


def remove_attribute_stat(stat_name: str, id: str):
    attribute_ratio = stat_attribute_to_score[stat_name]
    attribute @s (attribute_ratio['attribute']) modifier remove f'genesis:stat/{stat_name}/{id}'


# Macro function to update an attribute stat
function genesis:stat/modify_attribute_stat_macro:
    $attribute @s $(attribute) modifier add $(id) $(value) $(add_type)

# Set up variables
score_first_stats = []
for stat_name in stat_names:
    if stat_name not in stat_attribute_to_score:
        score_first_stats.append(stat_name)

# Add all scoreboards on load
append function genesis:load:
    for stat_name in stat_names:
        scoreboard objectives add f'genesis.stat.{stat_name}' dummy
    for stat_name in score_first_stats:
        for slot in slots:
            scoreboard objectives add f'genesis.stat.{stat_name}.{slot}' dummy

# Attribute to Score stats
append function genesis:player/tick:
    function genesis:stat/attribute_to_score_checks

function genesis:stat/attribute_to_score_checks:
    for stat_name, attribute_ratio in stat_attribute_to_score.items():
        scoreboard players operation .prev f'genesis.stat.{stat_name}' = @s f'genesis.stat.{stat_name}'
        store result score @s f'genesis.stat.{stat_name}' attribute @s attribute_ratio['attribute'] get attribute_ratio['ratio']
    for stat_name, attribute_ratio in stat_attribute_to_score.items():
        unless score .prev f'genesis.stat.{stat_name}' = @s f'genesis.stat.{stat_name}' function f'#genesis:stat/update/{stat_name}'

# Ensure stats are updated when on_equip and on_unequip run
prepend function_tag tungsten:swap/mainhand {"values":["genesis:stat/attribute_to_score_checks"]}
prepend function_tag tungsten:swap/offhand {"values":["genesis:stat/attribute_to_score_checks"]}
prepend function_tag tungsten:swap/head {"values":["genesis:stat/attribute_to_score_checks"]}
prepend function_tag tungsten:swap/chest {"values":["genesis:stat/attribute_to_score_checks"]}
prepend function_tag tungsten:swap/legs {"values":["genesis:stat/attribute_to_score_checks"]}
prepend function_tag tungsten:swap/feet {"values":["genesis:stat/attribute_to_score_checks"]}

# Read all other stats from equipment
for slot in slots:
    nbt_path = f'equipment.{slot}'
    if slot == "mainhand":
        nbt_path = "SelectedItem"

    prepend function_tag f'tungsten:swap/{slot}' {"values":[f'genesis:stat/swap/{slot}']}
    function f'genesis:stat/swap/{slot}':
        data remove storage genesis:temp stat.stats
        data modify storage genesis:temp stat.stats set from entity @s f'{nbt_path}.components."minecraft:custom_data".genesis.stats.{slot}'
        for stat_name in score_first_stats:
            scoreboard players operation .prev f'genesis.stat.{stat_name}.{slot}' = @s f'genesis.stat.{stat_name}.{slot}'
            store result score @s f'genesis.stat.{stat_name}.{slot}' data get storage genesis:temp f'stat.stats.{stat_name}'
            scoreboard players operation @s f'genesis.stat.{stat_name}' -= .prev f'genesis.stat.{stat_name}.{slot}'
            scoreboard players operation @s f'genesis.stat.{stat_name}' += @s f'genesis.stat.{stat_name}.{slot}'
            unless score .prev f'genesis.stat.{stat_name}.{slot}' = @s f'genesis.stat.{stat_name}.{slot}' function f'#genesis:stat/update/{stat_name}'

# Add special handling for attack speed
prepend function_tag genesis:stat/update/attack_speed {"values":["genesis:stat/score_to_attribute/attack_speed"]}
function genesis:stat/score_to_attribute/attack_speed:
    # Remove previous attributes
    attribute @s attack_speed modifier remove genesis:stat/attack_speed
    # If attack speed is 0, dont calculate or add anyhting
    if score @s genesis.stat.attack_speed matches 0 return 0
    # Calculate attribute from score
    # (12.2*x)/(1000+x) | amplified by 100x to get precision up to 0.01
    scoreboard players set #denominator genesis 1000
    scoreboard players operation #denominator genesis += @s genesis.stat.attack_speed
    scoreboard players operation #stat genesis = @s genesis.stat.attack_speed
    scoreboard players operation #stat genesis *= constant(2440) genesis
    execute store result score #temp genesis run scoreboard players operation #stat genesis /= #denominator genesis
    scoreboard players operation #stat genesis /= constant(2) genesis
    scoreboard players operation #temp genesis %= constant(2) genesis
    scoreboard players operation #stat genesis += #temp genesis
    # Remove the base 4 attack speed
    store result storage genesis:temp stat.attack_speed.value float 0.01 scoreboard players remove #stat genesis 400
    # Run macro to add attribute with correct value
    execute function ~/../attack_speed_macro with storage genesis:temp stat.attack_speed:
        $attribute @s attack_speed modifier add genesis:stat/attack_speed $(value) add_value

# Add special handling for knockback resistance
prepend function_tag genesis:stat/update/knockback_resistance {"values":["genesis:stat/score_to_attribute/knockback_resistance"]}
function genesis:stat/score_to_attribute/knockback_resistance:
    # Remove previous attributes
    attribute @s knockback_resistance modifier remove genesis:stat/knockback_resistance
    # If attack speed is 0, dont calculate or add anyhting
    if score @s genesis.stat.knockback_resistance matches 0 return 0
    # Calculate attribute from score
    # x/(100+x) | amplified by 10000x to get precision up to 0.0001
    scoreboard players set #denominator genesis 100
    scoreboard players operation #denominator genesis += @s genesis.stat.knockback_resistance
    scoreboard players operation #stat genesis = @s genesis.stat.knockback_resistance
    scoreboard players operation #stat genesis *= constant(20000) genesis
    execute store result score #temp genesis run scoreboard players operation #stat genesis /= #denominator genesis
    scoreboard players operation #stat genesis /= constant(2) genesis
    scoreboard players operation #temp genesis %= constant(2) genesis
    store result storage genesis:temp stat.knockback_resistance.value float 0.0001 scoreboard players operation #stat genesis += #temp genesis
    # Run macro to add attribute with correct value
    execute function ~/../knockback_resistance_macro with storage genesis:temp stat.knockback_resistance:
        $attribute @s knockback_resistance modifier add genesis:stat/knockback_resistance $(value) add_value

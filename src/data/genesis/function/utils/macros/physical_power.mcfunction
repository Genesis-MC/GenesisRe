#> MACRO FOR ADDING TO THE ATTTACK DAMAGE ATTRIBUTE
# Takes in 1 input: value(The value which the attribute is SET to)
# Ex: function genesis:utils/macros/physical_power {value:10}

$attribute @s minecraft:attack_damage base set $(value)
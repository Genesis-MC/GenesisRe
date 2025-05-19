#> MACRO FOR ADDING TO THE ATTTACK DAMAGE ATTRIBUTE
# Takes in 1 input: value(The # of hearts to heal * 10000; Ex: 5 hearts = 50000)
# Ex: function genesis:utils/macros/heal {value:50000} 
# Credit to XanBelOr's Custom Heal Library https://github.com/XanBelOr/Minecraft-Simple-Custom-Heal

$scoreboard players set @s c.heal $(value)
function custom_heal:apply_heal
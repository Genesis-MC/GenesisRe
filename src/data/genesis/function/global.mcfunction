#> NOT SURE IF THIS FILE WILL BE NEEDED AS IT'S OWN FILE IN THE END, IF NOT ALL THE STUFF WILL BE MOVED TO WHERE THEY ARE CALLED


from genesis:mapping import item_display_uuid


function ~/regive_mainhand:
    item replace entity item_display_uuid["hex"] contents from entity @s weapon.mainhand
    item replace entity @s weapon.mainhand with air
    item replace entity @s weapon.mainhand from entity item_display_uuid["hex"] contents


function ~/regive_offhand:
    item replace entity item_display_uuid["hex"] contents from entity @s weapon.offhand
    item replace entity @s weapon.offhand with air
    item replace entity @s weapon.offhand from entity item_display_uuid["hex"] contents

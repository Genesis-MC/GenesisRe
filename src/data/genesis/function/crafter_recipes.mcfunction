#> THIS FUNCTION WILL NOT BE A FUNCTION IN THE END AND IS USED TO DEFINE CUSTOM CRAFTING RECIPES


from genesis:utils import add_custom_recipe
from genesis:crafter import Crafter


add_custom_recipe([
    ["#logs","#logs","#logs"],
    ["#logs",None   ,"#logs"],
    ["#logs","#logs","#logs"],
], Crafter)

add_custom_recipe([
    [None,"#logs",None],
    [None,Crafter,None],
    [None,"#logs",None],
], Crafter)

add_custom_recipe([
    [None,None   ,None],
    [None,"glass",None],
    [None,None   ,None],
], "apple")

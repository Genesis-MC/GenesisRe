#> THIS FUNCTION WILL NOT BE A FUNCTION IN THE END AND IS USED TO DEFINE CUSTOM CRAFTING RECIPES
#! evaluate if we even need this, this would only be used to add crafting recipes requiring each other or crafting recipes resulting in a non-genesis item


from genesis:crafter import add_custom_recipe


add_custom_recipe([
    [None,None   ,None],
    [None,"glass",None],
    [None,None   ,None],
])("apple")


add_custom_recipe([
    ["iron_sword",None,None],
    ["apple",     None,None],
    [ None,       None,None],
], True)("melon_slice")

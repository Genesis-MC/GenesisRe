from genesis:mob import genesis_mob, TexturedZombieVariant


@genesis_mob
class VerdantZombie(TexturedZombieVariant):
  pass

@genesis_mob
class UndeadMiner(TexturedZombieVariant):
  righthand_extra_item_model = {
    "type": "minecraft:model",
    "model": "minecraft:item/iron_pickaxe"
  }
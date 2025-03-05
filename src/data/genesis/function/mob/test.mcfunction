from genesis:mob import genesis_mob, TexturedZombieVariant, PlayerLike, register_sounds, on_init, on_hurt, on_death


@genesis_mob
class VerdantZombie(TexturedZombieVariant):
  @on_init()
  def say_hi():
    say Hello, I'm a Verdant Zombie!

@genesis_mob
class UndeadMiner(TexturedZombieVariant):
  righthand_extra_item_model = {
    "type": "minecraft:model",
    "model": "minecraft:item/iron_pickaxe"
  }

@genesis_mob
class Pirate(PlayerLike):
  custom_sounds = {
    "hurt": "genesis:mob.pirate.hurt",
    "death": "genesis:mob.pirate.death",
    "ambient": "genesis:mob.pirate.ambient"
  }

  name = "Pirate"

  loot_table = {
    "pools": [
      {
        "rolls": 1,
        "entries": [
          {
            "type": "minecraft:item",
            "name": "minecraft:gold_ingot"
          }
        ]
      }
    ]
  }

  @on_init()
  def init():
    function genesis:mob/component/init/set_home_memory

  def add_sounds(mob):
    register_sounds("mob.pirate.death", ["genesis:mob/pirate/death0","genesis:mob/pirate/death1"])
    register_sounds("mob.pirate.hurt", ["genesis:mob/pirate/hurt0","genesis:mob/pirate/hurt1","genesis:mob/pirate/hurt2"])
    register_sounds("mob.pirate.ambient", ["genesis:mob/pirate/ambient0","genesis:mob/pirate/ambient1","genesis:mob/pirate/ambient2","genesis:mob/pirate/ambient3","genesis:mob/pirate/ambient4"])
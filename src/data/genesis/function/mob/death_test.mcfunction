particle minecraft:angry_villager
execute if entity @s[nbt={DeathTime:1s}] run tellraw @a {"nbt":"{}","entity":"@s"}
from beet import Context, Mcmeta

def beet_default(ctx: Context):
    ctx.data.mcmeta = Mcmeta({
        "pack": {
            "min_format": 83,
            "max_format": 1000,
            "pack_format": 83,
        }
    })
    ctx.assets.mcmeta = Mcmeta({
        "pack": {
            "min_format": 65,
            "max_format": 1000,
            "pack_format": 65,
        }
    })

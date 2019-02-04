import discord
from discord.ext import commands
import pandas as pd
from src.schedule_search import *


bot = commands.Bot(command_prefix='!')

@bot.event
async def on_ready():
    print('Logged in as')
    print(bot.user.name)
    print(bot.user.id)
    print('------')
    bot.schedule = pd.read_csv("schedule.csv")
    with open("members.txt") as f:
        content = f.readlines()
    bot.members = [x.strip().split() for x in content]

@bot.command()
async def update(ctx):
    await ctx.send('업데이트 됐다')

@bot.command()
async def search(ctx, name: str):
    info = search_musician(name, bot.schedule, bot.members)
    await ctx.send(info)

bot.run('NTQxNzA4NzEyNTQxMjkwNTE2.DzjcQQ.gaQwef5cnGWKqxyDOi7pdrmyRYs')
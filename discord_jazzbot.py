import discord
from discord.ext import commands
import pandas as pd
import os
from src.schedule_search import *


bot = commands.Bot(command_prefix='!')

@bot.event
async def on_ready():
    print('Logged in as')
    print(bot.user.name)
    print(bot.user.id)
    print('------')

@bot.command()
async def update(ctx):
    await ctx.send('업뎃 시작')
    os.system('Rscript update_schedule.R')
    await ctx.send('업뎃 끗')

@bot.command()
async def search(ctx, name: str):
    # prepare data
    bot.schedule = pd.read_csv("data/schedule.csv")
    with open("data/members.txt") as f:
        content = f.readlines()
    bot.members = [x.strip().split() for x in content]
    
    # search
    info = search_musician(name, bot.schedule, bot.members)
    await ctx.send(info)
    
    # clear
    del content, bot.schedule, bot.members, info

bot.run('NTQxNzA4NzEyNTQxMjkwNTE2.DzjcQQ.gaQwef5cnGWKqxyDOi7pdrmyRYs')

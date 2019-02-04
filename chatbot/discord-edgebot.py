import discord
import asyncio
import rpy2.robjects as robjects

client = discord.Client()

@client.event
async def on_ready():
    print('Logged in as')
    print(client.user.name)
    print(client.user.id)
    print('------')
    robjects.r('source("src/schedule-utils")')
    robjects.r('load(schedule)')

@client.event
async def on_message(message):
    if message.content.startswith('!update'):
        robjects.r('schedule <- get_schedule_all()')
        robjects.r('save(schedule, file = schedule.RData)')
        await client.send_message(message.channel, '업데이트 됐다')
    
    elif message.content.startswith('!search'):
        await client.send_message(message.channel, '누구')
        msg = await client.wait_for_message(timeout=15.0, author=message.author)
        
        if msg is None:
            await client.send_message(message.channel, '빨리말해')
            return
        else:
            cmd = 'when_my_star_performs(' + msg.content + ', schedule)'
            info = robjects.r(cmd)[0]
            await client.send_message(message.channel, info)

client.run('NTQxNzA4NzEyNTQxMjkwNTE2.DzjcQQ.gaQwef5cnGWKqxyDOi7pdrmyRYs')
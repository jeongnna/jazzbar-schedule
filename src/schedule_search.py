def print_info(schedule, members):
    date, stage, team = schedule['date'], schedule['stage'], schedule['team']
    members = ", ".join(members)
    info = 'Date   : %s\nStage  : %s\nTeam   : %s\nMembers: %s' % (date, stage, team, members)
    return info


def search_musician(name, schedule, members):
    out = [print_info(schedule.iloc[i], m) for i, m in enumerate(members) if name in m]
    out = "\n\n".join(out)
    return out

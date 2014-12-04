# Description:
#   Stahp.
#
# Dependencies:

#
# Configuration:
#   None
#
# Commands:
#   None
module.exports = (robot) ->

  apiToken = ->
    process.env.SLACK_API_TOKEN

  channelMap = {}
  loadChannelMap = ->
    url = "https://slack.com/api/channels.list?token=#{apiToken()}&exclude_archived=1"
    robot.http(url).get() (err, r, body) ->
      channels = JSON.parse(body)
      return unless channels["ok"] == true

      for channel in channels["channels"]
        channelMap[channel["name"]] = channel["id"]

  loadChannelMap()

  robot.hear /\@channel|at-channel/, (msg) ->
    channel = channelMap[msg.message.reply_to || msg.message.room || msg.message.channel]
    return unless channel

    msg.send "getting info about #{channel}"
    url = "https://slack.com/api/channels.info?token=#{apiToken()}&channel=#{channel}"

    robot.http(url).get() (err, r, body) ->
      channelStats = JSON.parse(body)
      return unless channelStats["ok"] == true

      subject = msg.message.user.name.toLowerCase()
      users = channelStats["channel"]["members"].length
      salaryPerMinute = 100000 / (2000 * 60)  # number of minutes 
      cost = salaryPerMinute * users * 15

      msg.send "At-channel to #{users} users x 15 minutes: #{subject} spends ~$#{cost}."

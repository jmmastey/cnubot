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
  api_token = ->
    process.env.SLACK_API_TOKEN

  robot.hear /\@channel|at-channel/, (msg) ->
    subject = msg.message.user.name.toLowerCase()
    channel = msg.message.reply_to || msg.message.room || msg.message.channel
    url = "https://slack.com/api/channels.info?token=#{api_token()}&channel=#{channel}"
    msg.send "getting info about #{channel}"

    robot.http(url).get() (err, r, body) ->
      channel_stats = JSON.parse(body)
      return unless channel_stats["ok"] == true

      users = channel_stats["channel"]["members"].length
      salary_per_minute = 100000 / (2000 * 60)  # number of minutes 
      cost = salary_per_minute * users * 15

      msg.send "At-channel to #{users} users x 15 minutes: #{subject} spends ~$#{cost}."

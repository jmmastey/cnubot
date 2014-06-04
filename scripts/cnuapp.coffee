# Description:
#   Cnuapp just don't understand.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot blame - who's responsible for this travesty
#   hubot tests - check on test suite status
#   hubot restart - restart hubot
#   hubot cluster - check which cluster hubot is on
#   hubot apply-patch <patch> - apply patch to hubot
#   hubot the laws - recite the laws

module.exports = (robot) ->

  robot.respond /tests?$/i, (msg) ->
    responses = [
      "Pass! No, fail!",
      "Fail! No, pass!",
      "Fails on Saturdays and Labor Day.",
      "All green.",
      "Current time: 12:30:00 14 June 2124",
      "Cannot connect to cnubot.qa: certificate expired",
      "I'll let you know tomorrow."
    ]
    msg.send msg.random responses

  robot.respond /net ?credit/i, (msg) ->
    msg.send "Yeah, like that's ever going to work."

  robot.respond /restart/, (msg) ->
    msg.send "Permission denied. Try sudo."

  robot.respond /sudo restart/, (msg) ->
    msg.send "Stop escalating privileges. This incident has been reported."

  robot.respond /cluster$/, (msg) ->
    responses = [
      "GB",
      "US",
      "JV",
      "CA",
      "AUAAHAHAHAHAHAHAHAA",
      "AUAAHAHAHAHAHAHAHAA"
    ]
    msg.send msg.random responses

  robot.respond /apply[-_]patch (.*)$/, (msg) ->
    msg.send "Could not load db-global."

  robot.respond /blame/, (msg) ->
    msg.send "41cdde6c (Joseph Mastey     2014-02-11 15:31:14 -0600  86)  -- I'm sorry. I'm so, so sorry."
    msg.send "90abaf97 (Trey Springer     2014-02-11 17:20:16 -0800  87)  "
    msg.send "c4f50706 (Robert Nubel  2014-02-12 17:19:09 -0600 146)  "
    msg.send "394ad1ca (Erhan Edlinger 2014-05-22 11:53:38 -0500 39)"
    msg.send "e7e46251 (Nathan Handler 2014-06-04 15:19:30 -0500 101)"

  robot.hear /hubot image me tiny pig/, (msg) ->
    msg.send "This part's my favorite!"

  robot.hear /metrix run/, (msg) ->
    msg.emote "/me chuckles softly in the corner"

  robot.hear /^cnubot\.([a-zA-Z0-9_?!]+)/, (msg) ->
    msg.send "NoMethodError: undefined method `" + msg.match[1] + "' for nil:NilClass"

  robot.hear /^cnubot && cnubot\.([a-zA-Z0-9_?!]+)/, (msg) ->
    msg.send "NoMethodError: undefined method `" + msg.match[1] + "' for #<Cabar::CnuBot:0xfea124eb>"

  robot.respond /the laws/, (msg) ->
    msg.send "NoMethodError: undefined method `gov_law_state_cd' for nil:NilClass"


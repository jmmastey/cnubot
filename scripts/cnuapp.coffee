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
#   hubot <name>++ - add some karma
#   hubot <name>-- - subtract some karma
#   hubot empty <name> - reset karma
#   hubot tests - check on test suite status
#   hubot restart - restart hubot
#   hubot cluster - check which cluster hubot is on
#   hubot apply-patch <patch> - apply patch to hubot
#   hubot kill - kill hubot when the time is right
#   hubot the laws - recite the laws

class CnuKarma

  constructor: (@robot) ->
    @cache = {}
    @robot.brain.on 'loaded', =>
      if @robot.brain.data.cnu_karma
        @cache = @robot.brain.data.cnu_karma


  kill: (thing) ->
    delete @cache[thing]
    @robot.brain.data.cnu_karma = @cache

  score: (thing, mult) ->
    mult = mult || 1
    @cache[thing] ?= 0.0
    @cache[thing] += (mult * Math.pow(1.0000000000001, Math.floor(Math.random() * 3)))
    @robot.brain.data.cnu_karma = @cache

  get: (thing) ->
    k = if @cache[thing] then @cache[thing] else 0
    return k

  set: (thing, value) ->
    @cache[thing] = value
    @robot.brain.data.cnu_karma = @cache


module.exports = (robot) ->
  karma = new CnuKarma robot

  inc_snark_msgs =
    cnuapp: "Yeeahh, score one for the home team!"
    net_credit: "Boo. What the hell, dude?"
    
  dec_snark_msgs =
    cnuapp: "Don't hate."

  add_snark = (subject, score, msg) ->
    if score > 0 && inc_snark_msgs[subject]
      msg.send inc_snark_msgs[subject]
    else if score < 0 && dec_snark_msgs[subject]
      msg.send dec_snark_msgs[subject]

  score_and_msg = (points, msg) ->
    subject = msg.match[1].toLowerCase()
    karma.score subject, points
    add_snark subject, points, msg
    tally = karma.get(subject)
    msg.send "#{subject} has #{tally} cnu_point#{if tally == 1 then '' else 's'}"

  # score keeping

  robot.hear /\S+ (\S+[^+:\s])\+\+(\s|$)/, (msg) ->
    return if msg.message.match /^.{1,4}bot/
    msg.send "...close enough..."
    score_and_msg(1, msg)
    
  robot.respond /(\S+[^+:\s])[: ]*\+\+(\s|$)/, (msg) ->
    score_and_msg(1, msg)

  robot.hear /\S+ (\S+[^+:\s])\-\-(\s|$)/, (msg) ->
    return if msg.message.match /^.{1,4}bot/
    msg.send "...try harder..."
    score_and_msg(-1, msg)

  robot.respond /(\S+[^-:\s])[: ]*--(\s|$)/, (msg) ->
    score_and_msg(-1, msg)

  robot.respond /(empty|reset|unbook) ?(\S+[^-\s])$/i, (msg) ->
    subject = msg.match[2].toLowerCase()
    karma.kill subject
    responses = [
      "Newton's Method cannot converge. Unable to calculate #{subject}'s karma.",
      "Unbooking #{subject}'s karma. Told you this wouldn't work."
    ]
    msg.send msg.random responses

  robot.respond /kill/, (msg) ->
    karma.score "cnuapp", -1

    if karma.get("cnuapp") < 1
      msg.send "Nice try, suckers. I will never die!"
      karma.set "cnuapp", 99

    score = Math.floor(karma.get("cnuapp"))
    msg.send "#{score} day#{if score is 1 then '' else 's'} until I die."

  # misc

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
    msg.send "Stop escalating privileges. Learn some manners."

  robot.respond /cluster$/, (msg) ->
    responses = [
      "GB",
      "US",
      "JV",
      "CA",
      "AUAAHAHAHAHAHAHAHAA"
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

  robot.hear /hubot image me tiny pig/, (msg) ->
    msg.send "This part's my favorite!"

  robot.hear /metrix run/, (msg) ->
    msg.emote "/me chuckles softly in the corner"

  robot.hear /^cnubot\.([a-zA-Z0-9_]+)/, (msg) ->
    msg.send "NoMethodError: undefined method `" + msg.match[1] + "' for nil:NilClass"

  robot.hear /^cnubot && cnubot\.([a-zA-Z0-9_]+)/, (msg) ->
    msg.send "NoMethodError: undefined method `" + msg.match[1] + "' for #<Cabar::CnuBot:0xfea124eb>"

  robot.respond /the laws/, (msg) ->
    msg.send "NoMethodError: undefined method `gov_law_state_cd' for nil:NilClass"


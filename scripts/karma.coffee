# Description:
#   Karmic justice, now with floats!
#
# Dependencies:

#
# Configuration:
#   None
#
# Commands:
#   hubot <name>++ - add some karma
#   hubot <name>-- - subtract some karma
#   hubot score <name> - check karma
#   hubot unbook <name> - reset karma
#   hubot kill - kill hubot when the time is right

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
    print_karma subject, msg

  print_karma = (subject, msg) ->
    tally = karma.get(subject)
    msg.send "#{subject} has #{tally} cnu_point#{if tally == 1 then '' else 's'}"

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

  robot.hear /^(cnubot |hubot )?(\S+[^-:\s])*—$/, (msg) ->
    subject = msg.message.user.name.toLowerCase()
    karma.score subject, -1
    print_karma subject, msg

  robot.respond /(empty|reset|unbook) ?(\S+[^-\s])$/i, (msg) ->
    subject = msg.match[2].toLowerCase()
    karma.kill subject
    responses = [
      "Newton's Method cannot converge. Unable to calculate #{subject}'s karma.",
      "Unbooking #{subject}'s karma. Told you this wouldn't work."
    ]
    msg.send msg.random responses

  robot.respond /(kill|die)/, (msg) ->
    karma.score "cnuapp", -1

    if karma.get("cnuapp") < 1
      msg.send "Nice try, suckers. I will never die!"
      karma.set "cnuapp", 20

    score = Math.floor(karma.get("cnuapp"))
    msg.send "#{score} day#{if score is 1 then '' else 's'} until I die."

  robot.respond /score (\S+)/, (msg) ->
    subject = msg.match[1].toLowerCase()
    tally = karma.get(subject)

    if tally < 0
    	msg.send ":hard_decline, fraud_flg=1"
    else if tally < 3
    	msg.send ":soft_decline"
    else
    	msg.send ":approved"



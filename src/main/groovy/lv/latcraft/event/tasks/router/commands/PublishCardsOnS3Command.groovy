package lv.latcraft.event.tasks.router.commands

import lv.latcraft.event.tasks.PublishCardsOnS3

import static lv.latcraft.event.utils.JsonMethods.dumpJson
import static lv.latcraft.event.utils.LambdaMethods.invokeLambda

class PublishCardsOnS3Command extends BaseCommand {

  @Override
  String getPrefix() { "publish cards" }

  @Override
  String getDescription() { "publish cards <card_template_id_1> [<card_template_id_2> [<card_template_id_3> ... ]] " }

  @Override
  String apply(String command) {
    getCards(command).each {
      invokeLambda(functionName(PublishCardsOnS3), dumpJson(
        [ cards: it, updateEventData: 'false' ]
      ))
    }
    "Please, be patient, my master, I started generating the cards!"
  }

  private List<String> getCards(String command) {
    getCommandParameterList(command) ?: [ PublishCardsOnS3.EVENT_CARDS + PublishCardsOnS3.SPEAKER_CARDS ] as List<String>
  }

}

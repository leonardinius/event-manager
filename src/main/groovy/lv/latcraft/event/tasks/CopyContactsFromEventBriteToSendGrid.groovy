package lv.latcraft.event.tasks

import com.amazonaws.services.lambda.runtime.Context
import groovy.util.logging.Log4j
import lv.latcraft.event.lambda.mock.InternalContext

import static lv.latcraft.event.integrations.Configuration.sendGridDefaultListId

@Log4j("logger")
class CopyContactsFromEventBriteToSendGrid extends BaseTask {

  Map<String, String> doExecute(Map<String, String> request, Context context) {

    // Parse request parameters
    int numOfEventsToLoad = request.containsKey('events') && request.events ? Integer.valueOf(request.events) : 10

    boolean foundContacts = false
    getAttendees(numOfEventsToLoad).collate(300).each { inputData ->
      logger.info "Inserting next batch of ${inputData.size()} contact(s)..."
      sendGrid.post("/v3/contactdb/recipients", inputData) { Map responseData ->

        foundContacts = foundContacts || reportResult(inputData, responseData)

        // This sleep is indeed to avoid hitting SendGrid's API request limit (2 requests/second)
        sleep(1000)

        sendGrid.post("/v3/contactdb/lists/${sendGridDefaultListId}/recipients", responseData.persisted_recipients)

        // This sleep is indeed to avoid hitting SendGrid's API request limit (2 requests/second)
        sleep(1000)

      }
    }

    if (!foundContacts) {
      slack.send("Sorry, master, no new contacts discovered this time!")
    }

    [:]
  }

  List<Map<String, ?>> getAttendees(int numOfEventsToLoad) {
    uniqueAttendees(getAllEventBriteAttendees(numOfEventsToLoad)).collect { fromEventBriteToSendGrid(it) }.findAll { it.email }
  }

  boolean reportResult(List<Map<String, ?>> inputData, Map responseData) {
    boolean foundContacts = false
    if (responseData.new_count.toString().toLong() > 0) {
      foundContacts = true
      logger.info "New contacts: ${responseData.new_count}"
      slack.send("New contacts discovered, master! (${responseData.new_count})")
    }
    handleErrors(inputData, responseData)
    foundContacts
  }

  void handleErrors(List<Map<String, ?>> inputData, Map responseData) {
    if (responseData.errors) {
      responseData.errors.each { error ->
        if (!error.message.toString().contains("Email duplicated in request") && !error.message.toString().contains("The email address you added is invalid")) {
          logger.error "Error: ${error.message} = ${error.error_indices.size()}"
          slack.send("I'm sorry, master, there are some errors found during contact import! (${error.message} = ${error.error_indices.size()})")
          error.error_indices.each { index ->
            logger.error "Error: ${inputData[index.toString().toInteger()].email}"
          }
        }
      }
    }
  }

  static Map<String, ?> fromEventBriteToSendGrid(Map attendee) {
    [
      company   : attendee.profile.company ?: '',
      email     : attendee.profile.email ?: '',
      first_name: attendee.profile.first_name ?: '',
      last_name : attendee.profile.last_name ?: '',
      name      : attendee.profile.name ?: '',
      job_title : attendee.profile.job_title ?: ''
    ]
  }

  static List<Map<String, ?>> uniqueAttendees(List<Map<String, ?>> attendees) {
    attendees.findAll { Map attendee ->
      attendee.profile.email
    }.collectEntries { Map attendee ->
      [attendee.profile.email.toLowerCase(), attendee]
    }.values()
    attendees
  }

  List<Map<String, ?>> getAllEventBriteAttendees(int numOfEventsToLoad) {
    List<Map<String, ?>> attendees = []
    eventBrite.events.findAll { Map eventBriteEvent ->
      !eventBriteEvent.name.text.toLowerCase().startsWith('devternity')
    }.reverse().take(numOfEventsToLoad).each { Map eventBriteEvent ->
      logger.info "Extracting attendees from: ${eventBriteEvent.name.text}"
      attendees.addAll(eventBrite.getAttendees(eventBriteEvent.id as String))
    }
    attendees
  }

  static void main(String[] args) {
    new CopyContactsFromEventBriteToSendGrid().execute([:], new InternalContext())
  }

}

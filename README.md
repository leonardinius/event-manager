[![Conference attendee](https://devternity.com/shields/fellow.svg)](https://devternity.com) [![Build Status](https://travis-ci.org/latcraft/event-manager.svg?branch=master)](https://travis-ci.org/latcraft/event-manager)

# Event manager

Automation tasks for event publishing and support. Most of the tasks are executable through the [CraftBot](https://github.com/latcraft/event-manager/blob/master/BOT.md) commands.

> **NOTE:** For running automation tasks locally, copy contents of the `local.properties` file from the `latcraft/passwords` project to the `local.propeties` file.

## Event publishing

Event publishing process consists of the following steps: 
 
0. **Manual:** Create data record for the event inside `events.json` (https://github.com/latcraft/website/blob/master/data/events.json) and push to Git.

   > **WARNING:** make sure that you removed EventBrite's eventId from the new event record. Otherwise, there is a risk of data corruption.
   
1. **Automated:** Publish event on EventBrite using the following task: 

        gradlew publishEventOnEventBrite

   Or the following `/craftbot` command:
   
        /craftbot publish eventbrite

   > **WARNING:** This task MUST be executed FIRST and event lead must wait until data inside `events.json` is updated since other tasks depend on it.

   It is safe to rerun this task several times after the first publication if there are any changes in the event description.

2. **Automated:** Generate event cards using the following task:
   
        gradlew publishCardsOnS3

    Or the following `/craftbot` command:
       
        /craftbot publish cards 
    
    Cards will be generated on AWS S3 share. Links to the cards will be published inside `#craftbot` channel in Slack.    
    
    > **WARNING:** It is a responsibility of the event lead to share cards at convenient times on social networks. 
    
    Different cards have different purposes (check the *Event cards* section below). 
    
    It is safe to run this task several times if there are any updates to the event data.     
        
3. **Automated:** Copy all contacts from EventBrite to SendGrid using the following task:

        gradlew copyContactsFromEventBriteToSendGrid

    Or the following `/craftbot` command:
   
        /craftbot copy contacts 4

4. **Automated:** Create invitation e-mail on SendGrid using the following task:
  
        gradlew publishCampaignOnSendGrid
 
    Or the following `/craftbot` command:
    
        /craftbot publish sendgrid

    Link to the e-mail HTML will be published inside `#craftbot` channel in Slack.
      
     > **WARNING:** Verify e-mail's content and layout before executing next task.   

     > **WARNING:** This task MUST be executed after `publishEventOnEventBrite`.
       
    It is safe to run this task several times. 
        
5. **Automated:** Send the invitation letter using the following task:
    
        gradlew sendCampaignOnSendGrid

    Or the following `/craftbot` command:
    
        /craftbot send campaign

    > **WARNING:** This task is not reversible. Double-check HTML e-mail message from previous step before proceeding.
    
    > **NOTE:** This task is safe to be called multiple times, because explicit check is done on SendGrid level to verify that campaign has not already been sent. 
    
6. **Manual:** Tweet about the event and speakers using LatCraft Twitter account and cards generated above. Pin the tweet about event. Use `normal_event_card_v3`, `workshop_event_card_v1` or `workshop_event_card_v2` card for event and `speaker_card_v2` for speakers.

7. **Manual:** Create Lanyrd event.

8. **Manual:** Create Facebook event. Use `normal_event_facebook_background_v2` or `workshop_facebook_background_v1` card for event background. Use `normal_event_card_v3`, `workshop_event_card_v1` or `workshop_event_card_v2` card for Facebook posts. Use `speaker_card_v2` for Facebook posts about speakers.  

9. **Manual:** Create LinkedIn post. Use `normal_event_card_v3`, `workshop_event_card_v1` or `workshop_event_card_v2` card for event announcement post.

## Event cards

- `normal_event_card_v1` (**DEPRECATED**): use for Twitter, LinkedIn; features: **Periscope Video**  

    > **WARNING:** Only use this card if we go back to using Periscope. Otherwise use cards with Facebook video streaming.

    <img src="https://github.com/latcraft/event-manager/raw/master/src/main/docs/images/cards/event-normal_event_card_v1-20170307.png" width="200">

- `normal_event_card_v2` (**DEPRECATED**): use for Twitter, LinkedIn; features: **Periscope Video**  
                                           
    > **WARNING:** Only use this card if we go back to using Periscope. Otherwise use cards with Facebook video streaming.

    <img src="https://github.com/latcraft/event-manager/raw/master/src/main/docs/images/cards/event-normal_event_card_v2-20170307.png" width="200">

- `normal_event_card_v3`: use for Twitter, LinkedIn; features: **Facebook Video**

   <img src="https://github.com/latcraft/event-manager/raw/master/src/main/docs/images/cards/event-normal_event_card_v3-20170307.png" width="200">

- `normal_event_facebook_background_v1`: (**DEPRECATED**): use for **Facebook Event Page background**; features: **Periscope Video**  

    > **WARNING:** Only use this card if we go back to using Periscope. Otherwise use cards with Facebook video streaming.
    
   <img src="https://github.com/latcraft/event-manager/raw/master/src/main/docs/images/cards/event-normal_event_facebook_background_v1-20170307.png" width="200">

- `normal_event_facebook_background_v2`: use for **Facebook Event Page background**; features: **Facebook Video**

   <img src="https://github.com/latcraft/event-manager/raw/master/src/main/docs/images/cards/event-normal_event_facebook_background_v2-20170307.png" width="200">

- `workshop_facebook_background_v1`: use for **Facebook Event Page background**; features: **Bring Laptop**

   <img src="https://github.com/latcraft/event-manager/raw/master/src/main/docs/images/cards/event-workshop_facebook_background_v1-20170307.png" width="200">

- `workshop_event_card_v1`: use for Twitter, LinkedIn; features: **Bring Laptop**

   <img src="https://github.com/latcraft/event-manager/raw/master/src/main/docs/images/cards/event-workshop_event_card_v1-20170307.png" width="200">

- `workshop_event_card_v2`: use for Twitter, LinkedIn; features: **Bring Laptop**

   <img src="https://github.com/latcraft/event-manager/raw/master/src/main/docs/images/cards/event-workshop_event_card_v2-20170307.png" width="200">
   
- `speaker_card_v1` (**DEPRECATED**): use for Twitter, LinkedIn, Facebook; features: **Periscope Video** 

   <img src="https://github.com/latcraft/event-manager/raw/master/src/main/docs/images/cards/event-speaker_card_v1-20170307-antons_mislevics.png" width="200">

- `speaker_card_v2`: use for Twitter, LinkedIn, Facebook; features: **Facebook Video** 
   
   <img src="https://github.com/latcraft/event-manager/raw/master/src/main/docs/images/cards/event-speaker_card_v2-20170307-antons_mislevics.png" width="200">


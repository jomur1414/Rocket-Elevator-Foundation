
# Rocket_Elevators_Controllers
Week 9 : Foundation



USER % EMPLOYEE : 
jonathanmurray1@msn.com // 123456
or all codeboxx employee email with password 123456


USER & CUSTOMER  :
adam@example.net   // 123456


Extra-miles :
with user account (use adam@exemple.net to try) and go to the dashboard section, you will see all the informations about the quotes you have made previously,
a summary of all possessions for the customer (number of building, battery, column and elevator) and also the leads made previously by the customer
----------------------------------------------------------------


The add an internvention, log with USER & EMPLOYEE. You will see Interventions in button section near CONTACT
(You can do it on cell phone also)



RESTapi foundation repo : https://github.com/jomur1414/RestApiFoundation
-----------------------------------------------------------------

Retrieving the informations about interventions
GET
https://restapifoundationjm.azurewebsites.net/api/interventions

-----------------------------------------------------------------

Returns all fields of all Service Request records that do not have a start date and are in "Pending" status.
GET 
https://restapifoundationjm.azurewebsites.net/api/interventions/pending

-----------------------------------------------------------------

Change the status of the intervention request to "InProgress" and add a start date and time (Timestamp).

PUT 
https://restapifoundationjm.azurewebsites.net/api/interventions/inprogress/{id}

IN THE BODY :

    {
        "status": "In progress",
        "intervention_start_time": "2020-02-23T16:47:53"
    }
    

-----------------------------------------------------------------

Change the status of the request for action to "Completed" and add an end date and time (Timestamp).

PUT
https://restapifoundationjm.azurewebsites.net/api/interventions/completed/{id}

IN THE BODY :

    {
        "status": "Completed",
        "intervention_end_time": "2020-03-23T16:47:53"
    }
    

-----------------------------------------------------------------
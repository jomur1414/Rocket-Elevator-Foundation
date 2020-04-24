
# Rocket_Elevators_Controllers
Week 11 : TDD



To run the test in Ruby/Rails : $ bundle exec rspec --format documentation
Path file of the test is : /Rocket-Elevator-Foundation/spec/elevator_media_spec.
Path file of the new content : /Rocket-Elevator-Foundation/lib/elevator_media/streamer.rb

To run the test in C#  -> https://github.com/jomur1414/CSharpTest and run $ cd nunit_codeboxx   AND    $ dotnet test

To run the test in Python ->  https://github.com/jomur1414/PythonTest  and run : $ pytest





















USER % EMPLOYEE : 
jonathanmurray1@msn.com // 123456
or all codeboxx employee email with password 123456


USER & CUSTOMER  :
adam@example.net   // 123456


Extra-miles :
with user account (use adam@exemple.net to try) and go to the dashboard section, you will see all the informations about the quotes the client have made previously,
a summary of all possessions for the customer (number of building, battery, column and elevator), the leads made previously by the customer
and also all the interventions where the client is involved
----------------------------------------------------------------


To add an intervention, log with an USER & EMPLOYEE account. You will see Interventions in button section near CONTACTS
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

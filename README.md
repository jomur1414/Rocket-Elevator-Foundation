
# Rocket_Elevators_Controllers
Week 7 : THE API

Site is now online at http://rocketelevatorsjm.club/.

API : Twilio, Slack, Dropbox, Google Maps, DropBox, SendGrid, IBM Watson et ZenDesk.

-IBM Watson : on the admin section, you can press a button and a file play to give you information sonically. It gave you your name, the number of elevator, number of customer, number of city etc...

-SendGrid : When a customer send a Lead he receives confirmation email via SendGrid with logo of Rocket Elevators and display some information. (All fields must containt some infomations including File Attachment)

-Zendesk : Everytime a customer fill up a lead or a quote, we receive a ticket and a email for letting us know there is someone who want to contact us

-Twilio: When an elevator status is updated (Active or Inactive). Twilio check if the status is in intervention, if so the contact name of the technician of this elevator is sent to a employee cellphone for a maintenance service

-Google Maps : The dashboard panel has a geolocations section which displays all the building deployed by Rocket Elevators. Google Maps Api is used to extract geolocation data from database and display key info including building location, number of batteries, columns and elevators.

-Slack : When an elevator status is changed in the dashboard system, a notification is sent to Rocket Elevator employees in the "elevator_operations"  slack channel to notify about the status update along with the specifications of that particular elevator.

-Dropbox: when an admin create a new customer, the dropbox api look if the email of the customer is already inside the lead database. It take the attach file, upload it to Rocket Elevator dropbox. The link of the uploaded file remplace the file attachment inside the database for an easy access.

Customer : 
On the site, you can make a submission, create a user or send a leads.

When you are logged as a customer, you can go to the page customer dashboard and see all the submissions linked to your email. 

If you try to have a quotes while being login, you will that some of yours informations are already there.


Admin :    jonathanmurray1@msn.com/////123456 or felix@homtail.com///////123456

If you go to the admin page (only avalaible if you are also an employee) , you can see all the informations in the SQL DB. You can also check for some BI information in the the dashboard blazer with the link chart or by using the srolldown button on the normal pages.

Finally, you can edit your informations of the user profil likes last name, first name, compagny, password ect.


To send the data from sql to postgresql DB use :  rake dataTransfert:transfer_for_fact


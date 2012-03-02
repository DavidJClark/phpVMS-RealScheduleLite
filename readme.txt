##This project is no longer being actively developed##

REALScheduleLite beta 1.0

phpVMS module to create a realistic aircraft placement scenario including jumpseat ticket purchases within your phpVMS managed virtual airline allowing pilots to fly flights available from their current location.

----------------------------------------------
A visible link to http://www.simpilotgroup.com must be provided on any webpage utilizing this script for the license to be valid.
----------------------------------------------

Developed by:
simpilot - David Clark
www.simpilotgroup.com
www.david-clark.net

Developed on:
phpVMS 2.1.934
php 5.2.11
mysql 5.0.51
apache 2.2.11

Install:

-Download the attached package.
-unzip the package and place the files as structured in your root phpVMS install.
-use the realschedulelite.sql file to create the table needed in your sql database using phpmyadmin or similar.

Open local.config.php and add

# Jumpseat Ticket Cost Per NM
Config::Set('JUMPSEAT_COST', '.25');


Change the '.25' to what you want to charge per mile of flight for a jumpseat ticket for your pilots. As it stands it is set to 25 cents per mile.

Create a link for your pilots to get to the Real Schedule Lite dispatch center

<?php echo url('/RealScheduleLite'); ?>


If you are requiring your pilots to use the Real Schedule Lite routing system you must disable all links to the built in phpVMS schedule listings. Any /index.php/schedules links will take the pilot to the native scheduling system and allow them to bid on any flight in the system.

Aircraft and Routes

EVERY aircraft must have a looping routing system, in other words, it must return to the airfield it first started at on its last flight leg or it will become stranded. It does not matter how many flight legs are in the route for the aircraft but it must only go to each airfield one time.

example of a looping route:

flight 1 - KBOS - KATL
flight 2 - KATL - KDEN
flight 3 - KDEN - KORD
flight 4 - KORD - KBOS

Each aircraft in your inventory can only be assigned to one looped route.

Pilots

A new pilot is automatically stationed at the hub he is assigned to.

An active pilot will be placed at the arrival location of the last filed PIREP or last jumpseat ticket purchased, whichever is most recent.

If a pilot gets "stranded" at an airport all the jumpseat tickets to airports with available aircraft must be purchased but the cost is set at $0.

I have included the basis to count how many jumpseat tickets a pilot has purchased, more functionality will come in future versions with this part of the module.

Any aircraft and routes that do not follow this method need to be disabled in the admin panel.

This is a VERY BASIC BETA version of this module. It only includes basic functionality and does not include the New England Virtual route builder and mapping functions.

Released under the following license:
Creative Commons Attribution-Noncommercial-Share Alike 3.0 Unported License
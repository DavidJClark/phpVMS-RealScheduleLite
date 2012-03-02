<?php
//simpilotgroup addon module for phpVMS virtual airline system
//
//simpilotgroup addon modules are licenced under the following license:
//Creative Commons Attribution Non-commercial Share Alike (by-nc-sa)
//To view full license text visit http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//@author David Clark (simpilot)
//@copyright Copyright (c) 2009-2010, David Clark
//@license http://creativecommons.org/licenses/by-nc-sa/3.0/

echo '<br /><h3>Available Flights At '.$name->name.'</h3>';
?>
<br />
<table width="100%" border="1px">
    <tr>
        <th colspan="2">Airport Information</th>
    </tr>
    <tr>
        <td colspan="2"><?php echo $airport->name; ?></td>
    </tr>
    <tr>
        <td>ICAO:</td>
        <td><?php echo $name->icao; ?></td>
    </tr>
    <tr>
        <td>Country:</td>
        <td><?php echo $name->country; ?></td>
    </tr>
    <tr>
        <td>Latitude:</td>
        <td><?php echo $name->lat; ?></td>
    </tr>
    <tr>
        <td>Longitude:</td>
        <td><?php echo $name->lng; ?></td>
    </tr>
    <tr>
        <td>Flight Aware Charts Link: (USA Airfileds Only)</td>
        <td><a href="http://flightaware.com/resources/airport/<?php echo $name->icao; ?>/procedures" target="_blank"><u><?php echo $name->icao; ?></u></a></td>
    </tr>
</table>
<hr />
<?php
echo '<table width="100%" border="1px">';
echo '<tr>';
echo '<th>Flight</th>';
echo '<th>Aircraft</th>';
echo '<th>Registration</th>';
echo '<th>Next Destination</th>';
echo '<th width="10%">Distance</th>';
echo '<th>Departure Time</th>';
if(Auth::LoggedIn() == true)
{
    echo '<th>Add Bid</th>';
}
echo '</tr>';
if(!$aircrafts)
{
    echo '<tr><td colspan="6">The Airline Has No Aircraft</td></tr>';
}
else
{
    foreach ($aircrafts as $aircraft)
    {
        $location = RealScheduleLiteData::get_aircraft_location($aircraft->id);
        if(!$location)
        {
            $location = RealScheduleLiteData::get_aircraft_start($aircraft->id);
            $airfield = $location->depicao;
        }
        else
        {
            $airfield = $location->arricao;
        }
        if ($airfield == $name->icao)
        {
            $flight = RealScheduleLiteData::get_next_flight($aircraft->id, $airfield);
            $airfield = OperationsData::getAirportInfo($flight->arricao);
            echo '<tr>';
            echo '<td>'.$flight->code.''.$flight->flightnum.'</td>';
            echo '<td>'.$aircraft->fullname.'</td>';
            echo '<td><a href="'.SITE_URL.'/index.php/RealScheduleLite/get_aircraft?id='.$aircraft->id.'" >'.$aircraft->registration.'</a></td>';
            echo '<td>'.$airfield->icao.' - '.$airfield->name.' - '.$airfield->country.'</td>';
            echo '<td>'.round($flight->distance).' nm</td>';
            echo '<td>'.$flight->deptime.'</td>';

            //If pilot is logged in check their location
            //If the pilot is at this airport allow them to bid on flights
            if(Auth::LoggedIn() == true)
            {
                $location = PIREPData::getLastReports(Auth::$userinfo->pilotid, 1, '');
                if($location->arricao == $name->icao)
                {
                    echo '<td><a id="'.$flight->id.'" class="addbid"
				href="'.actionurl('/schedules/addbid').'">Add to Bid</a></td>';
                }
                else
                {
                    echo '<td>You are not at this airport</td>';
                }
            }
            echo '</tr>';
        }
    }
}
echo '</table>';
echo '<form><input class="mail" type="button" value="Go Back To Listing" onClick="history.go(-1);return true;"> </form>';
?>
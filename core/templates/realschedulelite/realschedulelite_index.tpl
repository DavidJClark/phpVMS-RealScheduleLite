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

echo '<h3>Available Aircraft For '.SITE_NAME.'</h3>';
//If pilot is logged in find their location
//If they have not filed a PIREP yet place them at their hub
if(Auth::LoggedIn() == true)
{ 
    $location = RealScheduleLiteData::get_pilot_location(Auth::$userinfo->pilotid);
    if(!$location)
    {
        $icao = Auth::$userinfo->hub;
    }
    else
    {
        $icao = $location->arricao;
    }

    $stranded = '0';
    foreach($aircrafts as $aircraft)
    {
        $check = RealScheduleLiteData::get_aircraft_location($aircraft->id);
        if($check->arricao == $icao)
        {
            $stranded++;
        }
    }
    $curlocation = OperationsData::getAirportInfo($icao);
    echo Auth::$userinfo->firstname.', You are currently at '.$curlocation->name.' ('.$curlocation->icao.')<br />';
    if(!$location->jumpseats)
    {
        echo 'You have not purchased any jumpseat tickets with '.SITE_NAME.'<br /><br />';
    }
    else
    {
        echo 'You have purchased '.$location->jumpseats.' jumpseat tickets with '.SITE_NAME.'<br /><br />';
    }
}
if($stranded == 0)
{
    echo 'The Airfield You Are At Has No Available Aircraft, All Jumpseat Tickets Are Free<br /><br />';
}
echo 'Click On ICAO Code For Airport And Flight Details<br /><br />';
echo '<table width="100%" border="1px">';
echo '<tr><th width="5%">ICAO</th><th width="40%">Airport</th><th>Country</th><th>Available Aircraft</th>';
//If pilot is logged in allow him to jumpseat to another airport
if(Auth::LoggedIn() == true)
{
    echo '<th>Jumpseat Ticket</th>';
}
echo '</tr>';
$i = 0;
foreach ($airports as $airport)
{
    if ($i == 0)
    {
        echo '<tr>';
    }
    echo '<td><a href="'.SITE_URL.'/index.php/RealScheduleLite/get_airport?icao='.$airport->icao.'">'.$airport->icao.'</a></td>';
    if($airport->hub == 1)
    {
        echo '<td><font color="#FF0000">HUB - '.$airport->name.'</font></td>';
    }
    else
    {
        echo '<td>'.$airport->name.'</td>';
    }
    echo '<td>'.$airport->country.'</td><td>';
    $aircrafts = OperationsData::getAllAircraft('true');
    $count = 0;
    if(!$aircrafts)
    {
        echo 'The Airline Has No Aircraft';
    }
    else
    {
        foreach ($aircrafts as $aircraft)
        {
            $location = RealScheduleLiteData::get_aircraft_location($aircraft->id);
            $airfield = $location->arricao;
            if(!$location)
            {
                $location = RealScheduleLiteData::get_aircraft_start($aircraft->id);
                $airfield = $location->depicao;
            }
            else
            {
                $airfield = $location->arricao;
            }
            if ($airfield == $airport->icao)
            {
                if ($count == 0)
                {
                    echo '| ';
                }
                echo ''.$aircraft->registration.' | ';
                $count++;
            }
        }
        if ($count == 0)
        {
            echo '<font color="#6D7B8D"><i>No Aircraft Available</i></font>';
        }
        echo '</td>';
    }
    //If pilot is logged in allow him to jumpseat to another airport

    if(Auth::LoggedIn() == true)
    {
        if($curlocation->icao == $airport->icao)
        {
            echo '<td align="center">You Are<br />Here</td>';
        }
        else
        {
            //check to see if he is stranded with no aircraft
            if($count == 0)
            {
                echo '<td>&nbsp</td>';
            }
            else
            {
                if($stranded == '0')
                {
                    $cost = '0';
                    echo '<td align="center">Cost - $'.$cost.'<br /><a href="'.url('/realschedulelite/jumpseat').'?id='.$airport->icao.'&cost='.$cost.'"><b>Purchase</b></a></td>';
                }
                else
                {
                    $distance = round(SchedulesData::distanceBetweenPoints($curlocation->lat, $curlocation->lng, $airport->lat, $airport->lng), 0);
                    $permile = Config::Get('JUMPSEAT_COST');
                    $cost = ($permile * $distance);
                    echo '<td align="center">Cost - $'.$cost.'<br /><a href="'.url('/realschedulelite/jumpseat').'?id='.$airport->icao.'&cost='.$cost.'"><b>Purchase</b></a></td>';
                }
            }
        }
    }
}
echo '</table>';
?>
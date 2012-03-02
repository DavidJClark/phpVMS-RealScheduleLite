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
?>
<br />
<h3>Company Aircraft - Tail Number - <?php echo $aircraft->registration; ?></h3>
<table width="100%" border="1px">
    <tr>
        <th colspan="2">Aircraft</th>
    </tr>
    <tr>
        <td><u>Type:</u></td>
        <td><?php echo $aircraft->icao; ?></td>
    </tr>
    <tr>
        <td><u>Description:</u></td>
        <td><?php echo $aircraft->fullname; ?></td>
    </tr>
    <tr>
        <td><u>Registration:</u></td>
        <td><?php echo $aircraft->registration; ?></td>
    </tr>
</table>
<br />
<table width="100%" border="1px">
    <tr>
        <th>
            Flight Routing
        </th>
    </tr>
    <?php
    foreach($route as $schedule)
    {
        echo '<tr>';
        echo '<td>Flight: '.$schedule->code . $schedule->flightnum. ' / '.$schedule->depicao.' - '.$schedule->arricao.' / '.$schedule->distance.' nm</td>';
        echo '</tr>';
    }
    ?>
    <tr>
        <th>
            Filght pattern for <?php echo $aircraft->registration; ?>. Current location is shown in <font color="#ff0000">RED</font>.
        </th>
    </tr>
    <tr>
        <td>
            <?php
            $i = 0;
            if (!$current)
            {
                $cur = 1;
            }
            echo '| ';
            foreach ($route as $departure)
            {
                while($i == 0):
                    $end = $departure->depicao;
                    $i++;
                endwhile;

                if ($current->arricao == $departure->depicao)
                {
                    $cur = 1;
                }
                if ($cur == 1)
                {
                    echo '<font color="FF0000"><b>'.$departure->depicao.'</b></font> | ';
                    $cur++;
                }
                else
    {
        echo $departure->depicao.' | ';
    }
}
echo $end.' |';
?>
        </td>
    </tr>
</table>
<form><input class="mail" type="button" value="Go Back To Listing" onClick="history.go(-1);return true;"> </form>
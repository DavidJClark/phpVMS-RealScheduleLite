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
<h3>Confirm Jumpseat Ticket Purchase</h3>

<table width="100%" cellspacing="0">
    <tr>
        <td align="center" bgcolor="#cccccc"><font size="5"><b><?php echo SITE_NAME; ?> Paperless Ticket</b></font></td>
    </tr>
    <tr>
        <td bgcolor="#cccccc">Destination:<b> <?php echo $airport->name; ?></b></td>
    </tr>
    <tr>
        <td bgcolor="#cccccc">Departure Date:<b> <?php echo date('m/d/Y') ?></b></td>
    </tr>
    <tr>
        <td bgcolor="#cccccc">Travel Class:<b> Employee (Best Available)</b></td>
    </tr>
    <tr>
        <td bgcolor="#cccccc">Total Cost:<b> $<?php echo $cost; ?></b></td>
    </tr>
</table>
<br />
<center>
    <a href="<?php echo url('/RealScheduleLite'); ?>">Cancel Purchase</a> |
    <?php
        if($cost > Auth::$userinfo->totalpay)
        {
            echo 'You Do Not Have Funds To Cover This Purchase';
        }
        else
        {
            echo '<a href="'.url('/RealScheduleLite/purchase').'?id='.$airport->icao.'&cost='.$cost.'">Purchase Ticket</a>';
        }
        ?>
</center>
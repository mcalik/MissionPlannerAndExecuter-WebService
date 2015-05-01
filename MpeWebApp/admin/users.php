<?php

include('../session.php');
$query = mysql_query("select * from user");
if (@mysql_num_rows($query) > 0) {
    $user = array();
    echo "<table border='1px'><tr><th>id</th><th>name</th><th>address</th><th>birthdate</th><th>username</th><th>password</th><th>type</th><th>update</th><th>delete</th></tr>";
    while ($row = mysql_fetch_array($query)) {
        echo '<tr>';

        echo "<td>$row[id]</td>";

        echo "<td>$row[name]</td>";

        echo "<td>$row[address]</td>";

        echo "<td>$row[birthdate]</td>";

        echo "<td>$row[username]</td>";

        echo "<td>$row[password]</td>";

        echo "<td>$row[type]</td>";

        echo "<td><a href=\"edit_user_form.php?id=$row[id]\">Edit</a></td>";
        echo "<td><a href=\"delete_user_data.php?id=$row[id]\">Delete</a></td>";
        echo '</tr>';
    }
    echo '</table>';
} else
    echo 'No user found.';

echo "<a href='add_user_form.php' target='main'> Add new </a>";
?>

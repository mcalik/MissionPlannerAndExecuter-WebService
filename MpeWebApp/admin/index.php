<head>
<meta charset="utf-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</head>

<?php 
include('../session.php');
//header("Content-Type: text/html; charset=iso-8859-9");

?>
<div class='container'>
<div id="profile">
<b id="welcome">Hoşgeldin : <i><?php echo $login_session; ?></i></b>
<b id="logout"><a href="../logout.php" target="_parent">Çıkış yap</a></b>
</div>

<?php
mysql_query("SET NAMES 'utf8'");
mysql_query("SET CHARACTER SET utf8");
mysql_query("SET COLLATION_CONNECTION = 'utf8_general_ci'");
$query = mysql_query("select adsoyad,email,telefon,okul,sinif,kayit_zamani from kayit ORDER BY kayit_zamani DESC;");

if (@mysql_num_rows($query) > 0) {
    $user = array();

	echo "<div class='table-responsive'>";
    echo "<table class='table table-hover'><tr><th>Ad Soyad</th><th>Email</th><th>Telefon</th><th>Okul</th><th>Sınıf</th><th>Kayıt Zamanı</th></tr>";
    while ($row = mysql_fetch_array($query)) {
        echo '<tr>';
        
        echo "<td>$row[adsoyad]</td>";
        
        echo "<td>$row[email]</td>";
        
        echo "<td>$row[telefon]</td>";

        echo "<td>$row[okul]</td>";

        echo "<td>$row[sinif]</td>";
		
        echo "<td>$row[kayit_zamani]</td>";
        		
        echo '</tr>';
    }
    echo '</table>';
	echo "</div>";
} else
    echo 'Kayıt Bulunamadı.';

?>
</div>

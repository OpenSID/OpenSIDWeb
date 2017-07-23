<?php
$temp = <<<TMP
class {$classname} extends MY_Model
{
    protected \$_table = '{$table}';
    public \$primary_key = 'id';
}
TMP;
echo $temp;

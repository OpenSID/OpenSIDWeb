<?php
$temp = <<<TMP
class {$classname} extends MY_Model
{
    public \$table = '{$table}';
    public \$primary_key = 'id';
    protected \$timestamps = FALSE;
}
TMP;
echo $temp;

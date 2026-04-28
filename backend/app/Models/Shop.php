<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

#[Fillable(['shop_name', 'email', 'shop_mobile', 'shop_website', 'shop_address'])]
class Shop extends Model
{
    use SoftDeletes;
}

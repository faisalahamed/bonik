<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

#[Fillable(['shop_id', 'name', 'type', 'image_url', 'created_at', 'updated_at'])]
class Category extends Model
{
    use HasUuids;
}

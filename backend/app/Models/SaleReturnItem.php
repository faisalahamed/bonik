<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

#[Fillable(['id', 'shop_id', 'return_id', 'sale_item_id', 'product_id', 'product_name', 'sale_price', 'quantity', 'reason', 'created_at', 'updated_at'])]
class SaleReturnItem extends Model
{
    use HasUuids;
}
